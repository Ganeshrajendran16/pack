import 'package:awomowa_vendor/providers/DarkThemeProvider.dart';
import 'package:awomowa_vendor/providers/VendorDetailsProvider.dart';
import 'package:awomowa_vendor/screens/about_us%20_screen.dart';
import 'package:awomowa_vendor/screens/color_picker_screen.dart';
import 'package:awomowa_vendor/screens/login_screen.dart';
import 'package:awomowa_vendor/screens/package_screen.dart';
import 'package:awomowa_vendor/screens/privacy_policy_dialog.dart';
import 'package:awomowa_vendor/screens/shop_details_screen.dart';
import 'package:awomowa_vendor/screens/subscription_info_screen.dart';
import 'package:awomowa_vendor/screens/transaction_history_screen.dart';
import 'package:awomowa_vendor/utils/SharedPreferences.dart';
import 'package:awomowa_vendor/utils/app_constants.dart';
import 'package:awomowa_vendor/widgets/day_nght_switch.dart';
import 'package:awomowa_vendor/widgets/settings_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_svg/svg.dart';
import 'package:package_info/package_info.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

import 'manage_offers_screen.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  SharedPrefManager prefManager = SharedPrefManager();

  void initState() {
    super.initState();
  }

  showSnackBar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    return Consumer<VendorDetailsProvider>(
      builder: (BuildContext context,
          VendorDetailsProvider vendorDetailsProvider, Widget child) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            title: Text('Settings'),
            automaticallyImplyLeading: false,
          ),
          body: ListView(
            children: [
              (Provider.of<VendorDetailsProvider>(context)
                          .vendorDetailsResponse
                          .merchantInformations
                          .isSubscriptionActive !=
                      'yes')
                  ? Material(
                      elevation: 8.0,
                      child: Container(
                        color: Colors.red,
                        child: Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Row(
                            children: [
                              Icon(
                                Icons.warning,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 16.0,
                              ),
                              Flexible(
                                child: Text(
                                  'Your Subscription has been ended !',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              SizedBox(
                                width: 16.0,
                              ),
                              Visibility(
                                visible:
                                    Provider.of<VendorDetailsProvider>(context)
                                            .vendorDetailsResponse
                                            .merchantInformations
                                            .isAllowToRenewal ==
                                        'yes',
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, PackageScreen.routeName);
                                  },
                                  child: Text(
                                    'Renew now',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.white),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  : SizedBox(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    vendorDetailsProvider.isLoading
                        ? SizedBox()
                        : ShopInfoCard(
                            vendorDetailsProvider: vendorDetailsProvider,
                            colorCode: vendorDetailsProvider
                                .vendorDetailsResponse
                                .merchantInformations
                                .appColorCode,
                          ),
                    Divider(),
                    SettingsItem(
                      onTap: () {
                        Navigator.pushNamed(
                            context, ManageOffersScreen.routeName);
                      },
                      title: 'Manage Offers',
                      icon: FontAwesome.list_ul,
                      iconBgColor: Colors.red,
                    ),
                    Divider(),
                    SettingsItem(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ColorPickerScreen(
                              vendorDetailsProvider: vendorDetailsProvider,
                            ),
                          ),
                        );
                      },
                      title: 'Theme',
                      icon: FontAwesome.tint,
                      iconBgColor: Colors.blue,
                    ),
                    Divider(),
                    SettingsItem(
                      onTap: () {
                        Navigator.pushNamed(
                            context, SubscriptionInfoScreen.routeName);
                      },
                      title: 'Stats',
                      icon: Icons.credit_card,
                      iconBgColor: Colors.green,
                    ),
                    Divider(),
                    // SettingsItem(
                    //   onTap: () {
                    //     Navigator.pushNamed(
                    //         context, TransactionHistoryScreen.routeName);
                    //   },
                    //   title: 'Payment History',
                    //   icon: Icons.history,
                    //   iconBgColor: Colors.redAccent,
                    // ),
                    // Divider(),
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
                      trailing: DayNightSwitch(
                        value: themeChange.darkTheme,
                        moonImage: AssetImage('assets/moon.png'),
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
                        PackageInfo packageInfo =
                            await PackageInfo.fromPlatform();
                        Share.share(
                            'Hey Checkout this app https://play.google.com/store/apps/details?id=${packageInfo.packageName}');
                      },
                    ),
                    Divider(),
                    SettingsItem(
                      title: 'Logout',
                      icon: Icons.logout,
                      iconBgColor: Colors.redAccent,
                      onTap: () {
                        _showLogoutAlertDialog(context);
                      },
                    ),
                    Divider(),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class ShopInfoCard extends StatelessWidget {
  final VendorDetailsProvider vendorDetailsProvider;
  final String colorCode;
  final bool isClickable;

  const ShopInfoCard(
      {this.vendorDetailsProvider, this.colorCode, this.isClickable = true});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: () {
          if (isClickable) {
            Navigator.pushNamed(context, ShopDetails.routeName);
          }
        },
        child: Card(
          color: hexToColor(colorCode),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16.0),
            child: Stack(
              children: [
                Positioned(
                    top: -100,
                    left: -250.0,
                    child: SvgPicture.asset(
                      'assets/outline_blob2.svg',
                      color: Colors.black.withOpacity(0.1),
                      height: 300.0,
                      width: 200.0,
                    )),
                Positioned(
                    bottom: -20,
                    right: -50.0,
                    child: RotatedBox(
                      quarterTurns: 1,
                      child: SvgPicture.asset(
                        'assets/blob_1.svg',
                        color: Colors.black.withOpacity(0.1),
                        height: 150.0,
                        width: 150.0,
                        fit: BoxFit.fitHeight,
                      ),
                    )),
                Positioned(
                    bottom: -80,
                    right: 150.0,
                    child: SvgPicture.asset(
                      'assets/blob_1.svg',
                      color: Colors.black.withOpacity(0.1),
                      height: 150.0,
                      width: 150.0,
                      fit: BoxFit.fitHeight,
                    )),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: ListTile(
                    title: Text(
                      '${vendorDetailsProvider.vendorDetailsResponse.merchantInformations.shopName}',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w600),
                    ),
                    subtitle: Text(
                      vendorDetailsProvider.vendorDetailsResponse
                          .merchantInformations.shopCategoryName,
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    trailing: AspectRatio(
                      aspectRatio: 1,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50.0),
                        child: Container(
                          height: 100.0,
                          width: 100.0,
                          child: Image.network(
                            '${vendorDetailsProvider.vendorDetailsResponse.merchantInformations.shopLogo}',
                            fit: BoxFit.fill,
                          ),
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(50.0)),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

_showLogoutAlertDialog(BuildContext context) {
  Widget cancelButton = FlatButton(
    child: Text("Cancel"),
    onPressed: () {
      Navigator.pop(context);
    },
  );
  Widget continueButton = FlatButton(
    child: Text("Logout"),
    onPressed: () async {
      SharedPrefManager prefManager = SharedPrefManager();

      await prefManager.logout(context);

      Navigator.pushAndRemoveUntil<dynamic>(
        context,
        MaterialPageRoute<dynamic>(
          builder: (BuildContext context) => LoginScreen(),
        ),
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
