part of '../otp_verification_screen.dart';

class _DontReceiveVerificationCode extends StatelessWidget {
  final bool isEnabled;
  final bool isLoading;
  final VoidCallback onResendPressed;

  const _DontReceiveVerificationCode({
    required this.isEnabled,
    required this.isLoading,
    required this.onResendPressed,
  });

  @override
  Widget build(BuildContext context) {
    final bool isActive = isEnabled && !isLoading;
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.start,
      runAlignment: WrapAlignment.start,
      alignment: WrapAlignment.center,
      children: [
        Text(translate("didNotReceiveOTP") + "\t",
            style: TextStyles.regular12(
              color: kWhite100,
            )),
        GestureDetector(
          onTap: isActive ? onResendPressed : null,
          behavior: HitTestBehavior.opaque,
          child: Text(
            translate("resendCode"),
            style: TextStyles.regular14(
              color: !isActive ? kMainLight : kMainThemeColor,
            ),
          ),
        ),
        if (isLoading)
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            height: 10,
            width: 10,
            child: CircularProgressIndicator(
              color: kMainLight,
              strokeWidth: 2.5,
            ),
          )
      ],
    );
  }
}
