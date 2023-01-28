import 'package:awomowa/connection/repository/appointment_repository.dart';
import 'package:awomowa/responsemodels/appointment/calendar/calendar_response.dart';
import 'package:awomowa/responsemodels/appointment/service/service_response.dart';
import 'package:awomowa/responsemodels/appointment/slots/schedule_list_response.dart';
import 'package:awomowa/responsemodels/appointment/slots/slots_response.dart';
import 'package:awomowa/responsemodels/offer_list_response_model.dart';
import 'package:awomowa/utils/app_utils.dart';
import 'package:awomowa/utils/time_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class AppointmentsProvider extends ChangeNotifier {
  bool isLoading = false;
  bool isLoadingForCreateAppointmentScreen = false;
  DateTime selectedDateTime = DateTime.now();
  List<StoreList> storeList = [];
  bool isError = false;
  bool isLoadingForHistory = false;
  final List<DateTime> availableDates = [];
  final List<BookingHistory> bookingHistoryForUpcoming = [];
  final reasonContoller = TextEditingController();
  final List<BookingHistory> bookingHistoryForHistory = [];
  int index;
  final scrollContoller = ItemScrollController();
  bool isLoadingForSlots = false;
  int currentIndex = 0;
  final List<Slots> slots = [];
  List<Service> serviceProvided = [];
  String selectedSlotId;
  String selectedServiceId;
  String selectedService;

  String selectedVender;

  //Initial

  Future<void> init() async {
    isLoadingForHistory = true;
    reasonContoller.clear();
    bookingHistoryForHistory.clear();
    bookingHistoryForUpcoming.clear();
    final baseResponse = await Future.wait([
      AppointmentRepository.getUserScheduleHistory(),
      AppointmentRepository.getUserUpcomingSchedules()
    ]);

    for (final response in baseResponse) {
      if (response is ScheduleListResponse) {
        if (response.status == 'success' && response.responseFor == "history") {
          bookingHistoryForHistory.addAll(response.bookingHistory);
          notifyListeners();
        } else if (response.status == 'success' &&
            response.responseFor == "upcoming") {
          bookingHistoryForUpcoming.addAll(response.bookingHistory);
          isLoadingForHistory = false;
          notifyListeners();
        } else {
          isLoadingForHistory = false;
          AppUtils.showToast(response.message, color: Colors.red);
          notifyListeners();
        }
      }
    }
  }

  //Vendor List
  Future<void> getAllVendors() async {
    isLoading = true;
    isError = false;
    storeList.clear();
    selectedVender = null;
    final response = await AppointmentRepository.getAllVendor();
    if (response.status == 'success') {
      storeList.addAll(response.storeList);
      isLoading = false;
      notifyListeners();
    } else {
      isLoading = false;
      AppUtils.showToast(response.message, color: Colors.red);
      notifyListeners();
    }
  }

  //Get All Details For Store

  Future<void> getSlotsAndService() async {
    isLoadingForCreateAppointmentScreen = true;
    selectedService = null;
    selectedServiceId = null;
    isLoadingForSlots = false;
    isError = false;
    selectedDateTime = DateTime.now();
    selectedSlotId = null;
    serviceProvided.clear();
    availableDates.clear();
    slots.clear();
    final baseResponse = await Future.wait([
      AppointmentRepository.getAvailabeleSlotsBasedOnDateForStore(
          selectedDateTime, selectedVender),
      AppointmentRepository.getAvailableServicesForStore(selectedVender),
      AppointmentRepository.getAvailabelDates(selectedVender)
    ]);

    for (final response in baseResponse) {
      if (response is CalenderResponse) {
        if (response.status == 'success') {
          slots.addAll(response.slotTimings);
        } else {
          isLoadingForCreateAppointmentScreen = false;
          AppUtils.showToast(response.message, color: Colors.red);
          notifyListeners();
        }
      }
      if (response is CalenderAvailableDatesResponse) {
        if (response.status == 'success') {
          for (final item in response.dateList) {
            availableDates.add(DateFormat('MM\/dd/yyyy').parse(item));
          }

          index = availableDates.indexWhere((element) =>
              TimeUtils.checkDate(selectedDateTime, actualDate: element));
          notifyListeners();
        } else {
          isError = true;

          isLoadingForCreateAppointmentScreen = false;
          AppUtils.showToast(response.message, color: Colors.red);
          notifyListeners();
        }
      }
      if (response is ServiceResponse) {
        if (response.status == 'success') {
          serviceProvided.addAll(response.availableServices);
          isLoadingForCreateAppointmentScreen = false;
          notifyListeners();
        } else {
          isError = true;
          isLoadingForCreateAppointmentScreen = false;
          AppUtils.showToast(response.message, color: Colors.red);
          notifyListeners();
        }
      }
    }
  }

//Create Appointment
  Future<void> createAppointment(BuildContext context) async {
    if (selectedSlotId == null) {
      AppUtils.showToast("Select a Slot", color: Colors.red);
      return;
    }
    if (selectedServiceId == null) {
      AppUtils.showToast("Select a Service", color: Colors.red);
      return;
    }
    final response = await AppointmentRepository.createAppointment(
        serviceId: selectedServiceId,
        slotId: selectedSlotId,
        storeId: selectedVender);
    if (response.status == 'success') {
      AppUtils.showToast(response.message);
      Navigator.pop(context);
      Navigator.pop(context);
      init();
      notifyListeners();
    } else {
      isLoading = false;
      AppUtils.showToast(response.message, color: Colors.red);

      notifyListeners();
    }
  }

  //Date Pick
  Future<void> datePick(DateTime dateTime) async {
    isLoadingForSlots = true;
    notifyListeners();

    selectedDateTime = dateTime;
    slots.clear();
    final response =
        await AppointmentRepository.getAvailabeleSlotsBasedOnDateForStore(
            dateTime, selectedVender);
    if (response.status == 'success') {
      slots.addAll(response.slotTimings);
      notifyListeners();
      isLoadingForSlots = false;
    } else {
      isLoadingForSlots = false;
      AppUtils.showToast(response.message, color: Colors.red);
      notifyListeners();
    }
  }

  void refresh() {
    notifyListeners();
  }

  //Cancel Schedule

  Future<void> cancelAppointment(String bookedID) async {
    if (reasonContoller.text.isEmpty) {
      AppUtils.showToast("Reason is Required", color: Colors.red);
      return;
    }
    final response = await AppointmentRepository.cancelAppointment(
        bookedId: bookedID, reason: reasonContoller.text);
    if (response.status == 'success') {
      AppUtils.showToast(response.message);
      init();
      notifyListeners();
    } else {
      isLoadingForSlots = false;
      AppUtils.showToast(response.message, color: Colors.red);
      notifyListeners();
    }
  }
}
