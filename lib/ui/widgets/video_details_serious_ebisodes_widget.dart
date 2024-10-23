import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:vibers_net/common/styles.dart';
import 'package:vibers_net/common/text_styles.dart';
import 'package:vibers_net/ui/shared/app_image.dart';

class VideDetailsEbisodesWidget extends StatelessWidget {
  const VideDetailsEbisodesWidget(
      {Key? key,
      required this.seasons,
      required this.onSeasonChanged,
      required this.currentSeason})
      : super(key: key);
  final String currentSeason;
  final List<String> seasons;
  final void Function(int index) onSeasonChanged;

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
              Text(
                translate("EPISODES_"),
                style: TextStyles.semiBold12(color: kWhite100),
              ),
              const SizedBox(
                width: 12,
              ),
              Expanded(
                  child: Align(
                alignment: AlignmentDirectional.centerEnd,
                child: AppMenuAnchor<String>(
                  value: currentSeason,
                  getValueText: (value) => value,
                  onPopUpChange: (value, index) {
                    onSeasonChanged(index);
                  },
                  values: seasons,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        currentSeason,
                        textAlign: TextAlign.end,
                        style: TextStyles.semiBold12(color: kWhite100),
                      ),
                      const SizedBox(
                        width: 2,
                      ),
                      Icon(
                        Icons.keyboard_arrow_down_outlined,
                        size: 16,
                        color: kWhite100,
                      ),
                    ],
                  ),
                ),
              ))
            ],
          ),
        ),
        const SizedBox(
          height: 12,
        ),
      ],
    );
  }
}

class SeasonEpisodesListWidget extends StatelessWidget {
  const SeasonEpisodesListWidget({required this.getTumbnail, required this.onTap});

  final String Function(int index) getTumbnail;
  final void Function(int index) onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 110,
      child: ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
              width: 170,
              height: double.infinity,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  AppImage(
                    path: getTumbnail(index),
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                  Icon(
                    Icons.play_circle_filled_rounded,
                    color: kWhite100,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [
                          Colors.transparent,
                          Colors.transparent,
                          Colors.transparent,
                          Color(0xff5F5B55).withOpacity(.3),
                          Color(0xff5F5B55).withOpacity(.5),
                        ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter)),
                  ),
                  PositionedDirectional(
                      start: 8,
                      end: 8,
                      bottom: 8,
                      child: Text(
                        translate(
                          "EPISODE" + "\t${index + 1}",
                        ),
                        style: TextStyles.medium12(color: kWhite100),
                      )),
                ],
              ),
            );
          },
          separatorBuilder: (context, index) => const SizedBox(
                width: 6,
              ),
          itemCount: 5),
    );
  }
}

class _CommingSoonWidget extends StatelessWidget {
  const _CommingSoonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32),
      child: Text("data"),
    );
  }
}

class AppMenuAnchor<T> extends StatefulWidget {
  const AppMenuAnchor({
    required this.child,
    this.onTap,
    this.onClose,
    required this.getValueText,
    required this.values,
    this.onPopUpChange,
    this.value,
    this.menuWidth,
    this.dxMenu = 0,
    this.dyMenu = 0,
  });

  final Widget child;
  final void Function()? onTap;
  final void Function()? onClose;
  final String Function(T value) getValueText;
  final List<T> values;
  final void Function(T? value, int index)? onPopUpChange;
  final T? value;
  final double? menuWidth;
  final double dxMenu;
  final double dyMenu;

  @override
  State<AppMenuAnchor<T>> createState() => _AppMenuAnchorState<T>();
}

class _AppMenuAnchorState<T> extends State<AppMenuAnchor<T>> {
  final MenuController _menuController = MenuController();

  @override
  Widget build(BuildContext context) {
    return MenuAnchor(
      controller: _menuController,
      onClose: () {
        if (widget.onClose != null) widget.onClose!();
        setState(() {});
      },
      onOpen: () {
        setState(() {});
      },
      consumeOutsideTap: true,
      clipBehavior: Clip.antiAlias,
      alignmentOffset: Offset(widget.dxMenu, widget.dyMenu),
      style: MenuStyle(
        backgroundColor: WidgetStateProperty.all(kScafoldBgColor),
        // alignment: AlignmentDirectional.bottomEnd,
        // maximumSize: WidgetStateProperty.all<Size?>(
        //   Size(double.infinity, MediaQuery.of(context).size.height * .35),
        // ),
        // minimumSize: WidgetStateProperty.all<Size?>(
        //   Size(100, 10),
        // ),
        elevation: WidgetStateProperty.all<double>(5),
        shape: WidgetStateProperty.all<OutlinedBorder?>(
          RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
              side: BorderSide(color: kBorderColor, width: .5)),
        ),
      ),
      // alignmentOffset: const Offset(-150, 7),
      builder:
          (BuildContext context, MenuController controller, Widget? child) {
        return InkWell(
          hoverColor: Colors.transparent,
          focusColor: Colors.transparent,
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          onTap: () {
            if (widget.onTap != null) widget.onTap!();
            if (controller.isOpen) {
              controller.close();
            } else {
              controller.open();
            }
          },
          child: widget.child,
        );
      },

      menuChildren: widget.values.mapIndexed((index, element) {
        final currentValue = widget.values[index];
        return InkWell(
          focusColor: Colors.transparent,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () {
            if (widget.onPopUpChange != null) {
              widget.onPopUpChange!(currentValue, index);
            }
            _menuController.close();
          },
          child: Container(
            width: widget.menuWidth ?? MediaQuery.of(context).size.width * .4,
            constraints: widget.menuWidth == null
                ? BoxConstraints(
                    minWidth: MediaQuery.of(context).size.width * .4,
                    maxWidth: MediaQuery.of(context).size.width * .6)
                : null,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2),
                color: widget.value == currentValue ? kMainLight : null),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Text(
              widget.getValueText(element),
              maxLines: 5,
              overflow: TextOverflow.ellipsis,
              style: TextStyles.medium12(
                  color: widget.value == currentValue
                      ? kDarkTextColor
                      : kWhiteTextColor),
            ),
          ),
        );
      }).toList(),
    );
  }
}
