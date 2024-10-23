import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:vibers_net/common/styles.dart';
import 'package:vibers_net/common/text_styles.dart';

class AppFailWidget extends StatelessWidget {
  const AppFailWidget({super.key, this.onRetry, this.showOnlyText = false});
  final void Function()? onRetry;
  final bool showOnlyText;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onRetry,
      child: Center(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              translate("failToLoadtryAgain"),
              textAlign: TextAlign.center,
              style: TextStyles.bold14(color: kWhite100),
            ),
            const SizedBox(
              width: 8,
            ),
            const Icon(
              Icons.refresh_rounded,
              color: kWhite100,
              size: 20,
            )
          ],
        ),
      ),
    );
  }
}
