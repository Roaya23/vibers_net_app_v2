import 'package:flutter/material.dart';
import '/common/route_paths.dart';
import '/models/episode.dart';
import '/ui/screens/video_detail_screen.dart';
import '/ui/widgets/tvseries_item.dart';

class TvSeriesList extends StatefulWidget {
  final DatumType? type;
  final loading;
  final data;
  TvSeriesList({this.type, this.loading, this.data});
  @override
  _TvSeriesListState createState() => _TvSeriesListState();
}

class _TvSeriesListState extends State<TvSeriesList> {
  @override
  Widget build(BuildContext context) {
    return widget.loading == true
        ? Container(
            height: 170,
            child: ListView.separated(
              shrinkWrap: true,
              separatorBuilder: (context, index) => const SizedBox(
                width: 10,
              ),
              physics: ClampingScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 16),
              scrollDirection: Axis.horizontal,
              itemCount: 4,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  width: 105,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: ClipRRect(
                    borderRadius: new BorderRadius.circular(8.0),
                    child: Image.asset(
                      "assets/placeholder_box.jpg",
                      isAntiAlias: true,
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            ),
          )
        : Container(
            height: 170,
            margin: EdgeInsets.only(top: 15.0),
            child: ListView.separated(
              separatorBuilder: (context, index) => const SizedBox(
                width: 10,
              ),
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 16),
              scrollDirection: Axis.horizontal,
              itemCount: widget.data.length == 0 ? 4 : widget.data.length,
              itemBuilder: (BuildContext context, int index) {
                if (widget.data.length == 0) {
                  return Container(
                    width: 105,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      borderRadius: new BorderRadius.circular(5.0),
                    ),
                    child: Image.asset(
                      "assets/placeholder_box.jpg",
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          "assets/placeholder_box.jpg",
                          isAntiAlias: true,
                          fit: BoxFit.cover,
                        );
                      },
                    ),
                  );
                } else {
                  return InkWell(
                    borderRadius: BorderRadius.circular(8.0),
                    child: TVSeriesItem(widget.data[index], context),
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        RoutePaths.videoDetail,
                        arguments: VideoDetailScreen(
                          widget.data[index],
                        ),
                      );
                    },
                  );
                }
              },
            ),
          );
  }
}
