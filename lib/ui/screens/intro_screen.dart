import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:vibers_net/common/styles.dart';
import 'package:vibers_net/common/text_styles.dart';
import 'package:vibers_net/ui/shared/app_image.dart';
import 'package:vibers_net/ui/shared/app_loading_widget.dart';
import '/common/apipath.dart';
import '/common/route_paths.dart';
import '/providers/app_config.dart';
import 'package:provider/provider.dart';
import 'login_home.dart';

class IntroScreen extends StatefulWidget {
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final List<Slide> slides = [];
  Function? goToTab;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      isLoading = true;
    });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final blocks = context.read<AppConfig>().slides;
      List.generate(blocks.length, (int i) {
        return slides.add(
          new Slide(
            title: "${blocks[i].heading}",
            styleTitle: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'RobotoMono'),
            description: "${blocks[i].detail}",
            styleDescription: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontStyle: FontStyle.italic,
                fontFamily: 'Raleway'),
            pathImage: "${APIData.landingPageImageUri}${blocks[i].image}",
          ),
        );
      });
      setState(() {
        isLoading = false;
      });
    });
  }

//  WillPopScope to handle back press.
  Future<bool> onWillPopS() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      return Future.value(false);
    }
    return SystemNavigator.pop() as Future<bool>;
  }

//  After done pressed on intro slider
  void onDonePress() {
    // Back to the first tab
    Navigator.pushNamed(context, RoutePaths.loginHome);
  }

//  Counting index and changing UI page dynamically.
  void onTabChangeCompleted(index) {
    // Index of current tab is focused
  }

//  Next button
  Widget renderNextBtn() {
    return Icon(
      Icons.navigate_next,
      color: Theme.of(context).primaryColor,
    );
  }

//  Done button or last page of intro slider
  Widget renderDoneBtn() {
    return Icon(
      Icons.done,
      color: Theme.of(context).primaryColor,
    );
  }

//  Skip button to go directly on last page of intro slider
  Widget renderSkipBtn() {
    return Icon(
      Icons.skip_next,
      color: Theme.of(context).primaryColor,
    );
  }

//  Custom tabs
  List<Widget> renderListCustomTabs() {
    List<Widget> tabs = [];
    for (int i = 0; i < slides.length; i++) {
      Slide currentSlide = slides[i];
      tabs.add(Container(
        width: double.infinity,
        height: double.infinity,
        child: Container(
          margin: EdgeInsets.only(bottom: 70.0, top: 0.0),
          child: Center(
            child: Stack(
              children: <Widget>[
                Container(
                  decoration: new BoxDecoration(
                    color:
                        Theme.of(context).primaryColorLight.withOpacity(0.48),
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(0.0),
                        bottomLeft: Radius.circular(0.0)),
                    boxShadow: <BoxShadow>[
                      new BoxShadow(
                        color: Colors.black87.withOpacity(0.6),
                        blurRadius: 20.0,
                        offset: new Offset(0.0, 5.0),
                      ),
                    ],
                    image: new DecorationImage(
                      fit: BoxFit.cover,
                      colorFilter: new ColorFilter.mode(
                          Colors.black.withOpacity(0.8), BlendMode.dstATop),
                      image: new NetworkImage(currentSlide.pathImage!),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Container(
                        child: Text(
                          currentSlide.title!,
                          style: currentSlide.styleTitle,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Container(
                        child: Text(
                          currentSlide.description!,
                          style: currentSlide.styleDescription,
                          textAlign: TextAlign.center,
                          maxLines: 5,
                          overflow: TextOverflow.ellipsis,
                        ),
                        margin:
                            EdgeInsets.only(top: 20.0, left: 25.0, right: 25.0),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ));
    }
    return tabs;
  }

// Intro slider
  Widget introSlider() {
    return IntroSlider(
      // List slides
      slides: this.slides,
      // Skip button
      renderSkipBtn: this.renderSkipBtn(),
      showSkipBtn: true,
      skipButtonStyle: ButtonStyle(
        backgroundColor: WidgetStateProperty.all<Color>(
            Theme.of(context).primaryColor.withOpacity(0.3)),
      ),

      // Next button
      renderNextBtn: this.renderNextBtn(),

      // Done button
      renderDoneBtn: this.renderDoneBtn(),
      onDonePress: this.onDonePress,
      doneButtonStyle: ButtonStyle(
        backgroundColor: WidgetStateProperty.all<Color>(
            Theme.of(context).primaryColor.withOpacity(0.3)),
      ),

      nextButtonStyle: ButtonStyle(
        backgroundColor: WidgetStateProperty.all<Color>(
            Theme.of(context).primaryColor.withOpacity(0.3)),
      ),

      // Dot indicator
      colorDot: Theme.of(context).primaryColor,
      sizeDot: 13.0,
      typeDotAnimation: DotSliderAnimation.SIZE_TRANSITION,
      // Tabs
      listCustomTabs: this.renderListCustomTabs(),
      backgroundColorAllSlides: Colors.white,
      refFuncGoToTab: (refFunc) {
        this.goToTab = refFunc;
      },

      // Show or hide status bar
      hideStatusBar: false,

      // On tab change completed
      onTabChangeCompleted: this.onTabChangeCompleted,
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      child: Scaffold(body: _IntroBody()
          // isLoading == true ? AppLoadingWidget() : introSlider(),
          ),
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) {
          return;
        }
        onWillPopS;
      },
    );
  }
}

class _IntroBody extends StatelessWidget {
  const _IntroBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        AppImage(
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
            placeholderColor: Colors.transparent,
            path:
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ9M4mxgT_XHhfFVTiEA4u1IHKBjT6WixHoAw&s"),
        Container(
          width: double.infinity,
          color: Colors.black.withOpacity(0.3),
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Welcome to Vibers net",
                textAlign: TextAlign.center,
                style: TextStyles.bold22(color: kWhite100),
              ),
              const SizedBox(
                height: 12,
              ),
              Text(
                "THE ONLY & ULTIMATE APPLICATION EXPERIENCE OF ITS KIND IN DOCUMENTARY FILMS & PROGRAMS.",
                textAlign: TextAlign.center,
                style: TextStyles.regular12(color: kBorderColor),
              ),
              const SizedBox(
                height: 16,
              ),
              _ProgressWidget(
                count: 4,
                currentIndex: 1,
              ),
              const SizedBox(
                height: 16,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ProgressWidget extends StatelessWidget {
  const _ProgressWidget(
      {Key? key, required this.count, required this.currentIndex})
      : super(key: key);
  final int count;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        count,
        (index) {
          final bool isSelected = index == currentIndex;
          return Flexible(
            child: AnimatedContainer(
              duration: Durations.medium2,
              margin: EdgeInsets.symmetric(horizontal: 2),
              height: 8,
              width: isSelected ? 32 : 8,
              decoration: BoxDecoration(
                color: isSelected ? kRedColor : kDarkAccent,
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          );
        },
      ),
    );
  }
}
