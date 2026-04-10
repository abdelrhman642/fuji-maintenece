import 'package:flutter/material.dart';
import 'package:fuji_maintenance_system/core/theme/app_font.dart';
import 'package:fuji_maintenance_system/core/translation/app_strings.dart';
import 'package:get/get.dart';

class EmptyDataWidget extends StatefulWidget {
  const EmptyDataWidget({super.key});

  @override
  State<EmptyDataWidget> createState() => _EmptyDataWidgetState();
}

class _EmptyDataWidgetState extends State<EmptyDataWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<Offset> _slideAnimation;
  late final Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    // Slide from left (-1.5 width) to its place (0)
    _slideAnimation = Tween<Offset>(
      begin: const Offset(-1.5, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));

    // Rotate like a ball while moving, then settle (negative for CCW spin)
    _rotationAnimation = Tween<double>(
      begin: -1.5,
      end: 0.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.decelerate));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SlideTransition(
          position: _slideAnimation,
          child: RotationTransition(
            turns: _rotationAnimation,
            child: Icon(Icons.info, size: 100.sp, color: AppColor.gray_3),
          ),
        ),
        const SizedBox(height: 20),
        Text(
          AppStrings.noDataFound.tr,
          style: AppFont.font16W600Gray2,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
