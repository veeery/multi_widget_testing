import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_widget/utils/app_responsive.dart';

import '../controllers/indicator_controller.dart';
import '../models/indicator.dart';
import '../widgets/app_textfield.dart';

class IndicatorSelector extends StatelessWidget {
  final IndicatorController controller = Get.put(IndicatorController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Indicator Selector'),
      ),
      body: GetBuilder<IndicatorController>(
        initState: (_) => controller.getIndicators(),
        builder: (_) {
          return RefreshIndicator(
            onRefresh: () async {
              await controller.getIndicators();
            },
            child: Container(
              width: 100.w,
              height: 100.h,
              padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
              child: controller.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ListView(
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: controller.selectedIndicators.length,
                          itemBuilder: (context, index) {
                            IndicatorModel indicator = controller.selectedIndicators[index];

                            return Dismissible(
                              // key: Key('$indicator$index'),
                              key: UniqueKey(),
                              direction: DismissDirection.endToStart,
                              onDismissed: (direction) {
                                controller.removeIndicator(index);
                              },
                              background: Container(
                                margin: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  border: Border.all(color: Colors.orange),
                                  borderRadius: BorderRadius.circular(1.w),
                                ),
                                alignment: AlignmentDirectional.centerEnd,
                                child: const Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                ),
                              ),
                              child: Container(
                                margin: EdgeInsets.symmetric(vertical: 0.5.h),
                                padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.1.h),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.orange),
                                  borderRadius: BorderRadius.circular(1.w),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(indicator.name),
                                    IconButton(
                                      icon: const Icon(Icons.settings),
                                      onPressed: () {
                                        controller.bandController.text = indicator.band.toString();
                                        controller.periodController.text = indicator.period.toString();

                                        _showBottomSheet(
                                          index: index,
                                          context: context,
                                          indicator: indicator,
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                        // ...controller.selectedIndicators.asMap().entries.map((entry) {
                        //   int index = entry.key;
                        //   String indicator = entry.value.name;
                        //   return Dismissible(
                        //     // key: Key('$indicator$index'),
                        //     key: controller.key,
                        //     direction: DismissDirection.endToStart,
                        //     onDismissed: (direction) {
                        //       controller.removeIndicator(index);
                        //     },
                        //     background: Container(
                        //       margin: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
                        //       decoration: BoxDecoration(
                        //         color: Colors.red,
                        //         border: Border.all(color: Colors.orange),
                        //         borderRadius: BorderRadius.circular(1.w),
                        //       ),
                        //       alignment: AlignmentDirectional.centerEnd,
                        //       child: const Icon(
                        //         Icons.delete,
                        //         color: Colors.white,
                        //       ),
                        //     ),
                        //     child: Container(
                        //       margin: EdgeInsets.symmetric(vertical: 0.5.h),
                        //       padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.1.h),
                        //       decoration: BoxDecoration(
                        //         border: Border.all(color: Colors.orange),
                        //         borderRadius: BorderRadius.circular(1.w),
                        //       ),
                        //       child: Row(
                        //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //         children: [
                        //           Text(indicator),
                        //           IconButton(
                        //             icon: const Icon(Icons.settings),
                        //             onPressed: () => _showBottomSheet(context, controller.key.toString()),
                        //           ),
                        //         ],
                        //       ),
                        //     ),
                        //   );
                        // }),
                        GestureDetector(
                          onTap: () => _showIndicatorDialog(indicator: controller.indicators),
                          child: Container(
                            margin: EdgeInsets.symmetric(vertical: 0.5.h),
                            padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.1.h),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.orange),
                              borderRadius: BorderRadius.circular(1.w),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Add Indicator',
                                  style: TextStyle(color: Colors.orange),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.add, color: Colors.orange),
                                  onPressed: () => _showIndicatorDialog(indicator: controller.indicators),
                                ),
                                // Icon(Icons.add, color: Colors.orange),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Text("${controller.selectedIndicators.length} Indicators Selected"),
                        const Text("This below list is for testing purpose only."),
                        ...controller.selectedIndicators.asMap().entries.map((entry) {
                          int index = entry.key;
                          String indicator = entry.value.name;
                          String data = "Band: ${entry.value.band}, Period: ${entry.value.period}";
                          return Container(
                            margin: EdgeInsets.symmetric(vertical: 0.5.h),
                            padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.1.h),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.orange),
                              borderRadius: BorderRadius.circular(1.w),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(indicator),
                                Text(data),
                                IconButton(
                                  icon: const Icon(Icons.settings),
                                  onPressed: () {},
                                  // onPressed: () => _showBottomSheet(context, indicator),
                                ),
                              ],
                            ),
                          );
                        }),
                      ],
                    ),
            ),
          );
        },
      ),
    );
  }

  void _showIndicatorDialog({required List<IndicatorModel> indicator}) {
    Get.dialog(
      AlertDialog(
        title: const Text('Select Indicator'),
        content: Container(
          width: 100.w,
          height: 35.h,
          child: ListView.builder(
            itemCount: indicator.length,
            itemBuilder: (context, index) {
              IndicatorModel data = indicator[index];

              return _indicatorOption(indicator: data);
            },
          ),
        ),
      ),
    );
  }

  void _showBottomSheet({
    required BuildContext context,
    required int index,
    required IndicatorModel indicator,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(4.w)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Entry ${indicator.name} Setting',
                      style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold)),
                  SizedBox(height: 2.h),
                  AppTextField(
                    controller: controller.bandController,
                    labelText: "0",
                    titleText: 'Lower Band Standard Deviation',
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: 2.h),
                  AppTextField(
                    controller: controller.periodController,
                    labelText: "0",
                    titleText: 'Period',
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: 8.h),
                  Flexible(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          flex: 20,
                          child: ElevatedButton(
                            onPressed: () {
                              controller.resetIndicator(index: index);
                              Get.back();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey[200],
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            child: const Text(
                              "Reset",
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                        const Spacer(flex: 1),
                        Expanded(
                          flex: 20,
                          child: ElevatedButton(
                            onPressed: () {
                              controller.editIndicator(
                                index: index,
                                indicator: IndicatorModel(
                                  id: indicator.id,
                                  name: indicator.name,
                                  band: int.parse(controller.bandController.text),
                                  period: int.parse(controller.periodController.text),
                                ),
                              );
                              Get.back();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orange,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            child: const Text(
                              "Save",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _indicatorOption({required IndicatorModel indicator}) {
    return GestureDetector(
      onTap: () {
        controller.addIndicator(indicator: indicator);
        Get.back(); // Close the dialog
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4.0),
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(indicator.name),
            Icon(Icons.settings),
          ],
        ),
      ),
    );
  }
}
