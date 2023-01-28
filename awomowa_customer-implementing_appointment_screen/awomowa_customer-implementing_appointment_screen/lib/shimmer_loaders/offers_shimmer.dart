import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class OfferShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: List.generate(
          10,
          (index) => Shimmer.fromColors(
                baseColor: Colors.grey,
                highlightColor: Colors.white,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding:
                      EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 70.0,
                            width: 70.0,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16.0),
                                color: Colors.white12),
                          ),
                          SizedBox(
                            width: 16.0,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                height: 16.0,
                                width: MediaQuery.of(context).size.width * 0.5,
                                color: Colors.white12,
                              ),
                              SizedBox(
                                height: 8.0,
                              ),
                              Container(
                                height: 14.0,
                                width: MediaQuery.of(context).size.width * 0.25,
                                color: Colors.white12,
                              ),
                              SizedBox(
                                height: 8.0,
                              ),
                              Container(
                                height: 12.0,
                                width: MediaQuery.of(context).size.width * 0.2,
                                color: Colors.white12,
                              ),
                            ],
                          ),
                          Spacer(),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              SizedBox(
                                height: 24.0,
                              ),
                              Container(
                                height: 16.0,
                                color: Colors.white12,
                              ),
                            ],
                          )
                        ],
                      ),
                      Divider(),
                    ],
                  ),
                ),
              )),
    );
  }
}
