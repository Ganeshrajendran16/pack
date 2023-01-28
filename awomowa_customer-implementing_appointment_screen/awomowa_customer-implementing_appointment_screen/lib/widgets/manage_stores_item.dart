import 'package:awomowa/model/ManageStoresProvider.dart';
import 'package:awomowa/responsemodels/manage_stores_response.dart';
import 'package:awomowa/screens/manage_shop_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ManageStoresItem extends StatelessWidget {
  final StoreList store;

  ManageStoresItem({this.store});

  @override
  Widget build(BuildContext context) {
    return Consumer<ManageShopsProvider>(
      builder: (BuildContext context, ManageShopsProvider manageShopsProvider,
          Widget child) {
        return Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
              child: Container(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  onTap: () async {
                    await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ManageShopDetailsScreen(
                            shop: store,
                          ),
                        ));

                    manageShopsProvider.getShopList();
                  },
                  leading: AspectRatio(
                    aspectRatio: 1 / 1,
                    child: CircleAvatar(
                      radius: 90.0,
                      backgroundImage: NetworkImage('${store.shopLogo}'),
                    ),
                  ),
                  title: Text(
                    '${store.shopName}',
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.w700),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${store.shopCategoryName}',
                      ),
                      Text(
                        '${store.shopSubCategoryName}',
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Divider(
              height: 2.0,
            ),
          ],
        );
      },
    );
  }
}
