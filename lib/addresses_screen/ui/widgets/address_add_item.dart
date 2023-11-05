import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../utils/utils.dart';
import '../../../../widgets/widgets.dart';

class AddAddressItem extends StatelessWidget {
  const AddAddressItem({
    Key? key,
    required this.title,
    required this.hint,
    required this.textInputType,
    required this.onChanged,
    this.onFieldSubmitted,
    this.focusNode,
    this.enabled,
    this.value,
    this.minLines,
    this.bgColor = Colors.white,
    this.validator,
    this.error,
    this.textInputAction,
    this.inputFormatters,
  }) : super(key: key);
  final Function onChanged;
  final FocusNode? focusNode;
  final Function? onFieldSubmitted;
  final String? value;
  final String? error;
  final String? hint;
  final int? minLines;
  final bool? enabled;
  final Color bgColor;
  final TextInputType? textInputType;
  final FormFieldValidator<String>? validator;
  final String title;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputAction? textInputAction;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 9.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        color: CColors.address,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CTitlePoppins(title),
          h12,
          CTextField(
            minLines: minLines,
            inputFormatters: inputFormatters,
            validator: validator,
            onChanged: onChanged,
            focusNode: focusNode,
            hint: hint,
            enabled: enabled,
            value: value,
            textInputType: textInputType,
            textInputAction: textInputAction ?? TextInputAction.next,
            onFieldSubmitted: onFieldSubmitted,
          ),
        ],
      ),
    );
  }
}
