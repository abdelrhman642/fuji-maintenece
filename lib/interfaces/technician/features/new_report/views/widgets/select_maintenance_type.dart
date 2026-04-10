import 'package:flutter/material.dart';
import 'package:fuji_maintenance_system/core/theme/app_font.dart';
import 'package:get/get.dart';

class CustomContainerMaintenanceType extends StatefulWidget {
  const CustomContainerMaintenanceType({
    super.key,
    this.onTap,

    this.height = 117,
    this.width = 163,
    this.radius = 20,
    this.backgroundColor = Colors.white,
    this.boxShadow,

    this.borderColor = AppColor.primary,
    this.borderWidth = 1,

    this.icon = Icons.query_builder,
    this.iconSize = 40,
    this.iconColor = AppColor.blackColor,
    this.showIcon = true,

    required this.title,
    this.translateTitle = true,
    this.titleStyle,
    this.titleAlign = TextAlign.center,

    this.splashColor,

    this.isSelected = false,
    this.selectedBackgroundColor = AppColor.primary,
    this.selectedBorderColor = AppColor.primary,
    this.selectedIconColor = Colors.white,
    this.selectedTextColor = Colors.white,

    this.enablePressEffect = true,
    this.pressAnimDuration = const Duration(milliseconds: 120),
  });

  final VoidCallback? onTap;

  final double height;
  final double width;
  final double radius;
  final Color backgroundColor;
  final List<BoxShadow>? boxShadow;

  final Color borderColor;
  final double borderWidth;

  final IconData? icon;
  final double iconSize;
  final Color iconColor;
  final bool showIcon;

  final String title;
  final bool translateTitle;
  final TextStyle? titleStyle;
  final TextAlign titleAlign;

  final Color? splashColor;

  final bool isSelected;
  final Color selectedBackgroundColor;
  final Color selectedBorderColor;
  final Color selectedIconColor;
  final Color selectedTextColor;
  final bool enablePressEffect;
  final Duration pressAnimDuration;

  @override
  State<CustomContainerMaintenanceType> createState() =>
      _CustomContainerMaintenanceTypeState();
}

class _CustomContainerMaintenanceTypeState
    extends State<CustomContainerMaintenanceType> {
  bool _pressed = false;

  List<BoxShadow> get _defaultShadow => [
    BoxShadow(
      // ignore: deprecated_member_use
      color: AppColor.black.withOpacity(0.10),
      blurRadius: 18,
      offset: Offset(0, 8),
    ),
    BoxShadow(
      // ignore: deprecated_member_use
      color: AppColor.black.withOpacity(0.04),
      blurRadius: 6,
      offset: const Offset(0, 2),
    ),
  ];

  List<BoxShadow> get _pressedShadow => [
    BoxShadow(
      color: AppColor.black..withOpacity(0.08),
      blurRadius: 10,
      offset: const Offset(0, 4),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final effectiveShadow =
        widget.boxShadow ??
        (_pressed && widget.enablePressEffect
            ? _pressedShadow
            : _defaultShadow);

    final currentBackgroundColor =
        widget.isSelected
            ? widget.selectedBackgroundColor
            : widget.backgroundColor;
    final currentBorderColor =
        widget.isSelected ? widget.selectedBorderColor : widget.borderColor;
    final currentIconColor =
        widget.isSelected ? widget.selectedIconColor : widget.iconColor;
    final currentTextColor =
        widget.isSelected ? widget.selectedTextColor : null;

    return Material(
      color: AppColor.black.withOpacity(0),
      borderRadius: BorderRadius.circular(widget.radius.r),
      child: InkWell(
        borderRadius: BorderRadius.all(Radius.circular(widget.radius.r)),
        splashColor: (widget.splashColor ?? AppColor.primary.withOpacity(0.2)),
        highlightColor: AppColor.primary.withOpacity(0.06),
        onTap: widget.onTap,
        onTapDown:
            widget.enablePressEffect
                ? (_) => setState(() => _pressed = true)
                : null,
        onTapUp:
            widget.enablePressEffect
                ? (_) => setState(() => _pressed = false)
                : null,
        onTapCancel:
            widget.enablePressEffect
                ? () => setState(() => _pressed = false)
                : null,
        child: AnimatedContainer(
          duration: widget.pressAnimDuration,
          curve: Curves.easeOut,
          height: widget.height.h,
          width: widget.width,
          alignment: Alignment.center,
          padding: EdgeInsets.all(20.r),
          transform:
              widget.enablePressEffect && _pressed
                  // ignore: deprecated_member_use
                  ? (Matrix4.identity()..translate(0.0, 2.0))
                  : Matrix4.identity(),
          decoration: BoxDecoration(
            color: currentBackgroundColor,
            border: Border.all(
              color: currentBorderColor,
              width: widget.borderWidth,
            ),
            borderRadius: BorderRadius.circular(widget.radius.r),
            boxShadow: effectiveShadow,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (widget.showIcon && widget.icon != null)
                Icon(
                  widget.icon,
                  size: widget.iconSize.r,
                  color: currentIconColor,
                ),
              SizedBox(height: 8.h),
              Text(
                widget.translateTitle ? widget.title.tr : widget.title,
                textAlign: widget.titleAlign,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: (widget.titleStyle ?? AppFont.font14W600Black).copyWith(
                  color: currentTextColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
