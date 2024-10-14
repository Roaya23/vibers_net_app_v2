import 'package:flutter/material.dart';
import '/common/apipath.dart';

class TVSeriesItem extends StatelessWidget {
  final tvSeriesItem;
  final BuildContext context;

  TVSeriesItem(this.tvSeriesItem, this.context);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 105,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: FadeInImage.assetNetwork(
        image: APIData.tvImageUriTv + "${tvSeriesItem.thumbnail}",
        placeholder: "assets/placeholder_box.jpg",
        fit: BoxFit.cover,
        imageErrorBuilder: (context, error, stackTrace) {
          return Image.asset(
            "assets/placeholder_box.jpg",
            fit: BoxFit.cover,
            isAntiAlias: true,
          );
        },
      ),
    );
  }
}
