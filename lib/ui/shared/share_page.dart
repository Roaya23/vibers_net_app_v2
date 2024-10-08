import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:vibers_net/common/styles.dart';

// Share tab
class SharePage extends StatelessWidget {
  SharePage(this.shareType, this.shareId);
  final shareType;
  final shareId;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(24),
      onTap: () {
        Share.share('$shareType' + '$shareId');
      },
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Icon(
          Icons.share,
          size: 16,
          color: kWhite100TextColor,
        ),
      ),
    );
  }
}
