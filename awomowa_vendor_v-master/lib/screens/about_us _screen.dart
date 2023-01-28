import 'package:awomowa_vendor/providers/AboutUsProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class AboutUs extends StatefulWidget {
  static const routeName = 'aboutus';
  @override
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AboutUsProvider>(
      builder: (BuildContext context, AboutUsProvider aboutUsProvider,
          Widget child) {
        return Scaffold(
          appBar: AppBar(
            title: Text('About Us'),
          ),
          body: aboutUsProvider.isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 24.0,
                        ),
                        Text(
                          'Contact Us',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 24.0),
                        ),
                        SizedBox(
                          height: 16.0,
                        ),
                        Text(
                          '${aboutUsProvider.aboutUsResponse.appContent.contactUs}',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 16.0,
                              color: Colors.grey),
                        ),
                        Divider(
                          height: 48.0,
                        ),
                        AboutUsItem(
                          iconBgColor: Colors.yellow.withOpacity(0.2),
                          icon: SvgPicture.asset(
                            'assets/email.svg',
                            width: 24.0,
                          ),
                          title: 'Email Address',
                          subtitle:
                              '${aboutUsProvider.aboutUsResponse.appContent.emailDescription}',
                          contactTxt:
                              '${aboutUsProvider.aboutUsResponse.appContent.email}',
                        ),
                        AboutUsItem(
                            iconBgColor: Colors.pink.withOpacity(0.2),
                            icon: SvgPicture.asset(
                              'assets/telephone.svg',
                              width: 24.0,
                            ),
                            title: 'Telephone Number',
                            subtitle:
                                '${aboutUsProvider.aboutUsResponse.appContent.contactDescription}',
                            contactTxt:
                                '${aboutUsProvider.aboutUsResponse.appContent.contact}'),
                        AboutUsItem(
                            iconBgColor: Colors.green.withOpacity(0.2),
                            icon: SvgPicture.asset(
                              'assets/website.svg',
                              width: 24.0,
                            ),
                            title: 'Website',
                            subtitle:
                                '${aboutUsProvider.aboutUsResponse.appContent.websiteDescription}',
                            contactTxt:
                                '${aboutUsProvider.aboutUsResponse.appContent.website}'),
                        AboutUsItem(
                            iconBgColor: Colors.blue.withOpacity(0.2),
                            icon: SvgPicture.asset(
                              'assets/officeaddress.svg',
                              width: 24.0,
                            ),
                            title: 'Contact Address',
                            subtitle:
                                '${aboutUsProvider.aboutUsResponse.appContent.addressDescription}',
                            contactTxt:
                                '${aboutUsProvider.aboutUsResponse.appContent.address}'),
                      ],
                    ),
                  ),
                ),
        );
      },
    );
  }
}

class AboutUsItem extends StatelessWidget {
  final Color iconBgColor;
  final Widget icon;
  final String title;
  final String subtitle;

  final String contactTxt;

  const AboutUsItem(
      {this.iconBgColor,
      this.icon,
      this.title,
      this.subtitle,
      this.contactTxt});

  @override
  Widget build(BuildContext context) {
    return contactTxt != null && contactTxt.isNotEmpty
        ? Column(
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 22.0, horizontal: 10.0),
                  child: Container(
                    width: double.infinity,
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: iconBgColor,
                              borderRadius: BorderRadius.circular(14.0)),
                          child: Padding(
                              padding: EdgeInsets.all(12.0), child: icon),
                        ),
                        SizedBox(
                          height: 16.0,
                        ),
                        Text(
                          title,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 16.0),
                        ),
                        SizedBox(
                          height: 8.0,
                        ),
                        Text(
                          subtitle,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 16.0,
                              color: Colors.grey),
                        ),
                        SizedBox(
                          height: 12.0,
                        ),
                        SelectableText(
                          contactTxt,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 16.0,
                              color: Color(0xff006BFF)),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Divider(
                height: 32.0,
              ),
            ],
          )
        : SizedBox();
  }
}
