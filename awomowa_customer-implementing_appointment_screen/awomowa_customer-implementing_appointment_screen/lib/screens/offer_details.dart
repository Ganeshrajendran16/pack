import 'package:awomowa/app/theme.dart';
import 'package:awomowa/model/DarkThemeProvider.dart';
import 'package:awomowa/model/OfferDetailsProvider.dart';
import 'package:awomowa/responsemodels/offer_details_response.dart';
import 'package:awomowa/screens/shop_offers_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:like_button/like_button.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

import 'offers_screen.dart';

class OfferDetails extends StatefulWidget {
  static const routeName = 'offerDetails';
  final String shopId;
  final int index;
  final String broadcastId;

  const OfferDetails({this.shopId, this.index = 0, this.broadcastId = ''});

  @override
  _OfferDetailsState createState() => _OfferDetailsState();
}

class _OfferDetailsState extends State<OfferDetails> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) {
        return OfferDetailsProvider(widget.shopId, widget.broadcastId);
      },
      child: Consumer<OfferDetailsProvider>(
        builder: (BuildContext context,
            OfferDetailsProvider offerDetailsProvider, Widget child) {
          return Scaffold(
            backgroundColor: Provider.of<DarkThemeProvider>(context).darkTheme
                ? null
                : Colors.grey.shade200,
            appBar: AppBar(
              title: Text(offerDetailsProvider.isLoading
                  ? ''
                  : offerDetailsProvider.isEmpty
                      ? ''
                      : offerDetailsProvider
                              .offerDetailsResponse.offerStores[0].shopName ??
                          ''),
            ),
            body: offerDetailsProvider.isLoading
                ? Center(
                    child: CircularProgressIndicator(
                      valueColor:
                          new AlwaysStoppedAnimation<Color>(Colors.black),
                    ),
                  )
                : offerDetailsProvider.isEmpty
                    ? Center(
                        child: EmptyState(
                          title: 'Offer Not Available',
                          subtitle: 'This offer may be removed by the shop',
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.symmetric(vertical: 18.0),
                        child: PageView.builder(
                          itemCount: offerDetailsProvider
                              .offerDetailsResponse.offerStores.length,
                          controller: PageController(
                            viewportFraction: 0.9,
                            initialPage: widget.index,
                          ),
                          itemBuilder: (BuildContext context, int index) {
                            return OfferDetailsCard(
                              offer: offerDetailsProvider
                                  .offerDetailsResponse.offerStores[index],
                              offerDetailsProvider: offerDetailsProvider,
                            );
                          },
                        ),
                      ),
          );
        },
      ),
    );
  }
}

class OfferDetailsCard extends StatefulWidget {
  final OfferStores offer;
  final OfferDetailsProvider offerDetailsProvider;

  const OfferDetailsCard({this.offer, this.offerDetailsProvider});

  @override
  _OfferDetailsCardState createState() => _OfferDetailsCardState();
}

class _OfferDetailsCardState extends State<OfferDetailsCard> {
  bool isLiked;
  
  

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Stack(
              children: [
                Column(
                  children: [
                    GestureDetector(
                       
                    
                    child:  Hero(
                        tag: 'anything' + ('${widget.offer.imageUrl}'),
                      child: Image.network(
                            '${widget.offer.imageUrl}',
                            height: MediaQuery.of(context).size.height * 0.2,
                    width: MediaQuery.of(context).size.height * 0.2,
                            ),
                    ),
                     onTap:()=>
                
                      
                                    Navigator.of(context).push (
                    PageRouteBuilder(
                      pageBuilder: (
                          context,animation,secondaryAnimation
                    )=> imageview(
                                image:('${widget.offer.imageUrl}'
                                ),
                              )
                  
                    ),
                                    ),
                  ),
                  
               
    
                  
                    
                    SizedBox(
                      height: 16.0,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '${widget.offer.productName}',
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.w600),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '${widget.offer.categoryName} - ${widget.offer.subcategoryName}',
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Divider(),
                    SizedBox(
                      height: 8.0,
                    ),
                    Expanded(
                      child: Scrollbar(
                        isAlwaysShown: true,
                        child: SingleChildScrollView(
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              '${widget.offer.comments}',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey,
                                  fontSize: 14.0),
                            ),
                          ),
                        ),
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Open from',
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 12.0),
                                ),
                                SizedBox(
                                  height: 4.0,
                                ),
                                Text(
                                  ' ${widget.offer.publishedDate}',
                                  style: TextStyle(
                                      fontSize: 16.0, color: Colors.white),
                                ),
                              ],
                            ),
                            Spacer(),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  'Expires on',
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 12.0),
                                ),
                                SizedBox(
                                  height: 4.0,
                                ),
                                Text(
                                  ' ${widget.offer.expireDate}',
                                  style: TextStyle(
                                      fontSize: 16.0, color: Colors.white),
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
                    SizedBox(
                      height: 16.0,
                    ),
                    Container(
                      height: 100.0,
                      width: 100.0,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/price_bg.svg',
                            fit: BoxFit.fill,
                            height: 100.0,
                            width: 100.0,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: AppTheme.themeColor,
                              shape: BoxShape.circle,
                            ),
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      '\$ ${widget.offer.price}',
                                      style: TextStyle(
                                          fontSize: 32.0,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    Text('${widget.offer.unit}',
                                        style: TextStyle(
                                          color: Colors.black,
                                        )),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.black),
                                  onPressed: () {
                                    Share.share(
                                        widget.offer.referenceCodeShareContent);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(14.0),
                                    child: Text(
                                      'Share',
                                      style: TextStyle(
                                          color: AppTheme.themeColor,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ))),
                        ),
                        SizedBox(
                          width: 24.0,
                        ),
                        LikeButton(
                          onTap: (bool isLiked) async {
                            widget.offer.isLiked = 'yes';
    
                            widget.offerDetailsProvider
                                .toggleLike(widget.offer.broadcastId, isLiked);
    
                            return !isLiked;
                          },
                          isLiked: widget.offer.isLiked == 'yes',
                          size: 36.0,
                          circleColor: CircleColor(
                            start: Colors.redAccent,
                            end: Colors.red,
                          ),
                          bubblesColor: BubblesColor(
                            dotPrimaryColor: Colors.red,
                            dotSecondaryColor: Colors.redAccent,
                          ),
                          likeBuilder: (bool isLiked) {
                            return Icon(
                              isLiked ? Icons.favorite : Icons.favorite_outline,
                              color: isLiked ? Colors.red : Colors.grey,
                              size: 36.0,
                            );
                          },
                          likeCount: int.parse(widget.offer.noOfLikes),
                          countBuilder: (int count, bool isLiked, String text) {
                            var color = isLiked ? Colors.red : Colors.grey;
                            Widget result;
                            if (count == 0) {
                              result = Text(
                                "",
                                style: TextStyle(color: color),
                              );
                            } else
                              result = Text(
                                count.toString(),
                                style: TextStyle(color: color),
                              );
                            return result;
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    
  }

  
}

