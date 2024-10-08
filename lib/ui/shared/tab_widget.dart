import 'package:flutter/material.dart';

class TabWidget extends StatelessWidget {
  TabWidget(this.title);
  final title;
  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Container(
        alignment: Alignment.center,
        child: Text(
          title,
        ),
      ),
    );
  }
}
