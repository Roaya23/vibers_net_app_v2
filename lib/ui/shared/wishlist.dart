import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:vibers_net/ui/shared/app_loading_widget.dart';
import '/common/apipath.dart';
import '/common/global.dart';
import '/models/datum.dart';
import '/models/episode.dart';
import 'package:http/http.dart' as http;
import 'package:vibers_net/common/styles.dart';

class WishListView extends StatefulWidget {
  WishListView(this.videoDetail);

  final Datum? videoDetail;

  @override
  _WishListViewState createState() => _WishListViewState();
}

class _WishListViewState extends State<WishListView> {
  bool checkWishlist = false;
  bool _visible = false;

  checkWishList(vType, id) async {
    var res;
    if (vType == DatumType.M) {
      final response = await http.get(
          Uri.parse(
              "${APIData.checkWatchlistMovie}$id?secret=" + APIData.secretKey),
          headers: {HttpHeaders.authorizationHeader: "Bearer $authToken"});
      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200) {
        res = json.decode(response.body);
        if (res['wishlist'] == 1 || res['wishlist'] == "1") {
          setState(() {
            checkWishlist = true;
            _visible = true;
          });
        } else {
          setState(() {
            checkWishlist = false;
            _visible = true;
          });
        }
      } else {
        throw "Can't check wishlist";
      }
    } else {
      final response = await http.get(
          Uri.parse(
              "${APIData.checkWatchlistSeason}$id?secret=" + APIData.secretKey),
          headers: {HttpHeaders.authorizationHeader: "Bearer $authToken"});
      setState(() {
        res = json.decode(response.body);
      });
      if (response.statusCode == 200) {
        if (res['wishlist'] == 1 || res['wishlist'] == "1") {
          setState(() {
            _visible = true;
            checkWishlist = true;
          });
        } else {
          setState(() {
            checkWishlist = false;
            _visible = true;
          });
        }
      } else {
        throw "Can't check wishlist";
      }
    }
  }

  removeWishList(vType, id) async {
    if (vType == DatumType.M) {
      final response = await http.get(
          Uri.parse(
              "${APIData.removeWatchlistMovie}$id?secret=" + APIData.secretKey),
          headers: {HttpHeaders.authorizationHeader: "Bearer $authToken"});
      if (response.statusCode == 200) {
        setState(() {
          checkWishlist = false;
        });
      } else {
        throw "Can't remove from wishlist";
      }
    } else {
      final response = await http.get(
          Uri.parse("${APIData.removeWatchlistSeason}$id?secret=" +
              APIData.secretKey),
          headers: {HttpHeaders.authorizationHeader: "Bearer $authToken"});
      if (response.statusCode == 200) {
        setState(() {
          checkWishlist = false;
        });
      } else {
        throw "Can't remove from wishlist";
      }
    }
  }

  addWishList(vType, id) async {
    var type = vType == DatumType.T ? "S" : "M";
    final response = await http.post(Uri.parse("${APIData.addWatchlist}"),
        body: {"type": type, "id": '$id', "value": '1'},
        headers: {HttpHeaders.authorizationHeader: "Bearer $authToken"});
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      setState(() {
        checkWishlist = true;
      });
    } else {
      throw "Can't added to wishlist";
    }
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      _visible = false;
    });
    checkWishList(widget.videoDetail!.type, widget.videoDetail!.id);
  }

  @override
  Widget build(BuildContext context) {
    if (_visible) {
      return InkWell(
        borderRadius: BorderRadius.circular(24),
        onTap: () {
          if (checkWishlist == true) {
            removeWishList(widget.videoDetail!.type, widget.videoDetail!.id);
          } else {
            addWishList(widget.videoDetail!.type, widget.videoDetail!.id);
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Icon(
            checkWishlist ? Icons.favorite : Icons.favorite_border,
            size: 16,
            color: kWhite100TextColor,
          ),
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.all(4.0),
        child: const AppLoadingWidget(
          size: 12,
          color: kWhite100,
        ),
      );
    }
  }
}
