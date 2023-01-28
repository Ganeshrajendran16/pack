import 'dart:io';

import 'package:awomowa_vendor/app/theme.dart';
import 'package:awomowa_vendor/providers/EditShopInfoProvider.dart';
import 'package:awomowa_vendor/providers/VendorDetailsProvider.dart';
import 'package:awomowa_vendor/reponse_models/category_list_response.dart';
import 'package:awomowa_vendor/reponse_models/vendor_details_response.dart';
import 'package:awomowa_vendor/screens/error_screen.dart';
import 'package:awomowa_vendor/widgets/drop_down_button.dart';
import 'package:awomowa_vendor/widgets/form_field.dart';
import 'package:awomowa_vendor/widgets/login_screen_bg.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class EditShopInfo extends StatefulWidget {
  static const routeName = 'editShopInfo';
  @override
  _EditShopInfoState createState() => _EditShopInfoState();
}

class _EditShopInfoState extends State<EditShopInfo> {
  int selectedCategoryIndex;
  String selectedCategory;
  String selectedSubCategory;
  String selectedCategoryId;
  String selectedSubCategoryId;
  String selectedCountry;
  int selectedSubCategoryIndex;
  bool isFirstTimeChanged = false;
  File _shopLogo;
  String shopLogoUrl;
  int selectedCountryPosition;
  bool isEditable = true;
  final picker = ImagePicker();
  final TextEditingController shopNameController = TextEditingController();
  final TextEditingController mobileNumberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController userMobileController = TextEditingController();
  final TextEditingController userEmailController = TextEditingController();
  final TextEditingController addressLine1Controller = TextEditingController();
  final TextEditingController addressLine2Controller = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController pinCodeController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  String oldMondayStart,
      oldMondayEnd,
      oldTuesdayStart,
      oldTuesdayEnd,
      oldWednesdaytart,
      oldWednesdayEnd,
      oldThursdayStart,
      oldThursdayEnd,
      oldFridayStart,
      oldFridayEnd,
      oldsaturdayStart,
      oldSaturdayEnd,
      oldSundayStart,
      oldSundayEnd;
  TimeOfDay mondayStart, mondayEnd;
  TimeOfDay tuesdayStart, tuesdayEnd;
  TimeOfDay wednesdayStart, wednesdayEnd;
  TimeOfDay thursdayStart, thursdayEnd;
  TimeOfDay fridayStart, fridayEnd;
  TimeOfDay saturdayStart, saturdayEnd;
  TimeOfDay sundayStart, sundayEnd;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    getDetails();
  }

  getDetails() {
    VendorDetailsResponse vendorDetailsResponse =
        Provider.of<VendorDetailsProvider>(context, listen: false)
            .vendorDetailsResponse;

    shopNameController.text =
        vendorDetailsResponse.merchantInformations.shopName;
    mobileNumberController.text =
        vendorDetailsResponse.merchantInformations.shopContactNumber;
    emailController.text =
        vendorDetailsResponse.merchantInformations.shopMailId;
    nameController.text = vendorDetailsResponse.merchantInformations.firstName;
    userMobileController.text =
        vendorDetailsResponse.merchantInformations.contactNumber;
    userEmailController.text =
        vendorDetailsResponse.merchantInformations.mailId;
    addressLine1Controller.text =
        vendorDetailsResponse.merchantInformations.address1;
    addressLine2Controller.text =
        vendorDetailsResponse.merchantInformations.address2;
    cityController.text = vendorDetailsResponse.merchantInformations.shopCity;
    pinCodeController.text =
        vendorDetailsResponse.merchantInformations.shopPincode;
    descriptionController.text =
        vendorDetailsResponse.merchantInformations.description;
    selectedSubCategory =
        vendorDetailsResponse.merchantInformations.shopSubCategoryName;
    selectedCategory =
        vendorDetailsResponse.merchantInformations.shopCategoryName;
    selectedCountry =
        vendorDetailsResponse.merchantInformations.shopCountryName;

    selectedCategoryId =
        vendorDetailsResponse.merchantInformations.shopSubCategoryId;
    selectedSubCategoryId =
        vendorDetailsResponse.merchantInformations.shopSubCategoryId;

    shopLogoUrl = vendorDetailsResponse.merchantInformations.shopLogo;

    ShopTimings shopTimings =
        vendorDetailsResponse.merchantInformations.shopTimings;
    if (shopTimings != null) {
      oldMondayStart = shopTimings.monday.openingTime;
      oldMondayEnd = shopTimings.monday.closeingTime;
      oldTuesdayStart = shopTimings.tuesday.openingTime;
      oldTuesdayEnd = shopTimings.tuesday.closeingTime;
      oldWednesdaytart = shopTimings.wednesday.openingTime;
      oldWednesdayEnd = shopTimings.wednesday.closeingTime;
      oldThursdayStart = shopTimings.thursday.openingTime;
      oldThursdayEnd = shopTimings.thursday.closeingTime;
      oldFridayStart = shopTimings.friday.openingTime;
      oldFridayEnd = shopTimings.friday.closeingTime;
      oldsaturdayStart = shopTimings.saturday.openingTime;
      oldSaturdayEnd = shopTimings.saturday.closeingTime;
      oldSundayStart = shopTimings.sunday.openingTime;
      oldSundayEnd = shopTimings.sunday.closeingTime;
    }
    setState(() {});
  }

  int getSelectedCategoryIndex(EditShopInfoProvider editShopInfoProvider) {
    for (int i = 0;
        i <= editShopInfoProvider.categoryListResponse.categoryList.length;
        i++) {
      CategoryList category =
          editShopInfoProvider.categoryListResponse.categoryList[i];
      if (category.categoryId == selectedCategoryId) {
        selectedCategoryIndex = i;
        return i;
      }
    }
    return null;
  }

  int getSelectedSubCategoryIndex(
      EditShopInfoProvider editShopInfoProvider, int selectedCategoryIndex) {
    for (int i = 0;
        i <=
            editShopInfoProvider.categoryListResponse
                .categoryList[selectedCategoryIndex].subCategories.length;
        i++) {
      SubCategories subCategory = editShopInfoProvider.categoryListResponse
          .categoryList[selectedCategoryIndex].subCategories[i];
      if (subCategory.subCategeoryId == selectedSubCategoryId) {
        selectedSubCategoryIndex = i;
        return i;
      }
    }
    return null;
  }

  void toggleEditing() {
    isEditable = !isEditable;
    if (!isEditable) {
      getDetails();
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<EditShopInfoProvider>(
      builder: (BuildContext context, EditShopInfoProvider editShopInfoProvider,
          Widget child) {
        return Scaffold(
          body: editShopInfoProvider.isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : SingleChildScrollView(
                  child: Form(
                    key: _formKey,
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
                                          'Update Shop Info',
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
                        Container(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 16.0,
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Shop Details',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 18.0),
                                  ),
                                ),
                                SizedBox(
                                  height: 8.0,
                                ),
                                ClipOval(
                                  child: InkWell(
                                      onTap: () {
                                        if (isEditable) {
                                          pickLogo(context);
                                        }
                                      },
                                      child: Container(
                                        height: 150.0,
                                        width: 150.0,
                                        child: _shopLogo == null
                                            ? Image.network(
                                                shopLogoUrl,
                                                fit: BoxFit.cover,
                                              )
                                            : Image.file(
                                                _shopLogo,
                                                fit: BoxFit.cover,
                                              ),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border:
                                              Border.all(color: Colors.grey),
                                        ),
                                      )),
                                ),
                                SizedBox(
                                  height: 32.0,
                                ),
                                GlobalFormField(
                                    hint: 'Shop Name',
                                    prefixIcon: Icons.shopping_bag_outlined,
                                    controller: shopNameController,
                                    isEnabled: isEditable,
                                    textCapitalization:
                                        TextCapitalization.words,
                                    validator: (value) {
                                      if (value.length < 3) {
                                        return 'Enter Valid Shop Name';
                                      }
                                      return null;
                                    }),
                                SizedBox(
                                  height: 16.0,
                                ),
                                GlobalFormField(
                                    hint: 'Mobile Number',
                                    prefixIcon: Icons.phone,
                                    isEnabled: isEditable,
                                    isMobile: true,
                                    controller: mobileNumberController,
                                    validator: (value) {
                                      if (value.length < 10) {
                                        return 'Enter Valid Mobile Number';
                                      }
                                      return null;
                                    }),
                                SizedBox(
                                  height: 16.0,
                                ),
                                GlobalFormField(
                                  hint: 'Email',
                                  prefixIcon: Icons.mail,
                                  isEnabled: isEditable,
                                  inputType: TextInputType.emailAddress,
                                  textCapitalization: TextCapitalization.none,
                                  controller: emailController,
                                  validator: (value) {
                                    if (RegExp(
                                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                        .hasMatch(value)) {
                                      return null;
                                    } else {
                                      return 'Enter Valid Email';
                                    }
                                  },
                                ),
                                SizedBox(
                                  height: 32.0,
                                ),
                                GlobalDropDownButton(
                                  prefixIcon: Icons.person_pin_circle,
                                  selectedValue: selectedCountry,
                                  hint: 'Country',
                                  items:
                                      editShopInfoProvider.countriesResponse !=
                                              null
                                          ? editShopInfoProvider
                                              .countriesResponse.countries
                                              .map((e) => e.name)
                                              .toList()
                                          : [],
                                  onChanged: (int index) {
                                    setState(() {
                                      selectedCountryPosition = index;
                                    });
                                  },
                                  validator: (value) {
                                    if (value == null) {
                                      return 'Select Valid Country';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(
                                  height: 16.0,
                                ),
                                GlobalFormField(
                                    hint: 'Address Line 1',
                                    prefixIcon: Icons.credit_card,
                                    isEnabled: isEditable,
                                    controller: addressLine1Controller,
                                    textCapitalization:
                                        TextCapitalization.words,
                                    validator: (value) {
                                      if (value.length < 5) {
                                        return 'Enter Valid Address';
                                      }
                                      return null;
                                    }),
                                SizedBox(
                                  height: 16.0,
                                ),
                                GlobalFormField(
                                    hint: 'Address Line 2',
                                    prefixIcon: Icons.credit_card,
                                    textCapitalization:
                                        TextCapitalization.words,
                                    isEnabled: isEditable,
                                    controller: addressLine2Controller,
                                    validator: (value) {
                                      return null;
                                    }),
                                SizedBox(
                                  height: 16.0,
                                ),
                                GlobalFormField(
                                    hint: 'City',
                                    prefixIcon: Icons.location_city,
                                    isEnabled: isEditable,
                                    controller: cityController,
                                    textCapitalization:
                                        TextCapitalization.words,
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Enter Valid City';
                                      }
                                      return null;
                                    }),
                                SizedBox(
                                  height: 16.0,
                                ),
                                GlobalFormField(
                                    hint: editShopInfoProvider
                                                    .countriesResponse !=
                                                null &&
                                            selectedCountryPosition != null
                                        ? editShopInfoProvider
                                            .countriesResponse
                                            .countries[selectedCountryPosition]
                                            .pincodeLabel
                                        : 'Zip/Postal Code',
                                    prefixIcon: Icons.power_input_sharp,
                                    isEnabled: selectedCountryPosition != null,
                                    inputType: editShopInfoProvider
                                                    .countriesResponse !=
                                                null &&
                                            selectedCountryPosition != null
                                        ? editShopInfoProvider
                                                    .countriesResponse
                                                    .countries[
                                                        selectedCountryPosition]
                                                    .keyType ==
                                                'alphaNumeric'
                                            ? TextInputType.name
                                            : TextInputType.number
                                        : TextInputType.number,
                                    textCapitalization:
                                        TextCapitalization.characters,
                                    controller: pinCodeController,
                                    validator: (value) {
                                      Pattern pattern = editShopInfoProvider
                                          .countriesResponse
                                          .countries[selectedCountryPosition]
                                          .regex;
                                      RegExp regex = new RegExp(pattern);
                                      if (!regex.hasMatch(value))
                                        return 'Enter Valid Pin';
                                      else
                                        return null;
                                    }),
                                SizedBox(
                                  height: 16.0,
                                ),
                                isEditable
                                    ? GlobalDropDownButton(
                                        prefixIcon: Icons.list,
                                        hint: 'Category',
                                        selectedValue: selectedCategory,
                                        items: editShopInfoProvider
                                            .categoryListResponse.categoryList
                                            .map((e) => e.categoryName)
                                            .toList(),
                                        onChanged: (int index) {
                                          print('$index  category');
                                          selectedCategoryIndex = index;
                                          if (isFirstTimeChanged) {
                                            selectedSubCategory = null;
                                            isFirstTimeChanged = true;
                                          }
                                          setState(() {});
                                        },
                                        validator: (value) {
                                          if (value == null) {
                                            return 'Select Valid Category';
                                          }
                                          return null;
                                        },
                                      )
                                    : GlobalFormField(
                                        hint: 'Category',
                                        prefixIcon: Icons.list,
                                        isEnabled: isEditable,
                                        controller: TextEditingController(
                                            text: selectedCategory),
                                      ),
                                SizedBox(
                                  height: 16.0,
                                ),
                                isEditable
                                    ? GlobalDropDownButton(
                                        prefixIcon: Icons.list,
                                        hint: 'Sub Category',
                                        selectedValue: isFirstTimeChanged
                                            ? null
                                            : selectedSubCategory,
                                        items: selectedCategoryIndex == null
                                            ? []
                                            : editShopInfoProvider
                                                .categoryListResponse
                                                .categoryList[
                                                    selectedCategoryIndex]
                                                .subCategories
                                                .map((e) => e.subCategoryName)
                                                .toList(),
                                        onChanged: (int index) {
                                          print('$index  subcategory');
                                          setState(() {
                                            selectedSubCategoryIndex = index;
                                          });
                                        },
                                        validator: (value) {
                                          if (value == null) {
                                            return 'Select Valid Sub-Category';
                                          }
                                          return null;
                                        },
                                      )
                                    : GlobalFormField(
                                        hint: 'Sub-Category',
                                        prefixIcon: Icons.list,
                                        isEnabled: isEditable,
                                        controller: TextEditingController(
                                            text: selectedSubCategory),
                                      ),
                                SizedBox(
                                  height: 16.0,
                                ),
                                GlobalFormField(
                                    prefixIcon: Icons.info,
                                    hint: 'Description',
                                    isMultiLine: true,
                                    isEnabled: isEditable,
                                    controller: descriptionController,
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Enter Valid Description';
                                      }
                                      return null;
                                    }),
                                SizedBox(
                                  height: 16.0,
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Shop Timing',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 18.0),
                                  ),
                                ),
                                SizedBox(
                                  height: 16.0,
                                ),
                                AbsorbPointer(
                                  absorbing: !isEditable,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Flexible(
                                              flex: 3,
                                              fit: FlexFit.tight,
                                              child: Text(
                                                'Day',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 8,
                                            ),
                                            Flexible(
                                              flex: 5,
                                              fit: FlexFit.tight,
                                              child: Text(
                                                'Open',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 8,
                                            ),
                                            Flexible(
                                              flex: 5,
                                              fit: FlexFit.tight,
                                              child: Text(
                                                'Close',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: [
                                            Flexible(
                                              flex: 3,
                                              fit: FlexFit.tight,
                                              child: Text(
                                                'Monday',
                                                style: TextStyle(fontSize: 12),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 8,
                                            ),
                                            Flexible(
                                                flex: 5,
                                                fit: FlexFit.tight,
                                                child: RaisedButton(
                                                  color: Colors.grey[300],
                                                  child: Text(mondayStart ==
                                                          null
                                                      ? oldMondayStart ??
                                                          'Choose'
                                                      : '${mondayStart.format(context)}'),
                                                  onPressed: () async {
                                                    mondayStart =
                                                        await showTimePicker(
                                                            context: context,
                                                            initialTime:
                                                                TimeOfDay.now(),
                                                            helpText:
                                                                'Select Start Time');
                                                    mondayEnd =
                                                        await showTimePicker(
                                                            context: context,
                                                            initialTime:
                                                                mondayStart ??
                                                                    TimeOfDay
                                                                        .now(),
                                                            helpText:
                                                                'Select To Time');
                                                    setState(() {});
                                                  },
                                                )),
                                            SizedBox(
                                              width: 8,
                                            ),
                                            Flexible(
                                                flex: 5,
                                                fit: FlexFit.tight,
                                                child: RaisedButton(
                                                  color: Colors.grey[300],
                                                  child: Text(mondayEnd == null
                                                      ? oldMondayEnd ?? 'Choose'
                                                      : '${mondayEnd.format(context)}'),
                                                  onPressed: mondayStart == null
                                                      ? null
                                                      : () async {
                                                          mondayEnd = await showTimePicker(
                                                              context: context,
                                                              initialTime:
                                                                  mondayStart ??
                                                                      TimeOfDay
                                                                          .now(),
                                                              helpText:
                                                                  'Select To Time');
                                                          setState(() {});
                                                        },
                                                )),
                                          ],
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Flexible(
                                              child: SizedBox(
                                                width: double.maxFinite,
                                              ),
                                              flex: 3,
                                            ),
                                            SizedBox(
                                              width: 8,
                                            ),
                                            Flexible(
                                              flex: 10,
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    child: GestureDetector(
                                                      child: Card(
                                                        margin: EdgeInsets.zero,
                                                        color:
                                                            AppTheme.themeColor,
                                                        child: Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  vertical:
                                                                      8.0),
                                                          child: Text(
                                                            'Copy for all days',
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                          ),
                                                        ),
                                                      ),
                                                      onTap: () {
                                                        setState(() {
                                                          tuesdayStart =
                                                              mondayStart;
                                                          tuesdayEnd =
                                                              mondayEnd;
                                                          wednesdayStart =
                                                              mondayStart;
                                                          wednesdayEnd =
                                                              mondayEnd;
                                                          thursdayStart =
                                                              mondayStart;
                                                          thursdayEnd =
                                                              mondayEnd;
                                                          fridayStart =
                                                              mondayStart;
                                                          fridayEnd = mondayEnd;
                                                          saturdayStart =
                                                              mondayStart;
                                                          saturdayEnd =
                                                              mondayEnd;
                                                          sundayStart =
                                                              mondayStart;
                                                          sundayEnd = mondayEnd;
                                                        });
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Row(
                                          children: [
                                            Flexible(
                                              flex: 3,
                                              fit: FlexFit.tight,
                                              child: Text(
                                                'Tuesday',
                                                style: TextStyle(fontSize: 12),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 8,
                                            ),
                                            Flexible(
                                                flex: 5,
                                                fit: FlexFit.tight,
                                                child: RaisedButton(
                                                  color: Colors.grey[300],
                                                  child: Text(tuesdayStart ==
                                                          null
                                                      ? oldTuesdayStart ??
                                                          'Choose'
                                                      : '${tuesdayStart.format(context)}'),
                                                  onPressed: () async {
                                                    tuesdayStart =
                                                        await showTimePicker(
                                                            context: context,
                                                            initialTime:
                                                                TimeOfDay.now(),
                                                            helpText:
                                                                'Select Start Time');
                                                    tuesdayEnd =
                                                        await showTimePicker(
                                                            context: context,
                                                            initialTime:
                                                                tuesdayStart ??
                                                                    TimeOfDay
                                                                        .now(),
                                                            helpText:
                                                                'Select To Time');
                                                    setState(() {});
                                                  },
                                                )),
                                            SizedBox(
                                              width: 8,
                                            ),
                                            Flexible(
                                                flex: 5,
                                                fit: FlexFit.tight,
                                                child: RaisedButton(
                                                  color: Colors.grey[300],
                                                  child: Text(tuesdayEnd == null
                                                      ? oldTuesdayEnd ??
                                                          'Choose'
                                                      : '${tuesdayEnd.format(context)}'),
                                                  onPressed: tuesdayStart ==
                                                          null
                                                      ? null
                                                      : () async {
                                                          tuesdayEnd = await showTimePicker(
                                                              context: context,
                                                              initialTime:
                                                                  tuesdayStart ??
                                                                      TimeOfDay
                                                                          .now(),
                                                              helpText:
                                                                  'Select To Time');
                                                          setState(() {});
                                                        },
                                                )),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Row(
                                          children: [
                                            Flexible(
                                              flex: 3,
                                              fit: FlexFit.tight,
                                              child: Text(
                                                'Wednesday',
                                                style: TextStyle(fontSize: 12),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 8,
                                            ),
                                            Flexible(
                                                flex: 5,
                                                fit: FlexFit.tight,
                                                child: RaisedButton(
                                                  color: Colors.grey[300],
                                                  child: Text(wednesdayStart ==
                                                          null
                                                      ? oldWednesdaytart ??
                                                          'Choose'
                                                      : '${wednesdayStart.format(context)}'),
                                                  onPressed: () async {
                                                    wednesdayStart =
                                                        await showTimePicker(
                                                            context: context,
                                                            initialTime:
                                                                TimeOfDay.now(),
                                                            helpText:
                                                                'Select Start Time');
                                                    wednesdayEnd =
                                                        await showTimePicker(
                                                            context: context,
                                                            initialTime:
                                                                tuesdayStart ??
                                                                    TimeOfDay
                                                                        .now(),
                                                            helpText:
                                                                'Select To Time');
                                                    setState(() {});
                                                  },
                                                )),
                                            SizedBox(
                                              width: 8,
                                            ),
                                            Flexible(
                                                flex: 5,
                                                fit: FlexFit.tight,
                                                child: RaisedButton(
                                                  color: Colors.grey[300],
                                                  child: Text(wednesdayEnd ==
                                                          null
                                                      ? oldWednesdayEnd ??
                                                          'Choose'
                                                      : '${wednesdayEnd.format(context)}'),
                                                  onPressed: wednesdayStart ==
                                                          null
                                                      ? null
                                                      : () async {
                                                          wednesdayEnd = await showTimePicker(
                                                              context: context,
                                                              initialTime:
                                                                  tuesdayStart ??
                                                                      TimeOfDay
                                                                          .now(),
                                                              helpText:
                                                                  'Select To Time');
                                                          setState(() {});
                                                        },
                                                )),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Row(
                                          children: [
                                            Flexible(
                                              flex: 3,
                                              fit: FlexFit.tight,
                                              child: Text(
                                                'Thursday',
                                                style: TextStyle(fontSize: 12),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 8,
                                            ),
                                            Flexible(
                                                flex: 5,
                                                fit: FlexFit.tight,
                                                child: RaisedButton(
                                                  color: Colors.grey[300],
                                                  child: Text(thursdayStart ==
                                                          null
                                                      ? oldThursdayStart ??
                                                          'Choose'
                                                      : '${thursdayStart.format(context)}'),
                                                  onPressed: () async {
                                                    thursdayStart =
                                                        await showTimePicker(
                                                            context: context,
                                                            initialTime:
                                                                TimeOfDay.now(),
                                                            helpText:
                                                                'Select Start Time');
                                                    thursdayEnd =
                                                        await showTimePicker(
                                                            context: context,
                                                            initialTime:
                                                                thursdayStart ??
                                                                    TimeOfDay
                                                                        .now(),
                                                            helpText:
                                                                'Select To Time');
                                                    setState(() {});
                                                  },
                                                )),
                                            SizedBox(
                                              width: 8,
                                            ),
                                            Flexible(
                                                flex: 5,
                                                fit: FlexFit.tight,
                                                child: RaisedButton(
                                                  color: Colors.grey[300],
                                                  child: Text(thursdayEnd ==
                                                          null
                                                      ? oldThursdayEnd ??
                                                          'Choose'
                                                      : '${thursdayEnd.format(context)}'),
                                                  onPressed: thursdayStart ==
                                                          null
                                                      ? null
                                                      : () async {
                                                          thursdayEnd = await showTimePicker(
                                                              context: context,
                                                              initialTime:
                                                                  thursdayStart ??
                                                                      TimeOfDay
                                                                          .now(),
                                                              helpText:
                                                                  'Select To Time');
                                                          setState(() {});
                                                        },
                                                )),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Row(
                                          children: [
                                            Flexible(
                                              flex: 3,
                                              fit: FlexFit.tight,
                                              child: Text(
                                                'Friday',
                                                style: TextStyle(fontSize: 12),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 8,
                                            ),
                                            Flexible(
                                                flex: 5,
                                                fit: FlexFit.tight,
                                                child: RaisedButton(
                                                  color: Colors.grey[300],
                                                  child: Text(fridayStart ==
                                                          null
                                                      ? oldFridayStart ??
                                                          'Choose'
                                                      : '${fridayStart.format(context)}'),
                                                  onPressed: () async {
                                                    fridayStart =
                                                        await showTimePicker(
                                                            context: context,
                                                            initialTime:
                                                                TimeOfDay.now(),
                                                            helpText:
                                                                'Select Start Time');
                                                    fridayEnd =
                                                        await showTimePicker(
                                                            context: context,
                                                            initialTime:
                                                                fridayStart ??
                                                                    TimeOfDay
                                                                        .now(),
                                                            helpText:
                                                                'Select To Time');
                                                    setState(() {});
                                                  },
                                                )),
                                            SizedBox(
                                              width: 8,
                                            ),
                                            Flexible(
                                                flex: 5,
                                                fit: FlexFit.tight,
                                                child: RaisedButton(
                                                  color: Colors.grey[300],
                                                  child: Text(fridayEnd == null
                                                      ? oldFridayEnd ?? 'Choose'
                                                      : '${fridayEnd.format(context)}'),
                                                  onPressed: fridayStart == null
                                                      ? null
                                                      : () async {
                                                          fridayEnd = await showTimePicker(
                                                              context: context,
                                                              initialTime:
                                                                  fridayStart ??
                                                                      TimeOfDay
                                                                          .now(),
                                                              helpText:
                                                                  'Select To Time');
                                                          setState(() {});
                                                        },
                                                )),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Row(
                                          children: [
                                            Flexible(
                                              flex: 3,
                                              fit: FlexFit.tight,
                                              child: Text(
                                                'Saturday',
                                                style: TextStyle(fontSize: 12),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 8,
                                            ),
                                            Flexible(
                                                flex: 5,
                                                fit: FlexFit.tight,
                                                child: RaisedButton(
                                                  color: Colors.grey[300],
                                                  child: Text(saturdayStart ==
                                                          null
                                                      ? oldsaturdayStart ??
                                                          'Choose'
                                                      : '${saturdayStart.format(context)}'),
                                                  onPressed: () async {
                                                    saturdayStart =
                                                        await showTimePicker(
                                                            context: context,
                                                            initialTime:
                                                                TimeOfDay.now(),
                                                            helpText:
                                                                'Select Start Time');
                                                    saturdayEnd =
                                                        await showTimePicker(
                                                            context: context,
                                                            initialTime:
                                                                saturdayStart ??
                                                                    TimeOfDay
                                                                        .now(),
                                                            helpText:
                                                                'Select To Time');
                                                    setState(() {});
                                                  },
                                                )),
                                            SizedBox(
                                              width: 8,
                                            ),
                                            Flexible(
                                                flex: 5,
                                                fit: FlexFit.tight,
                                                child: RaisedButton(
                                                  color: Colors.grey[300],
                                                  child: Text(saturdayEnd ==
                                                          null
                                                      ? oldSaturdayEnd ??
                                                          'Choose'
                                                      : '${saturdayEnd.format(context)}'),
                                                  onPressed: saturdayStart ==
                                                          null
                                                      ? null
                                                      : () async {
                                                          saturdayEnd = await showTimePicker(
                                                              context: context,
                                                              initialTime:
                                                                  saturdayStart ??
                                                                      TimeOfDay
                                                                          .now(),
                                                              helpText:
                                                                  'Select To Time');
                                                          setState(() {});
                                                        },
                                                )),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Row(
                                          children: [
                                            Flexible(
                                              flex: 3,
                                              fit: FlexFit.tight,
                                              child: Text(
                                                'Sunday',
                                                style: TextStyle(fontSize: 12),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 8,
                                            ),
                                            Flexible(
                                                flex: 5,
                                                fit: FlexFit.tight,
                                                child: RaisedButton(
                                                  color: Colors.grey[300],
                                                  child: Text(sundayStart ==
                                                          null
                                                      ? oldSundayStart ??
                                                          'Choose'
                                                      : '${sundayStart.format(context)}'),
                                                  onPressed: () async {
                                                    sundayStart =
                                                        await showTimePicker(
                                                            context: context,
                                                            initialTime:
                                                                TimeOfDay.now(),
                                                            helpText:
                                                                'Select Start Time');
                                                    sundayEnd =
                                                        await showTimePicker(
                                                            context: context,
                                                            initialTime:
                                                                sundayStart ??
                                                                    TimeOfDay
                                                                        .now(),
                                                            helpText:
                                                                'Select To Time');
                                                    setState(() {});
                                                  },
                                                )),
                                            SizedBox(
                                              width: 8,
                                            ),
                                            Flexible(
                                                flex: 5,
                                                fit: FlexFit.tight,
                                                child: RaisedButton(
                                                  color: Colors.grey[300],
                                                  child: Text(sundayEnd == null
                                                      ? oldSundayEnd ?? 'Choose'
                                                      : '${sundayEnd.format(context)}'),
                                                  onPressed: sundayStart == null
                                                      ? null
                                                      : () async {
                                                          sundayEnd = await showTimePicker(
                                                              context: context,
                                                              initialTime:
                                                                  sundayStart ??
                                                                      TimeOfDay
                                                                          .now(),
                                                              helpText:
                                                                  'Select To Time');
                                                          setState(() {});
                                                        },
                                                )),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 48.0,
                                ),
                                SizedBox(
                                  height: 16.0,
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Your Details',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 18.0),
                                  ),
                                ),
                                SizedBox(
                                  height: 32.0,
                                ),
                                GlobalFormField(
                                  hint: 'Name',
                                  prefixIcon: Icons.shopping_bag_outlined,
                                  controller: nameController,
                                  textCapitalization: TextCapitalization.words,
                                  isEnabled: isEditable,
                                  validator: (value) {
                                    if (value.length < 3) {
                                      return 'Enter valid Name';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(
                                  height: 16.0,
                                ),
                                GlobalFormField(
                                  hint: 'Mobile Number',
                                  prefixIcon: Icons.phone,
                                  isMobile: true,
                                  isEnabled: isEditable,
                                  controller: userMobileController,
                                  validator: (value) {
                                    if (value.length < 10) {
                                      return 'Enter Valid Mobile Number';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(
                                  height: 16.0,
                                ),
                                GlobalFormField(
                                  hint: 'Email',
                                  prefixIcon: Icons.mail,
                                  inputType: TextInputType.emailAddress,
                                  isEnabled: isEditable,
                                  textCapitalization: TextCapitalization.none,
                                  controller: userEmailController,
                                  validator: (value) {
                                    if (RegExp(
                                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                        .hasMatch(value)) {
                                      return null;
                                    } else {
                                      return 'Enter valid Email';
                                    }
                                  },
                                ),
                                SizedBox(
                                  height: 16.0,
                                ),
                                SizedBox(
                                  height: 48.0,
                                ),
                                Column(
                                  children: [
                                    isEditable
                                        ? SizedBox(
                                            width: double.infinity,
                                            child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    primary:
                                                        AppTheme.themeColor),
                                                onPressed: () {
                                                  if (_formKey.currentState
                                                      .validate()) {
                                                    updateInfo(
                                                        editShopInfoProvider);
                                                  } else {
                                                    showSnackBar(
                                                        'Enter Valid Details !');
                                                  }
                                                },
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      14.0),
                                                  child: Text(
                                                    'Update Info',
                                                    style: TextStyle(
                                                        color:
                                                            AppTheme.textBlack,
                                                        fontWeight:
                                                            FontWeight.w700),
                                                  ),
                                                )))
                                        : SizedBox(),
                                    SizedBox(
                                      height: 16.0,
                                    ),
                                    SizedBox(
                                      height: 16.0,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
        );
      },
    );
  }

  void pickLogo(BuildContext context) async {
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
            ),
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

                    _shopLogo = await ImageCropper.cropImage(
                        sourcePath: pickedFile.path,
                        cropStyle: CropStyle.circle);

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
                    _shopLogo = File(pickedFile.path);
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

  void updateInfo(EditShopInfoProvider editShopInfoProvider) async {
    Map<String, dynamic> shopTiming = Map();

    shopTiming['monday'] = {
      'fromTime': mondayStart == null
          ? oldMondayStart
          : mondayStart.format(context) ?? '',
      'toTime':
          mondayEnd == null ? oldMondayEnd : mondayEnd.format(context) ?? ''
    };

    shopTiming['tuesday'] = {
      'fromTime': tuesdayStart == null
          ? oldTuesdayStart
          : tuesdayStart.format(context) ?? '',
      'toTime':
          tuesdayEnd == null ? oldTuesdayEnd : tuesdayEnd.format(context) ?? ''
    };

    shopTiming['wednesday'] = {
      'fromTime': wednesdayStart == null
          ? oldWednesdaytart
          : wednesdayStart.format(context) ?? '',
      'toTime': wednesdayEnd == null
          ? oldWednesdayEnd
          : wednesdayEnd.format(context) ?? ''
    };

    shopTiming['thursday'] = {
      'fromTime': thursdayStart == null
          ? oldThursdayStart
          : thursdayStart.format(context) ?? '',
      'toTime': thursdayEnd == null
          ? oldThursdayEnd
          : thursdayEnd.format(context) ?? ''
    };

    shopTiming['friday'] = {
      'fromTime': fridayStart == null
          ? oldFridayStart
          : fridayStart.format(context) ?? '',
      'toTime':
          fridayEnd == null ? oldFridayEnd : fridayEnd.format(context) ?? ''
    };

    shopTiming['saturday'] = {
      'fromTime': saturdayStart == null
          ? oldsaturdayStart
          : saturdayStart.format(context) ?? '',
      'toTime': saturdayEnd == null
          ? oldSaturdayEnd
          : saturdayEnd.format(context) ?? ''
    };

    shopTiming['sunday'] = {
      'fromTime': sundayStart == null
          ? oldSundayStart
          : sundayStart.format(context) ?? '',
      'toTime':
          sundayEnd == null ? oldSundayEnd : sundayEnd.format(context) ?? ''
    };

    await editShopInfoProvider.updateShopInfo(
        shopNameController.text,
        mobileNumberController.text,
        emailController.text,
        addressLine1Controller.text,
        addressLine2Controller.text ?? '',
        cityController.text,
        editShopInfoProvider
            .countriesResponse.countries[selectedCountryPosition].id,
        pinCodeController.text,
        selectedCategoryIndex,
        selectedSubCategoryIndex,
        descriptionController.text,
        nameController.text,
        userMobileController.text,
        userEmailController.text,
        _shopLogo,
        shopTiming);

    if (editShopInfoProvider.isError) {
      Navigator.pushNamed(context, NoInternet.routeName);
      return;
    }

    if (editShopInfoProvider.profileUpdateResponse['status'] == 'success') {
      Provider.of<VendorDetailsProvider>(context, listen: false)
          .getVendorDetails();

      Navigator.pop(context);
    } else {
      showSnackBar(editShopInfoProvider.profileUpdateResponse['message']);
    }
  }

  showSnackBar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }
}
