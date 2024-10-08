import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:vibers_net/common/styles.dart';
import 'package:vibers_net/common/text_styles.dart';
import 'package:readmore/readmore.dart';

class DescriptionText extends StatelessWidget {
  DescriptionText(this.text);

  final String? text;

  @override
  Widget build(BuildContext context) {
    if (text?.isEmpty == true) {
      return const SizedBox();
    }

    return Padding(
      padding: const EdgeInsets.all(16),
      child: ReadMoreText(
        text ?? '',
        trimMode: TrimMode.Line,
        style: TextStyles.regular12(color: kWhite100.withOpacity(.6)),
        trimLines: 2,
        lessStyle: TextStyles.semiBold10(color: kMainLight),
        colorClickableText: Colors.pink,
        trimCollapsedText: "\t\t" + translate("viewMore"),
        trimExpandedText: "\t\t" + translate("viewLess"),
        moreStyle: TextStyles.semiBold10(color: kMainLight),
      ),
    );
  }
}
