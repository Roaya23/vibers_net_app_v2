import 'package:flutter/material.dart';
import 'package:vibers_net/common/route_paths.dart';
import 'package:vibers_net/common/styles.dart';

class AppLoadingWidget extends StatelessWidget {
  const AppLoadingWidget({this.size = 50, this.strokeWidth = 6.0, this.color});
  final double size;
  final double strokeWidth;
  final Color? color;

  static const String routeName = "AppLoadingOverlay";

  static Future<void> overlay({BuildContext? context}) {
    return showDialog<bool?>(
      context: context ?? getAppNavigatorKeyContext,
      barrierDismissible: false,
      useRootNavigator: true,
      useSafeArea: true,
      routeSettings: const RouteSettings(name: routeName),
      builder: (BuildContext context) {
        return PopScope(
          canPop: false,
          child: Center(
            child: Container(
              height: 85,
              width: 85,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              alignment: Alignment.center,
              child: const FittedBox(child: AppLoadingWidget()),
            ),
          ),
        );
      },
    );
  }

  // static void removeOverlay() {
  //   final currentRoute = AppRouter.getCurrentRoute();
  //   if (currentRoute == routeName) {
  //     final context = AppRouter.navigatorKey.currentContext;
  //     if (context != null && context.mounted) {
  //       Navigator.of(context, rootNavigator: true).pop();
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SizedBox(
      height: size,
      width: size,
      child: FittedBox(
        child: CircularProgressIndicator(
          color: color ?? primaryBlue,
          strokeWidth: strokeWidth,
        ),
      ),
    ));
  }
}
