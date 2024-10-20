import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:launch_review/launch_review.dart';
import 'package:vibers_net/common/styles.dart';
import 'package:vibers_net/common/text_styles.dart';
import 'package:vibers_net/models/user_avatar_type_enum.dart';
import 'package:vibers_net/ui/screens/log_out_bottom_sheet.dart';
import 'package:vibers_net/ui/screens/subscription_plans.dart';
import 'package:vibers_net/ui/shared/app_image.dart';
import 'package:vibers_net/ui/widgets/app_bar_widget.dart';
import '/common/apipath.dart';
import '/common/global.dart';
import '/common/route_paths.dart';
import '/providers/user_profile_provider.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import '/providers/app_config.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_lwa/lwa.dart';
import 'package:flutter_lwa_platform_interface/flutter_lwa_platform_interface.dart';

LoginWithAmazon _loginWithAmazon = LoginWithAmazon(
  scopes: <Scope>[ProfileScope.profile(), ProfileScope.postalCode()],
);

class MenuScreen extends StatefulWidget {
  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  String? platform;
  @override
  void initState() {
    super.initState();
    _loginWithAmazon.onLwaAuthorizeChanged.listen((LwaAuthorizeResult auth) {
      setState(() {
        lwaAuth = auth;
      });
    });
    // _getTheme();
  }

  Future<void> _handleSignOut() async {
    if (lwaAuth.isLoggedIn) {
      setState(() {
        lwaAuth = LwaAuthorizeResult.empty();
      });
      _loginWithAmazon.signOut();
    } else {}
    return;
  }

// user name
  Widget userName(activeUsername) {
    return Text(
      activeUsername,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.w400,
      ),
    );
  }

  Widget profileImage() {
    var userDetails = Provider.of<UserProfileProvider>(context, listen: false)
        .userProfileModel!;
    return Column(
      children: <Widget>[
        AppImage.rounded(
            path: UserAvatarTypeEnum.values.first.emojiPath,
            height: 100,
            width: 100,
            fit: BoxFit.cover,
            radius: 30),
        // Container(
        //   height: 55.0,
        //   width: 55.0,
        //   child: Image.asset(
        //     "assets/avatar.png",
        //     scale: 1.7,
        //     fit: BoxFit.cover,
        //   ),
        //   decoration: BoxDecoration(
        //     border: Border.all(
        //       color: isLight ? Colors.black54 : Colors.white,
        //       width: 2.0,
        //     ),
        //   ),
        // ),
        const SizedBox(
          height: 24,
        ),
        Text(
          "${userDetails.user!.name}",
          textAlign: TextAlign.center,
          style: TextStyles.bold16(color: kWhite100),
        ),
        const SizedBox(
          height: 24,
        ),
      ],
    );
  }

  updateScreens(screen, count, index) async {
    final updateScreensResponse =
        await http.post(Uri.parse(APIData.updateScreensApi), body: {
      "macaddress": '$ip',
      "screen": '$screen',
      "count": '$count',
    }, headers: {
      HttpHeaders.authorizationHeader: "Bearer $authToken"
    });
    print("screen $screen");
    print("count $count");
    print(updateScreensResponse.statusCode);
    if (updateScreensResponse.statusCode == 200) {
      storage.write(
          key: "screenName", value: "${screenList[index].screenName}");
      storage.write(key: "screenStatus", value: "YES");
      storage.write(key: "screenCount", value: "${index + 1}");
      storage.write(
          key: "activeScreen", value: "${screenList[index].screenName}");
    } else {
      Fluttertoast.showToast(msg: translate("Error_in_selecting_profile"));
      throw "Can't select profile";
    }
  }

//  Drawer Header
  Widget drawerHeader(width) {
    var userDetails = Provider.of<UserProfileProvider>(context, listen: false)
        .userProfileModel!;
    var userScreenCount;
    if (userDetails.screen != null) {
      if (userDetails.screen.runtimeType == int) {
        userScreenCount = userDetails.screen;
      } else {
        userScreenCount = int.parse(userDetails.screen!);
      }
    }

    return Container(
      width: width,
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 11.0,
          ),
          userDetails.active == "1" || userDetails.active == 1
              ? userDetails.payment == "Free" || screenList.length == 0
                  ? profileImage()
                  : Expanded(
                      child: Container(
                      height: 100,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          physics: ClampingScrollPhysics(),
                          itemCount: userScreenCount,
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                              child: "${screenList[index].id + 1}" ==
                                      '$screenCount'
                                  ? Column(
                                      children: <Widget>[
                                        Container(
                                          height: 70.0,
                                          margin: EdgeInsets.only(right: 10.0),
                                          width: 70,
                                          child: userDetails.user!.image != null
                                              ? Image.network(
                                                  "${APIData.profileImageUri}" +
                                                      "${userDetails.user!.image}",
                                                  fit: BoxFit.cover,
                                                )
                                              : Image.asset(
                                                  "assets/avatar.png",
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      4.5,
                                                  fit: BoxFit.cover,
                                                ),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: Colors.white,
                                              width: 1.0,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                        Text(
                                          screenList[index].screenName!,
                                          style: TextStyle(
                                            fontSize: 12.0,
                                          ),
                                        ),
                                      ],
                                    )
                                  : Column(
                                      children: <Widget>[
                                        Container(
                                          margin: EdgeInsets.only(right: 12.0),
                                          height: 60.0,
                                          width: 60.0,
                                          child: userDetails.user!.image != null
                                              ? Image.network(
                                                  "${APIData.profileImageUri}" +
                                                      "${userDetails.user!.image}",
                                                  fit: BoxFit.cover,
                                                )
                                              : Image.asset(
                                                  "assets/avatar.png",
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      4.5,
                                                  fit: BoxFit.cover,
                                                ),
                                        ),
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                        userName(screenList[index].screenName),
                                      ],
                                    ),
                              onTap: () {
                                if ("${screenList[index].screenStatus}" ==
                                    "YES") {
                                  Fluttertoast.showToast(
                                    msg: translate("Profile_already_in_use_"),
                                  );
                                } else {
                                  setState(() {
                                    myActiveScreen =
                                        screenList[index].screenName;
                                    screenCount = index + 1;
                                  });
                                  updateScreens(
                                      myActiveScreen, screenCount, index);
                                }
                              },
                            );
                          }),
                    ))
              : profileImage(),
          // SizedBox(
          //   height: 15.0,
          // ),
          // Container(
          //   width: width,
          //   child: Padding(
          //     padding: EdgeInsets.only(bottom: 15.0),
          //     child: InkWell(
          //       onTap: () {
          //         Navigator.pushNamed(context, RoutePaths.manageProfile);
          //       },
          //       child: Row(
          //         crossAxisAlignment: CrossAxisAlignment.center,
          //         mainAxisAlignment: MainAxisAlignment.center,
          //         children: <Widget>[
          //           Icon(
          //             Icons.edit,
          //             size: 15,
          //           ),
          //           SizedBox(
          //             width: 10.0,
          //           ),
          //           Text(
          //             translate("Manage_Profile"),
          //             textAlign: TextAlign.center,
          //             style: TextStyle(
          //               fontSize: 14.0,
          //               fontWeight: FontWeight.w400,
          //             ),
          //           ),
          //         ],
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }

//  Notification
  Widget notification() {
    return _TileWidget(
      icon: Icons.notifications_rounded,
      title: translate("Notifications_"),
      onTap: () {
        Navigator.pushNamed(context, RoutePaths.notifications);
      },
    );
  }

//  App settings
  Widget appSettings() {
    return _TileWidget(
      icon: Icons.settings_outlined,
      title: translate("App_Settings"),
      onTap: () {
        Navigator.pushNamed(context, RoutePaths.appSettings);
      },
    );
  }

  //  watch  history
  Widget watchHistory() {
    return _TileWidget(
      icon: Icons.view_list,
      title: translate("Watch_History"),
      onTap: () {
        Navigator.pushNamed(context, RoutePaths.watchHistory);
      },
    );
  }

//  Account
  Widget account() {
    return InkWell(
      onTap: () {
        _onButtonPressed();
      },
      child: Padding(
        padding: EdgeInsets.fromLTRB(20.0, 12.0, 10.0, 12.0),
        child: Row(
          children: <Widget>[
            Text(
              translate("Manage_Account"),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }

//  Subscribe
  Widget subscribe() {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SubscriptionPlan(),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Theme.of(context).primaryColorDark,
              width: 3.0,
            ),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.fromLTRB(20.0, 12.0, 10.0, 20.0),
          child: Row(
            children: <Widget>[
              Text(
                translate("Manage_Subscription"),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

//  Help
  Widget help() {
    return _TileWidget(
      icon: Icons.help_outline_outlined,
      title: translate("FAQ_"),
      onTap: () {
        Navigator.pushNamed(context, RoutePaths.faq);
      },
    );
  }

  // Blog
  Widget blog() {
    return _TileWidget(
      icon: Icons.newspaper_rounded,
      title: translate("Blog_"),
      onTap: () {
        Navigator.pushNamed(context, RoutePaths.blogList);
      },
    );
  }

  // Donate
  Widget donate() {
    return _TileWidget(
      icon: Icons.attach_money_outlined,
      title: translate("Donate_"),
      onTap: () {
        Navigator.pushNamed(context, RoutePaths.donation);
      },
    );
  }

  //  Rate Us
  Widget checkForUpdate() {
    return InkWell(
      onTap: () {
        String os = Platform.operatingSystem; //in your code
        if (os == 'android') {
          if (APIData.androidAppId != '') {
            LaunchReview.launch(
              androidAppId: APIData.androidAppId,
            );
          } else {
            Fluttertoast.showToast(
                msg: translate('PlayStore_id_is_not_available'));
          }
        } else {
          if (APIData.iosAppId != '') {
            LaunchReview.launch(
                androidAppId: APIData.androidAppId, iOSAppId: APIData.iosAppId);

            LaunchReview.launch(writeReview: false, iOSAppId: APIData.iosAppId);
          } else {
            Fluttertoast.showToast(
                msg: translate('AppStore_id_is_not_available'));
          }
        }
      },
      child: Padding(
        padding: EdgeInsets.fromLTRB(20.0, 12.0, 10.0, 12.0),
        child: Row(
          children: <Widget>[
            Text(
              translate("Rate_Us"),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }

//  Rate Us
  Widget rateUs() {
    return _TileWidget(
      hasTrailingIcon: false,
      icon: Icons.star_rate_rounded,
      title: translate("Rate_Us"),
      onTap: () {
        String os = Platform.operatingSystem; //in your code
        if (os == 'android') {
          if (APIData.androidAppId != '') {
            LaunchReview.launch(
              androidAppId: APIData.androidAppId,
            );
          } else {
            Fluttertoast.showToast(
                msg: translate('PlayStore_id_is_not_available'));
          }
        } else {
          if (APIData.iosAppId != '') {
            LaunchReview.launch(
                androidAppId: APIData.androidAppId, iOSAppId: APIData.iosAppId);

            LaunchReview.launch(writeReview: false, iOSAppId: APIData.iosAppId);
          } else {
            Fluttertoast.showToast(
                msg: translate('AppStore_id_is_not_available'));
          }
        }
      },
    );
  }

//  Share app
  Widget shareApp() {
    return _TileWidget(
      hasTrailingIcon: false,
      icon: Icons.share_outlined,
      title: translate("Share_App"),
      onTap: () {
        String os = Platform.operatingSystem; //in your code
        if (os == 'android') {
          if (APIData.androidAppId != '') {
            Share.share(APIData.shareAndroidAppUrl);
          } else {
            Fluttertoast.showToast(
                msg: translate('PlayStore_id_is_not_available'));
          }
        } else {
          if (APIData.iosAppId != '') {
            Share.share(APIData.shareIOSAppUrl);
          } else {
            Fluttertoast.showToast(
                msg: translate('AppStore_id_is_not_available'));
          }
        }
      },
    );
  }

//  Sign Out
  Widget signOut() {
    return InkWell(
      onTap: () {
        _signOutDialog();
      },
      child: Padding(
        padding: EdgeInsets.fromLTRB(20.0, 12.0, 10.0, 12.0),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 8,
              child: Text(
                translate("Sign_Out"),
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Icon(
                Icons.settings_power,
                size: 15,
              ),
            )
          ],
        ),
      ),
    );
  }

  // Bottom Sheet after on tapping account
  Widget _buildBottomSheet() {
    return Container(
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text(translate('Membership_')),
            onTap: () => Navigator.pushNamed(context, RoutePaths.membership),
            trailing: Icon(
              Icons.arrow_forward_ios,
              size: 15.0,
            ),
          ),
          ListTile(
            title: Text(translate('Payment_History')),
            trailing: Icon(
              Icons.arrow_forward_ios,
              size: 15.0,
            ),
            onTap: () {
              Navigator.pushNamed(context, RoutePaths.paymentHistory);
            },
          ),
        ],
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(50.0),
          topRight: const Radius.circular(50.0),
        ),
      ),
    );
  }

  Widget drawer(width, height2) {
    var appConfig = Provider.of<AppConfig>(context, listen: false).appModel!;
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          drawerHeader(width),
          const SizedBox(
            height: 12,
          ),
          // _TileWidget(
          //   icon: Icons.edit_outlined,
          //   title: translate("Edit_Profile"),
          //   onTap: () {
          //     Navigator.pushNamed(context, RoutePaths.editAccountPage);
          //   },
          // ),
          _TileWidget(
            icon: Icons.supervisor_account_sharp,
            title: translate("accounts"),
            onTap: () {
              Navigator.pushNamed(context, RoutePaths.accountsPage);
            },
          ),
          notification(),
          watchHistory(),
          _TileWidget(
            icon: Icons.download_rounded,
            title: translate("Downloads_"),
            onTap: () {
              Navigator.of(context).pushNamed(RoutePaths.download);
            },
          ),
          appSettings(),
          // account(),
          // subscribe(),
          _TileWidget(
            icon: Icons.privacy_tip_outlined,
            title: translate("privacy_policy"),
            onTap: () {
              Navigator.of(context).pushNamed(RoutePaths.privacyPolicyPage);
            },
          ),
          help(),
          appConfig.config!.donation == 1 ||
                  "${appConfig.config!.donation}" == "1"
              ? donate()
              : SizedBox.shrink(),
          appConfig.blogs!.length != 0 ? blog() : SizedBox.shrink(),
          rateUs(),
          shareApp(),
          _TileWidget(
            icon: Icons.logout_outlined,
            title: translate("Sign_Out"),
            onTap: _signOutDialog,
            hasTrailingIcon: false,
          ),
          const SizedBox(
            height: 50,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double height2 = (height * 76.75) / 100;
    return Scaffold(
      appBar: AppBarWidget(
        titleText: translate("Menu_"),
        leading: const SizedBox(),
      ),
      body: drawer(width, height2),
    );
  }

  void _onButtonPressed() {
    showModalBottomSheet(
      context: context,
      builder: (builder) {
        return Theme(
            data: ThemeData(
              dialogBackgroundColor: Color.fromRGBO(0, 0, 0, 0.2),
              // platform: TargetPlatform.android,
            ),
            child: new Container(
              height: 150.0,
              color:
                  Colors.transparent, //could change this to Color(0xFF737373),
              //so you don't have to change MaterialApp canvasColor
              child: new Container(
                decoration: new BoxDecoration(
                  borderRadius: new BorderRadius.only(
                    topLeft: const Radius.circular(10.0),
                    topRight: const Radius.circular(10.0),
                  ),
                ),
                child: _buildBottomSheet(),
              ),
            ));
      },
    );
  }

  _signOutDialog() {
    return LogOutBottomSheet.show(context,
        onLogOutPressed: () => screenLogout());
  }

  bool isShowing = true;

  void screenLogout() async {
    var userDetails = Provider.of<UserProfileProvider>(context, listen: false)
        .userProfileModel!;
    setState(() {
      isShowing = false;
    });
    var screenLogOutResponse, screenCount, actScreen;
    final facebookLogin = FacebookAuth.instance;
    final GoogleSignIn googleSignIn = new GoogleSignIn();

    googleSignIn.isSignedIn().then((s) {
      googleSignIn.signOut();
    });

    facebookLogin.logOut();

    _handleSignOut();
    if (userDetails.active == "1" || userDetails.active == 1) {
      if (userDetails.payment == "Free") {
        screenLogOutResponse =
            await http.post(Uri.parse(APIData.screenLogOutApi), headers: {
          "Accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded",
          HttpHeaders.authorizationHeader: "Bearer $authToken"
        });
      } else {
        screenCount = await storage.read(key: "screenCount");
        actScreen = await storage.read(key: "activeScreen");
        screenLogOutResponse =
            await http.post(Uri.parse(APIData.screenLogOutApi), body: {
          "screen": '$actScreen',
          "count": '$screenCount',
          "macaddress": '$ip',
        }, headers: {
          "Content-Type": "application/x-www-form-urlencoded",
          HttpHeaders.authorizationHeader: "Bearer $authToken"
        });
      }
    } else {
      screenLogOutResponse =
          await http.post(Uri.parse(APIData.screenLogOutApi), headers: {
        "Accept": "application/json",
        "Content-Type": "application/x-www-form-urlencoded",
        HttpHeaders.authorizationHeader: "Bearer $authToken"
      });
    }

    print('screenLogOutResponse: ${screenLogOutResponse.body}');
    if (screenLogOutResponse.statusCode == 200) {
      setState(() {
        isShowing = true;
      });
      await storage.deleteAll();
      Navigator.pushNamed(context, RoutePaths.loginHome);
    } else {
      setState(() {
        isShowing = true;
      });
      Fluttertoast.showToast(msg: translate("Something_went_wrong_"));
    }
  }

  goToDialog() {
    if (isShowing == true) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => PopScope(
          child: AlertDialog(
            backgroundColor: Colors.white,
            title: Row(
              children: [
                CircularProgressIndicator(
                  valueColor: new AlwaysStoppedAnimation<Color>(
                    Theme.of(context).colorScheme.background,
                  ),
                ),
                SizedBox(
                  width: 15.0,
                ),
                Text(
                  translate("Loading_"),
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.background),
                )
              ],
            ),
          ),
          canPop: false,
          onPopInvokedWithResult: (didPop, _) {
            if (didPop) {
              return;
            }
          },
        ),
      );
    } else {
      Navigator.pop(context);
    }
  }
}

class _TileWidget extends StatelessWidget {
  const _TileWidget(
      {Key? key,
      this.onTap,
      required this.icon,
      required this.title,
      this.hasTrailingIcon = true})
      : super(key: key);
  final VoidCallback? onTap;
  final IconData icon;
  final String title;
  final bool hasTrailingIcon;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Icon(
              icon,
              color: kErrorRed,
              size: 18,
            ),
            const SizedBox(
              width: 8,
            ),
            Expanded(
                child: Text(
              title,
              style: TextStyles.regular12(color: kWhite100),
            )),
            if (hasTrailingIcon)
              const SizedBox(
                width: 8,
              ),
            if (hasTrailingIcon)
              Icon(
                Icons.arrow_forward_ios_outlined,
                size: 10,
                color: Colors.white,
              ),
          ],
        ),
      ),
    );
  }
}
