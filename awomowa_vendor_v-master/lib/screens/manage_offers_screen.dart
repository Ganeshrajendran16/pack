import 'package:awomowa_vendor/providers/DarkThemeProvider.dart';
import 'package:awomowa_vendor/providers/ManageOffersProvider.dart';
import 'package:awomowa_vendor/screens/offer_list.dart';
import 'package:awomowa_vendor/widgets/empty_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ManageOffersScreen extends StatelessWidget {
  static const routeName = 'manageOfferScreen';
  @override
  Widget build(BuildContext context) {
    Provider.of<ManageOffersProvider>(context, listen: false).getOfferList();
    return Consumer<ManageOffersProvider>(
      builder: (BuildContext context, ManageOffersProvider manageOffersProvider,
          Widget child) {
        return Scaffold(
          backgroundColor: Provider.of<DarkThemeProvider>(context).darkTheme
              ? null
              : Colors.grey.shade300,
          appBar: AppBar(
            title: Text('Manage Offers'),
          ),
          body: manageOffersProvider.isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : manageOffersProvider.isEmpty
                  ? Center(
                      child: EmptyState(
                        title: 'Add your Offers here',
                        subtitle:
                            'Please start sharing your App with your customers',
                      ),
                    )
                  : Stack(
                      children: [
                        // SplashScreenBg(),
                        ListView.builder(
                          itemCount: manageOffersProvider
                              .offerListResponse.histories.length,
                          itemBuilder: (BuildContext context, int index) {
                            return OfferListItem(
                                offer: manageOffersProvider
                                    .offerListResponse.histories[index]);
                          },
                        )
                      ],
                    ),
        );
      },
    );
  }
}
