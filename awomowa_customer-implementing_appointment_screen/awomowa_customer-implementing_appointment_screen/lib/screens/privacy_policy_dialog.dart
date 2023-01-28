import 'package:awomowa/model/AboutUsProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PrivacyPolicyDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AboutUsProvider>(builder:
        (BuildContext context, AboutUsProvider aboutUsProvider, Widget child) {
      return AlertDialog(
        title: ListTile(
          leading: Image.asset('assets/awomowa-round.png'),
          title: Text(
              '${aboutUsProvider.isLoading ? '' : aboutUsProvider.aboutUsResponse.appContent.appName}'),
          subtitle: Text(
              '${aboutUsProvider.isLoading ? '' : aboutUsProvider.aboutUsResponse.appContent.appVersion}'),
        ),
        content: aboutUsProvider.isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Privacy Policy',
                      style: TextStyle(fontWeight: FontWeight.w800),
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    Text(
                      '${aboutUsProvider.aboutUsResponse.appContent.privacyPolicy}',
                      style: TextStyle(fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
        actions: [
          TextButton(
            child: Text("OK"),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      );
    });
  }
}
