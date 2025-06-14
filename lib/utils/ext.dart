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
