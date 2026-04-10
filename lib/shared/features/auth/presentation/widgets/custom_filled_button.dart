import 'package:flutter/material.dart';

import '../../../../../core/theme/app_font.dart';
import '../../../../../core/widgets/loading_widget.dart';

class CustomFilledButton extends StatelessWidget {
  const CustomFilledButton({
    super.key,
    this.text,
    this.isLoading = false,
    this.color,
    this.height,
    this.onPressed,
    this.textSize,
    this.width,
    this.widget,
    this.ignorePressOnNotValid = false,
    this.isValid = true,
    this.borderRadius,
    this.elevation = 0,
    this.textColor,
    this.icon,
  });

  final bool isLoading;
  final Color? color;
  final Color? textColor;
  final String? text;
  final Widget? widget;
  final Widget? icon;
  final void Function()? onPressed;
  final bool isValid;
  final double? height;
  final double? width;
  final double? textSize;
  final double? borderRadius;
  final double elevation;
  final bool ignorePressOnNotValid;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: height ?? 54.h,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor:
              !isValid ? AppColor.disabled : color ?? AppColor.primary,
          elevation: elevation,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 15.r),
          ),
        ),
        onPressed:
            isLoading || (ignorePressOnNotValid && !isValid) ? null : onPressed,
        child:
            isLoading
                ? LoadingWidget(color: AppColor.white)
                : widget != null
                ? widget!
                : Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (icon != null) ...[icon!, SizedBox(width: 8.w)],
                    Text(
                      text!,
                      style: AppFont.font20W600White.copyWith(
                        overflow: TextOverflow.ellipsis,
                        fontSize: textSize ?? 20.sp,
                        fontWeight: FontWeight.w600,
                        color: textColor ?? AppColor.white,
                      ),
                    ),
                  ],
                ),
      ),
    );
  }
}
