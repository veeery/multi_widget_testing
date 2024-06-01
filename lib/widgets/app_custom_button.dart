import 'package:flutter/material.dart';
import 'package:multi_widget/utils/app_responsive.dart';

class AppCustomButton extends StatelessWidget {
  final double? width;
  final double? height;
  final String name;
  final VoidCallback onPressed;
  final Color? backgroundColor;

  AppCustomButton({
    required this.name,
    required this.onPressed,
    this.backgroundColor,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // width: MediaQuery.of(context).size.width * 0.4,
      // height: MediaQuery.of(context).size.height * 0.06,
      width: width ?? 90.w,
      height: height ?? 5.h,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          // primary: backgroundColor,
          backgroundColor: backgroundColor ?? Colors.orange,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        child: Text(
          name,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
