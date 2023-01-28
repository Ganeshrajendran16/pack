import 'dart:convert';

import 'package:awomowa/app/theme.dart';
import 'package:awomowa/model/AboutUsProvider.dart';
import 'package:awomowa/model/AddShopProvider.dart';
import 'package:awomowa/model/DarkThemeProvider.dart';
import 'package:awomowa/model/EditProfileProvider.dart';
import 'package:awomowa/model/ForgotPasswordProvider.dart';
import 'package:awomowa/model/LoginProvider.dart';
import 'package:awomowa/model/ManageStoresProvider.dart';
import 'package:awomowa/model/NotificationListProvider.dart';
import 'package:awomowa/model/OfferDetailsProvider.dart';
import 'package:awomowa/model/OfferListProvider.dart';
import 'package:awomowa/model/ShopOfferProvider.dart';
import 'package:awomowa/model/SignUpProvider.dart';
import 'package:awomowa/model/UpdateDetailsProvider.dart';
import 'package:awomowa/screens/about_us%20_screen.dart';
import 'package:awomowa/screens/add_shop_screen.dart';
import 'package:awomowa/screens/appointment_list_screen.dart';
import 'package:awomowa/screens/edit_profile.dart';
import 'package:awomowa/screens/error_screen.dart';
import 'package:awomowa/screens/forgot_password_screen.dart';
import 'package:awomowa/screens/home_screen.dart';
import 'package:awomowa/screens/login_screen.dart';
import 'package:awomowa/screens/manage_stores_screen.dart';
import 'package:awomowa/screens/notification_screen.dart';
import 'package:awomowa/screens/offer_details.dart';
import 'package:awomowa/screens/register_screen.dart';
import 'package:awomowa/screens/reset_password_screen.dart';
import 'package:awomowa/screens/schedule/appointment_provider.dart';
import 'package:awomowa/screens/schedule/select_vendor_screen.dart';
import 'package:awomowa/screens/schedule_calendar_screen.dart';
import 'package:awomowa/screens/shop_details_screen.dart';
import 'package:awomowa/screens/splash_screen.dart';
import 'package:awomowa/screens/update_details_screen.dart';
import 'package:awomowa/screens/welcome_screen.dart';
import 'package:awomowa/utils/app_constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class Awomowa extends StatefulWidget {
  @override
  _AwomowaState createState() => _AwomowaState();
}

DarkThemeProvider themeChangeProvider = new DarkThemeProvider();

void getCurrentAppTheme() async {
  themeChangeProvider.darkTheme =
      await themeChangeProvider.darkThemePreference.getTheme();
}

class _AwomowaState extends State<Awomowa> {
  FirebaseMessaging messaging;
  setupNotification() async {
    await Firebase.initializeApp();
    messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: true,
      sound: true,
    );

    messaging.getToken().then((value) {
      print(value);
    });
        
    // negFirebaseMessaging.onBackgroundMessage(_messageHandler);

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print("$message weeeeeee");

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
      } else if (messageObject['broadcastType'] == 'userUpcoming' 
         ) {
        setIndex("userUpcoming");

        Navigator.push(navigatorKey.currentContext,
            MaterialPageRoute(builder: (context) => AppointmentListScreen()));
      } else if( messageObject['broadcastType'] == 'userHistory') {
        setIndex("userHistory");
         Navigator.push(navigatorKey.currentContext,
            MaterialPageRoute(builder: (context) => AppointmentListScreen()));

      }else {
        Navigator.push(
            navigatorKey.currentContext,
            MaterialPageRoute(
                builder: (context) => UpdateDetails(
                      broadCastId: messageObject['broadcastId'].toString(),
                    )));
      }
    });
  }

  void setIndex(String type) {
    if (type == "userHistory") {
      navigatorKey.currentContext.read<AppointmentsProvider>().currentIndex =
          1;
    } else if (type == "userUpcoming") {
      navigatorKey.currentContext.read<AppointmentsProvider>().currentIndex =
          0;
    }
    setState(() {});
  }

  @override
  void initState() {
    setupNotification();
    getCurrentAppTheme();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<DarkThemeProvider>(
            create: (context) => themeChangeProvider),
        ChangeNotifierProvider<SignUpProvider>(
            create: (context) => SignUpProvider()),
        ChangeNotifierProvider<LoginProvider>(
            create: (context) => LoginProvider()),
        ChangeNotifierProvider<OfferListProvider>(
            create: (context) => OfferListProvider()),
        ChangeNotifierProvider<OfferDetailsProvider>(
            create: (context) => OfferDetailsProvider("", "")),
        ChangeNotifierProvider<NotificationListProvider>(
            create: (context) => NotificationListProvider()),
        ChangeNotifierProvider<AboutUsProvider>(
            create: (context) => AboutUsProvider()),
        ChangeNotifierProvider<AddShopProvider>(
            create: (context) => AddShopProvider()),
        ChangeNotifierProvider<ManageShopsProvider>(
            create: (context) => ManageShopsProvider()),
        ChangeNotifierProvider<ForgotPasswordProvider>(
            create: (context) => ForgotPasswordProvider()),
        ChangeNotifierProvider<EditProfileProvider>(
            create: (context) => EditProfileProvider()),
        ChangeNotifierProvider<UpdateDetailsProvider>(
            create: (context) => UpdateDetailsProvider()),
        ChangeNotifierProvider<ShopOfferProvider>(
            create: (context) => ShopOfferProvider()),
        ChangeNotifierProvider<AppointmentsProvider>(
            create: (context) => AppointmentsProvider()),
      ],
      child: Consumer<DarkThemeProvider>(
        builder: (BuildContext context, value, Widget child) {
          return Sizer(
            builder: (context, orientation, deviceType) {
              return MaterialApp(
                navigatorKey: navigatorKey,
                themeMode: themeChangeProvider.darkTheme
                    ? ThemeMode.dark
                    : ThemeMode.light,
                theme: AppTheme.light(),
                darkTheme: AppTheme.dark(),
                home: SplashScreen(),
                routes: {
                  LoginScreen.routeName: (context) => LoginScreen(),
                  RegisterScreen.routeName: (context) => RegisterScreen(),
                  HomeScreen.routeName: (context) => HomeScreen(),
                  AddShopScreen.routeName: (context) => AddShopScreen(),
                  ForgotPasswordScreen.routeName: (context) =>
                      ForgotPasswordScreen(),
                  NotificationsScreen.routeName: (context) =>
                      NotificationsScreen(),
                  OfferDetails.routeName: (context) => OfferDetails(),
                  AboutUs.routeName: (context) => AboutUs(),
                  ShopDetails.routeName: (context) => ShopDetails(),
                  ManageStoresScreen.routeName: (context) =>
                      ManageStoresScreen(),
                  WelcomeScreen.routeName: (context) => WelcomeScreen(),
                  ProfileScreen.routeName: (context) => ProfileScreen(),
                  NoInternet.routeName: (context) => NoInternet(),
                  ResetPasswordScreen.routeName: (context) =>
                      ResetPasswordScreen(),
                  ScheduleCalendarScreen.routeName: (context) =>
                      ScheduleCalendarScreen(),
                  SelectVendorScreen.routeName: (context) =>
                      SelectVendorScreen()
                },
              );
            },
          );
        },
      ),
    );
  }
}
