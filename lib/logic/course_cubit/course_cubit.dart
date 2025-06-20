import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test/logic/course_cubit/course_state.dart';
import 'package:test/model/course_model.dart';
import 'package:test/utils/app_images_constant.dart';

class CourseCubit extends Cubit<CourseState> {
  CourseCubit()
      : super(CourseState(
          selectedCategory: CourseCategory.all,
          allCourses: [
            Course(
              title: 'Photoshop Course',
              rating: 5,
              duration: const Duration(hours: 5, minutes: 15),
              category: CourseCategory.design,
              assetIcon: ApplicationImagesConst.applicationCameraImage,
            ),
            Course(
              title: '3D Design',
              rating: 4.6,
              duration: const Duration(hours: 10, minutes: 30),
              category: CourseCategory.design,
              assetIcon: ApplicationImagesConst.application3dImage,
            ),
           
          ],
        ));

  void selectCategory(CourseCategory cat) =>
      emit(state.copyWith(selectedCategory: cat));
}
