import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vibers_net/common/styles.dart';
import 'package:vibers_net/common/text_styles.dart';
import 'package:vibers_net/ui/widgets/app_button.dart';
import '/common/route_paths.dart';
import 'package:flutter_translate/flutter_translate.dart';

class BlankDownloadList extends StatefulWidget {
  @override
  _BlankDownloadListState createState() => _BlankDownloadListState();
}

class _BlankDownloadListState extends State<BlankDownloadList> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  FontAwesomeIcons.download,
                  // size: 150,
                  color: kWhite100TextColor,
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              translate(
                  "Download_movies_&_TV_shows_to_your_Device_so_you_can_easily_watch_them_later"),
              textAlign: TextAlign.center,
              style: TextStyles.regular12(color: kWhite100TextColor),
            ),
            SizedBox(
              height: 32.0,
            ),
            AppButton(
              text: translate("Find_Something_to_watch").toUpperCase(),
              textStyle: TextStyles.semiBold12(color: kDarkTextColor),
              onPressed: () {
                Navigator.pushNamed(context, RoutePaths.bottomNavigationHome);
              },
            ),
          ],
        ),
      ),
    );
  }
}
