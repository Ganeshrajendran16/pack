import 'dart:io';

import 'package:awomowa_vendor/app/theme.dart';
import 'package:awomowa_vendor/providers/DarkThemeProvider.dart';
import 'package:awomowa_vendor/providers/VendorDetailsProvider.dart';
import 'package:awomowa_vendor/screens/new_offer.dart';
import 'package:awomowa_vendor/screens/offer_list.dart';
import 'package:awomowa_vendor/screens/settings_screen.dart';
import 'package:awomowa_vendor/screens/update_list_screen.dart';
import 'package:awomowa_vendor/utils/SharedPreferences.dart';
import 'package:downloads_path_provider_28/downloads_path_provider_28.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = 'homeScreen';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedItem = 0;
  SharedPrefManager prefManager = SharedPrefManager();

  var taskId;

  @override
  void initState() {
    super.initState();
  }

  Future<Directory> _getDownloadDirectory() async {
    if (Platform.isAndroid) {
      return await DownloadsPathProvider.downloadsDirectory;
    }

    // in this example we are using only Android and iOS so I can assume
    // that you are not trying it for other platforms and the if statement
    // for iOS is unnecessary

    // iOS directory visible to user
    return await getApplicationDocumentsDirectory();
  }

  showSnackBar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    return Scaffold(
      floatingActionButton: _selectedItem != 2
          ? FloatingActionButton(
              onPressed: () {
                if (Provider.of<VendorDetailsProvider>(context, listen: false)
                        .vendorDetailsResponse
                        .merchantInformations
                        .isSubscriptionActive ==
                    'yes') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NewOfferScreen(
                        initialIndex: _selectedItem,
                      ),
                    ),
                  );
                } else {
                  showSnackBar('Your Subscription has been ended !');
                }
              },
              backgroundColor: Colors.black,
              child: Icon(
                Icons.add,
                color: AppTheme.themeColor,
              ),
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
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
              label: 'Offers'),
          BottomNavigationBarItem(
              icon: Icon(_selectedItem == 1
                  ? Icons.notifications
                  : Icons.notifications_none),
              label: 'Updates'),
          BottomNavigationBarItem(
              icon: Icon(_selectedItem == 2 ? Icons.settings : LineIcons.cog),
              label: 'Settings'),
        ],
      ),
      body: IndexedStack(
        index: _selectedItem,
        children: [OfferListScreen(), UpdatesListScreen(), SettingsScreen()],
      ),
    );
  }
}
