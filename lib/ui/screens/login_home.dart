import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:vibers_net/common/styles.dart';
import 'package:vibers_net/common/text_styles.dart';
import 'package:vibers_net/models/app_model.dart';
import 'package:vibers_net/ui/shared/app_image.dart';
import 'package:vibers_net/ui/shared/app_loading_widget.dart';
import 'package:vibers_net/ui/widgets/app_button.dart';
import '/common/apipath.dart';
import '/common/route_paths.dart';
import '/providers/app_config.dart';
import '/ui/shared/logo.dart';
import 'package:provider/provider.dart';
import 'bottom_navigations_bar.dart';

DateTime? currentBackPressTime;

class LoginHome extends StatefulWidget {
  @override
  _LoginHomeState createState() => _LoginHomeState();
}

class _LoginHomeState extends State<LoginHome> {
  bool _visible = false;
  bool isLoggedIn = false;
  var profileData;

  void onLoginStatusChanged(bool isLoggedIn, {profileData}) {
    setState(() {
      this.isLoggedIn = isLoggedIn;
      this.profileData = profileData;
    });
  }

//  Register button
  Widget registerButton() {
    return AppOutlineButton(
      text: translate("Register_"),
      onPressed: () => Navigator.pushNamed(context, RoutePaths.register),
    );
  }

//  Setting background design of login button
  Widget loginButton() {
    return AppButton(
      text: translate(
        "Login_",
      ),
      onPressed: () => Navigator.pushNamed(context, RoutePaths.login),
    );
  }

// If you get HTML tag in copy right text
  Widget html() {
    return Consumer<AppConfig>(builder: (context, myModel, child) {
      print("${myModel.appModel!.config!.copyright}");
      return HtmlWidget("${myModel.appModel!.config!.copyright}",
          customStylesBuilder: (element) {
        return {'text-align': 'center'};
      });
    });
  }

// Background image filter
  Widget imageBackDropFilter(String image) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
      child: Container(
        width: double.infinity,
        height: double.infinity,
        child: AppImage(
          path: image,
          placeholderColor: Colors.transparent,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

// ListView contains buttons and logo
  Widget listView(myModel) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            AnimatedOpacity(
              /*
          If the widget is visible, animate to 0.0 (invisible).
          If the widget is hidden, animate to 1.0 (fully visible).
        */
              opacity: _visible == true ? 1.0 : 0.0,
              duration: Duration(milliseconds: 500),

              /*
        For setting logo image that is accessed from the server using API.
        You can change logo by server
        */
              child: logoImage(context, myModel, 1, 230.0, 230.0),
            ),
            SizedBox(
              height: 50.0,
            ),
            loginButton(),
            SizedBox(
              height: 24.0,
            ),
            registerButton(),
            SizedBox(
              height: 40.0,
            ),
            // TODO[Continue As Guest] : handle log in home continue as guest action
            GestureDetector(
                onTap: () {},
                child: Text(
                  translate("continueAsGuest"),
                  style: TextStyles.regular12(color: kBorderColor),
                )),
          ],
        ),
      ),
    );
  }

//  Overall this page in Stack
  Widget stack(myModel) {
    final logo = Provider.of<AppConfig>(context, listen: false).appModel!;
    return Stack(
      children: <Widget>[
        imageBackDropFilter('${APIData.loginImageUri}${logo.loginImg!.image}'),
        Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                const Color(0xff070010).withOpacity(.8),
                const Color(0xff070010).withOpacity(.6),
                Color(0xff070010).withOpacity(.2)
              ])),
        ),
        listView(myModel),
      ],
    );
  }

// WillPopScope to handle app exit
  Widget willPopScope(AppModel myModel) {
    return PopScope(
      child: Center(
        child: stack(myModel),
      ),
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) {
          return;
        }
        onWillPopS;
      },
    );
  }

  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), () {
      setState(() {
        _visible = true;
      });
    });
  }

// build method
  @override
  Widget build(BuildContext context) {
    final myModel = Provider.of<AppConfig>(context).appModel;
    return Scaffold(
      body: myModel == null
          ? Center(child: AppLoadingWidget())
          : willPopScope(myModel),
    );
  }
}
