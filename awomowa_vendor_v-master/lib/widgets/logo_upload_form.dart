import 'dart:io';

import 'package:awomowa_vendor/app/theme.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class LogoUploadForm extends StatefulWidget {
  File _shopLogo;

  File get getShopLogo => _shopLogo;
  @override
  _LogoUploadFormState createState() => _LogoUploadFormState();
}

class _LogoUploadFormState extends State<LogoUploadForm> {
  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: InkWell(
          onTap: () {
            pickLogo(context);
          },
          child: Container(
            height: 150.0,
            width: 150.0,
            child: widget._shopLogo == null
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.cloud_upload,
                        color: AppTheme.themeColor,
                        size: 42.0,
                      ),
                      Text(
                        'Upload Logo',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 14.0),
                      ),
                    ],
                  )
                : Image.file(
                    widget._shopLogo,
                    fit: BoxFit.cover,
                  ),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.grey),
            ),
          )),
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

                    widget._shopLogo = await ImageCropper.cropImage(
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
                    widget._shopLogo = File(pickedFile.path);
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
}
