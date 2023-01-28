import 'package:awomowa/app/theme.dart';
import 'package:awomowa/widgets/splash_screen_bg.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class OfferDetailsShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: List.generate(
          10,
          (index) => Shimmer.fromColors(
                baseColor: Colors.grey,
                highlightColor: Colors.white,
                child: Stack(
                  children: [
                    SplashScreenBg(),
                    Container(
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Container(
                                color: Colors.white12,
                                height:
                                    MediaQuery.of(context).size.height * 0.2,
                                width: MediaQuery.of(context).size.height * 0.2,
                              ),
                              SizedBox(
                                height: 16.0,
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  color: Colors.white12,
                                  height: 18.0,
                                  width: double.infinity,
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  color: Colors.white12,
                                  height: 14.0,
                                  width: double.infinity,
                                ),
                              ),
                              Divider(),
                              SizedBox(
                                height: 8.0,
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  color: Colors.white12,
                                  height: 14.0,
                                  width: double.infinity,
                                ),
                              ),
                              Divider(
                                height: 24.0,
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Offer Details',
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.grey),
                                ),
                              ),
                              SizedBox(
                                height: 8.0,
                              ),
                              Card(
                                color: Colors.black,
                                margin: EdgeInsets.zero,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Open from',
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 12.0),
                                          ),
                                          SizedBox(
                                            height: 4.0,
                                          ),
                                          Container(
                                            color: Colors.white12,
                                            height: 14.0,
                                            width: double.infinity,
                                          ),
                                        ],
                                      ),
                                      Spacer(),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            'Expires on',
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 12.0),
                                          ),
                                          SizedBox(
                                            height: 4.0,
                                          ),
                                          Container(
                                            color: Colors.white12,
                                            height: 14.0,
                                            width: double.infinity,
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Divider(
                                height: 24.0,
                              ),
                              Spacer(),
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  Container(
                                    color: Colors.white12,
                                    height: 14.0,
                                    width: double.infinity,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: AppTheme.themeColor,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Spacer(),
                              SizedBox(
                                height: 16.0,
                              ),
                              SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          primary: Colors.black),
                                      onPressed: () {},
                                      child: Padding(
                                        padding: const EdgeInsets.all(14.0),
                                        child: Text(
                                          'Share',
                                          style: TextStyle(
                                              color: AppTheme.themeColor,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ))),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )),
    );
  }
}
