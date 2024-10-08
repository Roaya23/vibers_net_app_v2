import 'package:flutter/material.dart';

class GroupCustomButton extends StatelessWidget {
  const GroupCustomButton({
    Key? key,
    required this.onPressed,
    required this.widget,
    required this.isSelected,
    this.selectedTextStyle,
    this.unselectedTextStyle,
    this.selectedColor,
    this.unselectedColor,
    required this.selectedBorderColor,
    required this.unselectedBorderColor,
    this.borderRadius,
    this.selectedShadow,
    this.unselectedShadow,
    this.height,
    this.width,
  }) : super(key: key);

  final Widget widget;
  final void Function() onPressed;
  final bool isSelected;
  final TextStyle? selectedTextStyle;
  final TextStyle? unselectedTextStyle;
  final Color? selectedColor;
  final Color? unselectedColor;
  final Color selectedBorderColor;
  final Color unselectedBorderColor;
  final BorderRadius? borderRadius;
  final List<BoxShadow>? selectedShadow;
  final List<BoxShadow>? unselectedShadow;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: borderRadius ?? BorderRadius.circular(30),
        boxShadow: isSelected ? selectedShadow : unselectedShadow,
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          padding: WidgetStateProperty.all(EdgeInsets.zero),
          elevation: WidgetStateProperty.all<double>(0.0),
          backgroundColor: isSelected
              ? WidgetStateProperty.all<Color?>(selectedColor)
              : WidgetStateProperty.all<Color?>(unselectedColor),
          shape: WidgetStateProperty.all<OutlinedBorder>(
            RoundedRectangleBorder(
              borderRadius: borderRadius ?? BorderRadius.circular(30),
              side: BorderSide(
                color: isSelected ? selectedBorderColor : unselectedBorderColor,
              ),
            ),
          ),
        ),
        child: widget,
      ),
    );
  }
}
