import 'package:awomowa/model/DarkThemeProvider.dart';
import 'package:awomowa/screens/schedule/appointment_provider.dart';
import 'package:awomowa/screens/schedule_calendar_screen.dart';
import 'package:awomowa/widgets/offers_grid_item.dart';
import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';
import 'package:provider/provider.dart';

class SelectVendorScreen extends StatefulWidget {
  static const routeName = 'selectVenderScreen';

  const SelectVendorScreen({Key key}) : super(key: key);

  @override
  _SelectVendorScreenState createState() => _SelectVendorScreenState();
}

class _SelectVendorScreenState extends State<SelectVendorScreen> {
  @override
  void initState() {
    context.read<AppointmentsProvider>().getAllVendors();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.read<AppointmentsProvider>();
    final darkThemeProvider = context.read<DarkThemeProvider>();
    return Scaffold(
      appBar: AppBar(
        title: Container(),
      ),
      body: IntroSlider(
        showSkipBtn: true,
        hideStatusBar: false,
        onSkipPress: () {
          Navigator.pop(context);
        },
        renderSkipBtn: Text(
          "Back",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        slides: [
          Slide(
            title: "Select Vendor",
            maxLineTitle: 2,
            styleTitle: TextStyle(
                color:
                    darkThemeProvider.darkTheme ? Colors.white : Colors.black,
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'RobotoMono'),
            marginDescription: EdgeInsets.only(
                left: 20.0, right: 20.0, top: 20.0, bottom: 70.0),
            centerWidget: Selector<AppointmentsProvider, bool>(
              builder: (context, value, child) {
                return value
                    ? CircularProgressIndicator()
                    : GridView.builder(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        itemCount: provider.storeList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return OffersGridItem(
                            onTapForAppintment: (id) {
                              provider.selectedVender = id;
                              Navigator.pushNamed(
                                  context, ScheduleCalendarScreen.routeName);
                            },
                            isForAppointment: true,
                            offerStores: provider.storeList[index],
                          );
                        },
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3),
                      );
              },
              selector: (context, provider) => provider.isLoading,
            ),
            backgroundColor:
                darkThemeProvider.darkTheme ? Colors.black : Color(0xfff5a623),
          ),
        ],
        showDotIndicator: false,
        showDoneBtn: false,
      ),
    );
  }
}
