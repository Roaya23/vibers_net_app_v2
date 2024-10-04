import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vibers_net/common/styles.dart';

abstract class TextStyles {
  //region:: Light
  static TextStyle light12({Color? color}) => TextStyle(
        color: color,
        fontSize: 12.sp,
        fontWeight: FontWeight.w300,
        fontFamily: kFontFamilyName,
      );

  static TextStyle light14({Color? color}) => TextStyle(
        color: color,
        fontSize: 14.sp,
        fontWeight: FontWeight.w300,
        fontFamily: kFontFamilyName,
      );

  //region:: Regular
  static TextStyle regular20({Color? color}) => TextStyle(
        color: color,
        fontSize: 20.sp,
        fontWeight: FontWeight.w400,
        fontFamily: kFontFamilyName,
      );

  static TextStyle regular18({Color? color}) => TextStyle(
        color: color,
        fontSize: 18.sp,
        fontWeight: FontWeight.w400,
        fontFamily: kFontFamilyName,
      );

  static TextStyle regular17({Color? color}) => TextStyle(
        color: color,
        fontSize: 17.sp,
        fontWeight: FontWeight.w400,
        fontFamily: kFontFamilyName,
      );

  static TextStyle regular16({Color? color, String? font}) => TextStyle(
        color: color,
        fontSize: 16.sp,
        fontWeight: FontWeight.w400,
        fontFamily: font ?? kFontFamilyName,
      );

  static TextStyle regular15({Color? color}) => TextStyle(
        color: color,
        fontSize: 15.sp,
        fontWeight: FontWeight.w400,
        fontFamily: kFontFamilyName,
      );

  static TextStyle regular14({
    Color? color,
    String? fontFamily = kFontFamilyName,
  }) =>
      TextStyle(
        color: color,
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
        fontFamily: fontFamily,
      );

  static TextStyle regular13({Color? color}) => TextStyle(
        color: color,
        fontSize: 13.sp,
        fontWeight: FontWeight.w400,
        fontFamily: kFontFamilyName,
      );

  static TextStyle regular12({Color? color}) => TextStyle(
        color: color,
        fontSize: 12.sp,
        fontWeight: FontWeight.w400,
        fontFamily: kFontFamilyName,
      );

  //endregion

  //region:: Medium
  static TextStyle medium40({Color? color}) => TextStyle(
        color: color,
        fontSize: 40.sp,
        fontWeight: FontWeight.w500,
        fontFamily: kFontFamilyName,
      );

  static TextStyle medium32({Color? color}) => TextStyle(
        color: color,
        fontSize: 32.sp,
        fontWeight: FontWeight.w500,
        fontFamily: kFontFamilyName,
      );

  static TextStyle medium24({Color? color}) => TextStyle(
        color: color,
        fontSize: 24.sp,
        fontWeight: FontWeight.w500,
        fontFamily: kFontFamilyName,
      );
  static TextStyle medium25({Color? color}) => TextStyle(
        color: color,
        fontSize: 25.sp,
        fontWeight: FontWeight.w500,
        fontFamily: kFontFamilyName,
      );

  static TextStyle medium22({Color? color}) => TextStyle(
        color: color,
        fontSize: 22.sp,
        fontWeight: FontWeight.w500,
        fontFamily: kFontFamilyName,
      );

  static TextStyle medium20({Color? color}) => TextStyle(
        color: color,
        fontSize: 20.sp,
        fontWeight: FontWeight.w500,
        fontFamily: kFontFamilyName,
      );

  static TextStyle medium18({Color? color}) => TextStyle(
        color: color,
        fontSize: 18.sp,
        fontWeight: FontWeight.w500,
        fontFamily: kFontFamilyName,
      );

  static TextStyle medium17({Color? color}) => TextStyle(
        color: color,
        fontSize: 17.sp,
        fontWeight: FontWeight.w500,
        fontFamily: kFontFamilyName,
      );

  static TextStyle medium16({
    Color? color,
    String? font,
  }) =>
      TextStyle(
        color: color,
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
        fontFamily: font ?? kFontFamilyName,
      );

  static TextStyle medium15({Color? color}) => TextStyle(
        color: color,
        fontSize: 15.sp,
        fontWeight: FontWeight.w500,
        fontFamily: kFontFamilyName,
      );

  static TextStyle medium14({
    Color? color,
    String? font,
  }) =>
      TextStyle(
        color: color,
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
        fontFamily: font ?? kFontFamilyName,
      );

  static TextStyle medium13({Color? color}) => TextStyle(
        color: color,
        fontSize: 13.sp,
        fontWeight: FontWeight.w500,
        fontFamily: kFontFamilyName,
      );

  static TextStyle medium12({Color? color}) => TextStyle(
        color: color,
        fontSize: 12.sp,
        fontWeight: FontWeight.w500,
        fontFamily: kFontFamilyName,
      );

  static TextStyle medium10({Color? color}) => TextStyle(
        color: color,
        fontSize: 10.sp,
        fontWeight: FontWeight.w500,
        fontFamily: kFontFamilyName,
      );

  //endregion

  //region:: SemiBold
  static TextStyle semiBold40({Color? color}) => TextStyle(
        color: color,
        fontSize: 40.sp,
        fontWeight: FontWeight.w700,
        fontFamily: kFontFamilyName,
      );

  static TextStyle semiBold24({Color? color}) => TextStyle(
        color: color,
        fontSize: 24.sp,
        fontWeight: FontWeight.w700,
        fontFamily: kFontFamilyName,
      );

  static TextStyle semiBold22({Color? color}) => TextStyle(
        color: color,
        fontSize: 22.sp,
        fontWeight: FontWeight.w700,
        fontFamily: kFontFamilyName,
      );

  static TextStyle semiBold20({Color? color}) => TextStyle(
        color: color,
        fontSize: 20.sp,
        fontWeight: FontWeight.w700,
        fontFamily: kFontFamilyName,
      );

  static TextStyle semiBold18({Color? color}) => TextStyle(
        color: color,
        fontSize: 18.sp,
        fontWeight: FontWeight.w700,
        fontFamily: kFontFamilyName,
      );

  static TextStyle semiBold17({Color? color}) => TextStyle(
        color: color,
        fontSize: 17.sp,
        fontWeight: FontWeight.w700,
        fontFamily: kFontFamilyName,
      );

  static TextStyle semiBold16({Color? color}) => TextStyle(
        color: color,
        fontSize: 16.sp,
        fontWeight: FontWeight.w700,
        fontFamily: kFontFamilyName,
      );

  static TextStyle semiBold15({Color? color}) => TextStyle(
        color: color,
        fontSize: 15.sp,
        fontWeight: FontWeight.w700,
        fontFamily: kFontFamilyName,
      );

  static TextStyle semiBold14({Color? color}) => TextStyle(
        color: color,
        fontSize: 14.sp,
        fontWeight: FontWeight.w700,
        fontFamily: kFontFamilyName,
      );

  static TextStyle semiBold12({Color? color}) => TextStyle(
        color: color,
        fontSize: 12.sp,
        fontWeight: FontWeight.w700,
        fontFamily: kFontFamilyName,
      );

  //endregion

  //region:: Bold
  static TextStyle bold32({Color? color}) => TextStyle(
        color: color,
        fontSize: 32.sp,
        fontWeight: FontWeight.w700,
        fontFamily: kFontFamilyName,
      );

  static TextStyle bold24({Color? color}) => TextStyle(
        color: color,
        fontSize: 24.sp,
        fontWeight: FontWeight.w700,
        fontFamily: kFontFamilyName,
      );

  static TextStyle bold22({Color? color}) => TextStyle(
        color: color,
        fontSize: 22.sp,
        fontWeight: FontWeight.w700,
        fontFamily: kFontFamilyName,
      );

  static TextStyle bold20({Color? color, String? font}) => TextStyle(
        color: color,
        fontSize: 20.sp,
        fontWeight: FontWeight.w700,
        fontFamily: font ?? kFontFamilyName,
      );

  static TextStyle bold19({Color? color}) => TextStyle(
        color: color,
        fontSize: 19.sp,
        fontWeight: FontWeight.bold,
        fontFamily: kFontFamilyName,
      );

  static TextStyle bold18({Color? color}) => TextStyle(
        color: color,
        fontSize: 18.sp,
        fontWeight: FontWeight.bold,
        fontFamily: kFontFamilyName,
      );

  static TextStyle bold17({Color? color}) => TextStyle(
        color: color,
        fontSize: 17.sp,
        fontWeight: FontWeight.bold,
        fontFamily: kFontFamilyName,
      );

  static TextStyle bold16({Color? color}) => TextStyle(
        color: color,
        fontSize: 16.sp,
        fontWeight: FontWeight.bold,
        fontFamily: kFontFamilyName,
      );

  static TextStyle bold15({Color? color}) => TextStyle(
        color: color,
        fontSize: 15.sp,
        fontWeight: FontWeight.bold,
        fontFamily: kFontFamilyName,
      );

  static TextStyle bold14({Color? color}) => TextStyle(
        color: color,
        fontSize: 14.sp,
        fontWeight: FontWeight.bold,
        fontFamily: kFontFamilyName,
      );
  static TextStyle bold12({Color? color}) => TextStyle(
        color: color,
        fontSize: 12.sp,
        fontWeight: FontWeight.bold,
        fontFamily: kFontFamilyName,
      );

//endregion

  //region:: UnderLine Regular
  static TextStyle underlineRegular20({Color? color}) => TextStyle(
        color: color,
        fontSize: 20.sp,
        fontWeight: FontWeight.w400,
        decoration: TextDecoration.underline,
        fontFamily: kFontFamilyName,
      );
  static TextStyle underlineBold14({Color? color}) => TextStyle(
        color: color,
        fontSize: 14.sp,
        fontWeight: FontWeight.w700,
        decoration: TextDecoration.underline,
        fontFamily: kFontFamilyName,
      );
//endregion
}
