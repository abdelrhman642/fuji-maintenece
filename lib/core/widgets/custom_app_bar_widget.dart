import 'package:flutter/material.dart';
import 'package:fuji_maintenance_system/core/theme/app_color.dart';
import 'package:go_router/go_router.dart';

class CustomAppBarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  const CustomAppBarWidget({
    super.key,
    required this.title,
    this.actions,
    this.backgroundColor,
    this.textColor,
    this.bottom,
  });

  final String title;
  final List<Widget>? actions;
  final Color? backgroundColor;
  final Color? textColor;
  final PreferredSizeWidget? bottom;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      backgroundColor: backgroundColor ?? AppColor.primaryDark,
      foregroundColor: textColor ?? AppColor.white,
      title: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
      ),
      centerTitle: true,
      leading:
          (context.canPop())
              ? GestureDetector(
                onTap: () => context.pop(),
                child: Container(
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.all(5),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: FittedBox(
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: AppColor.white,
                      size: 20,
                    ),
                  ),
                ),
              )
              : null,
      actions: [if (actions != null) ...actions!],
      bottom: bottom,
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(kToolbarHeight + (bottom?.preferredSize.height ?? 0));
}
