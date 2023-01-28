import 'package:awomowa/app/theme.dart';
import 'package:awomowa/model/NotificationListProvider.dart';
import 'package:awomowa/responsemodels/notification_list_reponse.dart';
import 'package:awomowa/screens/offer_details.dart';
import 'package:awomowa/screens/offers_screen.dart';
import 'package:awomowa/screens/update_details_screen.dart';
import 'package:awomowa/shimmer_loaders/notification_list_shimmer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NotificationsScreen extends StatefulWidget {
  static const routeName = 'notification';

  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  @override
  void initState() {
    // TODO: implement initState

    WidgetsBinding.instance.addPostFrameCallback((_) =>
        Provider.of<NotificationListProvider>(context, listen: false)
            .getNotificationList());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NotificationListProvider>(builder: (BuildContext context,
        NotificationListProvider notificationListProvider, Widget child) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Notifications'),
        ),
        body: notificationListProvider.isLoading
            ? NotificationListShimmer()
            : notificationListProvider.isEmpty
                ? Center(
                    child: EmptyState(
                      title: 'No Notification found',
                      onClick: () {
                        notificationListProvider.getNotificationList();
                      },
                      subtitle: '',
                      btnText: 'Reload',
                      buttonIcon: Icons.refresh_sharp,
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                      itemCount:
                          notificationListProvider.notificationListResponse ==
                                  null
                              ? 0
                              : notificationListProvider
                                  .notificationListResponse.offerStores.length,
                      itemBuilder: (BuildContext context, int index) {
                        return NotificationItem(
                          notification: notificationListProvider
                              .notificationListResponse.offerStores[index],
                        );
                      },
                    ),
                  ),
      );
    });
  }
}

class NotificationItem extends StatefulWidget {
  final OfferStores notification;

  const NotificationItem({this.notification});

  @override
  _NotificationItemState createState() => _NotificationItemState();
}

class _NotificationItemState extends State<NotificationItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        setState(() {
          widget.notification.isUserViewed == 'yes';
        });

        if (widget.notification.broadcastType == 'offer') {
          await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => OfferDetails(
                        shopId: widget.notification.shopId,
                        broadcastId: widget.notification.broadcastId,
                      )));

          Provider.of<NotificationListProvider>(context, listen: false)
              .getNotificationList();
        } else {
          await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => UpdateDetails(
                        broadCastId: widget.notification.broadcastId,
                      )));

          Provider.of<NotificationListProvider>(context, listen: false)
              .getNotificationList();
        }
      },
      child: Container(
        color: widget.notification.isUserViewed == "no"
            ? AppTheme.themeColor.withOpacity(0.3)
            : Colors.transparent,
        child: Column(
          children: [
            ListTile(
              leading: ClipOval(
                child: CircleAvatar(
                  backgroundColor: AppTheme.themeColor,
                  backgroundImage:
                      NetworkImage('${widget.notification.imageUrl}'),
                  radius: 32.0,
                ),
              ),
              title: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    child: Text(
                      widget.notification.productName ??
                          widget.notification.shopName,
                      style: TextStyle(fontSize: 14.0),
                    ),
                  ),
                ],
              ),
              subtitle: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  '${widget.notification.publishedDate}',
                  style: TextStyle(fontSize: 12.0),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Container(
                height: 0.5,
                color: Colors.grey,
              ),
            )
          ],
        ),
      ),
    );
  }
}
