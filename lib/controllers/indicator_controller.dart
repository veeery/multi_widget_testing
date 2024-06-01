import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:multi_widget/api_repository.dart';

import '../models/indicator.dart';

class IndicatorController extends GetxController {
  UniqueKey key = UniqueKey();

  bool isLoading = false;

  List<IndicatorModel> indicators = [];
  List<IndicatorModel> selectedIndicators = [];

  TextEditingController bandController = TextEditingController();
  TextEditingController periodController = TextEditingController();

  triggerLoading() {
    isLoading = !isLoading;
    update();
  }

  void addIndicator({required IndicatorModel indicator}) {
    selectedIndicators.add(indicator);
    update();
  }

  void removeIndicator(int index) {
    selectedIndicators.removeAt(index);
    update();
  }

  void editIndicator({required int index, required IndicatorModel indicator}) {
    selectedIndicators[index] = indicator;
    update();
  }

  void resetIndicator({required int index}) {
    selectedIndicators[index].band = 0;
    selectedIndicators[index].period = 0;
    update();
  }

  Future<void> getIndicators() async {
    triggerLoading();
    await Future.delayed(const Duration(seconds: 2));
    indicators = await APIService.fetchIndicators();
    triggerLoading();
  }
}
