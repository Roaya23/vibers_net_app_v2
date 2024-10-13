import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:vibers_net/common/text_styles.dart';
import 'package:vibers_net/ui/widgets/app_button.dart';
import 'package:vibers_net/ui/widgets/show_modal_bottom_sheet.dart';

class LogOutBottomSheet extends StatelessWidget {
  const LogOutBottomSheet._({Key? key, required this.onLogOutPressed})
      : super(key: key);

  final VoidCallback onLogOutPressed;

  static void show(BuildContext context,
      {required VoidCallback onLogOutPressed}) async {
    await showAppModalBottomSheet(
        title: translate("Sign_Out_"),
        context: context,
        child: LogOutBottomSheet._(
          onLogOutPressed: onLogOutPressed,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
      child: Column(
        children: [
          Text(
            translate("Are_you_sure_that_you_want_to_logout_"),
            textAlign: TextAlign.center,
            style: TextStyles.medium18(color: Colors.white),
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            children: [
              Expanded(
                  child: AppButton(
                text: translate("yesLogOut"),
                onPressed: onLogOutPressed,
                radius: 16,
                textStyle: TextStyles.regular16(color: Colors.black),
              )),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                child: AppOutlineButton(
                  text: translate("Cancel_"),
                  textStyle: TextStyles.regular16(color: Colors.white),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  radius: 16,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
