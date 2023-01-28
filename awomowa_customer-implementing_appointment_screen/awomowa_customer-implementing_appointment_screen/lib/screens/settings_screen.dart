import 'package:awomowa/model/DarkThemeProvider.dart';
import 'package:awomowa/model/LoginProvider.dart';
import 'package:awomowa/model/OfferListProvider.dart';
import 'package:awomowa/screens/about_us%20_screen.dart';
import 'package:awomowa/screens/edit_profile.dart';
import 'package:awomowa/screens/manage_stores_screen.dart';
import 'package:awomowa/screens/privacy_policy_dialog.dart';
import 'package:awomowa/utils/SharedPreferences.dart';
import 'package:awomowa/widgets/settings_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:package_info/package_info.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

import 'login_screen.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        leading: SizedBox(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            SettingsItem(
              onTap: () async {
                await Navigator.pushNamed(
                    context, ManageStoresScreen.routeName);

                Provider.of<OfferListProvider>(context, listen: false)
                    .getOfferList();
              },
              title: 'Manage Favs',
              icon: FontAwesome.shopping_bag,
              iconBgColor: Colors.cyan,
            ),
            Divider(),
            SettingsItem(
              onTap: () {
                Navigator.pushNamed(context, ProfileScreen.routeName);
              },
              title: 'Profile',
              icon: FontAwesome.user,
              iconBgColor: Colors.pinkAccent,
            ),
            Divider(),
            SettingsItem(
              onTap: () {
                Navigator.pushNamed(context, AboutUs.routeName);
              },
              title: 'About Us',
              icon: Icons.info,
              iconBgColor: Colors.blue,
            ),
            Divider(),
            SettingsItem(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return PrivacyPolicyDialog();
                  },
                );
              },
              title: 'Privacy Policy',
              icon: Icons.list,
              iconBgColor: Colors.deepPurpleAccent,
            ),
            Divider(),
            SettingsItem(
              title: 'Dark Mode',
              icon: Icons.wb_sunny_outlined,
              iconBgColor: Colors.green,
              trailing: Switch(
                value: themeChange.darkTheme,
                onChanged: (value) {
                  themeChange.darkTheme = !themeChange.darkTheme;
                },
              ),
            ),
            Divider(),
            SettingsItem(
              title: 'Share app',
              icon: Icons.share,
              iconBgColor: Colors.deepPurpleAccent,
              onTap: () async {
                PackageInfo packageInfo = await PackageInfo.fromPlatform();
                Share.share(
                    'Hey Checkout this app https://play.google.com/store/apps/details?id=${packageInfo.packageName}');
              },
            ),
            Divider(),
            SettingsItem(
              title: 'Logout',
              icon: Icons.logout,
              iconBgColor: Colors.redAccent,
              onTap: () async {
                _showLogoutAlertDialog(context);
              },
            ),
            Divider(),
          ],
        ),
      ),
    );
  }
}

_showLogoutAlertDialog(BuildContext context) {
  // set up the buttons
  Widget cancelButton = FlatButton(
    child: Text("Cancel"),
    onPressed: () {
      Navigator.pop(context);
    },
  );
  Widget continueButton = FlatButton(
    child: Row(
      children: [
        Text("Logout"),
      ],
    ),
    onPressed: () async {
      SharedPrefManager prefManager = SharedPrefManager();

      Provider.of<LoginProvider>(context, listen: false).signOut();

      Navigator.pushNamedAndRemoveUntil<dynamic>(
        context,
        LoginScreen.routeName,
        (route) => false, //if you want to disable back feature set to false
      );
    },
  );
  AlertDialog alert = AlertDialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
    title: Text("Alert !"),
    content: Text("Are You sure you want to logout?"),
    actions: [
      cancelButton,
      continueButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
