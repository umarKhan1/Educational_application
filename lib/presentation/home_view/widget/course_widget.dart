import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test/logic/course_cubit/course_cubit.dart';
import 'package:test/logic/course_cubit/course_state.dart';
import 'package:test/model/course_model.dart';
import 'package:test/utils/ext.dart';

class CourseSelectWidget extends StatefulWidget {
  const CourseSelectWidget({super.key});

  @override
  State<CourseSelectWidget> createState() => _CourseSelectWidgetState();
}

class _CourseSelectWidgetState extends State<CourseSelectWidget> {
    late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    final initialPage = CourseCategory.values.indexOf(
        context.read<CourseCubit>().state.selectedCategory);
    _pageController = PageController(initialPage: initialPage);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void onChipTap(int idx) {
    _pageController.animateToPage(
      idx,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    context
        .read<CourseCubit>()
        .selectCategory(CourseCategory.values[idx]);
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CourseCubit, CourseState>(
      builder: (context, state) {
        return Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // ── Chip row ───────────────────────────────────
              Row(
                children: List.generate(CourseCategory.values.length, (i) {
                  final cat = CourseCategory.values[i];
                  final isSelected = cat == state.selectedCategory;
                  final label = cat == CourseCategory.all
                      ? 'All'
                      : cat.name.capitalize();

                  return Expanded(                                // ← makes each chip flexible
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: i == 0 ? 0 : 6,                     // half-spacing between chips
                        right: i == CourseCategory.values.length - 1 ? 0 : 6,
                      ),
                      child: GestureDetector(
                        onTap: () => onChipTap(i),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          alignment: Alignment.center,            // center the text
                          decoration: BoxDecoration(
                            color: isSelected
                                ? Theme.of(context).primaryColor
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            label,
                            style: TextStyle(
                              fontSize:14.sp,
                              color: isSelected ? Colors.white : Colors.grey,
                              fontWeight:
                              isSelected ? FontWeight.bold : FontWeight.normal,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),

              const SizedBox(height: 16),
          
              // ── PageView in place of your ListView ─────────
              Expanded(
                child: PageView(
                  controller: _pageController,
                  onPageChanged: (idx) {
                    context
                        .read<CourseCubit>()
                        .selectCategory(CourseCategory.values[idx]);
                  },
                  children: CourseCategory.values.map((cat) {
                   final courses = state.allCourses
                        .where((c) => cat == CourseCategory.all
                            ? true
                            : c.category == cat)
                        .toList();
          
                    return ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: courses.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 12),
                      itemBuilder: (context, idx) {
                        final c = courses[idx];
                        return Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.grey[300]!),
                          ),
                          child: Row(
                            children: [
                              Container(
                                height: 65,
                                width: 75,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: Colors.grey.withValues(alpha: 0.1),
                                  border: Border.all(color: Colors.grey[500]!),
                                ),
                                child: Image.asset(c.assetIcon, width: 38, height: 38, ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(c.title,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w600)),
                                    const SizedBox(height: 4),
                                    Row(
                                      children: [
                                        const Icon(Icons.star,
                                            size: 16, color: Colors.amber),
                                        const SizedBox(width: 4),
                                        Text(c.rating.toStringAsFixed(1)),
                                        const SizedBox(width: 12),
                                        const Icon(Icons.access_time,
                                            size: 16, color: Colors.grey),
                                        const SizedBox(width: 4),
                                        Text(
                                            '${c.duration.inHours}h ${c.duration.inMinutes % 60}m'),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
