import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AboutUs extends StatefulWidget {
  static const routeName = 'aboutus';
  @override
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Us'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              Card(
                color: Colors.black,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: Stack(
                    children: [
                      Positioned.fill(
                          child: Container(
                        decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [
                          Color(0xff006BFF),
                          Color(0x4D006BFF)
                        ])),
                      )),
                      ListTile(
                          trailing: Container(
                            width: 50.0,
                            height: 50.0,
                            color: Colors.white,
                            child: Placeholder(),
                          ),
                          title: Text(
                            'Headlines TV',
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.white),
                          ),
                          subtitle: Text('Version - 1.00',
                              style: TextStyle(
                                color: Colors.white70,
                              ))),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 24.0,
              ),
              Text(
                'Contact Us',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 24.0),
              ),
              SizedBox(
                height: 16.0,
              ),
              Text(
                'Got a special request, need more information or you simply want to talk? Reach out to us and we\'ll respond as soon as possible.',
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
                      'For project inquiries, send us an email via the email address below',
                  contactTxt: 'sale@istrides.in'),
              Divider(
                height: 24.0,
              ),
              AboutUsItem(
                  iconBgColor: Colors.pink.withOpacity(0.2),
                  icon: SvgPicture.asset(
                    'assets/telephone.svg',
                    width: 24.0,
                  ),
                  title: 'Telephone Number',
                  subtitle:
                      'For voice conversation, call us on given number below',
                  contactTxt: '+91 9876543210'),
              Divider(
                height: 32.0,
              ),
              AboutUsItem(
                  iconBgColor: Colors.green.withOpacity(0.2),
                  icon: SvgPicture.asset(
                    'assets/website.svg',
                    width: 24.0,
                  ),
                  title: 'Website',
                  subtitle:
                      'To know about our works and clients, visit us on the website given below.',
                  contactTxt: 'www.istrides.in'),
              Divider(
                height: 32.0,
              ),
              AboutUsItem(
                  iconBgColor: Colors.blue.withOpacity(0.2),
                  icon: SvgPicture.asset(
                    'assets/officeaddress.svg',
                    width: 24.0,
                  ),
                  title: 'Contact Address',
                  subtitle:
                      'For direct inquiries, visit at us at our office address given below',
                  contactTxt:
                      'Mount Road, Vasan Ave, Anna Salai, Thousand Lights, Chennai, Tamil Nadu 600002'),
            ],
          ),
        ),
      ),
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
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 22.0, horizontal: 10.0),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: iconBgColor,
                  borderRadius: BorderRadius.circular(14.0)),
              child: Padding(padding: EdgeInsets.all(12.0), child: icon),
            ),
            SizedBox(
              height: 16.0,
            ),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16.0),
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
    );
  }
}
