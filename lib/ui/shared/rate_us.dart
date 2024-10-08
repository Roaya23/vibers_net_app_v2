import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '/common/apipath.dart';
import '/common/global.dart';
import '/models/episode.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
// ignore: import_of_legacy_library_into_null_safe
//import 'package:rating_bar/rating_bar.dart';
import 'package:http/http.dart' as http;
import 'package:vibers_net/common/styles.dart';

class RateUs extends StatefulWidget {
  RateUs(
    this.type,
    this.id,
  );
  final type;
  final id;

  @override
  _RateUsState createState() => _RateUsState();
}

class _RateUsState extends State<RateUs> {
  var _rating;
  var s = 0;

  Widget rateText() {
    return Text(
      translate("Rate_"),
      style: TextStyle(
        fontFamily: kFontFamilyName,
        fontSize: 12.0,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.0,
      ),
    );
  }

  Widget rateUsTabColumn() {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Icon(
        Icons.star_border,
        size: 16.0,
        color: kWhite100,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: () {
        checkRating();
      },
      child: rateUsTabColumn(),
    );
  }

  Widget ratingVideosSheet() {
    return SafeArea(
      bottom: true,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Divider(
            color: kWhite100TextColor,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                GestureDetector(
                  child: Icon(
                    Icons.close,
                    size: 20,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                )
              ],
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RatingBar.builder(
                initialRating: _rating ?? 0,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => Icon(
                  Icons.star_rate_rounded,
                  color: kMainThemeColor,
                ),
                onRatingUpdate: (rating) {
                  setState(() {
                    _rating = rating;
                  });
                  postRating();
                  Navigator.pop(context);
                },
              ),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
        ],
      ),
    );
  }

  Future<String?> postRating() async {
    var vType = widget.type == DatumType.T ? "T" : "M";
    final postRatingResponse =
        await http.post(Uri.parse(APIData.postVideosRating), body: {
      "type": '$vType',
      "id": '${widget.id}',
      "rating": '$_rating',
    }, headers: {
      HttpHeaders.authorizationHeader: "Bearer $authToken"
    });
    if (postRatingResponse.statusCode == 200) {
      Fluttertoast.showToast(msg: translate("Rated_Successfully"));
    } else {
      Fluttertoast.showToast(msg: translate("Error_in_rating"));
    }

    return null;
  }

  Future<String?> checkRating() async {
    var vType = widget.type == DatumType.T ? "T" : "M";
    final checkRatingResponse = await http.get(
        Uri.parse(APIData.checkVideosRating +
            '/' +
            '$vType' +
            '/' +
            '${widget.id}' +
            '?secret=' +
            APIData.secretKey),
        headers: {HttpHeaders.authorizationHeader: "Bearer $authToken"});
    var checkRate = json.decode(checkRatingResponse.body);
    print(checkRate.length);
    var mRate;
    List.generate(checkRate.length == null ? 0 : checkRate.length, (int index) {
      mRate = checkRate[0];
      return Text(checkRate[0].toString());
    });
    if (mRate == "0") {
      _onRatingPressed();
    } else {
      Fluttertoast.showToast(msg: translate("Already_Rated"));
    }
    return null;
  }

  void _onRatingPressed() {
    showModalBottomSheet(
      context: context,
      builder: (builder) {
        return Container(
          decoration: BoxDecoration(
            color: kScafoldBgColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12.0),
              topRight: Radius.circular(12.0),
            ),
          ),
          child: ratingVideosSheet(),
        );
      },
    );
  }
}
