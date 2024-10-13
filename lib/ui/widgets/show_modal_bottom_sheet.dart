// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vibers_net/common/styles.dart';
import 'package:vibers_net/common/text_styles.dart';

Future<T?> showAppModalBottomSheet<T>(
    {required BuildContext context,
    required Widget child,
    double? borderRadius,
    bool isDismissible = true,
    bool enableDrag = true,
    String? title,
    String? subTitle,
    TextStyle? subTitleStyle,
    bool hasTopInductor = true,
    RouteSettings? routeSettings,
    EdgeInsets? padding}) async {
  if (FocusManager.instance.primaryFocus?.hasPrimaryFocus == true) {
    FocusScope.of(context).requestFocus(FocusNode());
    SystemChannels.textInput.invokeMethod('TextInput.hide');
  }
  return await showModalBottomSheet<T?>(
    context: context,
    isScrollControlled: true,
    enableDrag: enableDrag,
    // useRootNavigator: true,
    isDismissible: isDismissible,
    routeSettings: routeSettings,
    useSafeArea: true,
    clipBehavior: Clip.antiAlias,
    elevation: 0,
    backgroundColor: kScafoldBgColor,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius ?? 20.r),
        side: BorderSide.none),
    builder: (BuildContext context) {
      return Container(
          clipBehavior: Clip.antiAlias,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: kScafoldBgColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(28.r),
                  topRight: Radius.circular(28.r))),
          padding: padding ??
              const EdgeInsets.symmetric(horizontal: 16, vertical: 16).r,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (hasTopInductor)
                Container(
                  alignment: Alignment.center,
                  width: 32,
                  height: 4,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: const Color(0xff938F99)),
                ),
                const SizedBox(
                  height: 32,
                ),
              Flexible(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      if (title != null)
                        Text(title,
                            textAlign: TextAlign.center,
                            style: TextStyles.semiBold20(color: Colors.white)),
                      if (title != null)
                        Container(
                          height: 1,
                          margin: EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            color: kBorderColor,
                          ),
                        ),
                      const SizedBox(height: 12),
                      child,
                      SizedBox(
                          height: MediaQuery.of(context).viewInsets.bottom),
                    ],
                  ),
                ),
              ),
            ],
          ));
    },
  );
}

Future<T?> showAppTopModalSheet<T>({
  required BuildContext context,
  required List<Widget> children,
  double? borderRadius,
  bool isDismissible = true,
  bool hasInductor = true,
  String? routeSettingsName,
  EdgeInsets? padding,
  Widget Function(BuildContext context)? header,
  Widget Function(BuildContext context)? footer,
}) async {
  if (FocusManager.instance.primaryFocus?.hasPrimaryFocus == true) {
    FocusScope.of(context).requestFocus(FocusNode());
    SystemChannels.textInput.invokeMethod('TextInput.hide');
  }
  return await showGeneralDialog<T?>(
    context: context,
    barrierDismissible: isDismissible,
    useRootNavigator: true,
    barrierLabel: routeSettingsName ?? "showAppTopModalSheet",
    routeSettings: RouteSettings(name: routeSettingsName),
    pageBuilder: (BuildContext buildContext, Animation animation,
        Animation secondaryAnimation) {
      return Align(
        alignment: Alignment.topCenter,
        child: Material(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(12.r),
                  bottomRight: Radius.circular(12.r))),
          elevation: .7,
          child: Container(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              width: MediaQuery.of(context).size.width,
              constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * .92),
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              padding: padding ??
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 12).r,
              child: SafeArea(
                top: true,
                bottom: false,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (header != null) header(context),
                    Flexible(
                      child: SingleChildScrollView(
                        child: Column(children: children),
                      ),
                    ),
                    if (footer != null) footer(context),
                    const SizedBox(
                      height: 20,
                    ),
                    if (hasInductor)
                      Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width * .25,
                        height: 5,
                        margin: const EdgeInsets.only(top: 4),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: const Color(0xffD6D6D6)),
                      ),
                  ],
                ),
              )),
        ),
      );
    },
    transitionBuilder: (context, anim1, anim2, child) {
      return SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, -1), // Slide from top
          end: const Offset(0, 0),
        ).animate(anim1),
        child: child,
      );
    },
    transitionDuration: const Duration(milliseconds: 300),
  );
}
