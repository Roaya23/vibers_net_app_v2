// ignore_for_file: unused_element

part of "../otp_verification_screen.dart";

const int appOtpFieldsLength = 6;
const Color _fieldColor = kDarkBgLight;
const Color _focusedFieldColor = kDarkBgLight;
final Color _unFilledBorderColor = kBorderColor;
const Color _filledBorderColor = kWhite100;
const Color _focusBorderColor = kWhite100;
const Color _errorBorderColor = kRedColor;
const _fieldRadius = BorderRadius.all(
  Radius.circular(8),
);
final _textStyle = TextStyles.regular14(color: kWhiteTextColor);
final _errorTextStyle = TextStyles.regular14(color: kWhiteTextColor);
const double _unFocusBorderWidth = 1;
const double _focusBorderWidth = 1.5;

class _OtpPinCodeWidget extends StatelessWidget {
  final bool hasError;
  final String? errorMessage;
  final bool readOnly;
  final TextEditingController controller;
  final void Function(String value)? onChange;
  final void Function(String value)? onCompleted;
  final String? Function(String? value)? validator;

  const _OtpPinCodeWidget({
    required this.controller,
    this.hasError = false,
    this.errorMessage,
    this.readOnly = false,
    this.onChange,
    this.validator,
    this.onCompleted,
  });

  @override
  Widget build(BuildContext context) {
    final double fieldSize =
        ((MediaQuery.of(context).size.width / appOtpFieldsLength) -
            (appOtpFieldsLength ));
    final fieldHeight = fieldSize + (fieldSize * .091);
    
    // if (fieldSize > 48) {
    //   fieldSize = 48;
    // }
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Pinput(
        controller: controller,
        length: appOtpFieldsLength,
        readOnly: readOnly,
        showCursor: true,
        cursor: Container(
          width: 3,
          // margin: EdgeInsets.only(top: fieldSize * .3),
          height: fieldHeight * .35,
          alignment: Alignment.center,
          color: kMainThemeColor,
        ),
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly,
        ],
        keyboardType: TextInputType.phone,
        enableSuggestions: true,
        autofocus: true,
        // androidSmsAutofillMethod: AndroidSmsAutofillMethod.smsRetrieverApi,
        // preFilledWidget: Container(
        //   width: fieldSize * .3,
        //   margin: EdgeInsets.only(top: fieldHeight * .3),
        //   height: 2,
        //   alignment: Alignment.bottomCenter,
        //   color: AppColors.label,
        // ),
        defaultPinTheme: PinTheme(
          width: fieldSize,
          height: fieldHeight,
          textStyle: _textStyle,
          decoration: BoxDecoration(
            color: _fieldColor,
            borderRadius: _fieldRadius,
            border: Border.all(
              color: _filledBorderColor,
              width: _unFocusBorderWidth,
            ),
          ),
        ),
        submittedPinTheme: PinTheme(
          width: fieldSize,
          height: fieldHeight,
          textStyle: _textStyle,
          decoration: BoxDecoration(
            color: _fieldColor,
            borderRadius: _fieldRadius,
            border: Border.all(
              color: _filledBorderColor,
              width: _unFocusBorderWidth,
            ),
          ),
        ),
        followingPinTheme: PinTheme(
          width: fieldSize,
          height: fieldHeight,
          textStyle: _textStyle,
          decoration: BoxDecoration(
            color: _fieldColor,
            borderRadius: _fieldRadius,
            border: Border.all(
              color: _unFilledBorderColor,
              width: _unFocusBorderWidth,
            ),
          ),
        ),
        focusedPinTheme: PinTheme(
          width: fieldSize,
          height: fieldHeight,
          textStyle: _textStyle,
          decoration: BoxDecoration(
            color: _focusedFieldColor,
            borderRadius: _fieldRadius,
            border: Border.all(
              color: _focusBorderColor,
              width: _unFocusBorderWidth,
            ),
          ),
        ),
        errorPinTheme: PinTheme(
          width: fieldSize,
          height: fieldHeight,
          textStyle: _textStyle,
          decoration: BoxDecoration(
            color: _fieldColor,
            borderRadius: _fieldRadius,
            border: Border.all(
              color: _errorBorderColor,
              width: _focusBorderWidth,
            ),
          ),
        ),
        forceErrorState: hasError,
        errorTextStyle: _errorTextStyle,
        onChanged: onChange,
        onCompleted: onCompleted,
        validator: validator,
        errorText: errorMessage,
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
      ),
    );
  }
}
