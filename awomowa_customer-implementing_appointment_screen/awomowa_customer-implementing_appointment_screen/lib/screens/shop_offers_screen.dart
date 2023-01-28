import 'dart:ui';

import 'package:awomowa/app/theme.dart';
import 'package:awomowa/model/ShopOfferProvider.dart';
import 'package:awomowa/responsemodels/manage_stores_response.dart'
    as ManageShopResponse;
import 'package:awomowa/responsemodels/notification_list_reponse.dart';
import 'package:awomowa/responsemodels/shop_offers_response.dart';
import 'package:awomowa/screens/manage_shop_details_screen.dart';
import 'package:awomowa/screens/offer_details.dart';
import 'package:awomowa/screens/offers_screen.dart';
import 'package:awomowa/screens/update_details_screen.dart';
import 'package:awomowa/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class ShopOffersScreen extends StatefulWidget {
  final String shopId;

  const ShopOffersScreen({this.shopId});

  @override
  _ShopOffersScreenState createState() => _ShopOffersScreenState();
}

class _ShopOffersScreenState extends State<ShopOffersScreen>
    with SingleTickerProviderStateMixin {
  TabController controller;
  @override
  void initState() {
    super.initState();
    controller = TabController(
      length: 2,
      vsync: this,
    );


    WidgetsBinding.instance.addPostFrameCallback((_) =>
        Provider.of<ShopOfferProvider>(context, listen: false)
            .getShopOffers(widget.shopId));
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ShopOfferProvider>(
      builder: (BuildContext context, ShopOfferProvider shopOfferProvider,
          Widget child) {
        return Scaffold(
            bottomNavigationBar: Container(
              child: TabBar(
                indicatorColor: hexToColor(
                    shopOfferProvider.shopOffersResponse == null
                        ? '#FFC324'
                        : shopOfferProvider.shopOffersResponse
                            .merchantInformations.appColorCode),
                unselectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
                tabs: [Tab(text: 'Offers'), Tab(text: 'Updates')],
                controller: controller,
              ),
            ),
            body: shopOfferProvider.isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Container(
                    child: Column(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.2,
                          child: InkWell(
                            onTap: () {},
                            child: Container(
                              color: Theme.of(context).scaffoldBackgroundColor,
                              child: Stack(
                                children: [
                                  Positioned(
                                      bottom: -100,
                                      right: -150.0,
                                      child: SvgPicture.asset(
                                        'assets/blob_1.svg',
                                        color: Colors.grey,
                                        height: 300.0,
                                        width: 300.0,
                                      )),
                                  Positioned(
                                      top: -150,
                                      left: -200.0,
                                      child: RotatedBox(
                                        quarterTurns: 2,
                                        child: SvgPicture.asset(
                                          'assets/outline_blob2.svg',
                                          color: Colors.grey.withOpacity(0.2),
                                          height: 400.0,
                                          width: 200.0,
                                          fit: BoxFit.fitHeight,
                                        ),
                                      )),
                                  Center(
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          top: MediaQuery.of(context)
                                              .padding
                                              .top),
                                      child: ShopInfoCard(
                                          shopOfferProvider: shopOfferProvider),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: TabBarView(
                            controller: controller,
                            children: <Widget>[
                              shopOfferProvider.isOffersEmpty
                                  ? EmptyState(
                                      title: 'No offers found',
                                      subtitle:
                                          'Thi shop has not published any offers',
                                    )
                                  : ListView(
                                      //physics: NeverScrollableScrollPhysics(),
                                      padding: EdgeInsets.fromLTRB(0, 0, 0, 52),
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16.0),
                                          child: Text(
                                            'Offers',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w800,
                                                fontSize: 18.0),
                                          ),
                                        ),
                                        ListView.builder(
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          itemBuilder: (ctx, index) {
                                            return ShopOfferItem(
                                              offer: shopOfferProvider
                                                  .shopOffersResponse
                                                  .activeOffers[index],
                                              index: index,
                                            );
                                          },
                                          padding: EdgeInsets.zero,
                                          shrinkWrap: true,
                                          itemCount: shopOfferProvider
                                              .shopOffersResponse
                                              .activeOffers
                                              .length,
                                        ),
                                      ],
                                    ),
                              shopOfferProvider.isUpdateEmpty
                                  ? EmptyState(
                                      title: 'No updates found',
                                      subtitle:
                                          'Thi shop has not published any updates',
                                    )
                                  : ListView(
                                      //physics: NeverScrollableScrollPhysics(),
                                      padding: EdgeInsets.fromLTRB(0, 0, 0, 52),
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Text(
                                            'Updates',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w800,
                                                fontSize: 18.0),
                                          ),
                                        ),
                                        ListView.builder(
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          itemBuilder: (ctx, index) {
                                            return UpdateItem(
                                              update: shopOfferProvider
                                                  .shopOffersResponse
                                                  .updatesHistory[index],
                                            );
                                          },
                                          shrinkWrap: true,
                                          padding: EdgeInsets.zero,
                                          itemCount: shopOfferProvider
                                              .shopOffersResponse
                                              .updatesHistory
                                              .length,
                                        ),
                                      ],
                                    ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ));
      },
    );
  }
}

class ShopOfferItem extends StatelessWidget {
  final ActiveOffers offer;
  final int index;
  

  const ShopOfferItem({this.offer, this.index});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OfferDetails(
                shopId: offer.shopId,
                index: index,
              ),
            ));
      },
      child: Card(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 0.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  children: [
                    InkWell(
                                  
              
              child:Hero(
                    tag: 'anything' + ('${offer.imageUrl}'),
                          child: CircleAvatar(
                            backgroundImage: ('${offer.imageUrl}')!= null
                                ?
                                    NetworkImage('${offer.imageUrl}')
                                 
                                : null,
                            radius: 23,
                          ),
                            
                    ),
                          onTap:()=>
              
                    
                                  Navigator.of(context).push (
                  PageRouteBuilder(
                    pageBuilder: (
                        context,animation,secondaryAnimation
                  )=> imageview(
                              image:('${offer.imageUrl}'),
                            productname:('${offer.productName}'
                              ),
                            )
                
                  ),
                                  ),
                     ),


                
                    
                    SizedBox(
                      width: 8.0,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${offer.productName}',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    Spacer(),
                    Container(
                      decoration: BoxDecoration(
                          color: AppTheme.themeColor,
                          borderRadius: BorderRadius.circular(8.0)),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Icon(
                          Icons.chevron_right,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Published on',
                        style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w400,
                            fontSize: 12.0),
                      ),
                      Text(
                        '${offer.publishedDate}',
                        style: TextStyle(
                            color: Colors.grey, fontWeight: FontWeight.w600),
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
                            color: Colors.grey,
                            fontWeight: FontWeight.w400,
                            fontSize: 12.0),
                      ),
                      Text(
                        '${offer.expireDate}',
                        style: TextStyle(
                            color: Colors.grey, fontWeight: FontWeight.w600),
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

class UpdateItem extends StatelessWidget {
  final UpdatesHistory update;

  const UpdateItem({this.update});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => UpdateDetails(
                      broadCastId: update.broadcastId,
                    )));
      },
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                leading: CircleAvatar(
                  radius: 24.0,
                  backgroundColor: Colors.yellow,
                  backgroundImage: NetworkImage(update.imageUrl),
                ),
                trailing: Column(
                  children: [
                    Text(
                      'Published On',
                      style: TextStyle(color: Colors.grey, fontSize: 12.0),
                    ),
                    Text(update.publishedDate),
                  ],
                ),
                title: Text(
                  update.comments,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ShopInfoCard extends StatelessWidget {
  final ShopOfferProvider shopOfferProvider;

  const ShopInfoCard({this.shopOfferProvider});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: Colors.black),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.chevron_left,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 7,
            child: Container(
              child: InkWell(
                onTap: () async {
                  ManageShopResponse.StoreList shop =
                      ManageShopResponse.StoreList();

                  MerchantInformations shopInformation =
                      shopOfferProvider.shopOffersResponse.merchantInformations;

                  shop.shopName = shopInformation.shopName;
                  shop.shopLogo = shopInformation.shopLogo;
                  shop.shopCategoryName = shopInformation.shopCategoryName;
                  shop.shopSubCategoryName =
                      shopInformation.shopSubCategoryName;
                  shop.referenceNumber = shopInformation.referenceNumber;
                  shop.description = shopInformation.description;
                  shop.shopAddressLine1 = shopInformation.address1;
                  shop.shopAddressLine2 = shopInformation.address2;
                  shop.shopPincode = shopInformation.shopPincode;
                  shop.shopMailId = shopInformation.shopMailId;
                  shop.shopContactNumber = shopInformation.shopContactNumber;
                  shop.shopShareContent =
                      shopInformation.referenceCodeShareContent;
                  shop.storeId = shopInformation.merchantId;
                  shop.shopCity = shopInformation.shopCity;
                  shop.appColorCode = shopInformation.appColorCode;
                  shop.shopActualName = shopInformation.shopActualName;
                  if (shopInformation.shopTimings != null) {
                    Map<String, dynamic> timings = {
                      "monday": {
                        "openingTime":
                            shopInformation.shopTimings.monday.openingTime,
                        "closeingTime":
                            shopInformation.shopTimings.monday.closeingTime
                      },
                      "tuesday": {
                        "openingTime":
                            shopInformation.shopTimings.tuesday.openingTime,
                        "closeingTime":
                            shopInformation.shopTimings.tuesday.closeingTime
                      },
                      "wednesday": {
                        "openingTime":
                            shopInformation.shopTimings.wednesday.openingTime,
                        "closeingTime":
                            shopInformation.shopTimings.wednesday.closeingTime
                      },
                      "thursday": {
                        "openingTime":
                            shopInformation.shopTimings.thursday.openingTime,
                        "closeingTime":
                            shopInformation.shopTimings.thursday.closeingTime
                      },
                      "friday": {
                        "openingTime":
                            shopInformation.shopTimings.friday.openingTime,
                        "closeingTime":
                            shopInformation.shopTimings.friday.closeingTime
                      },
                      "saturday": {
                        "openingTime":
                            shopInformation.shopTimings.saturday.openingTime,
                        "closeingTime":
                            shopInformation.shopTimings.saturday.closeingTime
                      },
                      "sunday": {
                        "openingTime":
                            shopInformation.shopTimings.sunday.openingTime,
                        "closeingTime":
                            shopInformation.shopTimings.sunday.closeingTime
                      }
                    };

                    shop.shopTimings =
                        ManageShopResponse.ShopTimings.fromJson(timings);
                  }
                  await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ManageShopDetailsScreen(
                          shop: shop,
                          isFromOffers: true,
                        ),
                      ));

                  Provider.of<ShopOfferProvider>(context, listen: false)
                      .getShopOffers(shop.storeId);
                },
                child: Card(
                  margin: EdgeInsets.zero,
                  color: hexToColor(shopOfferProvider
                      .shopOffersResponse.merchantInformations.appColorCode),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0)),
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
                              '${shopOfferProvider.shopOffersResponse.merchantInformations.shopName}',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600),
                            ),
                            subtitle: Text(
                              shopOfferProvider.shopOffersResponse
                                  .merchantInformations.shopCategoryName,
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                            trailing: AspectRatio(
                              aspectRatio: 1,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(75.0),
                                child: Container(
                                  height: 150.0,
                                  width: 150.0,
                                  child: Image.network(
                                    '${shopOfferProvider.shopOffersResponse.merchantInformations.shopLogo}',
                                    fit: BoxFit.fill,
                                  ),
                                  decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius:
                                          BorderRadius.circular(50.0)),
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
            ),
          ),
        ],
      ),
    );
  }
}


class imageview extends StatefulWidget {
    final image,productname;
    
    
  imageview(
      {this.image,this.productname});

  @override
  _imageviewState createState() => _imageviewState();
}

class _imageviewState extends State<imageview> {
  
  @override
  Widget build(BuildContext context) {
    double width=MediaQuery.of(context).size.width;
  double height=MediaQuery.of(context).size.height;
      return MaterialApp(
       
      // Scaffold Widget
      home: Scaffold(
         appBar: AppBar(
  leading: IconButton(
    icon: Icon(Icons.arrow_back, color: Colors.black),
    onPressed: () => Navigator.of(context).pop(),
  ), 
  //title:Text('${widget.productname}'),
  
),

        body: Center(
          child: Container(
       child:Hero(
  tag: 'anything' + widget.image,
                           
                        child:ClipRRect(
                              borderRadius:BorderRadius.circular(8.0),
                              child:Image.network('${widget.image}',
                               height: height/2,
                               width: width,
                              //fit:BoxFit.fill,
                              ),
                        ),


       ),      
                      ),
        ),
      ),
    );
    
    
  
  }
}