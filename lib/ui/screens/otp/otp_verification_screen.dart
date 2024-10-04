import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:pinput/pinput.dart';
import 'package:vibers_net/common/styles.dart';
import 'package:vibers_net/common/text_styles.dart';
import 'package:vibers_net/models/otp/otp_verification_params.dart';
import 'package:vibers_net/ui/screens/manage_profile_screen.dart';
import 'package:vibers_net/ui/widgets/app_bar_widget.dart';
import 'package:vibers_net/ui/widgets/app_button.dart';

part "widgets/dont_receive_code_widget.dart";
part 'widgets/otp_pin_fields_widget.dart';
part 'widgets/resend_timer_notifier.dart';

class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({Key? key, required this.params})
      : super(key: key);
  final OtpVerificationParams params;

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final _resendOtpNotifier = _ResendOtpTimerNotifier()..startTimer();
  final TextEditingController _otpController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void onVerifyOtp(){
    final isValidForm = _formKey.currentState?.validate() ?? false;
    if(isValidForm){

    }
  }

  void onVerifySuccess(){
    switch(widget.params.type){
      case OtpVerificationTypeEnum.register:
        break;
      case OtpVerificationTypeEnum.forgetPassword:
        break;
      case OtpVerificationTypeEnum.updatePassword:
        // TODO: Handle this case.
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBarWidget(
          titleText: translate("verifyMobileNumber"),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                translate("OTPPageDescreption"),
                style: TextStyles.regular12(color: kWhite100TextColor),
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "${translate("sendTo")}\t(${widget.params.getObuscateText})",
                      style: TextStyles.regular12(color: kWhite100TextColor),
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        translate("change"),
                        style: TextStyles.regular12(color: kMainThemeColor),
                      )),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              _OtpPinCodeWidget(
                controller: _otpController,
                validator: (value) {
                  final text = value ?? '';
                  if (text.isEmpty) {
                    return translate("Enter_OTP");
                  } else if (text.length < appOtpFieldsLength) {
                    return "Otp must consist of 6 digit";
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 16,
              ),
              ValueListenableBuilder<_ResendOtpNotifierValue>(
                valueListenable: _resendOtpNotifier,
                builder: (context, value, child) {
                  if (value.isEnded) {
                    return const SizedBox(
                      height: 19,
                    );
                  }
                  return Row(
                    children: [
                      Text("${translate("resendCodeIn")}\t${value.timerText}",
                          style: TextStyles.regular14(color: kErrorRed)),
                    ],
                  );
                },
              ),
              const SizedBox(
                height: 4,
              ),
              ValueListenableBuilder<_ResendOtpNotifierValue>(
                valueListenable: _resendOtpNotifier,
                builder: (context, value, child) {
                  final bool isEnabled = value.isEnded;
                  return _DontReceiveVerificationCode(
                      isEnabled: isEnabled,
                      isLoading: false,
                      onResendPressed: () {
                        _resendOtpNotifier.startTimer();
                        // OtpCubit.of(context).resendOtp();
                      });
                },
              ),
              const SizedBox(
                height: 24,
              ),
              ValueListenableBuilder<TextEditingValue>(
                valueListenable: _otpController,
                builder: (context, value, child) {
                  return AppButton(
                    isEnabled: value.text.length >= appOtpFieldsLength,
                    text: translate("continue"),
                    onPressed: () {},
                  );
                },
              ),
              const SizedBox(
                height: 32,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _otpController.dispose();
    _resendOtpNotifier.dispose();
    super.dispose();
  }

}
