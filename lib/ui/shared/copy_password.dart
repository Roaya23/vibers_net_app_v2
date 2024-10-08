import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:vibers_net/common/text_styles.dart';
import 'package:vibers_net/models/datum.dart';
import 'package:vibers_net/common/styles.dart';

// Share tab
class CopyPassword extends StatelessWidget {
  CopyPassword(this.videoDetail);
  final Datum videoDetail;

  @override
  Widget build(BuildContext context) {
    return new InkWell(
      onTap: () {
        Clipboard.setData(
          new ClipboardData(text: ''
              //        protectedContentPwd['${videoDetail.id}_${videoDetail.id}'],
              ),
        );
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              translate(
                'Protected_Content_Password_copied_Just_paste_it_when_ask_for_password'),
                style: TextStyles.medium14(color: kDarkTextColor),
                ),
          ),
        );
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.copy,
            size: 16.0,
            color: kWhite100,
          ),
          // new Padding(
          //   padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 10.0),
          // ),
          // Text(
          //   translate("Copy_"),
          //   style: TextStyle(
          //     fontFamily: kFontFamilyName,
          //     fontSize: 12.0,
          //     fontWeight: FontWeight.w600,
          //     letterSpacing: 0.0,
          //   ),
          // ),
        ],
      ),
    );
  }
}
