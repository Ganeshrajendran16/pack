import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefManager {
  static const THEME_STATUS = "THEMESTATUS";
  static const AUTH_KEY = "authkey";
  static const IS_LOGGED_IN = "isloggedin";
  static const SHOP_NAME = "shopName";
  static const CATEGORY = "category";
  static const DOB = "dateofbirth";
  static const EMAIL = "email";
  static const MOBILENUMBER = "mobilenm";
  static const LOGO = "pic";
  static const IS_SUBSCRIPTION_ACTIVE = "SUBSACTIVE";
  static const SUBS_REMAINING_DAYS = "REMAININGDAYS";
  static const ISALLOWTORENEW = "allowtorenew";

  setDarkTheme(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(THEME_STATUS, value);
  }

  Future<bool> getTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(THEME_STATUS) ?? false;
  }

  setAuthKey(String authKey) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(AUTH_KEY, authKey);
  }

  Future<String> getAuthKey() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(AUTH_KEY) ?? null;
  }

  setLoggedIn(bool isloggedIn) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(IS_LOGGED_IN, isloggedIn);
  }

  Future<bool> getLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(IS_LOGGED_IN) ?? false;
  }

  setIsSubscribed(bool isSubscribed) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(IS_SUBSCRIPTION_ACTIVE, isSubscribed ?? false);
  }

  Future<bool> isSubsActive() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(IS_SUBSCRIPTION_ACTIVE) ?? false;
  }

  setRemainingDays(String days) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print(days);
    prefs.setInt(SUBS_REMAINING_DAYS, int.parse(days) ?? 0);
  }

  Future<int> getRemainingDays() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(SUBS_REMAINING_DAYS) ?? 0;
  }

  setAllowToRenewal(bool allow) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(ISALLOWTORENEW, allow);
  }

  Future<bool> isAllowToRenew() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(ISALLOWTORENEW) ?? false;
  }

  setShopName(String name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(SHOP_NAME, name);
  }

  Future<String> getShopName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(SHOP_NAME) ?? '';
  }

  Future<void> logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  setEmail(String name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(EMAIL, name);
  }

  Future<String> getEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(EMAIL) ?? '';
  }

  setMobile(String mobile) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(MOBILENUMBER, mobile);
  }

  Future<String> getMobile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(MOBILENUMBER) ?? '';
  }

  setShopCategory(String url) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(CATEGORY, url);
  }

  Future<String> getShopCategory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(CATEGORY) ?? '';
  }

  setShopLogo(String category) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(CATEGORY, category);
  }

  Future<String> getShopLogo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(LOGO) ?? '';
  }
}
