import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:multi_widget/utils/app_responsive.dart';

class AppTextField extends StatefulWidget {
  final TextEditingController controller;
  final String? labelText;
  final String? hintText;
  final TextInputType? keyboardType;
  final String? titleText;

  const AppTextField({
    Key? key,
    required this.controller,
    this.labelText = "",
    this.hintText = "",
    this.titleText = "",
    this.keyboardType = TextInputType.text,
  }) : super(key: key);

  @override
  _AppTextFieldState createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.titleText!.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              "${widget.titleText}",
              style: TextStyle(
                fontSize: 15.sp,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        TextFormField(
          controller: widget.controller,
          keyboardType: widget.keyboardType,
          focusNode: _focusNode,
          inputFormatters: widget.keyboardType == TextInputType.number
              ? <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(4),
                ]
              : <TextInputFormatter>[],
          decoration: InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.never,
            labelText: "${widget.labelText}",
            hintText: "${widget.hintText}",
            labelStyle: TextStyle(
              fontSize: 15.sp,
              color: Colors.black,
            ),
            hintStyle: TextStyle(
              fontSize: 15.sp,
              color: Colors.grey,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(2.w),
              ),
              borderSide: BorderSide(
                color: Colors.red,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(2.w),
              ),
              borderSide: const BorderSide(
                color: Colors.orange,
              ),
            ),
          ),
          cursorColor: Colors.orange,
        ),
      ],
    );
  }
}
