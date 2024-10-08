import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:vibers_net/common/apipath.dart';
import 'package:vibers_net/common/text_styles.dart';
import 'package:vibers_net/ui/shared/app_image.dart';
import '../../common/global.dart';
import '../../common/styles.dart';
import '/models/datum.dart';
import '/providers/movie_tv_provider.dart';
import '/providers/slider_provider.dart';
import 'package:provider/provider.dart';

class ImageSlider extends StatefulWidget {
  @override
  _ImageSliderState createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  List<Datum>? showsMoviesList;

  Widget imageSlider() {
    final slider = Provider.of<SliderProvider>(context, listen: false);
    final movieList =
        Provider.of<MovieTVProvider>(context, listen: false).moviesList;
    final tvList =
        Provider.of<MovieTVProvider>(context, listen: false).tvSeriesList;
    final slidersList = slider.sliderModel?.slider ?? [];
    final slidersLength = slidersList.length;
    return Column(
      children: [
        Expanded(
          child: Container(
            // height: MediaQuery.of(context).size.height * Constants.sliderHeight,
            child: slider.sliderModel!.slider!.length == 0
                ? SizedBox.shrink()
                : CarouselSlider.builder(
                    itemCount: slidersLength,
                    options: CarouselOptions(
                      height: MediaQuery.of(context).size.height *
                          Constants.sliderHeight,
                      scrollDirection: Axis.horizontal,
                      autoPlay: false,
                      autoPlayInterval: Duration(seconds: 10),
                      autoPlayAnimationDuration: Duration(milliseconds: 500),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      viewportFraction: 1.0,
                      enableInfiniteScroll: true,
                    ),
                    itemBuilder:
                        (BuildContext context, int index, int realIndex) {
                      final currentSlider = slidersList[index];
                      final sliderImage = currentSlider.slideImage;
                      var linkedTo = currentSlider.tvSeriesId != null
                          ? "shows/"
                          : currentSlider.movieId != null
                              ? "movies/"
                              : "";

                      if (slidersList.isEmpty) {
                        return SizedBox.shrink();
                      } else {
                        if (sliderImage == null) {
                          return SizedBox.shrink();
                        } else {
                          List<Datum> x = [];

                          if (currentSlider.movieId != null) {
                            x = List.from(movieList.where((item) =>
                                "${item.id}" == "${currentSlider.movieId}"));
                          } else {
                            x = List.from(tvList.where((item) =>
                                "${item.id}" == "${currentSlider.tvSeriesId}"));
                          }

                          return InkWell(
                            child: Container(
                              height: MediaQuery.of(context).size.height *
                                  Constants.sliderHeight,
                              padding: const EdgeInsets.only(
                                  top: 0.0, bottom: 0.0, left: 0.0, right: 0.0),
                              child: Stack(
                                alignment: Alignment.bottomCenter,
                                children: [
                                  AppImage(
                                    // path:
                                    // "https://media.istockphoto.com/id/507995592/photo/pensive-man-looking-at-the-camera.jpg?s=612x612&w=0&k=20&c=fVoaIqpHo07YzX0-Pw51VgDBiWPZpLyGEahSxUlai7M=",
                                    path: "${APIData.appSlider}" +
                                        "$linkedTo" +
                                        "$sliderImage",
                                    height: double.infinity,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                    showFailIcon: false,
                                  ),
                                  Container(
                                    height: MediaQuery.of(context).size.height *
                                        Constants.sliderHeight,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      gradient: LinearGradient(
                                        begin: FractionalOffset.topCenter,
                                        end: FractionalOffset.bottomCenter,
                                        colors: [
                                          Theme.of(context)
                                              .primaryColorDark
                                              .withOpacity(.8),
                                          Theme.of(context)
                                              .primaryColorDark
                                              .withOpacity(.4),
                                          Colors.transparent,
                                          Colors.transparent,
                                          Theme.of(context).primaryColorDark,
                                        ],
                                        stops: [0.02, .1, 0.4, 0.6, 1.0],
                                      ),
                                    ),
                                  ),
                                  // x.length > 0
                                  //     ? slider.sliderModel!.slider![index].movieId !=
                                  //                 null ||
                                  //             slider.sliderModel!.slider![index]
                                  //                     .tvSeriesId !=
                                  //                 null
                                  //         ? Padding(
                                  //             padding: EdgeInsets.only(bottom: 20.0),
                                  //             child: ElevatedButton.icon(
                                  //               style: ElevatedButton.styleFrom(
                                  //                 shape: RoundedRectangleBorder(
                                  //                   borderRadius:
                                  //                       BorderRadius.circular(5.0),
                                  //                 ),
                                  //                 backgroundColor: isLight
                                  //                     ? Colors.black.withOpacity(0.7)
                                  //                     : Colors.white70,
                                  //                 padding: EdgeInsets.symmetric(
                                  //                     vertical: 10.0,
                                  //                     horizontal: 20.0),
                                  //               ),
                                  //               onPressed: () {
                                  //                 print(
                                  //                     "here: ${slider.sliderModel!.slider![index].movieId}");
                                  //                 print(
                                  //                     "here2: ${slider.sliderModel!.slider![index].tvSeriesId}");

                                  //                 Navigator.pushNamed(
                                  //                     context, RoutePaths.videoDetail,
                                  //                     arguments:
                                  //                         VideoDetailScreen(x[0]));
                                  //               },
                                  //               icon: Icon(
                                  //                 Icons.info_outline_rounded,
                                  //                 color: isLight
                                  //                     ? buildLightTheme()
                                  //                         .primaryColorLight
                                  //                     : buildDarkTheme()
                                  //                         .primaryColorDark,
                                  //                 size: 24.0,
                                  //               ),
                                  //               label: Text(
                                  //                 translate('Detail___More'),
                                  //                 style: TextStyle(
                                  //                   color: isLight
                                  //                       ? buildLightTheme()
                                  //                           .primaryColorLight
                                  //                       : buildDarkTheme()
                                  //                           .primaryColorDark,
                                  //                 ),
                                  //               ),
                                  //             ),
                                  //           )
                                  //         : SizedBox.shrink()
                                  //     : SizedBox.shrink(),
                                  Positioned(
                                      bottom: 0,
                                      left: 0,
                                      right: 0,
                                      child: _CurrentSliderDetailsWidget(
                                        onPlayPressed: () {},
                                        age: "18",
                                        duration: "55m",
                                        name: "Muslim Celebrities - UK",
                                        quality: "HD",
                                        date: "2023",
                                      )),
                                ],
                              ),
                            ),
                          );
                        }
                      }
                    },
                  ),
          ),
        ),
        Container(
          height: kTextTabBarHeight,
          width: double.infinity,
          color: kScafoldBgColor,
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final slider =
        Provider.of<SliderProvider>(context, listen: false).sliderModel!;
    return slider.slider == null
        ? SizedBox.shrink()
        : Container(
            child: imageSlider(),
          );
  }
}

class _CurrentSliderDetailsWidget extends StatelessWidget {
  const _CurrentSliderDetailsWidget(
      {Key? key,
      required this.onPlayPressed,
      required this.name,
      required this.duration,
      required this.quality,
      required this.age,
      required this.date})
      : super(key: key);
  final VoidCallback onPlayPressed;
  final String name, duration, date, quality, age;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/home_slider_shade_bg.png"),
          fit: BoxFit.fitWidth,
        ),
        color: Colors.black.withOpacity(.11),
        // gradient: LinearGradient(colors: [
        //   Color(0xff161616),
        //   Color(0xff444341).withOpacity(.4),
        //   Color(0xff161616).withOpacity(0)
        // ], begin: Alignment.bottomCenter, end: Alignment.topCenter)
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            name,
            style: TextStyles.regular16(color: kWhite100),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            softWrap: true,
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 4,
          ),
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            alignment: WrapAlignment.center,
            runAlignment: WrapAlignment.center,
            runSpacing: 4,
            spacing: 4,
            children: [
              Text(
                date,
                style: TextStyles.regular12(color: kWhite100),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                softWrap: true,
                textAlign: TextAlign.center,
              ),
              plusIcon,
              outlinedText(age),
              plusIcon,
              Text(
                duration,
                style: TextStyles.regular12(color: kWhite100),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                softWrap: true,
                textAlign: TextAlign.center,
              ),
              plusIcon,
              outlinedText(quality),
            ],
          ),
          const SizedBox(
            height: 4,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {},
                child: Icon(
                  Icons.info_outline,
                  color: kWhite100.withOpacity(.8),
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Flexible(
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: kWhite100.withOpacity(.38)),
                  padding: EdgeInsets.symmetric(vertical: 6, horizontal: 30),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.play_circle_fill_outlined,
                        color: kDarkTextColor,
                        size: 20,
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      Text(
                        "Play",
                        style: TextStyles.semiBold14(color: kDarkTextColor),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {},
                child: Icon(
                  Icons.add_circle_outline,
                  color: kWhite100.withOpacity(.8),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              5,
              (index) {
                final bool isSelected = index == 2;
                return Flexible(
                  flex: isSelected ? 2 : 1,
                  fit: FlexFit.loose,
                  child: AnimatedContainer(
                    duration: Durations.medium1,
                    margin: EdgeInsets.symmetric(horizontal: 1),
                    height: 4,
                    width: isSelected ? 32 : 17,
                    decoration: BoxDecoration(
                      color: isSelected ? kMainThemeColor : kWhite100,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  Widget get plusIcon {
    return Icon(
      Icons.add,
      size: 14,
      color: kRedColor,
    );
  }

  Widget outlinedText(String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2),
        border: Border.all(color: kRedColor, width: 1.5),
      ),
      child: Text(
        text,
        style: TextStyles.regular12(color: kWhite100),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        softWrap: true,
        textAlign: TextAlign.center,
      ),
    );
  }
}
