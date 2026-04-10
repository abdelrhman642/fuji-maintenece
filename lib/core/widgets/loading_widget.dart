import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../theme/app_color.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    super.key,
    this.color,
    this.size,
    this.type = LoadingType.pulse,
  });

  final Color? color;
  final double? size;
  final LoadingType type;

  @override
  Widget build(BuildContext context) {
    final loadingColor = color ?? AppColor.primary;
    final loadingSize = size ?? 24.sp;

    switch (type) {
      case LoadingType.pulse:
        return LoadingAnimationWidget.threeArchedCircle(
          color: loadingColor,
          size: loadingSize,
        );
      case LoadingType.rotation:
        return LoadingAnimationWidget.threeRotatingDots(
          color: loadingColor,
          size: loadingSize,
        );
      case LoadingType.beat:
        return LoadingAnimationWidget.beat(
          color: loadingColor,
          size: loadingSize,
        );
      case LoadingType.circular:
        return SizedBox(
          width: loadingSize,
          height: loadingSize,
          child: CircularProgressIndicator(
            color: loadingColor,
            strokeWidth: 2.0,
          ),
        );
      case LoadingType.linear:
        return SizedBox(
          width: loadingSize * 3,
          child: LinearProgressIndicator(
            color: loadingColor,
            backgroundColor: loadingColor.withOpacity(0.2),
          ),
        );
    }
  }
}

enum LoadingType { pulse, rotation, beat, circular, linear }
