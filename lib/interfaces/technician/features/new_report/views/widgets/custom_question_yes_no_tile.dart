import 'package:flutter/material.dart';
import 'package:fuji_maintenance_system/core/theme/app_color.dart';
import 'package:fuji_maintenance_system/core/translation/app_strings.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class QuestionYesNoTile extends StatefulWidget {
  const QuestionYesNoTile({
    super.key,
    required this.question,
    this.initialValue,
    this.onChanged,
    this.yesColor,
    this.noColor,
    this.bgColor,
  });

  final String question;
  final bool? initialValue;
  final ValueChanged<bool?>? onChanged;
  final Color? yesColor;
  final Color? noColor;
  final Color? bgColor;

  @override
  State<QuestionYesNoTile> createState() => _QuestionYesNoTileState();
}

class _QuestionYesNoTileState extends State<QuestionYesNoTile> {
  late bool? _value;

  @override
  void initState() {
    _value = widget.initialValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final yesActive = widget.yesColor ?? AppColor.primary;
    final noActive = widget.noColor ?? AppColor.primaryDark;

    final unselected = AppColor.lightGrey;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      margin: EdgeInsets.only(top: 24, left: 16, right: 16),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: AppColor.gray_3,
            offset: Offset(0, 2),
            blurRadius: 0,
            spreadRadius: 1.2,
          ),
        ],
        color: AppColor.backroyndIcon,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              widget.question,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: AppColor.blackColor,
              ),
            ),
          ),

          RadioLabel(
            label: AppStrings.yes.tr,
            value: true,
            groupValue: _value,
            activeColor: yesActive,
            unselectedColor: unselected,
            onChanged: (v) {
              setState(() => _value = v);
              widget.onChanged?.call(_value);
            },
          ),

          RadioLabel(
            label: AppStrings.no.tr,
            value: false,
            groupValue: _value,
            activeColor: noActive,
            unselectedColor: unselected,
            onChanged: (v) {
              setState(() => _value = v);
              widget.onChanged?.call(_value);
            },
          ),
        ],
      ),
    );
  }
}

class RadioLabel extends StatelessWidget {
  const RadioLabel({
    super.key,
    required this.label,
    required this.value,
    required this.groupValue,
    required this.activeColor,
    required this.unselectedColor,
    required this.onChanged,
  });

  final String label;
  final bool value;
  final bool? groupValue;
  final Color activeColor;
  final Color unselectedColor;
  final ValueChanged<bool?> onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(
      context,
    ).copyWith(unselectedWidgetColor: unselectedColor);

    return Theme(
      data: theme,
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () => onChanged(value),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,

          children: [
            Radio<bool>(
              value: value,
              groupValue: groupValue,

              fillColor: MaterialStateProperty.resolveWith((states) {
                if (states.contains(MaterialState.selected)) return activeColor;
                return unselectedColor;
              }),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              visualDensity: VisualDensity.compact,
              onChanged: (_) => onChanged(value),
            ),
            SizedBox(width: 2),
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: groupValue == value ? activeColor : AppColor.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
