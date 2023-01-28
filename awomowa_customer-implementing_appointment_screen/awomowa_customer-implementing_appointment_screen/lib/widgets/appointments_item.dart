import 'package:awomowa/responsemodels/appointment/slots/schedule_list_response.dart';
import 'package:awomowa/screens/login_screen.dart';
import 'package:awomowa/screens/schedule/appointment_provider.dart';
import 'package:awomowa/utils/time_utils.dart';
import 'package:awomowa/widgets/common/custom_alert_dialogue.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class AppointmentItem extends StatelessWidget {
  final String type;
  final BookingHistory bookingHistory;
  final AppointmentsProvider provider;
  final TextEditingController controller;

  const AppointmentItem(
      {this.type, this.bookingHistory, this.controller, this.provider});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 32.0,
                        child: Icon(Icons.person),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 16.0,
                  ),
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        bookingHistory.shopName,
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 16.0),
                      ),
                      Text(
                        "${getTime(TimeUtils.convertTimeofDay(bookingHistory.startTime), TimeUtils.convertTimeofDay(bookingHistory.endTime))} | ${TimeUtils.convertddLLLYYYYDate(DateFormat('MM\/dd/yyyy').parse(bookingHistory.bookedDate))}",
                        style: TextStyle(fontSize: 12.0),
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      Text(
                        bookingHistory.serviceName,
                        style: TextStyle(),
                      ),
                      if (type == 'upcoming')
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                              onTap: () {
                                CustomAlertDialog.showdialog(
                                    context: context,
                                    title: "Confirmation Dialog",
                                    type: AlertType.warning,
                                    description:
                                        "Are you sure you want to Cancel this Appointment",
                                    positiveText: "Yes",
                                    content: Container(
                                      margin: const EdgeInsets.only(
                                        top: 10,
                                      ),
                                      child: LoginFormField(
                                        hint: 'Reason',
                                        prefixIcon: Icons.help,
                                        controller: controller,
                                        textCapitalization:
                                            TextCapitalization.none,
                                        validator: (value) {
                                          if (value.length < 5) {
                                            return 'Please Enter Valid Reason';
                                          }

                                          return null;
                                        },
                                      ),
                                    ),
                                    negativeText: "No",
                                    positiveFunction: () {
                                      provider.cancelAppointment(
                                          bookingHistory.bookedId);
                                      Navigator.pop(context);
                                    },
                                    negativeFunction: () {
                                      Navigator.pop(context);
                                    });
                              },
                              child: Container(
                                padding: const EdgeInsets.only(
                                    top: 10, bottom: 10, right: 15, left: 10),
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.red),
                                    borderRadius: BorderRadius.circular(30)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.cancel, color: Colors.red),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "Cancel",
                                      style: TextStyle(color: Colors.red),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )
                    ],
                  ))
                ],
              ),
              Align(
                alignment: Alignment.topRight,
                child: type == 'upcoming'
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Container(
                          padding: EdgeInsets.all(8.0),
                          color: bookingHistory.bookingStatus == 'pending'
                              ? Colors.orange[50]
                              : Colors.green[100],
                          child: Text(
                            toBeginningOfSentenceCase(
                                bookingHistory.bookingStatus),
                            style: TextStyle(
                                color: bookingHistory.bookingStatus == 'pending'
                                    ? Colors.orange
                                    : Colors.green,
                                fontSize: 12.0),
                          ),
                        ),
                      )
                    : GestureDetector(
                        onTap: () {
                          if (bookingHistory.bookingStatus == 'cancelled') {
                            Alert(
                                context: context,
                                title: "Cancel Reason",
                                style: AlertStyle(isButtonVisible: false),
                                content: SizedBox(
                                  height: 300,
                                  width: 300,
                                  child: Container(
                                      margin: const EdgeInsets.all(10),
                                      child: ListTile(
                                        title: Text(
                                            "Reason : ${bookingHistory.cancelReason}"),
                                        subtitle: Text(
                                            "Canceled By : ${bookingHistory.cancelledBy}"),
                                      )),
                                )).show();
                          }
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Container(
                            padding: EdgeInsets.all(8.0),
                            color: bookingHistory.bookingStatus == 'cancelled'
                                ? Colors.red[50]
                                : Colors.green[100],
                            child: Text(
                              toBeginningOfSentenceCase(
                                  bookingHistory.bookingStatus),
                              style: TextStyle(
                                  color: bookingHistory.bookingStatus ==
                                          'cancelled'
                                      ? Colors.red
                                      : Colors.green,
                                  fontSize: 12.0),
                            ),
                          ),
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String getTime(TimeOfDay startTime, TimeOfDay endTime) {
    return "${TimeUtils.convertAmPM(TimeUtils.convertHIS(startTime))} - ${TimeUtils.convertAmPM(TimeUtils.convertHIS(endTime))} ";
  }
}
