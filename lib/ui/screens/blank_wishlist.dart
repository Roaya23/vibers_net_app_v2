import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vibers_net/common/styles.dart';
import 'package:vibers_net/common/text_styles.dart';
import '/common/route_paths.dart';

class BlankWishList extends StatefulWidget {
  @override
  _BlankWishListState createState() => _BlankWishListState();
}

class _BlankWishListState extends State<BlankWishList> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        Navigator.pushNamed(context, RoutePaths.bottomNavigationHome);
      },
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.add_circle_outline_outlined,
              size: 20,
              color: kWhite100TextColor,
            ),
            const SizedBox(
              height: 18,
            ),
            Text(
              translate(
                  "Add_movies_&_TV_shows_to_your_list_so_you_can_easily_find_them_later"),
              textAlign: TextAlign.center,
              style: TextStyles.regular12(
                color: kWhite100TextColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
