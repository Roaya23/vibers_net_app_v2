import 'dart:io';
import 'package:flutter/material.dart';
import 'package:vibers_net/common/styles.dart';
import 'package:cached_network_image/cached_network_image.dart';

class AppImage extends StatelessWidget {
  final String path;
  final Color placeholderColor;
  final BoxFit? fit;
  final double? height;
  final double? width;
  final double scale;
  final bool showFailIcon;
  final bool cacheImage;

  const AppImage({
    required this.path,
    this.placeholderColor = kGrey400,
    this.fit = BoxFit.cover,
    this.height,
    this.width,
    this.scale = 1.0,
    this.showFailIcon = false,
    this.cacheImage = true,
  });

  static circle(
      {required String path,
      BoxFit? fit,
      double? dimension,
      BoxBorder? border,
      bool showFailIcon = false,
      Color? bgColor}) {
    return Container(
      height: dimension,
      width: dimension,
      decoration: BoxDecoration(
          shape: BoxShape.circle, border: border, color: bgColor ?? kGrey400),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: AppImage(
        path: path,
        fit: fit ?? BoxFit.cover,
        showFailIcon: showFailIcon,
      ),
    );
  }

  static Widget rounded({
    Key? key,
    required String path,
    final BoxFit? fit,
    final double? height,
    final double? width,
    final double? radius,
    final Color? bgColor,
    final List<BoxShadow>? boxShadow,
    bool showFailIcon = false,
  }) {
    return Container(
      key: key,
      height: height,
      width: width,
      decoration: BoxDecoration(
          color: bgColor ?? kGrey400,
          borderRadius: BorderRadius.circular(radius ?? 8),
          boxShadow: boxShadow),
      foregroundDecoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius ?? 8),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: AppImage(
        path: path,
        fit: fit,
        height: height,
        width: width,
        showFailIcon: showFailIcon,
      ),
    );
  }

  static defaultImage({
    required String path,
    final BoxFit? fit,
    final double? height,
    final double? width,
  }) {
    return AppImage(
      height: height,
      width: width,
      path: path,
      fit: fit,
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget imageWidget;
    if (path.startsWith('http') || path.startsWith('https')) {
      if (cacheImage) {
        imageWidget = CachedNetworkImage(
          imageUrl: path,
          placeholder: (context, url) => Container(),
          errorWidget: (context, url, error) => _errorBuilderWidget(),
          height: height,
          width: width,
          fit: fit,
          useOldImageOnUrlChange: false,
        );
      } else {
        imageWidget = FadeInImage.assetNetwork(
          width: width,
          height: height,
          imageScale: scale,
          placeholder: "assets/native_splash/native_bg_with_dot.png",
          placeholderFit: fit ?? BoxFit.cover,
          image: path,
          placeholderScale: .5,
          placeholderErrorBuilder: (context, error, stackTrace) {
            return const SizedBox();
          },
          imageErrorBuilder: (context, error, stackTrace) {
            return _errorBuilderWidget();
          },
          fit: fit,
        );
      }
    } else if (path.startsWith('/')) {
      imageWidget = Image.file(
        File(path),
        height: height,
        scale: scale,
        width: width,
        fit: fit,
        errorBuilder: (context, error, stackTrace) {
          return _errorBuilderWidget();
        },
      );
    } else {
      imageWidget = Image.asset(
        path,
        height: height,
        width: width,
        scale: scale,
        errorBuilder: (context, error, stackTrace) {
          return _errorBuilderWidget();
        },
        fit: fit,
      );
    }
    return imageWidget;
  }

  Widget _errorBuilderWidget() {
    if (showFailIcon == false) return const SizedBox();
    return FractionallySizedBox(
        widthFactor: 0.25,
        heightFactor: 0.25,
        child: FittedBox(
            child: Icon(Icons.broken_image_rounded, color: primaryBlue)));
  }
}
