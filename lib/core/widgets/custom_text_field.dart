import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../theme/app_font.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final String? labelText;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final FormFieldSetter<String>? onSaved;

  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function()? onTap;
  final bool readOnly;
  final int? maxLines;
  final int? minLines;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatters;
  final EdgeInsetsGeometry? contentPadding;
  final bool enabled;
  final String? errorText;
  final Color? fillColor;
  final Color? borderColor;
  final double? borderRadius;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;
  final TextAlign textAlign;
  final bool autofocus;
  final FocusNode? focusNode;
  final Color? labelColor;

  const CustomTextField({
    super.key,
    this.controller,
    this.hintText,
    this.labelText,
    this.prefixIcon,

    this.onSaved,
    this.suffixIcon,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.onChanged,
    this.onTap,
    this.readOnly = false,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
    this.inputFormatters,
    this.contentPadding,
    this.enabled = true,
    this.errorText,
    this.fillColor,
    this.borderColor,
    this.borderRadius,
    this.textStyle,
    this.hintStyle,
    this.textAlign = TextAlign.start,
    this.autofocus = false,
    this.focusNode,
    this.labelColor = AppColor.primary,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (labelText != null) ...[
          Text(
            labelText!,
            style: AppFont.labelTextField.copyWith(
              color: AppColor.black,
              fontSize: 14.sp,
              fontWeight: FontWeight.w900,
            ),
          ),
          SizedBox(height: 8.h),
        ],
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          validator:
              validator ??
              (value) {
                if (value == null || value.isEmpty) {
                  return 'This field is required';
                }
                return null;
              },
          onChanged: onChanged,
          onSaved: onSaved,

          onTap: onTap,
          readOnly: readOnly,
          maxLines: maxLines,
          minLines: minLines,
          maxLength: maxLength,
          inputFormatters: inputFormatters,
          enabled: enabled,
          textAlign: textAlign,
          autofocus: autofocus,
          focusNode: focusNode,
          style: (textStyle ?? AppFont.textFiled).copyWith(color: Colors.black),
          // textDirection: TextDirection.rtl,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: hintStyle ?? AppFont.hintTextField,
            errorText: errorText,
            prefixIcon:
                prefixIcon != null
                    ? Icon(prefixIcon, color: AppColor.grey2, size: 20.sp)
                    : null,
            suffixIcon: suffixIcon,
            filled: true,
            fillColor: fillColor ?? AppColor.white,
            contentPadding:
                contentPadding ??
                EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? 12.r),
              borderSide: BorderSide(
                color: borderColor ?? AppColor.primary,
                width: 1,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? 12.r),
              borderSide: BorderSide(
                color: borderColor ?? AppColor.primary,
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? 12.r),
              borderSide: BorderSide(color: AppColor.primary, width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? 12.r),
              borderSide: BorderSide(color: AppColor.error, width: 1),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? 12.r),
              borderSide: BorderSide(color: AppColor.error, width: 2),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? 12.r),
              borderSide: BorderSide(color: AppColor.disabled, width: 1),
            ),
          ),
        ),
      ],
    );
  }
}
