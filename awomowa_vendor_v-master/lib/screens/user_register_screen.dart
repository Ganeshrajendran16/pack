import 'package:awomowa_vendor/app/theme.dart';
import 'package:awomowa_vendor/providers/UserDetailsProvider.dart';
import 'package:awomowa_vendor/providers/VendorDetailsProvider.dart';
import 'package:awomowa_vendor/screens/error_screen.dart';
import 'package:awomowa_vendor/screens/shop_details_screen.dart';
import 'package:awomowa_vendor/utils/SharedPreferences.dart';
import 'package:awomowa_vendor/widgets/drop_down_button.dart';
import 'package:awomowa_vendor/widgets/form_field.dart';
import 'package:awomowa_vendor/widgets/loader_button.dart';
import 'package:awomowa_vendor/widgets/login_screen_bg.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserDetailsScreen extends StatefulWidget {
  static const routeName = 'userDetailsCapture';
  @override
  _UserDetailsScreenState createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController addressLine1Controller = TextEditingController();
  final TextEditingController addressLine2Controller = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController pinCodeController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  int selectedCountryPosition;
  TimeOfDay mondayStart, mondayEnd;
  TimeOfDay tuesdayStart, tuesdayEnd;
  TimeOfDay wednesdayStart, wednesdayEnd;
  TimeOfDay thursdayStart, thursdayEnd;
  TimeOfDay fridayStart, fridayEnd;
  TimeOfDay saturdayStart, saturdayEnd;
  TimeOfDay sundayStart, sundayEnd;
  showSnackBar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  bool isShopMobileUsed = false, isShopEmailUsed = false;
  SharedPrefManager prefManger = SharedPrefManager();
  @override
  Widget build(BuildContext context) {
    return Consumer<UserDetailsProvider>(
      builder: (BuildContext context, UserDetailsProvider userDetailsProvider,
          Widget child) {
        return Scaffold(
          body: Provider.of<VendorDetailsProvider>(context, listen: true)
                  .isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.2,
                        color: AppTheme.themeColor,
                        child: Stack(
                          children: [
                            LoginScreenBg(),
                            Container(
                              height: MediaQuery.of(context).size.height * 0.2,
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Spacer(),
                                    FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text(
                                        'Complete your App Profile',
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
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
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
                                  height: 32.0,
                                ),
                                GlobalFormField(
                                    hint: 'Address Line 1',
                                    prefixIcon: Icons.credit_card,
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
                                    controller: addressLine2Controller,
                                    textCapitalization:
                                        TextCapitalization.words,
                                    validator: (value) {
                                      return null;
                                    }),
                                SizedBox(
                                  height: 16.0,
                                ),
                                GlobalDropDownButton(
                                  prefixIcon: Icons.person_pin_circle,
                                  hint: 'Country',
                                  items:
                                      userDetailsProvider.countriesResponse !=
                                              null
                                          ? userDetailsProvider
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
                                    hint: 'City',
                                    prefixIcon: Icons.location_city,
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
                                    hint: userDetailsProvider
                                                    .countriesResponse !=
                                                null &&
                                            selectedCountryPosition != null
                                        ? userDetailsProvider
                                            .countriesResponse
                                            .countries[selectedCountryPosition]
                                            .pincodeLabel
                                        : 'Zip/Postal Code',
                                    prefixIcon: Icons.power_input_sharp,
                                    isEnabled: selectedCountryPosition != null,
                                    inputType: userDetailsProvider
                                                    .countriesResponse !=
                                                null &&
                                            selectedCountryPosition != null
                                        ? userDetailsProvider
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
                                      Pattern pattern = userDetailsProvider
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
                                GlobalFormField(
                                    prefixIcon: Icons.info,
                                    hint: 'Description',
                                    isMultiLine: true,
                                    controller: descriptionController,
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Enter Valid Description';
                                      }
                                      return null;
                                    }),
                                SizedBox(
                                  height: 32.0,
                                ),
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
                                  absorbing: false,
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
                                                      ? 'Choose'
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
                                                      ? 'Choose'
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
                                                      ? 'Choose'
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
                                                      ? 'Choose'
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
                                                      ? 'Choose'
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
                                                      ? 'Choose'
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
                                                      ? 'Choose'
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
                                                      ? 'Choose'
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
                                                      ? 'Choose'
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
                                                      ? 'Choose'
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
                                                      ? 'Choose'
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
                                                      ? 'Choose'
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
                                                      ? 'Choose'
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
                                                      ? 'Choose'
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
                                  controller: mobileController,
                                  isEnabled: !isShopMobileUsed,
                                  validator: (value) {
                                    if (value.length < 10) {
                                      return 'Enter Valid Mobile Number';
                                    }
                                    return null;
                                  },
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Checkbox(
                                        value: isShopMobileUsed,
                                        onChanged: (value) async {
                                          isShopMobileUsed = !isShopMobileUsed;

                                          if (isShopMobileUsed) {
                                            mobileController.text =
                                                await prefManger.getMobile();
                                          } else {
                                            mobileController.text = '';
                                          }
                                          setState(() {});
                                        }),
                                    Text('Use Shop Mobile Number'),
                                  ],
                                ),
                                SizedBox(
                                  height: 16.0,
                                ),
                                GlobalFormField(
                                  hint: 'Email',
                                  prefixIcon: Icons.mail,
                                  controller: emailController,
                                  inputType: TextInputType.emailAddress,
                                  textCapitalization: TextCapitalization.none,
                                  isEnabled: !isShopEmailUsed,
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
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Checkbox(
                                        value: isShopEmailUsed,
                                        onChanged: (value) async {
                                          isShopEmailUsed = !isShopEmailUsed;

                                          if (isShopEmailUsed) {
                                            emailController.text =
                                                await prefManger.getEmail();
                                          } else {
                                            emailController.text = '';
                                          }
                                          setState(() {});
                                        }),
                                    Text('Use Shop Email'),
                                  ],
                                ),
                                SizedBox(
                                  height: 16.0,
                                ),
                                SizedBox(
                                  height: 48.0,
                                ),
                                Column(
                                  children: [
                                    LoaderButton(
                                      btnTxt: 'Proceed',
                                      isLoading: userDetailsProvider.isLoading,
                                      onPressed: () {
                                        if (_formKey.currentState.validate()) {
                                          submitUserDetails(
                                              userDetailsProvider);
                                        } else {
                                          showSnackBar('Enter Valid Details !');
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
        );
      },
    );
  }

  void submitUserDetails(UserDetailsProvider userDetailsProvider) async {
    Map<String, dynamic> shopTiming = Map();

    shopTiming['monday'] = {
      'fromTime': mondayStart == null
          ? 'Choose'
          : mondayStart.format(context) ?? 'Choose',
      'toTime':
          mondayEnd == null ? 'Choose' : mondayEnd.format(context) ?? 'Choose'
    };

    shopTiming['tuesday'] = {
      'fromTime': tuesdayStart == null
          ? 'Choose'
          : tuesdayStart.format(context) ?? 'Choose',
      'toTime':
          tuesdayEnd == null ? 'Choose' : tuesdayEnd.format(context) ?? 'Choose'
    };

    shopTiming['wednesday'] = {
      'fromTime': wednesdayStart == null
          ? 'Choose'
          : wednesdayStart.format(context) ?? 'Choose',
      'toTime': wednesdayEnd == null
          ? 'Choose'
          : wednesdayEnd.format(context) ?? 'Choose'
    };

    shopTiming['thursday'] = {
      'fromTime': thursdayStart == null
          ? 'Choose'
          : thursdayStart.format(context) ?? 'Choose',
      'toTime': thursdayEnd == null
          ? 'Choose'
          : thursdayEnd.format(context) ?? 'Choose'
    };

    shopTiming['friday'] = {
      'fromTime': fridayStart == null
          ? 'Choose'
          : fridayStart.format(context) ?? 'Choose',
      'toTime':
          fridayEnd == null ? 'Choose' : fridayEnd.format(context) ?? 'Choose'
    };

    shopTiming['saturday'] = {
      'fromTime': saturdayStart == null
          ? 'Choose'
          : saturdayStart.format(context) ?? 'Choose',
      'toTime': saturdayEnd == null
          ? 'Choose'
          : saturdayEnd.format(context) ?? 'Choose'
    };

    shopTiming['sunday'] = {
      'fromTime': sundayStart == null
          ? 'Choose'
          : sundayStart.format(context) ?? 'Choose',
      'toTime':
          sundayEnd == null ? 'Choose' : sundayEnd.format(context) ?? 'Choose'
    };

    await userDetailsProvider.submitDetails(
        nameController.text,
        mobileController.text,
        emailController.text,
        addressLine1Controller.text,
        addressLine2Controller.text ?? '',
        pinCodeController.text,
        cityController.text,
        userDetailsProvider
            .countriesResponse.countries[selectedCountryPosition].id,
        descriptionController.text,
        shopTiming);

    if (userDetailsProvider.isError) {
      Navigator.pushNamed(context, NoInternet.routeName);
      return;
    }

    if (userDetailsProvider.userDetailsSubmitResponse['status'] == 'success') {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ShopDetails(
              isFromSettings: false,
            ),
          ));
    } else {
      showSnackBar(userDetailsProvider.userDetailsSubmitResponse['message']);
    }
  }
}
