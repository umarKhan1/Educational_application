// ignore_for_file: unused_element

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

extension IntExtension on int {
  Widget get appHeight => SizedBox(
        height: h, // Apply height scaling
      );

  Widget get appWidth => SizedBox(
        width: w, // Apply width scaling
      );
}

extension StringExtension on String {
  String capitalize() =>
      isNotEmpty ? '${this[0].toUpperCase()}${substring(1)}' : '';
}
