import 'package:flutter/material.dart';
// import 'package:vibers_net/common/global.dart';
import 'package:vibers_net/ui/shared/app_image.dart';
// import '/common/apipath.dart';
// import '/providers/app_config.dart';
// import 'package:provider/provider.dart';

//    Logo image on login page
Widget logoImage(context, myModel, double scale, double height, double width) {
  return AppImage(
    path: "assets/logo.png",
    scale: scale,
    height: height,
    width: width,
  );
  // var logo = Provider.of<AppConfig>(context).appModel == null
  //     ? null
  //     : Provider.of<AppConfig>(context).appModel!.config!.logo;
  // return Row(
  //   crossAxisAlignment: CrossAxisAlignment.center,
  //   mainAxisAlignment: MainAxisAlignment.center,
  //   children: <Widget>[
  //     logo != null
  //         ? Padding(
  //             padding: EdgeInsets.only(top: 15.0, left: 20.0),
  //             child: Container(
  //               color: isLight ? Colors.black87 : Colors.transparent,
  //               child: Image.network(
  //                 '${APIData.logoImageUri}$logo',
  //                 scale: scale,
  //                 height: height,
  //                 width: width,
  //                 errorBuilder: (context, error, stackTrace) {
  //                   return Image.asset(
  //                     'assets/logo.png',
  //                     scale: scale,
  //                     height: height,
  //                     width: width,
  //                   );
  //                 },
  //               ),
  //             ),
  //           )
  //         : Padding(
  //             padding: EdgeInsets.only(top: 15.0, left: 20.0),
  //             child: Container(
  //               color: isLight ? Colors.black87 : Colors.transparent,
  //               child: Image.asset(
  //                 'assets/logo.png',
  //                 scale: scale,
  //                 height: height,
  //                 width: width,
  //               ),
  //             ),
  //           )
  //   ],
  // );
}
