import 'package:flutter/material.dart';
import 'package:vibers_net/common/global.dart';
import 'package:vibers_net/common/styles.dart';
import 'package:vibers_net/common/text_styles.dart';
import 'package:vibers_net/ui/shared/app_image.dart';
import 'package:vibers_net/ui/shared/image_slider.dart';

class HomeEBookList extends StatelessWidget {
  const HomeEBookList({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
              height:
                  MediaQuery.of(context).size.height * Constants.sliderHeight,
              child: ImageSlider()),
          const SizedBox(
            height: 32,
          ),
          _ListPreview(
            title: "Recommended for you",
          ),
          const SizedBox(
            height: 24,
          ),
          _ListPreview(
            title: "Trending",
          ),
          const SizedBox(
            height: 32,
          ),
        ],
      ),
    );
  }
}

class _ListPreview extends StatelessWidget {
  const _ListPreview({required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: TextStyles.semiBold14(color: kWhite100),
                ),
              ),
              const SizedBox(
                width: 8,
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        SizedBox(
          height: 160,
          child: ListView.separated(
            itemCount: 10,
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 16),
            separatorBuilder: (context, index) => const SizedBox(
              width: 16,
            ),
            itemBuilder: (context, index) {
              return AppImage.rounded(
                  fit: BoxFit.cover,
                  path:
                      "https://m.media-amazon.com/images/I/719WTtlFxTL._AC_UF894,1000_QL80_.jpg",
                  width: 105);
            },
          ),
        ),
      ],
    );
  }
}
