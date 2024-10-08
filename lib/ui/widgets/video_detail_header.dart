import 'dart:developer';
import 'dart:io';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:vibers_net/common/styles.dart';
import 'package:vibers_net/common/text_styles.dart';
import 'package:vibers_net/models/user_profile_model.dart';
import 'package:vibers_net/providers/app_config.dart';
import 'package:vibers_net/services/download/download_page.dart';
import 'package:vibers_net/ui/shared/copy_password.dart';
import 'package:vibers_net/ui/shared/rate_us.dart';
import 'package:vibers_net/ui/shared/share_page.dart';
import 'package:vibers_net/ui/shared/wishlist.dart';
import 'package:vibers_net/ui/widgets/app_button.dart';
// import '../../common/google-ads.dart';
import '../../models/CountViewModel.dart';
import '../../models/Subtitles.dart';
import '../../providers/count_view_provider.dart';
import '/common/apipath.dart';
import '/common/global.dart';
import '/common/route_paths.dart';
import '/models/datum.dart';
import '/models/episode.dart';
import '/player/iframe_player.dart';
import '/player/m_player.dart';
import '/player/player.dart';
import '/player/playerMovieTrailer.dart';
import '/player/player_episodes.dart';
import '/providers/user_profile_provider.dart';
import '/ui/widgets/video_header_diagonal.dart';
import 'package:provider/provider.dart';

class VideoDetailHeader extends StatefulWidget {
  VideoDetailHeader(this.videoDetail, this.userProfileModel);

  final Datum? videoDetail;
  final UserProfileModel? userProfileModel;

  @override
  VideoDetailHeaderState createState() => VideoDetailHeaderState();
}

class VideoDetailHeaderState extends State<VideoDetailHeader>
    with WidgetsBindingObserver {
  var dMsg = '';
  var hdUrl;
  var sdUrl;
  var mReadyUrl,
      mIFrameUrl,
      mUrl360,
      mUrl480,
      mUrl720,
      mUrl1080,
      youtubeUrl,
      vimeoUrl,
      uploadVideo;

  bool notAdult() {
    bool canWatch = true;
    if (widget.videoDetail!.maturityRating == MaturityRating.ADULT) {
      log('Adult Content');
      if (int.parse(widget.userProfileModel!.user!.age.toString()) <= 18) {
        canWatch = false;
      }
    }
    return canWatch;
  }

  getAllScreens(mVideoUrl, type, subtitles) async {
    log("Video Details :-> ${widget.videoDetail?.toJson().toString()}");
    bool canWatch = notAdult();
    if (canWatch) {
      if (type == "CUSTOM") {
        addHistory(widget.videoDetail!.type, widget.videoDetail!.id);
        var router = new MaterialPageRoute(
          builder: (BuildContext context) => new MyCustomPlayer(
            url: mVideoUrl,
            title: widget.videoDetail!.title!,
            downloadStatus: 1,
            subtitles: subtitles,
          ),
        );
        Navigator.of(context).push(router);
      } else if (type == "EMD") {
        addHistory(widget.videoDetail!.type, widget.videoDetail!.id);
        var router = new MaterialPageRoute(
          builder: (BuildContext context) => IFramePlayerPage(url: mVideoUrl),
        );
        Navigator.of(context).push(router);
      } else if (type == "JS") {
        addHistory(widget.videoDetail!.type, widget.videoDetail!.id);
        var router = new MaterialPageRoute(
          builder: (BuildContext context) => PlayerMovie(
            id: widget.videoDetail!.id,
            type: widget.videoDetail!.type,
          ),
        );
        Navigator.of(context).push(router);
      }
    } else {
      log("You can't access this content!");
      Fluttertoast.showToast(
        msg: translate("You_cant_access_this_content_"),
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  var appconfig;
  @override
  void initState() {
    super.initState();
    appconfig = Provider.of<AppConfig>(context, listen: false).appModel;
  }

  Future<String?> addHistory(vType, id) async {
    var type = vType == DatumType.M ? "M" : "T";
    final response = await http.get(
        Uri.parse(
            "${APIData.addWatchHistory}/$type/$id?secret=${APIData.secretKey}"),
        headers: {HttpHeaders.authorizationHeader: "Bearer $authToken"});
    log("Add to Watch History API Input :-> Type = $type, ID = $id");
    log("Add to Watch History API Status Code :-> ${response.statusCode}");
    log("Add to Watch History API Response :-> ${response.body}");
    if (response.statusCode == 200) {
    } else {
      throw "can't added to history.";
    }
    return null;
  }

  void _showMsg() {
    var userDetails = Provider.of<UserProfileProvider>(context, listen: false)
        .userProfileModel!;
    if (userDetails.paypal!.length == 0 ||
        userDetails.user!.subscriptions == null ||
        userDetails.user!.subscriptions!.length == 0) {
      dMsg = translate(
              "Watch_unlimited_movies__TV_shows_and_videos_in_HD_or_SD_quality") +
          " " +
          translate("You_dont_have_subscribe");
    } else {
      dMsg = translate(
              "Watch_unlimited_movies__TV_shows_and_videos_in_HD_or_SD_quality") +
          " " +
          translate("You_dont_have_any_active_subscription_plan");
    }
    // set up the button
    Widget cancelButton = TextButton(
      child: Text(
        translate("Cancel_"),
        style: TextStyle(color: activeDotColor, fontSize: 16.0),
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    Widget subscribeButton = TextButton(
      child: Text(
        translate("Subscribe_"),
        style: TextStyle(color: activeDotColor, fontSize: 16.0),
      ),
      onPressed: () {
        Navigator.pop(context);
        Navigator.pushNamed(context, RoutePaths.subscriptionPlans);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      contentPadding:
          EdgeInsets.only(top: 10.0, left: 16.0, right: 16.0, bottom: 0.0),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            translate("Subscription_Plans"),
            style: TextStyle(color: Colors.black),
          ),
        ],
      ),
      content: Row(
        children: <Widget>[
          Flexible(
            flex: 1,
            fit: FlexFit.loose,
            child: Text(
              "$dMsg",
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          )
        ],
      ),
      actions: [
        subscribeButton,
        cancelButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void _showDialog(i) {
    log("Video Details :-> ${widget.videoDetail?.toJson().toString()}");
    var videoLinks;
    var episodeUrl;
    var episodeTitle;
    episodeUrl = widget.videoDetail!.seasons![newSeasonIndex].episodes;
    episodeTitle = episodeUrl![0].title;
    videoLinks = episodeUrl![0].videoLink;

    var subtitles = Subtitles1.fromJson(episodeUrl![0].subtitles);
    log("Subtitles :-> ${subtitles.toJson()}");

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          backgroundColor: Color.fromRGBO(250, 250, 250, 1.0),
          title: Text(
            translate("Video_Quality"),
            style: TextStyle(
              color: Color.fromRGBO(72, 163, 198, 1.0),
              fontWeight: FontWeight.w600,
              fontSize: 20.0,
            ),
            textAlign: TextAlign.center,
          ),
          content: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  translate(
                      "Select_Video_Format_in_which_you_want_to_play_video"),
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.7),
                    fontSize: 12.0,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                videoLinks.url360 == null
                    ? SizedBox.shrink()
                    : Padding(
                        padding: EdgeInsets.only(left: 50.0, right: 50.0),
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all<Color?>(
                              activeDotColor,
                            ),
                            overlayColor: WidgetStateProperty.all<Color?>(
                              Color.fromRGBO(72, 163, 198, 1.0),
                            ),
                          ),
                          child: Container(
                            alignment: Alignment.center,
                            width: 100.0,
                            height: 30.0,
                            child: Text("360"),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                            print("season Url: ${videoLinks.url360}");
                            var hdUrl = videoLinks.url360;
                            var hdTitle = episodeTitle;
                            freeTrial(hdUrl, "CUSTOM", hdTitle, subtitles);
                          },
                        ),
                      ),
                videoLinks.url480 == null
                    ? SizedBox.shrink()
                    : Padding(
                        padding: EdgeInsets.only(left: 50.0, right: 50.0),
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all<Color?>(
                              activeDotColor,
                            ),
                            overlayColor: WidgetStateProperty.all<Color?>(
                              Color.fromRGBO(72, 163, 198, 1.0),
                            ),
                          ),
                          child: Container(
                            alignment: Alignment.center,
                            width: 100.0,
                            height: 30.0,
                            child: Text("480"),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                            print("season Url: ${videoLinks.url480}");
                            var hdUrl = videoLinks.url480;
                            var hdTitle = episodeTitle;
                            freeTrial(hdUrl, "CUSTOM", hdTitle, subtitles);
                          },
                        ),
                      ),
                videoLinks.url720 == null
                    ? SizedBox.shrink()
                    : Padding(
                        padding: EdgeInsets.only(left: 50.0, right: 50.0),
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all<Color?>(
                              activeDotColor,
                            ),
                            overlayColor: WidgetStateProperty.all<Color?>(
                              Color.fromRGBO(72, 163, 198, 1.0),
                            ),
                          ),
                          child: Container(
                            alignment: Alignment.center,
                            width: 100.0,
                            height: 30.0,
                            child: Text("720"),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                            print("season Url: ${videoLinks.url720}");
                            var hdUrl = videoLinks.url720;
                            var hdTitle = episodeTitle;
                            freeTrial(hdUrl, "CUSTOM", hdTitle, subtitles);
                          },
                        ),
                      ),
                videoLinks.url1080 == null
                    ? SizedBox.shrink()
                    : Padding(
                        padding: EdgeInsets.only(left: 50.0, right: 50.0),
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all<Color?>(
                              activeDotColor,
                            ),
                            overlayColor: WidgetStateProperty.all<Color?>(
                              Color.fromRGBO(72, 163, 198, 1.0),
                            ),
                          ),
                          child: Container(
                            alignment: Alignment.center,
                            width: 100.0,
                            height: 30.0,
                            child: Text("1080"),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                            print("season Url: ${videoLinks.url1080}");
                            var hdUrl = videoLinks.url1080;
                            var hdTitle = episodeTitle;
                            freeTrial(hdUrl, "CUSTOM", hdTitle, subtitles);
                          },
                        ),
                      ),
              ],
            ),
          ),
        );
      },
    );
  }

  freeTrial(videoURL, type, title, subtitles) {
    bool canWatch = notAdult();
    if (canWatch) {
      if (type == "EMD") {
        print("mIFrameUrl22");
        addHistory(widget.videoDetail!.type, widget.videoDetail!.id);
        var router = new MaterialPageRoute(
          builder: (BuildContext context) => IFramePlayerPage(url: mIFrameUrl),
        );
        Navigator.of(context).push(router);
      } else if (type == "CUSTOM") {
        addHistory(widget.videoDetail!.type, widget.videoDetail!.id);
        var router1 = new MaterialPageRoute(
          builder: (BuildContext context) => MyCustomPlayer(
            url: videoURL,
            title: title,
            downloadStatus: 1,
            subtitles: subtitles,
          ),
        );
        Navigator.of(context).push(router1);
      } else {
        addHistory(widget.videoDetail!.type, widget.videoDetail!.id);
        var router = new MaterialPageRoute(
          builder: (BuildContext context) => PlayerEpisode(id: videoURL),
        );
        Navigator.of(context).push(router);
      }
    } else {
      log("You can't access this content!");
      Fluttertoast.showToast(
        msg: translate("You_cant_access_this_content_"),
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  void _onTapPlay() {
    if (widget.videoDetail!.type == DatumType.T) {
      var videoLinks;
      var episodeUrl;
      episodeUrl = widget.videoDetail!.seasons![newSeasonIndex].episodes;
      videoLinks = episodeUrl![0].videoLink;

      var subtitles = Subtitles1.fromJson(episodeUrl![0].subtitles);
      log("Subtitles :-> ${subtitles.toJson()}");

      log("Video Details :-> ${widget.videoDetail?.toJson().toString()}");

      mReadyUrl = videoLinks.readyUrl;
      mUrl360 = videoLinks.url360;
      mUrl480 = videoLinks.url480;
      mUrl720 = videoLinks.url720;
      mUrl1080 = videoLinks.url1080;
      mIFrameUrl = videoLinks.iframeurl;

      if (mIFrameUrl != null ||
          mReadyUrl != null ||
          mUrl360 != null ||
          mUrl480 != null ||
          mUrl720 != null ||
          mUrl1080 != null) {
        if (mIFrameUrl != null) {
          var matchIFrameUrl = mIFrameUrl.substring(0, 24);
          if (matchIFrameUrl == 'https://drive.google.com') {
            var rep = mIFrameUrl.split('/d/').last;
            rep = rep.split('/preview').first;
            var newurl =
                "https://www.googleapis.com/drive/v3/files/$rep?alt=media&key=${APIData.googleDriveApi}";
            getAllScreens(newurl, "CUSTOM", subtitles);
          } else {
            getAllScreens(mIFrameUrl, "EMD", subtitles);
          }
        } else if (mReadyUrl != null) {
          var checkMp4 = videoLinks.readyUrl.substring(mReadyUrl.length - 4);
          var checkMpd = videoLinks.readyUrl.substring(mReadyUrl.length - 4);
          var checkWebm = videoLinks.readyUrl.substring(mReadyUrl.length - 5);
          var checkMkv = videoLinks.readyUrl.substring(mReadyUrl.length - 4);
          var checkM3u8 = videoLinks.readyUrl.substring(mReadyUrl.length - 5);

          if (videoLinks.readyUrl.substring(0, 18) == "https://vimeo.com/" ||
              videoLinks.readyUrl.substring(0, 25) ==
                  "https://player.vimeo.com/") {
            getAllScreens(episodeUrl[0]['id'], "JS", subtitles);
          } else if (videoLinks.readyUrl.substring(0, 29) ==
              'https://www.youtube.com/embed') {
            getAllScreens(mReadyUrl, "EMD", subtitles);
          } else if (videoLinks.readyUrl.substring(0, 23) ==
              'https://www.youtube.com') {
            getAllScreens(episodeUrl[0]['id'], "JS", subtitles);
          } else if (checkMp4 == ".mp4" ||
              checkMpd == ".mpd" ||
              checkWebm == ".webm" ||
              checkMkv == ".mkv" ||
              checkM3u8 == ".m3u8") {
            getAllScreens(mReadyUrl, "CUSTOM", subtitles);
          } else {
            getAllScreens(episodeUrl[0]['id'], "JS", subtitles);
          }
        } else if (mUrl360 != null ||
            mUrl480 != null ||
            mUrl720 != null ||
            mUrl1080 != null) {
          _showDialog(0);
        } else {
          getAllScreens(seasonEpisodeData[0]['id'], "JS", subtitles);
        }
      } else {
        Fluttertoast.showToast(msg: translate("Video_URL_doesnt_exist"));
      }
    } else {
      var videoLink = widget.videoDetail!.videoLink!;
      var subtitles = widget.videoDetail!.subtitles;

      var vLink = videoLink.toJson();
      log("Video Link :-> $vLink");
      mIFrameUrl = videoLink.iframeurl;
      print("Iframe: $mIFrameUrl");
      mReadyUrl = videoLink.readyUrl;
      print("Ready Url: $mReadyUrl");
      mUrl360 = videoLink.url360;
      print("Url 360: $mUrl360");
      mUrl480 = videoLink.url480;
      print("Url 480: $mUrl480");
      mUrl720 = videoLink.url720;
      print("Url 720: $mUrl720");
      mUrl1080 = videoLink.url1080;
      print("Url 1080: $mUrl1080");
      String uvURL = videoLink.uploadVideo.toString();
      uploadVideo =
          uvURL.contains(' ') ? uvURL.replaceAll(RegExp(r' '), '%20') : uvURL;
      print("Upload Video: $uploadVideo");
      if (mIFrameUrl == null &&
          mReadyUrl == null &&
          mUrl360 == null &&
          mUrl480 == null &&
          mUrl720 == null &&
          mUrl1080 == null &&
          uploadVideo == null) {
        Fluttertoast.showToast(msg: translate("Video_is_not_available"));
      } else {
        if (mUrl360 != null ||
            mUrl480 != null ||
            mUrl720 != null ||
            mUrl1080 != null) {
          _showQualityDialog(mUrl360, mUrl480, mUrl720, mUrl1080, subtitles);
        } else {
          if (mIFrameUrl != null) {
            var matchIFrameUrl = mIFrameUrl.substring(0, 24);
            if (matchIFrameUrl == 'https://drive.google.com') {
              var rep = mIFrameUrl.split('/d/').last;
              rep = rep.split('/preview').first;
              var newurl =
                  "https://www.googleapis.com/drive/v3/files/$rep?alt=media&key=${APIData.googleDriveApi}";
              getAllScreens(newurl, "CUSTOM", subtitles);
            } else {
              print("mIFrameUrl $mIFrameUrl");
              getAllScreens(mIFrameUrl, "EMD", subtitles);
            }
          } else if (mReadyUrl != null) {
            var matchUrl = mReadyUrl;
            var checkMp4 = mReadyUrl.substring(mReadyUrl.length - 4);
            var checkMpd = mReadyUrl.substring(mReadyUrl.length - 4);
            var checkWebm = mReadyUrl.substring(mReadyUrl.length - 5);
            var checkMkv = mReadyUrl.substring(mReadyUrl.length - 4);
            var checkM3u8 = mReadyUrl.substring(mReadyUrl.length - 5);

            if (matchUrl.substring(0, 18) == "https://vimeo.com/" ||
                matchUrl.substring(0, 25) == "https://player.vimeo.com/") {
              var router = new MaterialPageRoute(
                builder: (BuildContext context) => PlayerMovie(
                  id: widget.videoDetail!.id,
                  type: widget.videoDetail!.type,
                ),
              );
              Navigator.of(context).push(router);
            } else if (matchUrl == 'https://www.youtube.com/embed') {
              var url = '$mReadyUrl';
              getAllScreens(url, "EMD", subtitles);
            } else if (matchUrl.substring(0, 23) == 'https://www.youtube.com') {
              getAllScreens(mReadyUrl, "JS", subtitles);
            } else if (checkMp4 == ".mp4" ||
                checkMpd == ".mpd" ||
                checkWebm == ".webm" ||
                checkMkv == ".mkv" ||
                checkM3u8 == ".m3u8") {
              getAllScreens(mReadyUrl, "CUSTOM", subtitles);
            } else {
              getAllScreens(mReadyUrl, "JS", subtitles);
            }
          } else if (uploadVideo != null) {
            getAllScreens(uploadVideo, "CUSTOM", subtitles);
          }
        }
      }
    }
  }

  void _showQualityDialog(mUrl360, mUrl480, mUrl720, mUrl1080, subtitles) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
          ),
          backgroundColor: Color.fromRGBO(250, 250, 250, 1.0),
          title: Text(
            translate("Video_Quality"),
            style: TextStyle(
              color: Color.fromRGBO(72, 163, 198, 1.0),
              fontWeight: FontWeight.w600,
              fontSize: 20.0,
            ),
            textAlign: TextAlign.center,
          ),
          content: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  translate(
                      "Select_Video_Format_in_which_you_want_to_play_video"),
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.7),
                    fontSize: 12.0,
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                mUrl360 == null
                    ? SizedBox.shrink()
                    : Padding(
                        padding: EdgeInsets.only(left: 50.0, right: 50.0),
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all<Color?>(
                              activeDotColor,
                            ),
                            overlayColor: WidgetStateProperty.all<Color?>(
                              Color.fromRGBO(72, 163, 198, 1.0),
                            ),
                          ),
                          child: Container(
                            alignment: Alignment.center,
                            width: 100.0,
                            height: 30.0,
                            child: Text("360"),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                            getAllScreens(mUrl360, "CUSTOM", subtitles);
                          },
                        ),
                      ),
                SizedBox(
                  height: 5.0,
                ),
                mUrl480 == null
                    ? SizedBox.shrink()
                    : Padding(
                        padding: EdgeInsets.only(left: 50.0, right: 50.0),
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all<Color?>(
                              activeDotColor,
                            ),
                            overlayColor: WidgetStateProperty.all<Color?>(
                              Color.fromRGBO(72, 163, 198, 1.0),
                            ),
                          ),
                          child: Container(
                            alignment: Alignment.center,
                            width: 100.0,
                            height: 30.0,
                            child: Text("480"),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                            getAllScreens(mUrl480, "CUSTOM", subtitles);
                          },
                        ),
                      ),
                SizedBox(
                  height: 5.0,
                ),
                mUrl720 == null
                    ? SizedBox.shrink()
                    : Padding(
                        padding: EdgeInsets.only(left: 50.0, right: 50.0),
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all<Color?>(
                              activeDotColor,
                            ),
                            overlayColor: WidgetStateProperty.all<Color?>(
                              Color.fromRGBO(72, 163, 198, 1.0),
                            ),
                          ),
                          child: Container(
                            alignment: Alignment.center,
                            width: 100.0,
                            height: 30.0,
                            child: Text("720"),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                            getAllScreens(mUrl720, "CUSTOM", subtitles);
                          },
                        ),
                      ),
                SizedBox(
                  height: 5.0,
                ),
                mUrl1080 == null
                    ? SizedBox.shrink()
                    : Padding(
                        padding: EdgeInsets.only(left: 50.0, right: 50.0),
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all<Color?>(
                              activeDotColor,
                            ),
                            overlayColor: WidgetStateProperty.all<Color?>(
                              Color.fromRGBO(72, 163, 198, 1.0),
                            ),
                          ),
                          child: Container(
                            alignment: Alignment.center,
                            width: 100.0,
                            height: 30.0,
                            child: Text("1080"),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                            getAllScreens(mUrl1080, "CUSTOM", subtitles);
                          },
                        ),
                      ),
                SizedBox(
                  height: 5.0,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _onTapTrailer() {
    bool canWatch = notAdult();
    if (canWatch) {
      var trailerUrl;
      if (widget.videoDetail!.type == DatumType.T) {
        trailerUrl = widget.videoDetail!.seasons![newSeasonIndex].strailerUrl;
      } else {
        trailerUrl = widget.videoDetail!.trailerUrl;
      }
      if (trailerUrl == null) {
        Fluttertoast.showToast(msg: translate("Trailer_is_not_available"));
      } else {
        var checkMp4 = trailerUrl.substring(trailerUrl.length - 4);
        var checkMpd = trailerUrl.substring(trailerUrl.length - 4);
        var checkWebm = trailerUrl.substring(trailerUrl.length - 5);
        var checkMkv = trailerUrl.substring(trailerUrl.length - 4);
        var checkM3u8 = trailerUrl.substring(trailerUrl.length - 5);
        if (trailerUrl.substring(0, 23) == 'https://www.youtube.com') {
          var router = new MaterialPageRoute(
            builder: (BuildContext context) => new PlayerMovieTrailer(
              id: widget.videoDetail!.id,
              type: widget.videoDetail!.type,
            ),
          );
          Navigator.of(context).push(router);
        } else if (checkMp4 == ".mp4" ||
            checkMpd == ".mpd" ||
            checkWebm == ".webm" ||
            checkMkv == ".mkv" ||
            checkM3u8 == ".m3u8") {
          var router = new MaterialPageRoute(
            builder: (BuildContext context) => new MyCustomPlayer(
              url: trailerUrl,
              title: widget.videoDetail!.title!,
              downloadStatus: 1,
              subtitles: null,
            ),
          );
          Navigator.of(context).push(router);
        } else {
          var router = new MaterialPageRoute(
            builder: (BuildContext context) => new PlayerMovieTrailer(
              id: widget.videoDetail!.id,
              type: widget.videoDetail!.type,
            ),
          );
          Navigator.of(context).push(router);
        }
      }
    } else {
      log("You can't access this content!");
      Fluttertoast.showToast(
        msg: translate("You_cant_access_this_content_"),
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Column(
      children: <Widget>[
        _buildDiagonalImageBackground(context),
        const SizedBox(
          height: 24,
        ),
        headerRow(theme),
      ],
    );
  }

  Widget headerRow(theme) {
    var dW = MediaQuery.of(context).size.width;
    var theme = Theme.of(context);
    dynamic tmbdRat = widget.videoDetail!.rating;
    if (tmbdRat.runtimeType == int) {
      double reciprocal(double d) => 1 / d;

      reciprocal(tmbdRat.toDouble());

      tmbdRat = widget.videoDetail!.rating == null ? 0.0 : tmbdRat / 2;
    } else if (tmbdRat.runtimeType == String) {
      tmbdRat =
          widget.videoDetail!.rating == null ? 0.0 : double.parse(tmbdRat) / 2;
    } else {
      tmbdRat = widget.videoDetail!.rating == null ? 0.0 : tmbdRat / 2;
    }

    CountViewModel countViewModel =
        Provider.of<CountViewProvider>(context, listen: false).countViewModel;
    int views = 0;
    print("Movie ID :-> ${widget.videoDetail?.id}");
    countViewModel.movies?.forEach((element) {
      if (element.id == widget.videoDetail?.id &&
          element.title == widget.videoDetail?.title) {
        // View Count
        views = element.views! + element.uniqueViewsCount!;
        // Protected Content Password
        if (element.isProtect == 1) {
          String password =
              element.password != null ? element.password.toString() : "N/A";
          if (protectedContentPwd.length > 0) {
            if (!protectedContentPwd.containsKey(
                '${widget.videoDetail?.id}_${widget.videoDetail?.id}')) {
              protectedContentPwd[
                      '${widget.videoDetail?.id}_${widget.videoDetail?.id}'] =
                  password;
            }
          } else {
            protectedContentPwd[
                    '${widget.videoDetail?.id}_${widget.videoDetail?.id}'] =
                password;
          }
        }
      }
    });

    var viewsCount = Container(
      clipBehavior: Clip.antiAlias,
      padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.0),
          border: Border.all(color: kRedColor, width: 1)),
      child: Text(
        "${valueToKMB(value: views)} ${(views == 1) ? 'view' : 'views'}",
        style: TextStyles.regular12(color: kWhite100),
      ),
    );

    final Datum? videoDetail = widget.videoDetail;
    final String publishYear = (videoDetail?.publishYear.toString() ?? "");
    return new Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  widget.videoDetail!.title!,
                  style: Theme.of(context).textTheme.titleLarge,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(
                width: 6,
              ),
              WishListView(widget.videoDetail),
              const SizedBox(
                width: 4,
              ),
              RateUs(widget.videoDetail!.type, widget.videoDetail!.id),
              const SizedBox(
                width: 4,
              ),
              if (protectedContentPwd.length > 0)
                if (protectedContentPwd.containsKey(
                        '${widget.videoDetail?.id}_${widget.videoDetail?.id}') &&
                    (widget.userProfileModel?.active == 1 ||
                        widget.userProfileModel?.active == '1'))
              Padding(
                padding: const EdgeInsetsDirectional.only(end: 4),
                child: CopyPassword(widget.videoDetail!),
              ),

              SharePage(APIData.shareMovieUri, widget.videoDetail!.id),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 8,
            runSpacing: 8,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.star,
                    size: 16,
                    color: kWhite100,
                  ),
                  const SizedBox(
                    width: 2,
                  ),
                  Text(
                    "${tmbdRat.toStringAsFixed(2)}",
                    style: TextStyles.regular12(color: kWhite100),
                  ),
                ],
              ),
              if (publishYear.isNotEmpty)
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.keyboard_arrow_right_outlined,
                      size: 16,
                      color: kWhite100,
                    ),
                    // const SizedBox(width: 2),
                    Text(
                      publishYear,
                      style: TextStyles.regular14(color: kWhite100),
                    ),
                  ],
                ),
              viewsCount,
              Container(
                clipBehavior: Clip.antiAlias,
                padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.0),
                    border: Border.all(color: kRedColor, width: 1)),
                child: Text(
                  "15+",
                  style: TextStyles.regular12(color: kWhite100),
                ),
              ),
              Container(
                clipBehavior: Clip.antiAlias,
                padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.0),
                    border: Border.all(color: kRedColor, width: 1)),
                child: Text(
                  "Subtitles",
                  style: TextStyles.regular12(color: kWhite100),
                ),
              ),
            ],
          ),
          dW > 900
              ? Expanded(
                  flex: 2,
                  child: header(theme),
                )
              : header(theme),
        ],
      ),
    );
  }

  Widget headerDecorationContainer() {
    return Container(
      height: 262.0,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: FractionalOffset.topCenter,
          end: FractionalOffset.bottomCenter,
          colors: [
            Theme.of(context).primaryColorDark.withOpacity(0.1),
            Theme.of(context).primaryColorDark
          ],
          stops: [0.3, 0.8],
        ),
      ),
    );
  }

  Widget header(theme) {
    final platform = Theme.of(context).platform;
    var dW = MediaQuery.of(context).size.width;
    final userDetails = Provider.of<UserProfileProvider>(context, listen: false)
        .userProfileModel!;
    return Padding(
      padding: const EdgeInsets.only(top: 6.0),
      child: dW > 900
          ? Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(
                          Theme.of(context).primaryColor),
                      overlayColor: WidgetStateProperty.all(
                          Theme.of(context).primaryColorDark.withOpacity(0.1)),
                      padding: WidgetStateProperty.all(
                          const EdgeInsets.fromLTRB(0, 10.0, 0.0, 10.0)),
                      textStyle: WidgetStateProperty.all(
                        Theme.of(context).textTheme.bodyLarge!.copyWith(
                              fontFamily: kFontFamilyName,
                            ),
                      ),
                    ),
                    onPressed: () {
                      // Remove this line
                      // userDetails.active = "1";
                      // -----
                      if (userDetails.active == "1" ||
                          userDetails.active == 1) {
                        if ((userDetails.removeAds == "0" ||
                                userDetails.removeAds == 0) &&
                            (appconfig.appConfig.removeAds == 0 ||
                                appconfig.appConfig.removeAds == '0')) {
                          // createInterstitialAd()
                          //     .then((value) => showInterstitialAd());
                        }
                        _onTapPlay();
                      } else {
                        _showMsg();
                      }
                    },
                    icon: Icon(Icons.play_arrow,
                        size: 30.0,
                        color: Theme.of(context).colorScheme.secondary),
                    label: Text(
                      translate('Watch_Now'),
                    ),
                  ),
                ),
                SizedBox(
                  width: 20.0,
                ),
                Expanded(
                  child: ElevatedButton.icon(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(
                          Theme.of(context).primaryColor.withOpacity(0.2)),
                      overlayColor: WidgetStateProperty.all(
                          Theme.of(context).primaryColorDark.withOpacity(0.1)),
                      padding: WidgetStateProperty.all(
                          const EdgeInsets.fromLTRB(0, 10.0, 0.0, 10.0)),
                      textStyle: WidgetStateProperty.all(
                        Theme.of(context).textTheme.bodyLarge!.copyWith(
                              fontFamily: kFontFamilyName,
                            ),
                      ),
                    ),
                    onPressed: _onTapTrailer,
                    icon: Icon(Icons.play_arrow_outlined,
                        size: 30.0,
                        color: Theme.of(context).colorScheme.secondary),
                    label: Text(
                      translate('Preview_'),
                    ),
                  ),
                ),
              ],
            )
          : Column(
              children: <Widget>[
                AppButton(
                  text: translate("Play_"),
                  textStyle: TextStyles.bold12(color: kDarkTextColor),
                  radius: 20,
                  isEnabled: "${widget.videoDetail?.isUpcoming}" != "1",
                  onPressed: () {
                    // Remove this line
                    // userDetails.active = "1";
                    // -----
                    // if (userDetails.active == "1" ||
                    //     userDetails.active == 1) {
                    //   if ((userDetails.removeAds == "0" ||
                    //           userDetails.removeAds == 0) &&
                    //       (appconfig.appConfig.removeAds == 0 ||
                    //           appconfig.appConfig.removeAds == '0')) {
                    //     createInterstitialAd()
                    //         .then((value) => showInterstitialAd());
                    //   }
                    _onTapPlay();
                    // } else {
                    //   _showMsg();
                    // }
                  },
                  buttonColor: kMainThemeColor,
                  childrenBuilder: (context, isEnabled, isLoading, text) {
                    if (isEnabled == false) {
                      return [
                        AnimatedTextKit(
                          repeatForever: true,
                          animatedTexts: [
                            FadeAnimatedText(translate("Coming_Soon"),
                                textAlign: TextAlign.center,
                                textStyle:
                                    TextStyles.bold12(color: kDarkTextColor)),
                          ],
                        )
                      ];
                    }
                    return [
                      Icon(
                        Icons.play_circle_fill_rounded,
                        size: 20,
                        color: kDarkTextColor,
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      text,
                    ];
                  },
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    Expanded(
                      child: AppOutlineButton(
                        text: translate("Trailer_"),
                        radius: 20,
                        onPressed: _onTapTrailer,
                        borderColor: kWhiteTextColor.withOpacity(.35),
                        textStyle: TextStyles.regular12(color: kWhite100),
                        childrenBuilder: (context, isEnabled, isLoading, text) {
                          return [
                            Icon(
                              Icons.play_circle_fill_rounded,
                              color: kWhiteTextColor,
                              size: 16,
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            text
                          ];
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    widget.videoDetail!.type == DatumType.M
                        ? DownloadPage(widget.videoDetail!, platform)
                        : SizedBox.shrink(),
                  ],
                ),
              ],
            ),
    );
  }

  Widget _buildDiagonalImageBackground(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return widget.videoDetail!.poster == null
        ? Image.asset(
            "assets/placeholder_cover.jpg",
            height: 225.0,
            width: screenWidth,
            fit: BoxFit.cover,
          )
        : DiagonallyCutColoredImage(
            FadeInImage.assetNetwork(
              image: widget.videoDetail!.type == DatumType.M
                  ? "${APIData.movieImageUriPosterMovie}${widget.videoDetail!.poster}"
                  : "${APIData.tvImageUriPosterTv}${widget.videoDetail!.poster}",
              placeholder: "assets/placeholder_cover.jpg",
              width: screenWidth,
              fit: BoxFit.fitWidth,
              imageErrorBuilder: (context, error, stackTrace) {
                return Image.asset(
                  "assets/placeholder_cover.jpg",
                  fit: BoxFit.cover,
                  width: screenWidth,
                  height: 225.0,
                );
              },
            ),
            color: const Color(0x00FFFFFF),
          );
  }
}
