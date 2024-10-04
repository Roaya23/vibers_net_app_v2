import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:vibers_net/common/styles.dart';
import 'package:vibers_net/common/text_styles.dart';
import '../../common/global.dart';
import '/common/route_paths.dart';

Widget registerHereText(context) {
  return ListTile(
    title: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Flexible(
          flex: 1,
          fit: FlexFit.loose,
          child: InkWell(
            child: RichText(
              text: TextSpan(children: [
                TextSpan(
                  text: translate("If_you_dont_have_an_account") + " ",
                  style: TextStyles.regular14(
                    color: isLight ? Colors.black54 : Color(0xfffE6E6E7),
                  ),
                ),
                TextSpan(
                  text: translate('Sign_Up'),
                  style: TextStyles.regular16(
                    color: Theme.of(context).primaryColor,
                  ),
                )
              ]),
            ),
            onTap: () => Navigator.pushNamed(context, RoutePaths.register),
          ),
        ),
      ],
    ),
  );
}

Widget loginHereText(context) {
  return ListTile(
    title: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Flexible(
          flex: 1,
          fit: FlexFit.loose,
          child: InkWell(
            child: new RichText(
              text: new TextSpan(children: [
                new TextSpan(
                  text: translate("Already_have_an_account") + " ",
                  style: TextStyles.regular16(
                    color: isLight ? Colors.black54 : kWhiteTextColor,
                  ),
                ),
                TextSpan(
                  text: translate('Sign_In'),
                  style: TextStyles.regular16(
                    color: Theme.of(context).primaryColor,
                  ).copyWith(
                      decoration: TextDecoration.underline,
                      decorationColor: Theme.of(context).primaryColor),
                )
              ]),
            ),
            onTap: () => Navigator.pushNamed(context, RoutePaths.login),
          ),
        ),
      ],
    ),
  );
}
