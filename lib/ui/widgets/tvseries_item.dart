import 'package:flutter/material.dart';
import '/common/apipath.dart';

class TVSeriesItem extends StatelessWidget {
  final tvSeriesItem;
  final BuildContext context;

  TVSeriesItem(this.tvSeriesItem, this.context);

  @override
  Widget build(BuildContext context) {
    return FadeInImage.assetNetwork(
      image: APIData.tvImageUriTv + "${tvSeriesItem.thumbnail}",
      placeholder: "assets/placeholder_box.jpg",
      // height: 170,
      // width: 120.0,
      imageScale: 1.0,
      // fit: BoxFit.cover,
      imageErrorBuilder: (context, error, stackTrace) {
        return Image.asset(
          "assets/placeholder_box.jpg",
          height: 170,
          width: 120.0,
          fit: BoxFit.cover,
          isAntiAlias: true,
        );
      },
    );
  }
}
