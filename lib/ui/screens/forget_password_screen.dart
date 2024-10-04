import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:vibers_net/common/route_paths.dart';
import 'package:vibers_net/common/styles.dart';
import 'package:vibers_net/common/text_styles.dart';
import 'package:vibers_net/models/otp/otp_verification_params.dart';
import 'package:vibers_net/ui/shared/app_image.dart';
import 'package:vibers_net/ui/widgets/app_bar_widget.dart';
import 'package:vibers_net/ui/widgets/app_button.dart';
import 'package:vibers_net/ui/widgets/app_text_form_field.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final _emailOrPhoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBarWidget(
          titleText: translate("resetPasswordTitle"),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Center(
                child: AppImage(
                  path: "assets/illstraions/forget_password_illustration.png",
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .1,
              ),
              Text(
                translate("selectAccountVerificationMethod"),
                style: TextStyles.regular12(color: kWhite100),
              ),
              const SizedBox(
                height: 32,
              ),
              AppTextFormField(
                label: translate("enterPhoneNumberOrEmailAddress"),
                controller: _emailOrPhoneController,
                validator: (text) {
                  if (text?.isEmpty == true) {
                    return "Please enter your phone or email address";
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 24,
              ),
              AppButton(
                text: translate("continue"),
                onPressed: () {
                  final isValidForm =
                      _formKey.currentState?.validate() ?? false;
                  if (isValidForm) {
                    Navigator.pushNamed(context, RoutePaths.otp,
                        arguments: OtpVerificationParams(
                            type: OtpVerificationTypeEnum.forgetPassword,
                            phone: _emailOrPhoneController.text));
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
