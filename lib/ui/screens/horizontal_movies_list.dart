import 'package:flutter/material.dart';
import '/common/apipath.dart';
import '/common/route_paths.dart';
import '/models/episode.dart';
import '/ui/screens/video_detail_screen.dart';

class MoviesList extends StatefulWidget {
  final DatumType? type;
  final loading;
  final data;
  MoviesList({this.type, this.loading, this.data});
  @override
  _MoviesListState createState() => _MoviesListState();
}

class _MoviesListState extends State<MoviesList> {
  @override
  Widget build(BuildContext context) {
    print("type:1 ${widget.type}");
    return Container(
      margin: EdgeInsets.symmetric(vertical: 16),
      height: 160,
      child: widget.loading == true
          ? ListView.separated(
              separatorBuilder: (context, index) => SizedBox(width: 10.0),
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              scrollDirection: Axis.horizontal,
              itemCount: 4,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  clipBehavior: Clip.antiAlias,
                  width: 105,
                  child: Image.asset(
                    "assets/placeholder_box.jpg",
                    height: double.infinity,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    isAntiAlias: true,
                  ),
                );
              },
            )
          : widget.data.length == 0
              ? SizedBox.shrink()
              : ListView.separated(
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 10.0),
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.loading == true ? 4 : widget.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    if (widget.loading == true) {
                      return Container(
                        width: 105,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Image.asset(
                          "assets/placeholder_box.jpg",
                          height: double.infinity,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          isAntiAlias: true,
                        ),
                      );
                    } else {
                      return InkWell(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Container(
                          width: 105,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: widget.data[index].thumbnail == null
                              ? Image.asset(
                                  "assets/placeholder_box.jpg",
                                  height: double.infinity,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                  isAntiAlias: true,
                                )
                              : FadeInImage.assetNetwork(
                                  image: APIData.movieImageUri +
                                      "${widget.data[index].thumbnail}",
                                  placeholder: "assets/placeholder_box.jpg",
                                  height: double.infinity,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                  imageErrorBuilder:
                                      (context, error, stackTrace) {
                                    return Image.asset(
                                      "assets/placeholder_box.jpg",
                                      height: double.infinity,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                      isAntiAlias: true,
                                    );
                                  },
                                ),
                        ),
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
