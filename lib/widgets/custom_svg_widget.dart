import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomSvgWidget extends StatelessWidget {
  final String path;
  final double size;
  final Color? color;

  const CustomSvgWidget(
      {super.key, required this.path, this.size = 22, this.color});
  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      path,
      height: size.h,
      width: size.h,
      // ignore: deprecated_member_use
      color: color,
    );
  }
}
