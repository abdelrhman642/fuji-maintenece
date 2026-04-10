import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fuji_maintenance_system/core/theme/app_color.dart';
import 'package:get/get_utils/src/extensions/export.dart';

class CustomTextFieldBeta extends StatefulWidget {
  final String? title;
  final String hintText;
  final TextInputType? keyboardType;
  final IconData icon;
  final TextEditingController? textEditingController;
  final FormFieldValidator<String>? validator;
  final List<TextInputFormatter>? inputFormatters;
  final ValueChanged<String>? onChanged;

  final bool isPassword;
  final Color? iconColor;

  const CustomTextFieldBeta({
    super.key,
    this.title,
    required this.hintText,
    required this.icon,
    this.textEditingController,
    this.inputFormatters,
    this.validator,
    this.onChanged,
    this.keyboardType,
    this.isPassword = false,
    this.iconColor,
  });

  @override
  State<CustomTextFieldBeta> createState() => _CustomTextFieldBetaState();
}

class _CustomTextFieldBetaState extends State<CustomTextFieldBeta> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.title != null) ...[
            Text(
              widget.title!.tr,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColor.blackColor,
              ),
            ),
            SizedBox(height: 8),
          ],
          TextFormField(
            onChanged: widget.onChanged,
            inputFormatters: widget.inputFormatters,
            obscureText: _obscureText,
            keyboardType: widget.keyboardType,
            controller: widget.textEditingController,
            validator: widget.validator,
            decoration: InputDecoration(
              hintText: widget.hintText.tr,
              hintStyle: const TextStyle(
                fontSize: 16,
                color: AppColor.unselectedNavBar,
              ),

              prefixIcon: Icon(
                widget.icon,
                color: widget.iconColor ?? AppColor.blackColor,
              ),
              suffixIcon:
                  widget.isPassword
                      ? IconButton(
                        icon: Icon(
                          _obscureText
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: AppColor.blackColor,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                      )
                      : null,
              filled: true,

              fillColor: AppColor.lightGrey.withOpacity(0.2),
              contentPadding: EdgeInsets.symmetric(
                vertical: 16,
                horizontal: 12,
              ),
              border: UnderlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: AppColor.primaryDark,
                  width: 2,
                ),
              ),
              enabledBorder: UnderlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: AppColor.primaryDark, width: 2),
              ),
              focusedBorder: UnderlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: AppColor.primaryDark, width: 2),
              ),
              disabledBorder: UnderlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: AppColor.primaryDark, width: 2),
              ),
            ),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: AppColor.blackColor,
            ),
          ),
        ],
      ),
    );
  }
}
