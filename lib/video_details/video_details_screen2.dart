import 'package:flutter/material.dart';

part 'widgets/presistent_top_app_bar.dart';

class VideoDetailsScreen2 extends StatefulWidget {
  const VideoDetailsScreen2({Key? key}) : super(key: key);

  @override
  State<VideoDetailsScreen2> createState() => _VideoDetailsScreen2State();
}

class _VideoDetailsScreen2State extends State<VideoDetailsScreen2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _PersistentTopAppBar(),
          Expanded(
              child: NestedScrollView(
                  headerSliverBuilder: (context, innerBoxIsScrolled) {
                    return <Widget>[];
                  },
                  body: Column())),
        ],
      ),
    );
  }
}
