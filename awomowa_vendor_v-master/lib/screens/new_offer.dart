import 'dart:io';

import 'package:awomowa_vendor/app/theme.dart';
import 'package:awomowa_vendor/providers/ActiveOfferListProvider.dart';
import 'package:awomowa_vendor/providers/AddNewOfferProvider.dart';
import 'package:awomowa_vendor/screens/error_screen.dart';
import 'package:awomowa_vendor/screens/publish_success_screen.dart';
import 'package:awomowa_vendor/screens/publish_update_screen.dart';
import 'package:awomowa_vendor/widgets/drop_down_button.dart';
import 'package:awomowa_vendor/widgets/form_field.dart';
import 'package:awomowa_vendor/widgets/loader_button.dart';
import 'package:awomowa_vendor/widgets/new_offer_bg.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class NewOfferScreen extends StatefulWidget {
  static const routeName = 'newOffer';
  final int initialIndex;

  const NewOfferScreen({this.initialIndex = 0});
  @override
  _NewOfferScreenState createState() => _NewOfferScreenState();
}

class _NewOfferScreenState extends State<NewOfferScreen>
    with TickerProviderStateMixin {
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController expiryDateController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  int selectedUnitIndex;
  File _productImage;
  final picker = ImagePicker();
  TabController _controller;
  int _selectedIndex = 0;
  showSnackBar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  void initState() {
    _controller = TabController(
        length: 2, vsync: this, initialIndex: widget.initialIndex);
    _selectedIndex = widget.initialIndex;
    _controller.addListener(() {
      setState(() {
        _selectedIndex = _controller.index;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AddNewOfferProvider>(
      builder: (BuildContext context, AddNewOfferProvider addNewOfferProvider,
          Widget child) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.3,
                  color: AppTheme.themeColor,
                  child: Stack(
                    children: [
                      NewOfferBg(),
                      SafeArea(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Card(
                                  color: Colors.black,
                                  shape: CircleBorder(),
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Icon(
                                      Icons.chevron_left,
                                      color: AppTheme.themeColor,
                                    ),
                                  ),
                                ),
                              ),
                              Spacer(),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.5,
                                  child: Text(
                                    _selectedIndex == 0
                                        ? 'Add New Offer !'
                                        : 'Update Your Customers !',
                                    style: TextStyle(
                                        color: AppTheme.textBlack,
                                        fontSize: 22.0,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ),
                              Spacer(),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                TabBar(
                  controller: _controller,
                  indicatorColor: AppTheme.themeColor,
                  indicatorWeight: 4.0,
                  tabs: [
                    Tab(
                      icon: Icon(Icons.local_offer_rounded),
                      text: 'OFFER',
                    ),
                    Tab(icon: Icon(Icons.notifications), text: 'UPDATE'),
                  ],
                ),
                _selectedIndex == 0
                    ? addNewOfferProvider.isLoading
                        ? Container(
                            height: MediaQuery.of(context).size.height * 0.6,
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  Center(
                                      child: InkWell(
                                          onTap: () {
                                            pickImage(context);
                                          },
                                          child: Container(
                                            height: 200.0,
                                            width: 200.0,
                                            child: _productImage != null
                                                ? Image.file(_productImage)
                                                : Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Icon(
                                                        FontAwesome
                                                            .cloud_upload,
                                                        color:
                                                            AppTheme.themeColor,
                                                        size: 42.0,
                                                      ),
                                                      Text(
                                                        'Upload Image',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontSize: 14.0),
                                                      ),
                                                    ],
                                                  ),
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.grey),
                                                borderRadius:
                                                    BorderRadius.circular(8.0)),
                                          ))),
                                  SizedBox(
                                    height: 24.0,
                                  ),
                                  GlobalFormField(
                                    hint: 'Product / Offer Name',
                                    prefixIcon: Icons.shopping_bag_outlined,
                                    controller: productNameController,
                                    textCapitalization:
                                        TextCapitalization.words,
                                    validator: (value) {
                                      if (value.length < 3) {
                                        return 'Enter Valid Name';
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(
                                    height: 24.0,
                                  ),
                                  GlobalFormField(
                                    hint: 'Description',
                                    prefixIcon: Icons.info,
                                    isMultiLine: true,
                                    controller: descriptionController,
                                    validator: (value) {
                                      if (value.length < 3) {
                                        return 'Enter Valid Description';
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(
                                    height: 24.0,
                                  ),
                                  GlobalFormField(
                                    hint: 'Price',
                                    prefixIcon: FontAwesome.dollar,
                                    inputType: TextInputType.number,
                                    controller: priceController,
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Enter Valid Price';
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(
                                    height: 24.0,
                                  ),
                                  GlobalDropDownButton(
                                    prefixIcon: Icons.info,
                                    hint: 'Unit',
                                    items: addNewOfferProvider
                                        .unitsResponse.unitList
                                        .map((e) => e.unitName)
                                        .toList(),
                                    onChanged: (int index) {
                                      setState(() {
                                        selectedUnitIndex = index;
                                      });
                                    },
                                    validator: (value) {
                                      if (value == null) {
                                        return 'Select Valid Unit';
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(
                                    height: 24.0,
                                  ),
                                  GlobalFormField(
                                    hint: 'Offer Expiry date',
                                    prefixIcon: Icons.date_range,
                                    inputType: TextInputType.number,
                                    isExpiryDate: true,
                                    controller: expiryDateController,
                                    validator: (value) {
                                      if (value.length < 3) {
                                        return 'Enter Valid Expiry Date';
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(
                                    height: 48.0,
                                  ),
                                  LoaderButton(
                                    btnTxt: 'Publish Offer',
                                    onPressed: () {
                                      if (_formKey.currentState.validate()) {
                                        publishOffer(
                                            addNewOfferProvider, context);
                                      } else {
                                        showSnackBar('Enter Valid Details !');
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                          )
                    : PublishUpdate(),
              ],
            ),
          ),
        );
      },
    );
  }

  void pickImage(BuildContext context) async {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return Container(
            padding: EdgeInsets.only(
              left: 5.0,
              right: 5.0,
              top: 5.0,
              bottom: 5.0,
            ),
            decoration: new BoxDecoration(
                color: Colors.white,
                borderRadius: new BorderRadius.only(
                    topLeft: const Radius.circular(10.0),
                    topRight: const Radius.circular(10.0))),
            child: new Wrap(
              children: <Widget>[
                new ListTile(
                  title: const Text(
                    'Pick Image From',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    final pickedFile =
                        await picker.getImage(source: ImageSource.gallery);

                    _productImage = await ImageCropper.cropImage(
                      sourcePath: pickedFile.path,
                      aspectRatioPresets: [
                        CropAspectRatioPreset.square,
                      ],
                    );

                    setState(() {});
                    Navigator.pop(context);
                  },
                  child: new ListTile(
                    leading: new Container(
                      width: 4.0,
                      child: Icon(
                        Icons.image,
                        color: Colors.pink,
                        size: 24.0,
                      ),
                    ),
                    title: const Text(
                      'Gallery',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    final pickedFile =
                        await picker.getImage(source: ImageSource.camera);

                    _productImage = await ImageCropper.cropImage(
                      sourcePath: pickedFile.path,
                      aspectRatioPresets: [
                        CropAspectRatioPreset.square,
                      ],
                    );

                    setState(() {});
                    Navigator.pop(context);
                  },
                  child: new ListTile(
                    leading: new Container(
                      width: 4.0,
                      child: Icon(
                        Icons.camera,
                        color: Colors.black,
                        size: 24.0,
                      ),
                    ),
                    title: const Text(
                      'Camera',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  void publishOffer(
      AddNewOfferProvider addNewOfferProvider, BuildContext context) async {
    await addNewOfferProvider.addNewOffers(
        productNameController.text,
        descriptionController.text,
        priceController.text,
        selectedUnitIndex,
        expiryDateController.text,
        _productImage);

    if (addNewOfferProvider.isError) {
      Navigator.pushNamed(context, NoInternet.routeName);
      return;
    }

    print(addNewOfferProvider.addNewOfferResponse['status']);

    if (addNewOfferProvider.addNewOfferResponse['status'] == 'success') {
      Provider.of<ActiveOfferListProvider>(context, listen: false)
          .getOfferList();
      Navigator.pushNamed(context, PublishSuccessScreen.routeName);
    } else {
      showSnackBar(addNewOfferProvider.addNewOfferResponse['message']);
    }
  }
}
