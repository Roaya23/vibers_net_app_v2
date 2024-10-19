import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:vibers_net/common/styles.dart';
import 'package:vibers_net/common/text_styles.dart';
import 'package:vibers_net/ui/shared/app_image.dart';
import '/common/apipath.dart';
import '/common/route_paths.dart';
import '/models/episode.dart';
import '/providers/movie_tv_provider.dart';
import '/ui/screens/video_detail_screen.dart';
import '/ui/shared/card_seperator.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final searchController = new TextEditingController();
  late String filter;
  var focusNode = new FocusNode();
  bool descTextShowFlag = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  var found = false;

  // No result found page ui container

  Widget noResultFound() {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 15.0,
      ),
      child: InkWell(
        child: Stack(
          children: <Widget>[
            new Padding(padding: EdgeInsets.only(top: 32.0)),
            Padding(
                padding: EdgeInsets.all(10.0),
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      translate("No_Result_Found"),
                      style: TextStyles.bold16(),
                    ),
                    new Padding(padding: EdgeInsets.only(top: 12.0)),
                    Text(
                      translate("We_cant_find_any_item_matching_your_search"),
                      style: TextStyles.regular14(color: kWhite100),
                    )
                  ],
                )),
          ],
        ),
      ),
    );
  }

  // Default search page UI container
  Widget defaultSearchPage() {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 15.0,
      ),
      child: InkWell(
        child: Stack(
          children: <Widget>[
            Padding(
                padding: EdgeInsets.all(10.0),
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    new Padding(padding: EdgeInsets.only(top: 32.0)),
                    Text(
                      translate("Find_what_to_watch_next"),
                      style: TextStyles.bold16(),
                    ),
                    new Padding(padding: EdgeInsets.only(top: 12.0)),
                    Text(
                      translate(
                        "Search_for_shows_for_the_commute__movies_to_help_unwind__or_your_go_to_genres",
                      ),
                      style: TextStyles.regular14(color: kWhite100),
                    )
                  ],
                )),
          ],
        ),
      ),
    );
  }

  // Default place holder image
  Widget defaultPlaceHolderImage(index) {
    var movieTvList = Provider.of<MovieTVProvider>(context).movieTvList;
    final String imageUrl = movieTvList[index].type == DatumType.T
        ? "${APIData.tvImageUriTv}${movieTvList[index].thumbnail}"
        : "${APIData.movieImageUri}${movieTvList[index].thumbnail}";
    return Hero(
      tag: "planet-hero-${movieTvList[index].title}",
      child: AppImage.rounded(path: imageUrl, radius: 8, fit: BoxFit.cover),
    );
  }

  // search item column
  Widget searchItemColumn(index) {
    var movieTvList =
        Provider.of<MovieTVProvider>(context, listen: false).movieTvList;
    dynamic tmbdRat = movieTvList[index].rating;
    if (tmbdRat.runtimeType == int) {
      double reciprocal(double d) => 1 / d;

      reciprocal(tmbdRat.toDouble());

      tmbdRat = movieTvList[index].rating == null ? 0.0 : tmbdRat / 2;
    } else if (tmbdRat.runtimeType == String) {
      tmbdRat =
          movieTvList[index].rating == null ? 0.0 : double.parse(tmbdRat) / 2;
    } else {
      tmbdRat = movieTvList[index].rating == null ? 0.0 : tmbdRat / 2;
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Flexible(
          flex: 6,
          child: new Text(
            movieTvList[index].title!,
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
            ),
            maxLines: 2,
          ),
        ),
        new SizedBox(height: 5.0),
        movieTvList[index].description! != ''
            ? new Flexible(
                flex: 5,
                child: Text(
                  movieTvList[index].description!,
                  // style: TextStyle(color: Colors.white54),
                  style: TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.w400,
                  ),
                  maxLines: 2,

                  overflow: TextOverflow.ellipsis,
                ),
              )
            : SizedBox.shrink(),
        Padding(
          padding: EdgeInsets.only(left: 2.0),
          child: new Separator(),
        ),
        new Flexible(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Expanded(
                    flex: 1,
                    child: new Container(
                      child: new Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            new Padding(
                              padding: const EdgeInsets.only(left: 0.0),
                              child: RatingBar.builder(
                                initialRating: movieTvList[index].rating == null
                                    ? 0.0
                                    : tmbdRat,
                                minRating: 1,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 5,
                                itemSize: 25,
                                itemBuilder: (context, _) => Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                onRatingUpdate: (rating) {
                                  print(rating);
                                },
                              ),
                            )
                          ]),
                    )),
                new Container(
                  width: 32.0,
                ),
              ],
            )),
      ],
    );
  }

  // List container
  Widget listContainer(index) {
    var movieTvList =
        Provider.of<MovieTVProvider>(context, listen: false).movieTvList;
    return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          Navigator.pushNamed(context, RoutePaths.videoDetail,
              arguments: VideoDetailScreen(movieTvList[index]));
        },
        child: defaultPlaceHolderImage(index));
    // return Container(
    //   margin: const EdgeInsets.symmetric(
    //     vertical: 8.0,
    //     horizontal: 15.0,
    //   ),
    //   child: InkWell(
    //     child: Stack(
    //       children: <Widget>[
    //         new Container(
    //           child: Container(
    //             margin: EdgeInsets.fromLTRB(76.0, 16.0, 16.0, 16.0),
    //             constraints: BoxConstraints.expand(),
    //             child: searchItemColumn(index),
    //           ),
    //           height: 140.0,
    //           margin: new EdgeInsets.only(left: 46.0),
    //           decoration: new BoxDecoration(
    //             color: Theme.of(context).primaryColor.withOpacity(0.1),
    //             shape: BoxShape.rectangle,
    //             borderRadius: new BorderRadius.circular(8.0),
    //           ),
    //         ),
    //         defaultPlaceHolderImage(index),
    //       ],
    //     ),
    //     onTap: () {
    //       Navigator.pushNamed(context, RoutePaths.videoDetail,
    //           arguments: VideoDetailScreen(movieTvList[index]));
    //     },
    //   ),
    // );
  }

  // Search result item column
  Widget searchResultItemColumn() {
    var movieTvList =
        Provider.of<MovieTVProvider>(context, listen: false).movieTvList;
    return searchController.text == ''
        ? defaultSearchPage()
        : GridView.builder(
            padding: EdgeInsets.all(16),
            itemCount: movieTvList.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 16,
                childAspectRatio: 2 / 3,
                mainAxisSpacing: 12),
            itemBuilder: (context, index) {
              return '${movieTvList[index].title}'
                      .replaceAll(new RegExp(r"\s+"), "")
                      .toLowerCase()
                      .contains(filter
                          .replaceAll(new RegExp(r"\s+"), "")
                          .toLowerCase())
                  ? listContainer(index)
                  : Container();
            },
          );
  }

  // Search TexField
  Widget searchField() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: TextField(
        focusNode: focusNode,
        controller: searchController,
        style: TextStyles.regular12(color: kWhite100),
        onChanged: (value) {
          setState(() {});
        },
        decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.search,
              color: kWhite100.withOpacity(.5),
              size: 20,
            ),
            suffixIcon: AnimatedOpacity(
              duration: Durations.medium3,
              opacity: searchController.text.isNotEmpty ? 1.0 : 0.0,
              child: GestureDetector(
                  onTap: () {
                    searchController.clear();
                  },
                  behavior: HitTestBehavior.opaque,
                  child: Icon(
                    Icons.cancel,
                    size: 16,
                    color: kWhite100,
                  )),
            ),
            contentPadding: EdgeInsets.symmetric(
              vertical: 6,
            ),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: kWhite100.withOpacity(.5))),
            hintText: translate('Search_for_a_show__movie__etc'),
            border: InputBorder.none,
            hintStyle: TextStyles.regular12(color: kWhite100.withOpacity(.5))),
      ),
    );
  }

  //  App bar
  Widget appBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      title: searchField(),
      backgroundColor: Theme.of(context).primaryColorLight,
      // actions: <Widget>[
      //   Padding(
      //     padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
      //     child: searchController.text == ''
      //         ? new IconButton(
      //             icon: new Icon(
      //               Icons.search,
      //             ),
      //             onPressed: () {
      //               FocusScope.of(context).requestFocus(focusNode);
      //             },
      //           )
      //         : new IconButton(
      //             icon: new Icon(
      //               Icons.clear,
      //             ),
      //             onPressed: () {
      //               searchController.clear();
      //             },
      //           ),
      //   )
      // ],
    );
  }

  @override
  void initState() {
    super.initState();
    searchController.addListener(() {
      setState(() {
        filter = searchController.text;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var movieTVList =
        Provider.of<MovieTVProvider>(context, listen: false).movieTvList;
    if (searchController.text == '') {
      found = true;
    } else {
      for (var i = 0; i < movieTVList.length; i++) {
        var watchName = '${movieTVList[i].title}';
        watchName = watchName.replaceAll(new RegExp(r"\s+"), "").toLowerCase();
        filter = filter.replaceAll(new RegExp(r"\s+"), "").toLowerCase();
        print(watchName);
        print(filter);
        watchName.contains(filter);

        var watchListItemName =
            watchName.toLowerCase().contains(filter.toLowerCase());

        print(watchListItemName);
        if (watchListItemName == true) {
          found = true;
          break;
        } else {
          found = false;
        }
      }
    }
    return Scaffold(
      key: _scaffoldKey,
      appBar: appBar() as PreferredSizeWidget?,
      body: found == false ? noResultFound() : searchResultItemColumn(),
      backgroundColor: Theme.of(context).primaryColorDark,
    );
  }
}
