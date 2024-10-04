import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:vibers_net/common/text_styles.dart';

const String kFontFamilyName = "GothicA1";

/// basic colors
const cStatusBarColor = Color(0xff070010);
const cSystemNavigationColor = cStatusBarColor;
const primaryBlue = Color(0xffFBCA51);
const kTeal50 = Color(0xFFE0F2F1);
const kTeal100 = Color(0xFF3FC1BE);
const kDefaultBackgroundAvatar = '3FC1BE';
const kDefaultTextColorAvatar = 'EEEEEE';
const kDefaultAdminBackgroundAvatar = 'EEEEEE';
const kDefaultAdminTextColorAvatar = '3FC1BE';
const kTeal400 = Color(0xFF26A69A);
const kGrey900 = Color(0xFF141414);
const kGreyColor = Color(0xFFa3a3a3);
const kGrey600 = Color(0xFF546E7A);
const kGrey200 = Color(0xFFEEEEEE);
const kGrey400 = Color(0xFF90a4ae);
const kErrorRed = Color(0xFFB00020);
const kSurfaceWhite = Color(0xFFFFFBFA);
const kBackgroundWhite = Color.fromRGBO(255, 255, 255, 1.0);

/// color for theme
const kMainThemeColor = primaryBlue;
const kMainLight = Color(0xffFEEDC2);
const kScafoldBgColor = Color(0xff070010);
const kLightScafoldBgColor = Color(0xffC4C4C4);
const kLightPrimary = Color(0xfffcfcff);
const kLightAccent = Color(0xFF546E7A);
const kLightThemeTextHeading = Color(0xff141414);
const kDarkAccent = Color(0xffF4F5F5);
const kLightBG1 = Color(0xffFFFFFF);
const kLightBG2 = Color(0xffF1F2F3);
const kDarkBG = Color.fromRGBO(34, 34, 34, 1.0);
const kHintColor = Color.fromRGBO(106, 122, 130, 1.0);
const kDarkBgLight = kScafoldBgColor;
const kDarkBgDark = kScafoldBgColor;
const kDarkTextColor = Color(0xff070010);
const kWhiteTextColor = Color(0xffFEFEFE);
final kWhite100TextColor = Color(0xffFEFEFE).withOpacity(.85);

const kLightThemeTextColor = Color.fromRGBO(27, 84, 111, 1.0);
const kBadgeColor = Colors.red;
const cardColor = Color.fromRGBO(100, 100, 100, 1.0);
final kBorderColor = kWhiteTextColor.withOpacity(.35);
const kWhite100 = Color(0xffE6E6E6);
const kProductTitleStyleLarge =
    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold);
const kRedColor = Color(0xFFCE060B);

var kTextField = InputDecoration(
  // hintText: translate('Enter_your_value'),
  contentPadding: EdgeInsets.only(
    top: 13,
    bottom: 7,
    right: 12,
    left: 12,
  ),
  border: OutlineInputBorder(
    borderSide: BorderSide(color: kBorderColor, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(6.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(6.0)),
  ),
  errorBorder: OutlineInputBorder(
    borderSide: BorderSide(color: kRedColor, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(6.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide:
        BorderSide(color: kWhiteTextColor.withOpacity(.5), width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(6.0)),
  ),
);

IconThemeData _customIconTheme1(IconThemeData original) {
  return original.copyWith(color: kLightThemeTextColor);
}

IconThemeData _customIconTheme2(IconThemeData original) {
  return original.copyWith(color: kHintColor);
}

IconThemeData _customIconTheme3(IconThemeData original) {
  return original.copyWith(color: kBackgroundWhite);
}

IconThemeData _customIconTheme4(IconThemeData original) {
  return original.copyWith(color: kGreyColor);
}

var _inputDecorationTheme = InputDecorationTheme(
  labelStyle: TextStyles.medium14(),
  contentPadding: EdgeInsets.symmetric(
    horizontal: 12,
    vertical: 10,
  ),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(const Radius.circular(6)),
    borderSide: BorderSide(
      color: kBorderColor,
    ),
  ),
  disabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(const Radius.circular(6)),
    borderSide: const BorderSide(
      color: Color(0xffE9E9E9),
    ),
  ),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(const Radius.circular(6)),
    borderSide: const BorderSide(
      color: kWhiteTextColor,
    ),
  ),
  
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(const Radius.circular(6)),
    borderSide: BorderSide(
      color: Colors.white,
    ),
  ),
  errorBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(const Radius.circular(8)),
    borderSide: const BorderSide(
      color: kErrorRed,
    ),
  ),
  focusedErrorBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(const Radius.circular(8)),
    borderSide: const BorderSide(
      color: kErrorRed,
    ),
  ),
);
ThemeData buildLightTheme() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
    cardColor: Colors.white,
    inputDecorationTheme: _inputDecorationTheme,
    textSelectionTheme: TextSelectionThemeData(
      selectionColor: kLightThemeTextColor,
      cursorColor: kLightAccent,
    ),
    buttonTheme: const ButtonThemeData(
      colorScheme: kColorScheme,
      textTheme: ButtonTextTheme.normal,
    ),
    primaryColorLight: kLightBG2,
    primaryColorDark: kDarkBgDark,
    primaryIconTheme: _customIconTheme1(base.iconTheme),
    textTheme: _buildTextTheme(base.textTheme),
    primaryTextTheme: _buildTextTheme(base.primaryTextTheme),
    iconTheme: _customIconTheme2(base.iconTheme),
    hintColor: kHintColor,
    primaryColor: kMainThemeColor,
    scaffoldBackgroundColor: kMainThemeColor,
    appBarTheme: AppBarTheme(
      elevation: 0,
      iconTheme: IconThemeData(
        color: kLightAccent,
      ),
      toolbarTextStyle: TextTheme(
        titleLarge: TextStyle(
          color: kDarkBG,
          fontSize: 18.0,
          fontWeight: FontWeight.w800,
        ),
      ).bodyMedium,
      titleTextStyle: TextTheme(
        titleLarge: TextStyle(
          color: kDarkBG,
          fontSize: 18.0,
          fontWeight: FontWeight.w800,
        ),
      ).titleLarge,
    ),
    colorScheme: kColorScheme
        .copyWith(
            // background: Colors.white,
            surface: kDarkBG)
        .copyWith(error: kErrorRed),
  );
}

TextTheme _buildTextTheme(TextTheme base) {
  return base
      .copyWith(
        headlineSmall: base.headlineSmall!
            .copyWith(fontWeight: FontWeight.w500, color: Colors.red),
        titleLarge: base.titleLarge!.copyWith(fontSize: 18.0),
        bodySmall: base.bodySmall!.copyWith(
          fontWeight: FontWeight.w400,
          fontSize: 14.0,
        ),
        bodyLarge: base.bodyLarge!.copyWith(
          fontWeight: FontWeight.w400,
          fontSize: 16.0,
        ),
        labelLarge: base.labelLarge!.copyWith(
          fontWeight: FontWeight.w400,
          fontSize: 14.0,
        ),
      )
      .apply(
        fontFamily: kFontFamilyName,
        displayColor: kGrey900,
        bodyColor: kGrey900,
      )
      .copyWith(
          headlineSmall:
              base.headlineSmall!.copyWith(fontFamily: kFontFamilyName));
}

const ColorScheme kColorScheme = ColorScheme(
  primary: kTeal100,
  secondary: kTeal50,
  surface: kSurfaceWhite,
  // background: kBackgroundWhite,
  error: kErrorRed,
  onPrimary: kGrey900,
  onSecondary: kGrey900,
  onSurface: kGrey900,
  // onBackground: kGrey900,
  onError: kSurfaceWhite,
  brightness: Brightness.light,
);

ThemeData buildDarkTheme() {
  final ThemeData base = ThemeData.dark();
  return base.copyWith(
    cardColor: cardColor,
    brightness: Brightness.dark,
    inputDecorationTheme: _inputDecorationTheme,
    primaryColor: kMainThemeColor,
    primaryColorLight: kDarkBgLight,
    primaryColorDark: kDarkBgDark,
    scaffoldBackgroundColor: kScafoldBgColor,
    hintColor: kGreyColor,
    primaryIconTheme: _customIconTheme3(base.iconTheme),
    iconTheme: _customIconTheme4(base.iconTheme),
    textSelectionTheme: TextSelectionThemeData(
      selectionColor: Colors.white,
      cursorColor: kDarkAccent,
    ),
    appBarTheme: AppBarTheme(
      elevation: 0,
      iconTheme: IconThemeData(
        color: kDarkAccent,
      ),
      toolbarTextStyle: TextTheme(
        titleLarge: TextStyle(
          color: kLightBG1,
          fontSize: 18.0,
          fontWeight: FontWeight.w800,
        ),
      ).bodyMedium,
      titleTextStyle: TextTheme(
        titleLarge: TextStyle(
          color: kLightBG1,
          fontSize: 18.0,
          fontWeight: FontWeight.w800,
        ),
      ).titleLarge,
    ),
    colorScheme: ColorScheme(
      // background: kDarkBG,
      primary: kTeal100,
      secondary: kTeal50,
      surface: kSurfaceWhite,
      error: kErrorRed,
      onPrimary: kGrey200,
      onSecondary: kGrey200,
      onSurface: kGrey200,
      // onBackground: kGrey200,
      onError: kSurfaceWhite,
      brightness: Brightness.dark,
    ),
  );
}

const kMessageContainerDecoration = BoxDecoration(
  border: Border(
    top: BorderSide(color: kTeal400, width: 2.0),
  ),
);

const kSendButtonTextStyle = TextStyle(
  color: kTeal400,
  fontWeight: FontWeight.bold,
  fontSize: 18.0,
);

var kMessageTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  hintText: translate('Type_your_message_here...'),
  border: InputBorder.none,
);
