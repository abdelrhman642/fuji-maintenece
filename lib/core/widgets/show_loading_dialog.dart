import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

Future<dynamic> showLoadingDialog(BuildContext context) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (dialogContext) => const CustomLoadingIndicator(),
  );
}

class CustomLoadingIndicator extends StatelessWidget {
  const CustomLoadingIndicator({super.key, this.color});
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ColorFiltered(
        colorFilter: ColorFilter.mode(
          color ?? Theme.of(context).primaryColor,
          BlendMode.srcIn,
        ),
        child: Lottie.asset(
          'assets/loading.json',
          width: 100,
          height: 100,
          fit: BoxFit.contain,
          repeat: true,
          animate: true,
        ),
      ),
    );
  }
}
