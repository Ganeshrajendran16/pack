import 'package:awomowa/model/ManageStoresProvider.dart';
import 'package:awomowa/screens/offers_screen.dart';
import 'package:awomowa/widgets/manage_stores_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'add_shop_screen.dart';

class ManageStoresScreen extends StatefulWidget {
  static const routeName = 'manageStoresScreen';

  @override
  _ManageStoresScreenState createState() => _ManageStoresScreenState();
}

class _ManageStoresScreenState extends State<ManageStoresScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) =>
        Provider.of<ManageShopsProvider>(context, listen: false).getShopList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ManageShopsProvider>(
      builder: (BuildContext context, ManageShopsProvider manageShopsProvider,
          Widget child) {
        return Scaffold(
          appBar: AppBar(title: Text('Manage Stores')),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              Navigator.pushNamed(context, AddShopScreen.routeName);
            },
            label: Text(
              'Add Favs',
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
            icon: Icon(Icons.add),
          ),
          body: manageShopsProvider.isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : manageShopsProvider.isEmpty
                  ? Center(
                      child: EmptyState(
                      onClick: () async {
                        await Navigator.pushNamed(
                            context, AddShopScreen.routeName);

                        manageShopsProvider.getShopList();
                      },
                      title: 'Add your Favs',
                      subtitle:
                          'Add all your favourite stores and explore all hidden offers and updates',
                    ))
                  : ListView.builder(
                      itemBuilder: (BuildContext context, int index) {
                        return ManageStoresItem(
                            store: manageShopsProvider
                                .manageShopResponse.storeList[index]);
                      },
                      itemCount: manageShopsProvider
                          .manageShopResponse.storeList.length,
                    ),
        );
      },
    );
  }
}
