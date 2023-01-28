import 'package:awomowa_vendor/app/theme.dart';
import 'package:awomowa_vendor/providers/ActiveOfferListProvider.dart';
import 'package:awomowa_vendor/providers/VendorDetailsProvider.dart';
import 'package:awomowa_vendor/reponse_models/offer_list_response.dart';
import 'package:awomowa_vendor/screens/active_offer_details.dart';
import 'package:awomowa_vendor/utils/SharedPreferences.dart';
import 'package:awomowa_vendor/widgets/empty_state.dart';
import 'package:awomowa_vendor/widgets/offer_screen_bg.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'package:provider/provider.dart';

class OfferListScreen extends StatefulWidget {
  @override
  _OfferListScreenState createState() => _OfferListScreenState();
}

class _OfferListScreenState extends State<OfferListScreen> {
  final _searchFocusNode = FocusNode();
  bool isSearchFocused = false;
  bool isGridView = false;
  ScrollController _scrollController;
  bool isAppbarExpanded = false;

  TextEditingController _searchController = new TextEditingController();
  SharedPrefManager prefManager = SharedPrefManager();

  @override
  void initState() {
    super.initState();

    _searchFocusNode.addListener(() {
      setState(() {
        isSearchFocused = _searchFocusNode.hasPrimaryFocus;
      });

      if (Provider.of<ActiveOfferListProvider>(context, listen: false)
          .isEmpty) {
        Provider.of<ActiveOfferListProvider>(context, listen: false)
            .searchString = '';
        _searchController.text = '';
        Provider.of<ActiveOfferListProvider>(context, listen: false)
            .getOfferList();
      } else {}
    });

    _searchController.addListener(() {
      if (_searchController.text.length > 1) {
        if (_searchFocusNode.hasPrimaryFocus) {
          Provider.of<ActiveOfferListProvider>(context, listen: false)
              .searchString = _searchController.text;
          Provider.of<ActiveOfferListProvider>(context, listen: false)
              .getOfferList();
        }
      } else {
        Provider.of<ActiveOfferListProvider>(context, listen: false)
            .searchString = '';
        Provider.of<ActiveOfferListProvider>(context, listen: false)
            .getOfferList();
      }
    });

    _searchFocusNode.addListener(() {
      setState(() {
        isSearchFocused = _searchFocusNode.hasPrimaryFocus;
      });
    });

    KeyboardVisibilityNotification().addNewListener(
      onChange: (bool visible) {
        if (!visible) {
          _searchFocusNode.unfocus();
        }
      },
    );

    _scrollController = ScrollController()
      ..addListener(() {
        if (isAppbarExpanded != _isAppBarExpanded) {
          setState(() {
            isAppbarExpanded = _isAppBarExpanded;
          });
        }
      });
  }

  bool get _isAppBarExpanded {
    return _scrollController.hasClients &&
        _scrollController.offset > (200 - kToolbarHeight);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ActiveOfferListProvider>(
      builder: (BuildContext context,
          ActiveOfferListProvider activeOfferListProvider, Widget child) {
        return WillPopScope(
          onWillPop: () async {
            Provider.of<ActiveOfferListProvider>(context, listen: false)
                .searchString = '';
            await Provider.of<ActiveOfferListProvider>(context, listen: false)
                .getOfferList();
            return true;
          },
          child: Scaffold(
            backgroundColor: AppTheme.themeColor,
            extendBodyBehindAppBar: true,
            body: CustomScrollView(
              controller: _scrollController,
              slivers: [
                SliverAppBar(
                  floating: true,
                  pinned: true,
                  stretch: true,
                  automaticallyImplyLeading: false,
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  title: TextFormField(
                    focusNode: _searchFocusNode,
                    controller: _searchController,
                    decoration: InputDecoration(
                        hintText: 'Search',
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black))),
                  ),
                  actions: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: InkWell(
                        onTap: () {
                          if (isSearchFocused) {
                            _searchController.text = '';
                            _searchFocusNode.unfocus();
                          } else {
                            _searchFocusNode.requestFocus();
                          }
                        },
                        child: Icon(
                          isSearchFocused ? Icons.close : Icons.search,
                          color: Colors.black,
                          size: 32.0,
                        ),
                      ),
                    )
                  ],
                  expandedHeight: isSearchFocused
                      ? 150.0
                      : MediaQuery.of(context).size.height * 0.3,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Container(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      child: AnimatedContainer(
                        height: isSearchFocused
                            ? 150.0
                            : MediaQuery.of(context).size.height * 0.3,
                        decoration: BoxDecoration(
                            color: AppTheme.themeColor,
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(0.0),
                                bottomRight: Radius.circular(0.0))),
                        duration: Duration(milliseconds: 300),
                        child: Stack(
                          children: [
                            OfferScreenBg(),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.5,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Spacer(),
                                    AnimatedOpacity(
                                      duration: Duration(milliseconds: 300),
                                      opacity: isSearchFocused ? 0.0 : 1.0,
                                      child: Text(
                                        Provider.of<VendorDetailsProvider>(
                                                        context)
                                                    .vendorDetailsResponse
                                                    .merchantInformations
                                                    .isSubscriptionActive ==
                                                'yes'
                                            ? 'Grow your customers with AwomowA ! '
                                            : 'Your subscription has expired',
                                        style: TextStyle(
                                            color: AppTheme.textBlack,
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                    Text(
                                      int.parse(Provider.of<
                                                          VendorDetailsProvider>(
                                                      context)
                                                  .vendorDetailsResponse
                                                  .merchantInformations
                                                  .subscriptionRemainingDays) >
                                              7
                                          ? 'Manage your Updates, Offers and much more'
                                          : 'Your subscription has ${Provider.of<VendorDetailsProvider>(context).vendorDetailsResponse.merchantInformations.subscriptionRemainingDays} days left',
                                      style: TextStyle(
                                          color: Colors.black54,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                activeOfferListProvider.isLoading
                    ? SliverList(
                        delegate: SliverChildListDelegate([
                          Container(
                            height: MediaQuery.of(context).size.height * 0.7,
                            child: Center(
                              child: CircularProgressIndicator(
                                valueColor: new AlwaysStoppedAnimation<Color>(
                                    Colors.black),
                              ),
                            ),
                          )
                        ]),
                      )
                    : SliverList(
                        delegate: activeOfferListProvider.isEmpty
                            ? SliverChildListDelegate([
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.5,
                                  child: Center(
                                    child: EmptyState(
                                      title: 'Add your Updates and Offers here',
                                      subtitle:
                                          'Please start sharing your App with your customers',
                                    ),
                                  ),
                                )
                              ])
                            : SliverChildBuilderDelegate(
                                (BuildContext context, int index) {
                                  return OfferListItem(
                                    offer: activeOfferListProvider
                                        .offerListResponse.histories[index],
                                  );
                                },
                                childCount:
                                    activeOfferListProvider.offerListResponse ==
                                            null
                                        ? 0
                                        : activeOfferListProvider
                                            .offerListResponse.histories.length,
                                // Or, uncomment the following line:
                                // childCount: 3,
                              ),
                      )
              ],
            ),
          ),
        );
      },
    );
  }
}

class OfferListItem extends StatelessWidget {
  final Histories offer;

  const OfferListItem({this.offer});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ActiveOfferDetails(
                offer: offer,
              ),
            ),
          );
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
                      CircleAvatar(
                        backgroundColor: Colors.orange,
                        backgroundImage: NetworkImage('${offer.imageUrl}'),
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
                          Text(
                            offer.status,
                            style: TextStyle(
                                color: offer.status == 'Active'
                                    ? Colors.green
                                    : Colors.red,
                                fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                      Spacer(),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.indigo.shade400,
                            borderRadius: BorderRadius.circular(8.0)),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Icon(
                            Icons.edit,
                            color: Colors.white,
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
                          '${offer.createdAt}',
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
      ),
    );
  }
}
