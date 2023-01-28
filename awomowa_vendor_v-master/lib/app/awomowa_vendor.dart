import 'package:awomowa_vendor/app/theme.dart';
import 'package:awomowa_vendor/providers/AboutUsProvider.dart';
import 'package:awomowa_vendor/providers/ActiveOfferListProvider.dart';
import 'package:awomowa_vendor/providers/AddNewOfferProvider.dart';
import 'package:awomowa_vendor/providers/DarkThemeProvider.dart';
import 'package:awomowa_vendor/providers/EditOfferProvider.dart';
import 'package:awomowa_vendor/providers/EditShopInfoProvider.dart';
import 'package:awomowa_vendor/providers/ForgotPasswordProvider.dart';
import 'package:awomowa_vendor/providers/LoginProvider.dart';
import 'package:awomowa_vendor/providers/ManageOffersProvider.dart';
import 'package:awomowa_vendor/providers/PackageDetailsProvider.dart';
import 'package:awomowa_vendor/providers/SettingsProvider.dart';
import 'package:awomowa_vendor/providers/SignUpProvider.dart';
import 'package:awomowa_vendor/providers/SplashScreenProvider.dart';
import 'package:awomowa_vendor/providers/SubscriptionInfoProvider.dart';
import 'package:awomowa_vendor/providers/ThemeColorProvider.dart';
import 'package:awomowa_vendor/providers/TransactionHistoryProvider.dart';
import 'package:awomowa_vendor/providers/UpdateListProvider.dart';
import 'package:awomowa_vendor/providers/UserDetailsProvider.dart';
import 'package:awomowa_vendor/providers/VendorDetailsProvider.dart';
import 'package:awomowa_vendor/screens/about_us%20_screen.dart';
import 'package:awomowa_vendor/screens/active_offer_details.dart';
import 'package:awomowa_vendor/screens/approval_screen.dart';
import 'package:awomowa_vendor/screens/color_picker_screen.dart';
import 'package:awomowa_vendor/screens/edit_shop_info_screen.dart';
import 'package:awomowa_vendor/screens/error_screen.dart';
import 'package:awomowa_vendor/screens/forgot_password_screen.dart';
import 'package:awomowa_vendor/screens/home_screen.dart';
import 'package:awomowa_vendor/screens/login_screen.dart';
import 'package:awomowa_vendor/screens/manage_offers_screen.dart';
import 'package:awomowa_vendor/screens/new_offer.dart';
import 'package:awomowa_vendor/screens/package_screen.dart';
import 'package:awomowa_vendor/screens/payment_success_screen.dart';
import 'package:awomowa_vendor/screens/publish_success_screen.dart';
import 'package:awomowa_vendor/screens/reset_password_screen.dart';
import 'package:awomowa_vendor/screens/shop_details_screen.dart';
import 'package:awomowa_vendor/screens/signup_screen.dart';
import 'package:awomowa_vendor/screens/splash_screen.dart';
import 'package:awomowa_vendor/screens/subscription_info_screen.dart';
import 'package:awomowa_vendor/screens/transaction_history_screen.dart';
import 'package:awomowa_vendor/screens/update_list_screen.dart';
import 'package:awomowa_vendor/screens/user_register_screen.dart';
import 'package:awomowa_vendor/utils/SharedPreferences.dart';
import 'package:awomowa_vendor/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class AwomowaVendor extends StatefulWidget {
  @override
  _AwomowaVendorState createState() => _AwomowaVendorState();
}

DarkThemeProvider themeChangeProvider = new DarkThemeProvider();
void getCurrentAppTheme() async {
  themeChangeProvider.darkTheme =
      await themeChangeProvider.darkThemePreference.getTheme();
}

class _AwomowaVendorState extends State<AwomowaVendor> {
  SharedPrefManager prefManger = SharedPrefManager();

  @override
  void initState() {
    getCurrentAppTheme();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<DarkThemeProvider>(
            create: (context) => themeChangeProvider),
        ChangeNotifierProvider<LoginProvider>(
            create: (context) => LoginProvider()),
        ChangeNotifierProvider<SignUpProvider>(
            create: (context) => SignUpProvider()),
        ChangeNotifierProvider<SplashScreenProvider>(
            create: (context) => SplashScreenProvider()),
        ChangeNotifierProvider<PackageDetailsProvider>(
            create: (context) => PackageDetailsProvider()),
        ChangeNotifierProvider<UserDetailsProvider>(
            create: (context) => UserDetailsProvider()),
        ChangeNotifierProvider<VendorDetailsProvider>(
            create: (context) => VendorDetailsProvider()),
        ChangeNotifierProvider<TransactionHistoryProvider>(
            create: (context) => TransactionHistoryProvider()),
        ChangeNotifierProvider<AddNewOfferProvider>(
            create: (context) => AddNewOfferProvider()),
        ChangeNotifierProvider<SettingsProvider>(
            create: (context) => SettingsProvider()),
        ChangeNotifierProvider<ActiveOfferListProvider>(
            create: (context) => ActiveOfferListProvider()),
        ChangeNotifierProvider<AboutUsProvider>(
            create: (context) => AboutUsProvider()),
        ChangeNotifierProvider<ManageOffersProvider>(
            create: (context) => ManageOffersProvider()),
        ChangeNotifierProvider<EditOfferProvider>(
            create: (context) => EditOfferProvider()),
        ChangeNotifierProvider<EditShopInfoProvider>(
            create: (context) => EditShopInfoProvider()),
        ChangeNotifierProvider<SubscriptionInfoProvider>(
            create: (context) => SubscriptionInfoProvider()),
        ChangeNotifierProvider<ForgotPasswordProvider>(
            create: (context) => ForgotPasswordProvider()),
        ChangeNotifierProvider<UpdateListProvider>(
            create: (context) => UpdateListProvider()),
        ChangeNotifierProvider<ThemeColorProvider>(
            create: (context) => ThemeColorProvider()),
      ],
      child: Sizer(
        builder: (BuildContext context, Orientation orientation,
            DeviceType deviceType) {
          return Consumer<DarkThemeProvider>(
            builder: (BuildContext context, value, Widget child) {
              return MaterialApp(
                themeMode: themeChangeProvider.darkTheme
                    ? ThemeMode.dark
                    : ThemeMode.light,
                theme: AppTheme.light(),
                darkTheme: AppTheme.dark(),
                home: SplashScreen(),
                navigatorKey: navigatorKey,
                routes: {
                  LoginScreen.routeName: (context) => LoginScreen(),
                  SignUpScreen.routeName: (context) => SignUpScreen(),
                  PackageScreen.routeName: (context) => PackageScreen(),
                  PaymentSuccessScreen.routeName: (context) =>
                      PaymentSuccessScreen(),
                  HomeScreen.routeName: (context) => HomeScreen(),
                  ShopDetails.routeName: (context) => ShopDetails(),
                  AboutUs.routeName: (context) => AboutUs(),
                  NewOfferScreen.routeName: (context) => NewOfferScreen(),
                  PublishSuccessScreen.routeName: (context) =>
                      PublishSuccessScreen(),
                  ForgotPasswordScreen.routeName: (context) =>
                      ForgotPasswordScreen(),
                  ResetPasswordScreen.routeName: (context) =>
                      ResetPasswordScreen(),
                  ActiveOfferDetails.routeName: (context) =>
                      ActiveOfferDetails(),
                  ApprovalScreen.routeName: (context) => ApprovalScreen(),
                  ManageOffersScreen.routeName: (context) =>
                      ManageOffersScreen(),
                  UserDetailsScreen.routeName: (context) => UserDetailsScreen(),
                  SubscriptionInfoScreen.routeName: (context) =>
                      SubscriptionInfoScreen(),
                  EditShopInfo.routeName: (context) => EditShopInfo(),
                  NoInternet.routeName: (context) => NoInternet(),
                  UpdatesListScreen.routeName: (context) => UpdatesListScreen(),
                  ColorPickerScreen.routeName: (context) => ColorPickerScreen(),
                  TransactionHistoryScreen.routeName: (context) =>
                      TransactionHistoryScreen(),
                },
              );
            },
          );
        },
      ),
    );
  }
}
