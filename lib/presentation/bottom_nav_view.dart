import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/material_symbols.dart';
import 'package:test/logic/navigation_cubit.dart';
import 'package:test/presentation/home_view/home_view.dart';

class BottomNavigationView extends StatelessWidget {
  const BottomNavigationView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavCubit, int>(
      builder: (context, page) {
        final navCubit = context.read<BottomNavCubit>();

        return Scaffold(
          body: PageView(
            controller: navCubit.controller,
            onPageChanged: navCubit.pageChanged,
            children: const [
              HomeScreenView(),
              Center(child: Text('Second')),
              Center(child: Text('Third')),
              Center(child: Text('Fourth')),
            ],
          ),

          bottomNavigationBar: BottomNavigationBar(
            currentIndex: page,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            selectedItemColor: Theme.of(context).primaryColor,
            unselectedItemColor: Colors.grey,
            selectedIconTheme: IconThemeData(
              color: Theme.of(context).primaryColor,
            ),

            showUnselectedLabels: true,
            showSelectedLabels: true,

            elevation: 5,
            selectedLabelStyle: TextStyle(
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.w500,
            ),
            unselectedLabelStyle: const TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.w300,
            ),
            unselectedIconTheme: const IconThemeData(color: Colors.grey),

            onTap: navCubit.goToPage,
            items: [
              BottomNavigationBarItem(
                icon: Iconify(
                  MaterialSymbols.home_outline,
                  color: page == 0
                      ? Theme.of(context).primaryColor
                      : Colors.grey,
                  size: 35.h,
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Iconify(
                  MaterialSymbols.play_circle_outline,
                  color: page == 1
                      ? Theme.of(context).primaryColor
                      : Colors.grey,
                  size: 35.h,
                ),
                label: 'My Courses',
              ),
              BottomNavigationBarItem(
                icon: Iconify(
                  MaterialSymbols.menu_book_outline,
                  color: page == 2
                      ? Theme.of(context).primaryColor
                      : Colors.grey,
                  size: 35.h,
                ),
                label: 'Blogs',
              ),
              BottomNavigationBarItem(
                icon: Iconify(
                  MaterialSymbols.person_4_outline,
                  color: page == 3
                      ? Theme.of(context).primaryColor
                      : Colors.grey,
                  size: 35.h,
                ),
                label: 'Profile',
              ),
            ],
          ),
        );
      },
    );
  }
}
