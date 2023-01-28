import 'package:awomowa/app/theme.dart';
import 'package:awomowa/model/OfferListProvider.dart';
import 'package:awomowa/screens/notification_screen.dart';
import 'package:awomowa/shimmer_loaders/offers_shimmer.dart';
import 'package:awomowa/utils/SharedPreferences.dart';
import 'package:awomowa/widgets/offerItem.dart';
import 'package:awomowa/widgets/offer_screen_bg.dart';
import 'package:awomowa/widgets/offers_grid_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:provider/provider.dart';

import 'add_shop_screen.dart';

class OffersScreen extends StatefulWidget {
  
  @override
  _OffersScreenState createState() => _OffersScreenState();
}

class _OffersScreenState extends State<OffersScreen>
    with WidgetsBindingObserver {
  final _searchFocusNode = FocusNode();
  bool isSearchFocused = false;
  bool isGridView = false;
  ScrollController _scrollController;
  bool isAppbarExpanded = false;
  SharedPrefManager prefManger = SharedPrefManager();
  TextEditingController _searchController = new TextEditingController();
  SharedPrefManager sharedPrefManager = new SharedPrefManager();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) =>
        Provider.of<OfferListProvider>(context, listen: false).getOfferList());
    WidgetsBinding.instance.addObserver(this);
    _searchFocusNode.addListener(() {
      setState(() {
        isSearchFocused = _searchFocusNode.hasPrimaryFocus;
      });

      if (Provider.of<OfferListProvider>(context, listen: false).isEmpty) {
        Provider.of<OfferListProvider>(context, listen: false).searchString =
            '';
        _searchController.text = '';
        Provider.of<OfferListProvider>(context, listen: false).getOfferList();
      } else {}

      // if (!isSearchFocused && _searchController.text.length < 1) {
      //   Provider.of<OfferListProvider>(context, listen: false).searchString =
      //       _searchController.text;
      //   Provider.of<OfferListProvider>(context, listen: false).getOfferList();
      // }
    });

    _searchController.addListener(() {
      print('textchanged');
      if (_searchController.text.length > 1) {
        if (_searchFocusNode.hasPrimaryFocus) {
          Provider.of<OfferListProvider>(context, listen: false).searchString =
              _searchController.text;
          Provider.of<OfferListProvider>(context, listen: false).getOfferList();
        }
      } else {
        Provider.of<OfferListProvider>(context, listen: false).searchString =
            '';
        Provider.of<OfferListProvider>(context, listen: false).getOfferList();
      }
    });

    // KeyboardVisibilityNotification().addNewListener(
    //   onChange: (bool visible) {
    //     if (!visible) {
    //       _searchFocusNode.unfocus();
    //     }
    //   },
    // );

     KeyboardVisibilityBuilder(builder: (context, visible) {
                    return Text(
                      'The keyboard is: ${visible ? 'VISIBLE' : 'NOT VISIBLE'}',
                    );
                  });

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
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      Provider.of<OfferListProvider>(context, listen: false).getOfferList();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (SharedPrefManager.isNewNotified) {
      Provider.of<OfferListProvider>(context, listen: false).getOfferList();
      SharedPrefManager.isNewNotified = false;
    }

    return Consumer<OfferListProvider>(
      builder: (BuildContext context, OfferListProvider offerListProvider,
          Widget child) {
        return WillPopScope(
          onWillPop: () async {
            Provider.of<OfferListProvider>(context, listen: false)
                .searchString = '';
            await Provider.of<OfferListProvider>(context, listen: false)
                .getOfferList();
            return true;
          },
          child: Scaffold(
            extendBodyBehindAppBar: true,
            floatingActionButton: FloatingActionButton(
              onPressed: () async {
                var result =
                    await Navigator.pushNamed(context, AddShopScreen.routeName);
              },
              child: Icon(Icons.add),
            ),
            body: CustomScrollView(
              controller: _scrollController,
              slivers: [
                SliverAppBar(
                  floating: true,
                  pinned: true,
                  stretch: true,
                  automaticallyImplyLeading: false,
                  title: isAppbarExpanded
                      ? Text(
                          'My Favs',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )
                      : null,
                  actions: [
                    AnimatedOpacity(
                      duration: Duration(milliseconds: 300),
                      opacity: isSearchFocused ? 0.0 : 1.0,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                                context, NotificationsScreen.routeName);
                          },
                          child: Icon(
                            Icons.notifications,
                            color: Colors.black,
                            size: 32.0,
                          ),
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
                                bottomLeft: Radius.circular(32.0),
                                bottomRight: Radius.circular(32.0))),
                        duration: Duration(milliseconds: 300),
                        child: Stack(
                          children: [
                            OfferScreenBg(),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Spacer(),
                                  AnimatedOpacity(
                                    duration: Duration(milliseconds: 300),
                                    opacity: isSearchFocused ? 0.0 : 1.0,
                                    child: Text(
                                      'Welcome,',
                                      style: TextStyle(
                                          color: AppTheme.textBlack,
                                          fontSize: 32.0,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                  Visibility(
                                    visible: !isSearchFocused,
                                    child: Text(
                                      '${offerListProvider.userName}',
                                      style: TextStyle(
                                          color: AppTheme.textBlack,
                                          fontSize: 28.0,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                  Spacer(),
                                  Spacer(),
                                  TextFormField(
                                    focusNode: _searchFocusNode,
                                    controller: _searchController,
                                    style: TextStyle(color: Colors.black),
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.all(4.0),
                                      prefixIcon: Icon(
                                        FontAwesome.search,
                                        color: Colors.black,
                                      ),
                                      suffixIcon: Visibility(
                                        visible: isSearchFocused,
                                        child: InkWell(
                                          onTap: () {
                                            _searchFocusNode.unfocus();
                                            _searchController.text = '';
                                          },
                                          child: Icon(
                                            Icons.close,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                      hintText: 'Search',
                                      hintStyle: TextStyle(color: Colors.black),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.black, width: 1.0),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.black, width: 1.0),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 24.0,
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SliverList(
                  // Use a delegate to build items as they're scrolled on screen.
                  delegate: SliverChildListDelegate([
                    offerListProvider.isLoading
                        ? OfferShimmer()
                        : offerListProvider.isEmpty
                            ? EmptyState(
                                onClick: () async {
                                  await Navigator.pushNamed(
                                      context, AddShopScreen.routeName);
                                  Provider.of<OfferListProvider>(context,
                                          listen: false)
                                      .getOfferList();
                                },
                                title: 'Add your Favs',
                                subtitle:
                                    'Add all your favourite Favs and explore all hidden offers and updates',
                              )
                            : Column(
                                children: [
                                  SizedBox(
                                    height: 14.0,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Row(
                                      children: [
                                        Text(
                                          'My Favs',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w800,
                                              fontSize: 20.0),
                                        ),
                                        Spacer(),
                                        InkWell(
                                            onTap: () {
                                              setState(() {
                                                isGridView = !isGridView;
                                              });
                                            },
                                            child: Icon(isGridView
                                                ? Icons.list_rounded
                                                : Icons.grid_view))
                                      ],
                                    ),
                                  ),
                                  !isGridView
                                      ? GridView.builder(
                                          padding: EdgeInsets.zero,
                                          shrinkWrap: true,
                                          physics: ScrollPhysics(),
                                          itemCount: offerListProvider
                                              .offerListResponse
                                              .storeList
                                              .length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return OffersGridItem(
                                              offerStores: offerListProvider
                                                  .offerListResponse
                                                  .storeList[index],
                                            );
                                          },
                                          gridDelegate:
                                              SliverGridDelegateWithFixedCrossAxisCount(
                                                  crossAxisCount: 3),
                                        )
                                      : ListView.builder(
                                          padding: EdgeInsets.zero,
                                          shrinkWrap: true,
                                          itemCount: offerListProvider
                                              .offerListResponse
                                              .storeList
                                              .length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return OfferItem(
                                              offerStores: offerListProvider
                                                  .offerListResponse
                                                  .storeList[index],
                                            );
                                          },
                                        ),
                                ],
                              )
                  ]),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

class EmptyState extends StatelessWidget {
  final String title;
  final Function onClick;
  final IconData buttonIcon;
  final String btnText;
  final String subtitle;

  const EmptyState(
      {this.title,
      this.onClick,
      this.buttonIcon = Icons.add,
      this.btnText = 'Add new shops',
      this.subtitle = 'Add new shops to explore their offers'});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/empty_state.svg',
            height: 200.0,
            width: 200.0,
          ),
          SizedBox(
            height: 8.0,
          ),
          Text(
            '$title',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 18.0,
            ),
          ),
          SizedBox(
            height: 4.0,
          ),
          Text(
            '$subtitle',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 16.0,
            ),
          ),
          SizedBox(
            height: 14.0,
          ),
        ],
      ),
    );
  }
}
