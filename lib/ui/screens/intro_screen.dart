import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:vibers_net/common/styles.dart';
import 'package:vibers_net/common/text_styles.dart';
import 'package:vibers_net/models/block.dart';
import 'package:vibers_net/ui/shared/app_image.dart';
import 'package:vibers_net/ui/shared/app_loading_widget.dart';
import 'package:vibers_net/ui/widgets/app_button.dart';
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
  final List<Block> slides = [];
  Function? goToTab;
  bool isLoading = false;
  int get kSlidersCounts => slides.length;
  int currentSlideIndex = 0;

  @override
  void initState() {
    super.initState();
    setState(() {
      isLoading = true;
    });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final blocks = context.read<AppConfig>().slides;
      slides.addAll(blocks);
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

  bool get isLastSlide => currentSlideIndex + 1 == kSlidersCounts;

  void _scrollNext() {
    if (!isLastSlide) {
      currentSlideIndex++;
    } else {
      onDonePress();
    }
    setState(() {});
  }

  bool get isFirstSlide => currentSlideIndex == 0;

  void _scrollPrevious() {
    if (!isFirstSlide) {
      currentSlideIndex--;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      child: Scaffold(
        backgroundColor: kLightScafoldBgColor,
        body: isLoading
            ? AppLoadingWidget()
            : _IntroBody(
                count: kSlidersCounts,
                currentIndex: currentSlideIndex,
                image:
                    "${APIData.landingPageImageUri}${slides[currentSlideIndex].image}",
                description: slides[currentSlideIndex].detail ?? '',
                title: slides[currentSlideIndex].heading ?? '',
                onScrollNextTap: (index) {
                  _scrollNext();
                },
                onPreviousScroll: (index) {
                  _scrollPrevious();
                },
              ),
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
}

class _IntroBody extends StatelessWidget {
  const _IntroBody(
      {Key? key,
      required this.image,
      required this.title,
      required this.description,
      required this.onScrollNextTap,
      required this.count,
      required this.currentIndex,
      required this.onPreviousScroll})
      : super(key: key);
  final String image;
  final String title;
  final String description;
  final void Function(int index) onScrollNextTap;
  final void Function(int index) onPreviousScroll;
  final int count;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    final isLast = currentIndex == count - 1;
    final isFirst = currentIndex == 0;
    return GestureDetector(
      // swipe left and right
      onHorizontalDragEnd: (details) {
        if (details.primaryVelocity! > 0) {
          onPreviousScroll(isFirst ? currentIndex : currentIndex - 1);
        } else if (details.primaryVelocity! < 0) {
          onScrollNextTap(isLast ? currentIndex : currentIndex + 1);
        }
      },
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            switchInCurve: Curves.easeIn,
            switchOutCurve: Curves.easeOut,
            transitionBuilder: (child, animation) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
            child: SizedBox(
              key: UniqueKey(),
              width: double.infinity,
              height: double.infinity,
              child: ColorFiltered(
                colorFilter:
                    const ColorFilter.mode(Colors.white10, BlendMode.lighten),
                child: AppImage(
                    fit: BoxFit.cover,
                    height: double.infinity,
                    width: double.infinity,
                    placeholderColor: Colors.white38,
                    path: image),
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: double.infinity,
            padding: EdgeInsets.all(16),
            alignment: Alignment.bottomCenter,
            decoration: BoxDecoration(
                // boxShadow: [
                // BoxShadow(
                //   color: Color(0xff000000).withOpacity(0.5),
                //   blurRadius: 4,
                //   offset: Offset(0, 4),
                // ),
                // ],
                gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
                Colors.black,
                Colors.black.withOpacity(.83),
                Colors.black.withOpacity(.2),
                Colors.black.withOpacity(0),
                Colors.black.withOpacity(0),
                Colors.black.withOpacity(0),
              ],
            )),
            child: SafeArea(
              bottom: true,
              top: false,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (title.isNotEmpty)
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style: TextStyles.bold22(color: kWhite100).copyWith(
                        shadows: [
                          Shadow(
                            color: Color(0xff000000).withOpacity(.25),
                            offset: Offset(0, 4),
                            blurRadius: 5,
                          ),
                          Shadow(
                            color: Color(0xff292929).withOpacity(.40),
                            offset: Offset(0, 18),
                            blurRadius: 15,
                          ),
                        ],
                      ),
                    ),
                  if (description.isNotEmpty)
                    const SizedBox(
                      height: 12,
                    ),
                  if (description.isNotEmpty)
                    Text(
                      description,
                      textAlign: TextAlign.center,
                      style: TextStyles.regular12(color: kBorderColor).copyWith(
                        shadows: [
                          Shadow(
                            color: Color(0xff000000).withOpacity(.25),
                            offset: Offset(0, 4),
                            blurRadius: 5,
                          ),
                          Shadow(
                            color: Color(0xff292929).withOpacity(.40),
                            offset: Offset(0, 18),
                            blurRadius: 15,
                          ),
                        ],
                      ),
                    ),
                  const SizedBox(
                    height: 16,
                  ),
                  _ProgressWidget(
                    count: count,
                    currentIndex: currentIndex,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  AppButton(
                    text: translate("continue"),
                    radius: 20,
                    onPressed: () => onScrollNextTap(currentIndex + 1),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
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
