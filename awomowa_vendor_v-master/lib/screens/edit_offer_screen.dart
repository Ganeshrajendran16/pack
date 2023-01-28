import 'dart:io';

import 'package:awomowa_vendor/app/theme.dart';
import 'package:awomowa_vendor/providers/ActiveOfferListProvider.dart';
import 'package:awomowa_vendor/providers/EditOfferProvider.dart';
import 'package:awomowa_vendor/providers/ManageOffersProvider.dart';
import 'package:awomowa_vendor/reponse_models/offer_list_response.dart';
import 'package:awomowa_vendor/screens/error_screen.dart';
import 'package:awomowa_vendor/widgets/drop_down_button.dart';
import 'package:awomowa_vendor/widgets/form_field.dart';
import 'package:awomowa_vendor/widgets/loader_button.dart';
import 'package:awomowa_vendor/widgets/login_screen_bg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class EditOfferScreen extends StatefulWidget {
  static const routeName = 'EditOffers';
  final Histories offer;

  EditOfferScreen({this.offer});

  @override
  _EditOfferScreenState createState() => _EditOfferScreenState();
}

class _EditOfferScreenState extends State<EditOfferScreen> {
  final TextEditingController productNameController = TextEditingController();

  final TextEditingController descriptionController = TextEditingController();

  final TextEditingController priceController = TextEditingController();

  final TextEditingController expiryDateController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  int selectedUnitIndex;
  bool isExpired = false;
  File _productImage;

  final picker = ImagePicker();

  TabController _controller;

  int _selectedIndex = 0;

  showSnackBar(String message, BuildContext context) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  void initState() {
    super.initState();
    loadOfferDetails();
  }

  void loadOfferDetails() {
    productNameController.text = widget.offer.productName;
    descriptionController.text = widget.offer.comments;
    priceController.text = widget.offer.price;
    expiryDateController.text = widget.offer.expireDate;
    print(widget.offer.status);
    isExpired = !(widget.offer.status == 'Active');

    if (isExpired) {
      expiryDateController.text = '';
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<EditOfferProvider>(builder: (BuildContext context,
        EditOfferProvider editOfferProvider, Widget child) {
      return Scaffold(
          body: editOfferProvider.isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.2,
                          color: AppTheme.themeColor,
                          child: Stack(
                            children: [
                              LoginScreenBg(),
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.2,
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: MediaQuery.of(context)
                                                    .padding
                                                    .top -
                                                12),
                                        child: FittedBox(
                                          fit: BoxFit.scaleDown,
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.pop(context);
                                            },
                                            child: Card(
                                              color: Colors.black,
                                              shape: CircleBorder(),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: Icon(
                                                  Icons.chevron_left,
                                                  color: AppTheme.themeColor,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Spacer(),
                                      FittedBox(
                                        fit: BoxFit.scaleDown,
                                        child: Text(
                                          isExpired
                                              ? 'Re-publish Offer'
                                              : 'Edit offer',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w800,
                                              fontSize: 24.0),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
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
                                            : Image.network(
                                                widget.offer.imageUrl),
                                        decoration: BoxDecoration(
                                            border:
                                                Border.all(color: Colors.grey),
                                            borderRadius:
                                                BorderRadius.circular(8.0)),
                                      ))),
                              SizedBox(
                                height: 24.0,
                              ),
                              GlobalFormField(
                                hint: 'Product Name',
                                prefixIcon: Icons.shopping_bag_outlined,
                                controller: productNameController,
                                validator: (value) {
                                  if (value.length < 3) {
                                    return 'Enter valid name';
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
                                    return 'Enter valid description';
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
                                    return 'Enter valid price';
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
                                selectedValue: widget.offer.unit,
                                items: editOfferProvider.unitsResponse.unitList
                                    .map((e) => e.unitName)
                                    .toList(),
                                onChanged: (int index) {
                                  selectedUnitIndex = index;
                                },
                                validator: (value) {
                                  if (value == null) {
                                    return 'Select valid Unit';
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
                                    return 'Enter valid expiry date';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(
                                height: 48.0,
                              ),
                              LoaderButton(
                                btnTxt: isExpired
                                    ? 'Re-Publish offer'
                                    : 'Update Offer',
                                isLoading: editOfferProvider.isLoading,
                                onPressed: () {
                                  if (_formKey.currentState.validate()) {
                                    if (isExpired) {
                                      showRepublishAlert(
                                          context, editOfferProvider);
                                    } else {
                                      publishOffer(editOfferProvider, context);
                                    }
                                  } else {
                                    showSnackBar(
                                        'Enter Valid Details !', context);
                                  }
                                },
                              ),
                              SizedBox(
                                height: 8.0,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.info,
                                    color: Colors.redAccent,
                                    size: 16.0,
                                  ),
                                  SizedBox(
                                    width: 8.0,
                                  ),
                                  Flexible(
                                    child: Text(
                                      isExpired
                                          ? 'Republish offer will create new offer with above content!'
                                          : 'Editing an offer will un-publish existing offer and add as a new offer!',
                                      style: TextStyle(
                                          color: Colors.redAccent,
                                          fontSize: 14.0),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 18.0,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ));
    });
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
                    _productImage = File(pickedFile.path);
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
                    _productImage = File(pickedFile.path);
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

  showRepublishAlert(
      BuildContext context, EditOfferProvider editOfferProvider) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = FlatButton(
      child: Text("Republish"),
      onPressed: () async {
        Navigator.pop(context);
        publishOffer(editOfferProvider, context);
      },
    );
    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      title: Text("Republish Offer"),
      content: Text("Are you sure you want to republish this offer?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void publishOffer(
      EditOfferProvider editOfferProvider, BuildContext context) async {
    await editOfferProvider.editOffer(
        productNameController.text,
        descriptionController.text,
        priceController.text,
        selectedUnitIndex,
        expiryDateController.text,
        widget.offer.broadcastId,
        _productImage);

    if (editOfferProvider.isError) {
      Navigator.pushNamed(context, NoInternet.routeName);
      return;
    }

    print(editOfferProvider.addNewOfferResponse['status']);

    if (editOfferProvider.addNewOfferResponse['status'] == 'success') {
      Provider.of<ActiveOfferListProvider>(context, listen: false)
          .getOfferList();
      Provider.of<ManageOffersProvider>(context, listen: false).getOfferList();
      showSnackBar('A new Offer has been published successfully !', context);
      int count = 0;
      Navigator.of(context).popUntil((_) => count++ >= 2);
    } else {
      showSnackBar(editOfferProvider.addNewOfferResponse['message'], context);
    }
  }
}
