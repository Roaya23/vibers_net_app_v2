import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vibers_net/common/styles.dart';
import 'package:vibers_net/common/text_styles.dart';

class AppButton extends StatelessWidget {
  final Color buttonColor;
  final double radius;
  final String text;
  final TextStyle? textStyle;
  final VoidCallback? onPressed;
  final Color textColor;
  final bool isLoading;
  final bool isEnabled;
  final double? elevation;
  final Widget? leading;
  final Widget? trailing;

  const AppButton({
    this.isLoading = false,
    this.isEnabled = true,
    this.buttonColor = primaryBlue,
    this.radius = 10,
    required this.text,
    this.textStyle,
    this.onPressed,
    this.textColor = kDarkTextColor,
    this.elevation,
    this.isExpanded = true,
    this.leading,
    this.trailing,
  });

  final bool isExpanded;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(
              radius,
            ),
          ).r,
          gradient: isEnabled == false || isLoading
              ? null
              : LinearGradient(
                  colors: const [
                      Color(0xff8F6E1B),
                      Color(0xffFAC43D),
                    ],
                  begin: AlignmentDirectional.centerStart,
                  end: AlignmentDirectional.centerEnd)),
      child: ElevatedButton(
        onPressed: isLoading || isEnabled == false ? null : onPressed,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        style: ElevatedButton.styleFrom(
          elevation: elevation,
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
          disabledBackgroundColor: buttonColor.withOpacity(.3),
          backgroundColor: buttonColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(
                radius,
              ),
            ).r,
          ),
        ),
        child: AnimatedSize(
          duration: Durations.medium1,
          alignment: Alignment.center,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: isExpanded ? MainAxisSize.max : MainAxisSize.min,
            children: [
              if (leading != null) ...[
                SizedBox(width: 5.w),
                leading!,
              ],
              Flexible(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.center,
                  child: Text(
                    text,
                    style: textStyle ?? TextStyles.bold15(color: textColor),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                  ),
                ),
              ),
              if (trailing != null) ...[
                SizedBox(width: 5.w),
                (isLoading)
                    ? _LoadingWidth(
                        color: textColor,
                      )
                    : trailing!
              ] else ...[
                SizedBox(width: 5.w),
                if (isLoading)
                  _LoadingWidth(
                    color: textColor,
                  )
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class AppOutlineButton extends StatelessWidget {
  final Color borderColor;
  final double radius;
  final String text;
  final VoidCallback? onPressed;
  final Color textColor;
  final TextStyle? textStyle;
  final bool isLoading;
  final bool isEnabled;
  final double? elevation;
  final Widget? leading;
  final bool isExpanded;
  final Widget? trailing;
  final double borderWidth;

  const AppOutlineButton({
    this.isLoading = false,
    this.isEnabled = true,
    this.borderColor = Colors.white,
    this.radius = 10,
    required this.text,
    this.textStyle,
    this.onPressed,
    this.textColor = kWhite100,
    this.elevation,
    this.isExpanded = true,
    this.leading,
    this.trailing,
    this.borderWidth = 1,
  });

  @override
  Widget build(BuildContext context) {
    final borderStateColor =
        isLoading || isEnabled == false ? kGrey400 : borderColor;
    final textStateColor =
        isLoading || isEnabled == false ? kGrey400 : textColor;
    return OutlinedButton(
      onPressed: isLoading || isEnabled == false ? null : onPressed,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      style: OutlinedButton.styleFrom(
        elevation: elevation,
        side: BorderSide(
          color: borderStateColor,
          width: borderWidth,
        ),
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
        // disabledBackgroundColor: buttonColor.withOpacity(.5),
        // backgroundColor: buttonColor,

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(
              radius,
            ),
          ).r,
        ),
      ),
      child: AnimatedSize(
        duration: Durations.medium1,
        alignment: Alignment.center,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: isExpanded ? MainAxisSize.max : MainAxisSize.min,
          children: [
            if (leading != null) ...[
              SizedBox(width: 5.w),
              leading!,
            ],
            Flexible(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.center,
                child: Text(
                  text,
                  style:
                      textStyle ?? TextStyles.regular16(color: textStateColor),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                ),
              ),
            ),
            if (trailing != null) ...[
              SizedBox(width: 5.w),
              (isLoading)
                  ? _LoadingWidth(
                      color: textColor,
                    )
                  : trailing!
            ] else ...[
              SizedBox(width: 5.w),
              if (isLoading)
                _LoadingWidth(
                  color: textColor,
                )
            ],
          ],
        ),
      ),
    );
  }
}

class _LoadingWidth extends StatelessWidget {
  const _LoadingWidth({
    required this.color,
  });

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 12,
      width: 12,
      margin: const EdgeInsetsDirectional.only(start: 12),
      child: CircularProgressIndicator(
        color: color,
        strokeWidth: 3,
      ),
    );
  }
}
