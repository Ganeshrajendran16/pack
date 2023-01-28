import 'package:awomowa/app/theme.dart';
import 'package:awomowa/model/DarkThemeProvider.dart';
import 'package:awomowa/responsemodels/offer_list_response_model.dart';
import 'package:awomowa/screens/shop_offers_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OfferItem extends StatelessWidget {
  final StoreList offerStores;

  const OfferItem({this.offerStores});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ShopOffersScreen(
                    shopId: offerStores.storeId,
                  ),
                ));
          },
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipOval(
                  child: Container(
                    height: 70.0,
                    width: 70.0,
                    child: Image.network(
                      offerStores.shopLogo,
                      fit: BoxFit.cover,
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.0),
                        color: Colors.red),
                  ),
                ),
                SizedBox(
                  width: 16.0,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      offerStores.shopName,
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.w700),
                    ),
                    Text(offerStores.shopCategoryName),
                    Text(
                      offerStores.shopSubCategoryName,
                      style: TextStyle(fontSize: 12.0),
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
                    OfferNos(
                      offerNos: offerStores.offerCounts,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        Divider(
          height: 2.0,
        ),
      ],
    );
  }
}

class OfferNos extends StatelessWidget {
  final String offerNos;

  const OfferNos({this.offerNos});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Provider.of<DarkThemeProvider>(context).darkTheme
              ? AppTheme.themeColor.withOpacity(0.5)
              : Colors.black.withOpacity(0.5),
          borderRadius: BorderRadius.circular(16.0)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 4.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '$offerNos ${offerNos == '1' ? 'Offer' : 'Offers'}',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w800),
            ),
          ],
        ),
      ),
    );
  }
}
