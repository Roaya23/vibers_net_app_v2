import 'package:flutter/material.dart';
import '/common/apipath.dart';
import '/common/route_paths.dart';
import '/models/episode.dart';
import '/ui/screens/video_detail_screen.dart';
import '/ui/widgets/tvseries_item.dart';

class FeaturedList extends StatefulWidget {
  final menuByCat;
  FeaturedList({this.menuByCat});
  @override
  _FeaturedListState createState() => _FeaturedListState();
}

class _FeaturedListState extends State<FeaturedList> {
  @override
  Widget build(BuildContext context) {
    print("type:1 ${widget.menuByCat}");
    return widget.menuByCat.length == 0
        ? SizedBox.shrink()
        : Container(
            height: 160,
            margin: EdgeInsets.only(top: 15.0),
            child: ListView.separated(
                separatorBuilder: (BuildContext context, int index) =>
                    SizedBox(width: 10.0),
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 16),
                scrollDirection: Axis.horizontal,
                itemCount: widget.menuByCat.length,
                itemBuilder: (BuildContext context, int index) {
                  print("type:2${widget.menuByCat[index].type}");
                  return Container(
                    width: 105,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: widget.menuByCat[index].type == DatumType.T
                        ? 
                        InkWell(
                            borderRadius: BorderRadius.circular(8.0),
                            child:
                                TVSeriesItem(widget.menuByCat[index], context),
                            onTap: () {
                              Navigator.pushNamed(
                                  context, RoutePaths.videoDetail,
                                  arguments: VideoDetailScreen(
                                      widget.menuByCat[index]));
                            },
                          )
                        : InkWell(
                            borderRadius: new BorderRadius.circular(8.0),
                            child: widget.menuByCat[index].thumbnail == null
                                ? Image.asset(
                                    "assets/placeholder_box.jpg",
                                    height: double.infinity,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                    isAntiAlias: true,
                                  )
                                : FadeInImage.assetNetwork(
                                    image: APIData.movieImageUri +
                                        "${widget.menuByCat[index].thumbnail}",
                                    placeholder: "assets/placeholder_box.jpg",
                                    // height: 170,
                                    // width: 120.0,
                                    // imageScale: 1.0,
                                    fit: BoxFit.cover,
                                    imageErrorBuilder:
                                        (context, error, stackTrace) {
                                      return Image.asset(
                                        "assets/placeholder_box.jpg",
                                        // height: 170,
                                        // width: 120.0,
                                        fit: BoxFit.cover,
                                        isAntiAlias: true,
                                      );
                                    },
                                  ),
                            onTap: () {
                              Navigator.pushNamed(
                                  context, RoutePaths.videoDetail,
                                  arguments: VideoDetailScreen(
                                      widget.menuByCat[index]));
                            },
                          ),
                  );
                }),
          );
  }
}
