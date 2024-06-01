import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_widget/utils/app_responsive.dart';
import 'package:multi_widget/view/indicator_selector.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      builder: (context, child) {
        AppResponsive.init(context: context);
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 0.95),
          child: child!,
        );
      },
      home: IndicatorSelector(),
    );
  }
}
