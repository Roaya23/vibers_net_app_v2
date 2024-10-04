import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vibers_net/common/styles.dart';
import 'package:vibers_net/common/text_styles.dart';

class AppTextFormField extends StatefulWidget {
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final int? maxLength;
  final TextStyle? inputTextStyle;
  final Clip? clipBehavior;
  final List<TextInputFormatter>? inputFormatters;
  final TextDirection? textDirection;
  final String? initialValue;
  final bool readOnly;
  final bool isTextSecured;
  final void Function()? onTap;
  final String? Function(String? text)? validator;
  final void Function(String text)? onChanged;
  final void Function(String text)? onFieldSubmitted;

  final String? label;
  final TextStyle? labelTextStyle;
  final String? hintText;
  final TextStyle? hintTextStyle;
  final InputBorder? enabledBorder;
  final InputBorder? focusedBorder;
  final InputBorder? disabledBorder;
  final InputBorder? errorBorder;
  final InputBorder? focusedErrorBorder;
  final Widget? prefixIcon;
  final BoxConstraints? prefixIconConstraints;
  final Widget? suffixIcon;

  final bool? filled;
  final Color? fillColor;

  final int? minLines;
  final int? maxLines;
  final Widget? prefix;

  final bool isRequired;
  final bool isOptional;

  const AppTextFormField({
    this.controller,
    this.keyboardType,
    this.maxLength,
    this.inputTextStyle,
    this.clipBehavior = Clip.antiAliasWithSaveLayer,
    this.inputFormatters,
    this.textDirection,
    this.initialValue,
    this.readOnly = false,
    this.isTextSecured = false,
    this.onTap,
    this.validator,
    this.onChanged,
    this.onFieldSubmitted,
    this.label,
    this.labelTextStyle,
    this.hintText,
    this.hintTextStyle,
    this.enabledBorder,
    this.focusedBorder,
    this.disabledBorder,
    this.errorBorder,
    this.focusedErrorBorder,
    this.prefixIcon,
    this.prefixIconConstraints,
    this.suffixIcon,
    this.filled,
    this.fillColor = Colors.white,
    this.minLines,
    this.maxLines,
    this.prefix,
    this.isRequired = false,
    this.isOptional = false,
  });

  @override
  State<AppTextFormField> createState() => _AppTextFormFieldState();
}

class _AppTextFormFieldState extends State<AppTextFormField> {
  bool isTextSecured = false;

  @override
  void initState() {
    isTextSecured = widget.isTextSecured;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null) ...[
          Text(
            widget.label!,
            style: TextStyles.regular14(color: kWhiteTextColor),
          ),
          SizedBox(height: 12.h),
        ],
        TextFormField(
          controller: widget.controller,
          keyboardType: widget.keyboardType,
          maxLength: widget.maxLength,
          style: widget.inputTextStyle ??
              TextStyles.medium16(color: kWhiteTextColor),
          cursorColor: Colors.white,
          clipBehavior: widget.clipBehavior!,
          inputFormatters: widget.inputFormatters,
          textDirection: widget.textDirection,
          initialValue: widget.initialValue,
          readOnly: widget.readOnly,
          obscureText: isTextSecured,
          onTap: widget.onTap,
          validator: widget.validator,
          onChanged: widget.onChanged,
          onFieldSubmitted: widget.onFieldSubmitted,
          minLines: widget.minLines ?? 1,
          maxLines: widget.maxLines ?? 1,
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintMaxLines: 10,
            errorMaxLines: 10,
            hintStyle: widget.hintTextStyle ??
                TextStyles.regular14(
                    // color: AppColors.gray350,
                    ),
            counter: const SizedBox.shrink(),
            enabledBorder: widget.enabledBorder,
            focusedBorder: widget.focusedBorder,
            disabledBorder: widget.disabledBorder,
            errorBorder: widget.errorBorder,
            focusedErrorBorder: widget.focusedErrorBorder,
            prefixIcon: widget.prefixIcon != null
                ? UnconstrainedBox(
                    child: widget.prefixIcon,
                  )
                : null,
            prefix: widget.prefix,
            prefixIconConstraints: widget.prefixIconConstraints,
            suffixIcon: widget.suffixIcon ?? _obsecureSuffix,
            filled: widget.filled,
            fillColor: widget.fillColor,
            
          ),
          
        ),
      ],
    );
  }

  Widget? get _obsecureSuffix {
    if (widget.isTextSecured) {
      return InkWell(
        child: Icon(
          !isTextSecured
              ? Icons.visibility_rounded
              : Icons.visibility_off_rounded,
          size: 16,
        ),
        onTap: () {
          setState(() {
            isTextSecured = !isTextSecured;
          });
        },
      );
    }
    return null;
  }
}
