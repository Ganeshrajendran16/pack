import 'package:awomowa/screens/schedule/appointment_provider.dart';
import 'package:awomowa/screens/schedule/select_vendor_screen.dart';
import 'package:awomowa/widgets/TabIndicator.dart';
import 'package:awomowa/widgets/appointments_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppointmentListScreen extends StatefulWidget {
  static const routeName = 'appointmentListScreen';

  @override
  _AppointmentListScreenState createState() => _AppointmentListScreenState();
}

class _AppointmentListScreenState extends State<AppointmentListScreen> {
  @override
  void initState() {
    context.read<AppointmentsProvider>().init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.read<AppointmentsProvider>();
    return Consumer<AppointmentsProvider>(
      builder: (context, providers, child) {
        return DefaultTabController(
          length: 2,
          initialIndex: provider.currentIndex,
          child: Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.pushNamed(context, SelectVendorScreen.routeName);
              },
              child: Icon(Icons.add),
            ),
            appBar: AppBar(
              title: Text('Appointments'),
              bottom: TabBar(
                indicator: CircleTabIndicator(color: Colors.black, radius: 3),
                unselectedLabelColor: Colors.white,
                tabs: <Widget>[
                  Tab(
                    child: Text(
                      'Upcoming',
                    ),
                  ),
                  Tab(
                    child: Text('History'),
                  ),
                ],
              ),
            ),
            body: Selector<AppointmentsProvider, bool>(
              builder: (context, value, child) {
                return value
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : TabBarView(
                        children: [
                          Selector<AppointmentsProvider, bool>(
                              builder: (context, value, child) {
                                return value
                                    ? Center(
                                        child: Text("No Appointment Available"))
                                    : RefreshIndicator(
                                        onRefresh: () async {
                                          provider.init();
                                        },
                                        child: ListView.builder(
                                          itemBuilder: (ctx, index) {
                                            return AppointmentItem(
                                              type: 'upcoming',
                                              bookingHistory: provider
                                                      .bookingHistoryForUpcoming[
                                                  index],
                                              controller:
                                                  provider.reasonContoller,
                                              provider: provider,
                                            );
                                          },
                                          itemCount: provider
                                              .bookingHistoryForUpcoming.length,
                                        ),
                                      );
                              },
                              selector: (context, provider) =>
                                  provider.bookingHistoryForUpcoming.isEmpty),
                          Selector<AppointmentsProvider, bool>(
                              builder: (context, value, child) {
                                return value
                                    ? Center(
                                        child: Text(
                                            "No Appointment History Available"))
                                    : RefreshIndicator(
                                        onRefresh: () async {
                                          provider.init();
                                        },
                                        child: ListView.builder(
                                            itemBuilder: (ctx, index) {
                                              return AppointmentItem(
                                                type: 'history',
                                                bookingHistory: provider
                                                        .bookingHistoryForHistory[
                                                    index],
                                                controller:
                                                    provider.reasonContoller,
                                                provider: provider,
                                              );
                                            },
                                            itemCount: provider
                                                .bookingHistoryForHistory
                                                .length),
                                      );
                              },
                              selector: (context, provider) =>
                                  provider.bookingHistoryForHistory.isEmpty),
                        ],
                      );
              },
              selector: (context, provider) => provider.isLoadingForHistory,
            ),
          ),
        );
      },
    );
  }
}
