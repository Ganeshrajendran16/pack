import 'dart:io';
import 'dart:ui';

import 'package:awomowa/app/theme.dart';
import 'package:awomowa/model/DarkThemeProvider.dart';
import 'package:awomowa/model/EditProfileProvider.dart';
import 'package:awomowa/screens/login_screen.dart';
import 'package:awomowa/utils/SharedPreferences.dart';
import 'package:awomowa/widgets/genderSelector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  static const routeName = "/profile";

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isEditable = false;
  final _formKey = GlobalKey<FormState>();
  final picker = ImagePicker();
  List<bool> selectedGender = [false, false, false];
  SharedPrefManager prefManager = SharedPrefManager();
  String strProfileImg = '';
  TextEditingController nameController = new TextEditingController();
  TextEditingController emailIdController = new TextEditingController();
  TextEditingController mobileNoController = new TextEditingController();
  TextEditingController dateOfBirthController = new TextEditingController();

  fetchUserDetails() async {
    nameController.text = await prefManager.getUsername();
    emailIdController.text = await prefManager.getEmail();
    setGender(await prefManager.getGender());
    mobileNoController.text = await prefManager.getMobile();
    dateOfBirthController.text = await prefManager.getDob();
    strProfileImg = await prefManager.getProfilePic();
    if (strProfileImg.isNotEmpty) {
      isImagePicked = true;
    }
  }

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isLoading = false;
  bool isImagePicked = false;
  File _image;

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      behavior: SnackBarBehavior.floating,
    ));
  }

  void open_gallery(EditProfileProvider editProfileProvider) async {
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
                      fontSize: 14.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    final pickedFile =
                        await picker.getImage(source: ImageSource.gallery);
                    uploadProfilePic(pickedFile, editProfileProvider);
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
                    uploadProfilePic(pickedFile, editProfileProvider);
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

  String _getGender() {
    if (selectedGender[0] == true) {
      return 'Male';
    } else if (selectedGender[1] == true) {
      return 'Female';
    } else if (selectedGender[2] == true) {
      return 'Others';
    }
    return null;
  }

  void setGender(String gender) {
    if (gender == 'Male') {
      selectedGender = [true, false, false];
    } else if (gender == 'Female') {
      selectedGender = [false, true, false];
    } else if (gender == 'Others') {
      selectedGender = [false, false, true];
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    fetchUserDetails();
  }

  void toggleEditing() {
    setState(() {
      isEditable = !isEditable;
    });
  }

  Future<void> uploadProfilePic(
      PickedFile pickedFile, EditProfileProvider editProfileProvider) async {
    await editProfileProvider.updateProfileImg(File(pickedFile.path));

    if (editProfileProvider.profileEditResponse['status'] == 'success') {
      strProfileImg = editProfileProvider
          .profileEditResponse['userInformations']['profileImage'];

      if (strProfileImg.isNotEmpty) {
        setState(() {
          isImagePicked = true;
        });
        prefManager.setProfilePic(strProfileImg);
      }
    } else {
      _showSnackBar(editProfileProvider.profileEditResponse['message']);
    }
  }

  Future<void> updateProfileInfo(
      EditProfileProvider editProfileProvider) async {
    await editProfileProvider.editProfile(
        nameController.text,
        _getGender(),
        dateOfBirthController.text,
        emailIdController.text,
        mobileNoController.text);
    if (editProfileProvider.profileEditResponse['status'] == 'success') {
      prefManager.setUsername(nameController.text);
      prefManager.setGender(_getGender());
      prefManager.setDob(dateOfBirthController.text);
      prefManager.setMobile(mobileNoController.text);
      prefManager.setEmail(emailIdController.text);
      setState(() {
        isEditable = false;
      });
    } else {
      _showSnackBar(editProfileProvider.profileEditResponse['message']);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<EditProfileProvider>(
      builder: (BuildContext context, EditProfileProvider editProfileProvider,
          Widget child) {
        return Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            title: Text('Profile'),
          ),
          floatingActionButton: isEditable
              ? null
              : FloatingActionButton.extended(
                  onPressed: () {
                    toggleEditing();
                  },
                  label: Text('Edit'),
                  icon: Icon(Icons.edit),
                ),
          body: editProfileProvider.isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 24.0,
                        ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Stack(
                                children: [
                                  Center(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.blueAccent,
                                      ),
                                      width: 150.0,
                                      height: 150.0,
                                      child: ClipOval(
                                          child: isImagePicked
                                              ? Image.network(
                                                  strProfileImg,
                                                  fit: BoxFit.cover,
                                                )
                                              : SvgPicture.asset(
                                                  'assets/man_avatar.svg')),
                                    ),
                                  ),
                                  Positioned(
                                      bottom: 16.0,
                                      right: 0.0,
                                      child: InkWell(
                                        onTap: () {
                                          open_gallery(editProfileProvider);
                                        },
                                        child: CircleAvatar(
                                          backgroundColor: Colors.green,
                                          child: Icon(
                                            Icons.add_a_photo_rounded,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ))
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 24.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 32.0,
                              ),
                              LoginFormField(
                                hint: 'Name',
                                prefixIcon: Icons.person,
                                isEnabled: isEditable,
                                controller: nameController,
                                textCapitalization: TextCapitalization.words,
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
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  GenderSelector(
                                    label: 'Male',
                                    icon: Icon(
                                      FontAwesome.mars,
                                      color: Colors.blue,
                                    ),
                                    isSelected: selectedGender[0],
                                    onTap: () =>
                                        isEditable ? setGender('Male') : null,
                                  ),
                                  SizedBox(
                                    width: 16.0,
                                  ),
                                  GenderSelector(
                                    label: 'Female',
                                    icon: Icon(
                                      FontAwesome.venus,
                                      color: Colors.pink,
                                    ),
                                    isSelected: selectedGender[1],
                                    onTap: () =>
                                        isEditable ? setGender('Female') : null,
                                  ),
                                  SizedBox(
                                    width: 16.0,
                                  ),
                                  GenderSelector(
                                    label: 'Others',
                                    icon: Icon(
                                      FontAwesome.transgender,
                                      color: Colors.green,
                                    ),
                                    isSelected: selectedGender[2],
                                    onTap: () =>
                                        isEditable ? setGender('Others') : null,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 24.0,
                              ),
                              LoginFormField(
                                hint: 'Date of birth',
                                isEnabled: isEditable,
                                prefixIcon: FontAwesome.calendar,
                                controller: dateOfBirthController,
                                isDateOfBirth: true,
                                validator: (value) {
                                  return null;
                                },
                              ),
                              SizedBox(
                                height: 24.0,
                              ),
                              LoginFormField(
                                hint: 'Email',
                                isEnabled: isEditable,
                                prefixIcon: Icons.mail_outline,
                                textCapitalization: TextCapitalization.none,
                                inputType: TextInputType.emailAddress,
                                controller: emailIdController,
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
                                height: 24.0,
                              ),
                              LoginFormField(
                                hint: 'Mobile Number',
                                isEnabled: isEditable,
                                prefixIcon: FontAwesome.mobile_phone,
                                controller: mobileNoController,
                                isMobile: true,
                                validator: (value) {
                                  if (value.length < 10) {
                                    return 'Please enter valid mobile number';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(
                                height: 24.0,
                              ),
                            ],
                          ),
                        ),
                        isEditable
                            ? Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: ElevatedButton(
                                        onPressed: () {
                                          if (_formKey.currentState
                                              .validate()) {
                                            updateProfileInfo(
                                                editProfileProvider);
                                          }
                                        },
                                        style: ElevatedButton.styleFrom(
                                            primary: AppTheme.themeColor),
                                        child: Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: Text(
                                            'Update',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 16.0,
                                    ),
                                    Expanded(
                                      child: OutlinedButton(
                                        style: OutlinedButton.styleFrom(
                                            side: BorderSide(
                                                color:
                                                    Provider.of<DarkThemeProvider>(
                                                                context)
                                                            .darkTheme
                                                        ? Colors.white
                                                        : AppTheme.textBlack),
                                            primary: AppTheme.themeColor),
                                        onPressed: () {
                                          toggleEditing();
                                          fetchUserDetails();
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: Text(
                                            'Cancel',
                                            style: TextStyle(
                                              color:
                                                  Provider.of<DarkThemeProvider>(
                                                              context)
                                                          .darkTheme
                                                      ? Colors.white
                                                      : AppTheme.textBlack,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            : SizedBox(),
                      ],
                    ),
                  ),
                ),
        );
      },
    );
  }
}
