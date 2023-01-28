import 'package:awomowa/app/theme.dart';
import 'package:awomowa/responsemodels/offer_list_response_model.dart';
import 'package:awomowa/screens/shop_offers_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OffersGridItem extends StatelessWidget {
  final StoreList offerStores;
  final double aspectRatio;
  final bool isForAppointment;
  final void Function(String id) onTapForAppintment;

  const OffersGridItem(
      {this.offerStores,
      this.aspectRatio,
      this.onTapForAppintment,
      this.isForAppointment = false});
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1 / 1,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: InkWell(
          onTap: () {
            if (isForAppointment) {
              onTapForAppintment(offerStores.storeId);
            } else {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ShopOffersScreen(
                      shopId: offerStores.storeId,
                    ),
                  ));
            }
          },
          child: Container(
            child: Column(
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      ClipOval(
                        child: AspectRatio(
                          aspectRatio: aspectRatio ?? 1 / 1,
                          child: Container(
                            child: Image.network(
                              offerStores.shopLogo,
                              fit: BoxFit.cover,
                            ),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16.0),
                                color: Colors.red),
                          ),
                        ),
                      ),
                      if (!isForAppointment)
                        Align(
                          alignment: Alignment.topRight,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppTheme.themeColor,
                                shape: BoxShape.circle,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0, vertical: 8.0),
                                child: Text(
                                  offerStores.offerCounts,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                Text(
                  '${offerStores.shopName}',
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
