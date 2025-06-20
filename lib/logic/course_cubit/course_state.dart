
import 'package:test/model/course_model.dart';

class CourseState {

  CourseState({
    required this.selectedCategory,
    required this.allCourses,
  });
  final CourseCategory selectedCategory;
  final List<Course> allCourses;

  List<Course> get filtered => selectedCategory == CourseCategory.all
      ? allCourses
      : allCourses
          .where((c) => c.category == selectedCategory)
          .toList();

  CourseState copyWith({CourseCategory? selectedCategory}) {
    return CourseState(
      selectedCategory: selectedCategory ?? this.selectedCategory,
      allCourses: allCourses,
    );
  }
}
