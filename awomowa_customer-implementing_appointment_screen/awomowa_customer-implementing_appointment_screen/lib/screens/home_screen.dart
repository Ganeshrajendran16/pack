import 'dart:convert';

import 'package:awomowa/model/DarkThemeProvider.dart';
import 'package:awomowa/model/OfferListProvider.dart';
import 'package:awomowa/screens/offers_screen.dart';
import 'package:awomowa/screens/schedule/appointment_provider.dart';
import 'package:awomowa/screens/settings_screen.dart';
import 'package:awomowa/screens/update_details_screen.dart';
import 'package:awomowa/utils/app_constants.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';

import 'appointment_list_screen.dart';
import 'offer_details.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = 'homescreen';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedItem = 0;

  @override
  void initState() {
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage message) {
      if (message != null) {
        _messageHandler(message);
      }
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage event) {
      print('receivd');

      Provider.of<OfferListProvider>(context, listen: false).getOfferList();
    });
    super.initState();
  }

  Future<void> _messageHandler(RemoteMessage message) async {
    final Map<String, dynamic> messageObject =
        jsonDecode(message.data['message'].toString());

    print(messageObject.toString());
    if (messageObject['broadcastType'] == 'offer') {
      Navigator.push(
          navigatorKey.currentContext,
          MaterialPageRoute(
              builder: (context) => OfferDetails(
                    shopId: messageObject['shopId'].toString(),
                    broadcastId: messageObject['broadcastId'].toString(),
                  )));
    } else if (messageObject['broadcastType'] == 'userUpcoming') {
      context.read<AppointmentsProvider>().currentIndex = 0;
      Navigator.push(navigatorKey.currentContext,
          MaterialPageRoute(builder: (context) => AppointmentListScreen()));
    } else if (messageObject['broadcastType'] == 'userHistory') {
      context.read<AppointmentsProvider>().currentIndex = 1;

      Navigator.push(navigatorKey.currentContext,
          MaterialPageRoute(builder: (context) => AppointmentListScreen()));
    } else {
      Navigator.push(
          navigatorKey.currentContext,
          MaterialPageRoute(
              builder: (context) => UpdateDetails(
                    broadCastId: messageObject['broadcastId'].toString(),
                  )));
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    return Scaffold(
      // floatingActionButton: Container(
      //   child: Stack(
      //     children: [
      //       ElevatedButton(
      //         child: Icon(
      //           Icons.add,
      //           color: Colors.black,
      //         ),
      //         onPressed: () async {
      //           var result =
      //               await Navigator.pushNamed(context, AddShopScreen.routeName);
      //         },
      //         style: ElevatedButton.styleFrom(
      //             primary: AppTheme.themeColor, elevation: 0),
      //       ),
      //     ],
      //   ),
      // ),
      // floatingActionButtonLocation:
      //     FloatingActionButtonLocation.miniCenterDocked,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedItem,
        showSelectedLabels: true,
        showUnselectedLabels: false,
        selectedItemColor: themeChange.darkTheme ? Colors.white : Colors.black,
        onTap: (i) {
          setState(() {
            _selectedItem = i;
          });
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(_selectedItem == 0
                  ? Icons.local_offer_rounded
                  : Icons.local_offer_outlined),
              label: ' My Favs'),
          BottomNavigationBarItem(
              icon:
                  Icon(_selectedItem == 1 ? Icons.more_time : Icons.more_time),
              label: ' Appointments'),
          BottomNavigationBarItem(
              icon: Icon(_selectedItem == 2 ? Icons.settings : LineIcons.cog),
              label: 'Settings'),
        ],
      ),
      body: DoubleBackToCloseApp(
        snackBar: const SnackBar(
          content: Text('Tap back again to leave'),
        ),
        child: IndexedStack(
          index: _selectedItem,
          children: [OffersScreen(), AppointmentListScreen(), SettingsScreen()],
        ),
      ),
    );
  }
}
