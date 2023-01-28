import 'dart:io';

import 'package:awomowa_vendor/app/theme.dart';
import 'package:awomowa_vendor/providers/AddNewOfferProvider.dart';
import 'package:awomowa_vendor/providers/UpdateListProvider.dart';
import 'package:awomowa_vendor/screens/error_screen.dart';
import 'package:awomowa_vendor/screens/publish_success_screen.dart';
import 'package:awomowa_vendor/widgets/form_field.dart';
import 'package:awomowa_vendor/widgets/loader_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class PublishUpdate extends StatefulWidget {
  const PublishUpdate({Key key}) : super(key: key);

  @override
  _PublishUpdateState createState() => _PublishUpdateState();
}

class _PublishUpdateState extends State<PublishUpdate> {
  File _productImage;
  final picker = ImagePicker();
  final TextEditingController descriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  showSnackBar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AddNewOfferProvider>(
      builder: (BuildContext context, AddNewOfferProvider addNewOfferProvider,
          Widget child) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
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
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        FontAwesome.cloud_upload,
                                        color: AppTheme.themeColor,
                                        size: 42.0,
                                      ),
                                      Text(
                                        'Upload Image',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14.0),
                                      ),
                                    ],
                                  ),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(8.0)),
                          ))),
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
                  LoaderButton(
                    btnTxt: 'Publish Update',
                    isLoading: addNewOfferProvider.isLoading,
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        publishUpdate(addNewOfferProvider);
                      }
                    },
                  ),
                ],
              ),
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
                  title: Text(
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
                    title: Text(
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

  void publishUpdate(AddNewOfferProvider addNewOfferProvider) async {
    await addNewOfferProvider.addNewUpdate(
        descriptionController.text, _productImage);

    if (addNewOfferProvider.isError) {
      Navigator.pushNamed(context, NoInternet.routeName);
      return;
    }

    if (addNewOfferProvider.addNewUpdateResponse['status'] == 'success') {
      Provider.of<UpdateListProvider>(context, listen: false).getUpdates();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PublishSuccessScreen(
            isUpdate: true,
          ),
        ),
      );
    } else {
      showSnackBar(addNewOfferProvider.addNewUpdateResponse['message']);
    }
  }
}
