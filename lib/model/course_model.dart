// models/course.dart
enum CourseCategory { all, design, coding, uiux }

class Course { 

  Course({
    required this.title,
    required this.rating,
    required this.duration,
    required this.category,
    required this.assetIcon,
  });
  final String title;
  final double rating;
  final Duration duration;
  final CourseCategory category;
  final String assetIcon;
}
