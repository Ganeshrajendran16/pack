import 'package:awomowa/screens/schedule/appointment_provider.dart';
import 'package:awomowa/utils/time_utils.dart';
import 'package:awomowa/widgets/drop_down_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../widgets/loader_button.dart';

class ScheduleCalendarScreen extends StatefulWidget {
  static const routeName = '/schedulerCalendarScreen';

  @override
  _ScheduleCalendarScreenState createState() => _ScheduleCalendarScreenState();
}

class _ScheduleCalendarScreenState extends State<ScheduleCalendarScreen> {
  @override
  void initState() {
    context.read<AppointmentsProvider>().getSlotsAndService();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.read<AppointmentsProvider>();

    return Scaffold(
        appBar: AppBar(
          title: Text('Book New Appointment'),
        ),
        body: Selector<AppointmentsProvider, bool>(
          builder: (context, value, child) {
            return value
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : provider.isError
                    ? Center(
                        child:
                            Text("You Cannot Book Appointment For this Vendor"),
                      )
                    : _BuildLayout();
          },
          selector: (context, provider) =>
              provider.isLoadingForCreateAppointmentScreen,
        ));
  }
}

class _BuildLayout extends StatelessWidget {
  const _BuildLayout({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = context.read<AppointmentsProvider>();

    return ListView(
      children: [
        Selector<AppointmentsProvider, DateTime>(
            builder: (context, value, child) {
              return _BuildCalendar();
            },
            selector: (context, provider) => provider.selectedDateTime),
        Container(
          margin: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 16.0,
              ),
              Text(
                'Select Your Slot',
                textAlign: TextAlign.left,
                style: TextStyle(fontWeight: FontWeight.w900, fontSize: 22.0),
              ),
              SizedBox(
                height: 32.0,
              ),
              Selector<AppointmentsProvider, bool>(
                  builder: (context, value, child) {
                    if (value) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      if (provider.slots.isEmpty) {
                        return Center(
                          child: Text("No Slots Available"),
                        );
                      } else {
                        return Selector<AppointmentsProvider, String>(
                            builder: (context, value, child) {
                              return Wrap(
                                  children: List.generate(
                                      provider.slots.length,
                                      (index) => Padding(
                                            padding: const EdgeInsets.only(
                                                right: 8.0),
                                            child: ElevatedButton(
                                                onPressed: () {
                                                  if (provider.slots[index]
                                                          .isAnyAppointment ==
                                                      'no') {
                                                    provider.selectedSlotId =
                                                        provider.slots[index]
                                                            .slotId;
                                                    provider.refresh();
                                                  }
                                                },
                                                style: ElevatedButton.styleFrom(
                                                    primary: provider
                                                                    .selectedSlotId !=
                                                                null &&
                                                            provider
                                                                    .slots[
                                                                        index]
                                                                    .slotId ==
                                                                provider
                                                                    .selectedSlotId
                                                        ? Theme.of(context)
                                                            .primaryColor
                                                        : provider.slots[index]
                                                                    .isAnyAppointment ==
                                                                'no'
                                                            ? Colors.green
                                                            : Colors.red),
                                                child: Text(
                                                  getTime(
                                                      TimeUtils
                                                          .convertTimeofDay(
                                                              provider
                                                                  .slots[index]
                                                                  .startTime),
                                                      TimeUtils
                                                          .convertTimeofDay(
                                                              provider
                                                                  .slots[index]
                                                                  .endTime)),
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )),
                                          )));
                            },
                            selector: (context, provider) =>
                                provider.selectedSlotId);
                      }
                    }
                  },
                  selector: (context, provider) => provider.isLoadingForSlots),
              SizedBox(
                height: 32.0,
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.circle,
                          color: Colors.red,
                        ),
                        Text(' Booked')
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.circle,
                          color: Colors.green,
                        ),
                        Text(' Available')
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.circle,
                          color: Theme.of(context).primaryColor,
                        ),
                        Text(' Selected')
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 14.0,
              ),
              Divider(),
              SizedBox(
                height: 14.0,
              ),
              Text(
                'Select Your Service',
                textAlign: TextAlign.left,
                style: TextStyle(fontWeight: FontWeight.w900, fontSize: 22.0),
              ),
              SizedBox(
                height: 16.0,
              ),
              Selector<AppointmentsProvider, String>(
                  builder: (context, value, child) {
                    return GlobalDropDownButton(
                      prefixIcon: Icons.info,
                      hint: provider.selectedService ?? 'Service',
                      items: provider.serviceProvided
                          .map((e) => e.serviceName)
                          .toList(),
                      onChanged: (int index) {
                        provider.selectedServiceId =
                            provider.serviceProvided[index].serviceId;
                        provider.selectedService =
                            provider.serviceProvided[index].serviceName;
                      },
                      validator: (value) {
                        if (value == null) {
                          return 'Select Valid Unit';
                        }
                        return null;
                      },
                    );
                  },
                  selector: (context, provider) => provider.selectedService),
              SizedBox(
                height: 32.0,
              ),
              LoaderButton(
                btnTxt: 'Book Appointment',
                onPressed: () {
                  provider.createAppointment(context);
                },
              )
            ],
          ),
        )
      ],
    );
  }

  String getTime(TimeOfDay startTime, TimeOfDay endTime) {
    return "${TimeUtils.convertAmPM(TimeUtils.convertHIS(startTime))} - ${TimeUtils.convertAmPM(TimeUtils.convertHIS(endTime))} ";
  }
}

//Calender
class _BuildCalendar extends StatelessWidget {
  _BuildCalendar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = context.read<AppointmentsProvider>();

    return Container(
        height: 100,
        child: ScrollablePositionedList.builder(
            initialScrollIndex: provider.index,
            itemScrollController: provider.scrollContoller,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  provider.datePick(provider.availableDates[index]);
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      border: Border.all(),
                      color: TimeUtils.checkDate(provider.selectedDateTime,
                              actualDate: provider.availableDates[index])
                          ? const Color(0xffFFC324)
                          : Colors.white),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Text(
                            TimeUtils.convertddLLLYYYYDate(
                                    provider.availableDates[index])
                                .split(" ")[1],
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            provider.availableDates[index].day.toString(),
                            style: TextStyle(fontSize: 20, color: Colors.black),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            provider.availableDates[index].year.toString(),
                            style: TextStyle(color: Colors.black),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
            itemCount: provider.availableDates.length));
  }
}
