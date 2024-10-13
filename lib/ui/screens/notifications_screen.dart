import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:vibers_net/common/text_styles.dart';
import '/common/route_paths.dart';
import '/common/styles.dart';
import '/providers/notifications_provider.dart';
import '/ui/screens/notification_detail_screen.dart';
import '/ui/shared/appbar.dart';
import 'package:provider/provider.dart';

class NotificationsScreen extends StatefulWidget {
  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  bool _visible = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {});
    try {
      NotificationsProvider notificationsProvider =
          Provider.of<NotificationsProvider>(context, listen: false);
      notificationsProvider.fetchNotifications();
      if (mounted) {
        setState(() {
          _visible = true;
        });
      }
    } catch (err) {
      return null;
    }
  }

  Widget notificationIconContainer() {
    return Container(
      child: Icon(
        Icons.notifications,
        size: 120.0,
        color: kWhite100TextColor,
      ),
    );
  }

//  Message when any notification is not available
  Widget message() {
    return Text(
      translate("You_dont_have_any_notification"),
      style: TextStyles.regular16(color: kWhite100),
    );
  }

//  When don't have any notification.
  Widget blankNotification() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            notificationIconContainer(),
            SizedBox(
              height: 25.0,
            ),
            message(),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var notifications =
        Provider.of<NotificationsProvider>(context).notificationsList;
    return Scaffold(
      appBar: customAppBar(context, translate("Notifications_"))
          as PreferredSizeWidget?,
      body: _visible == false
          ? Center(
              child: CircularProgressIndicator(),
            )
          : notifications.length == 0
              ? blankNotification()
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: notifications.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: <Widget>[
                        ListTile(
                          leading: CircleAvatar(
                            radius: 35.0,
                            backgroundColor: primaryBlue,
                            child: Text(
                              "${index + 1}",
                              // style: TextStyle(color: Colors.white),
                            ),
                          ),
                          title: Text("${notifications[index].title}"),
                          subtitle: Text(
                            "${notifications[index].data!.data}",
                            style: TextStyle(
                              fontSize: 12.0,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              RoutePaths.notificationDetail,
                              arguments: NotificationDetailScreen(
                                notifications[index].title,
                                notifications[index].data!.data,
                              ),
                            );
                          },
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Container(
                          color: Colors.white,
                          height: 0.15,
                        ),
                      ],
                    );
                  },
                ),
    );
  }
}
