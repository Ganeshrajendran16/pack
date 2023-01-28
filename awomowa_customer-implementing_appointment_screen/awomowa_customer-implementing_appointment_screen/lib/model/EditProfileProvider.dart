import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:awomowa/connection/api_urls.dart';
import 'package:awomowa/connection/repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class EditProfileProvider extends ChangeNotifier {
  bool isLoading = false;
  bool isError = false;
  bool isEmpty = false;

  toggleLoading() {
    isLoading = !isLoading;
    if (isLoading) {
      isError = false;
    }
    notifyListeners();
  }

  Map<String, dynamic> profileEditResponse;

  editProfile(String name, String gender, String dob, String email,
      String mobilNumber) async {
    toggleLoading();
    var formData = FormData.fromMap({
      'apiMethod': 'profileUpdate',
      'firstName': name,
      'contactNumber': mobilNumber,
      'mailId': email,
      'gender': gender,
      'dob': dob,
    });

    profileEditResponse = await loadApi(
        params: formData,
        apiUrl: PROFILE_UPDATE,
        onError: (e) {
          isError = true;
        });

    toggleLoading();
  }

  updateProfileImg(File pic) async {
    toggleLoading();
    var formData = FormData.fromMap({
      'apiMethod': 'profileUpdate',
      'profileImage': await MultipartFile.fromFile(pic.path,
          filename: '${getRandString(5)}.jpg'),
    });
    profileEditResponse = await loadApi(
        params: formData,
        apiUrl: PROFILE_UPDATE,
        onError: (e) {
          isError = true;
        });

    toggleLoading();
  }

  String getRandString(int len) {
    var random = Random.secure();
    var values = List<int>.generate(len, (i) => random.nextInt(255));
    return base64UrlEncode(values);
  }
}
