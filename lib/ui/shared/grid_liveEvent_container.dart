import 'package:flutter/material.dart';
import 'package:vibers_net/models/LiveEventModel.dart';
import 'package:vibers_net/ui/screens/liveEventScreen.dart';
import 'package:vibers_net/ui/shared/grid_liveEvent_box.dart';
import '../../common/route_paths.dart';

class GridLiveEventContainer extends StatelessWidget {
  GridLiveEventContainer(this.buildContext, this.liveEvent);
  final BuildContext buildContext;
  final LiveEvent liveEvent;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: new BorderRadius.circular(5.0),
      onTap: () => _goDetailsPage(context, liveEvent),
      child: liveEventColumn(context),
    );
  }

  void _goDetailsPage(BuildContext context, LiveEvent liveEvent) {
    Navigator.pushNamed(
      context,
      RoutePaths.Event,
      arguments: LiveEventScreen(
        liveEvent: liveEvent,
      ),
    );
  }

  Widget liveEventColumn(context) {
    return Hero(
      tag: Text("Hero"),
      child: new GridLiveEventBox(context, liveEvent),
    );
  }
}
