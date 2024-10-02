import 'package:flutter/material.dart';
import 'package:vibers_net/common/styles.dart';
import 'package:vibers_net/common/text_styles.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWidget({
    this.titleText,
    this.leading,
    this.actions = const [],
    this.centerTitle = true,
    this.bgColor,
    this.bottom,
    this.onPop,
  });

  final void Function()? onPop;

  final String? titleText;
  final Color? bgColor;
  final PreferredSizeWidget? bottom;
  final bool centerTitle;
  final List<Widget> actions;
  final Widget? leading;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: centerTitle,
      actions: actions,
      elevation: 0,
      automaticallyImplyLeading: false,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      backgroundColor: kScafoldBgColor,
      leading: leading ??
          ((ModalRoute.of(context)!.canPop || onPop != null)
              ? GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    if (onPop != null) {
                      onPop!();
                    } else {
                      Navigator.pop(context);
                    }
                  },
                  child: const Icon(
                    Icons.arrow_back,
                    size: 20,
                  ),
                )
              : null),
      title: titleText != null
          ? Text(
              titleText ?? '',
              style: TextStyles.semiBold20(color: kWhite100),
            )
          : null,
      bottom: bottom,
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(kToolbarHeight + (bottom?.preferredSize.height ?? 0));
}
