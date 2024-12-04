
import 'package:animated_chat_app/constants/const_colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UtilMethods {
  static Container loadingWidget(
      {double? width, double? height, double? radius, Color? color}) {
    return Container(
        width: width,
        height: height,
        alignment: Alignment.center,
        child: CupertinoActivityIndicator(
          radius: radius?.r ?? 10.r,
          color: color ?? ConstColors.appPrimeryColor,
        ));
  }

  // static getSnackBar(String? showText) {
  //   BotToast.showText(
  //     backButtonBehavior: BackButtonBehavior.none,
  //     align: const Alignment(0, .75),
  //     clickClose: true,
  //     crossPage: true,
  //     contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
  //     contentColor: ConstColors.appPrimeryColor,
  //     textStyle: const TextStyle(
  //         fontWeight: FontWeight.bold, color: ConstColors.appWhite),
  //     borderRadius: BorderRadius.circular(10),
  //     animationDuration: const Duration(milliseconds: 500),
  //     duration: const Duration(milliseconds: 2000),
  //     text: showText.toString(),
  //   );
  // }

  static Widget showNetWorkImage({
    required String image,
    double? height,
    double? width,
  }) {
    return SizedBox(
      height: height,
      width: width,
      child: CachedNetworkImage(
        imageUrl: image,
        fit: BoxFit.contain,
        placeholder: (context, _) {
          return Center(
            child: UtilMethods.loadingWidget(),
          );
        },
        errorWidget: (context, url, error) => const Center(
          child: Icon(
            Icons.image,
            color: ConstColors.appPrimeryColor,
          ),
        ),
      ),
    );
  }
}





// String returnFormatedDate(String date) {
//   return DateFormat('MMM d - hh:mm a ').format(DateTime.parse(date));
// }

// String returnDate(String date) {
//   return DateFormat('MM/dd').format(DateTime.parse(date));
// }

// String returnDay(String date) {
//   return DateFormat.EEEE().format(DateTime.parse(date));
// }
