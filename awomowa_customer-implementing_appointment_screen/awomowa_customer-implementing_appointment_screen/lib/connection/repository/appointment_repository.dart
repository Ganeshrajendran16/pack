import 'package:awomowa/connection/api_urls.dart';
import 'package:awomowa/connection/repository.dart';
import 'package:awomowa/responsemodels/appointment/calendar/calendar_response.dart';
import 'package:awomowa/responsemodels/appointment/generic/generic_response.dart';
import 'package:awomowa/responsemodels/appointment/service/service_response.dart';
import 'package:awomowa/responsemodels/appointment/slots/schedule_list_response.dart';
import 'package:awomowa/responsemodels/offer_list_response_model.dart';
import 'package:awomowa/utils/time_utils.dart';

class AppointmentRepository {
  const AppointmentRepository._();

  //Get All Vendor
  static Future<OfferListResponse> getAllVendor() async {
    final response =
        await loadApi(apiUrl: SHOPS, params: {"apiMethod": "userStoreList"});
    final OfferListResponse getAllVenderResponse =
        OfferListResponse.fromJson(response as Map<String, dynamic>);
    return getAllVenderResponse;
  }

  //Get Availabele Slots Base on Date For Store
  static Future<CalenderResponse> getAvailabeleSlotsBasedOnDateForStore(
      DateTime date, String storeId) async {
    final response = await loadApi(apiUrl: SHOPS_SCHEDULE, params: {
      "apiMethod": "sheduleShopSlotDetails",
      "selectedDate": TimeUtils.converttoAPIdateFormat(date),
      "storeId": storeId,
      "customercurrenttime":DateTime.now().toString(),
      "Customertimezone":DateTime.now().timeZoneName

    });
    final CalenderResponse calendarResponse =
        CalenderResponse.fromJson(response as Map<String, dynamic>);
    return calendarResponse;
  }

  //Get Availabe Service For Store
  static Future<ServiceResponse> getAvailableServicesForStore(
      String storeId) async {
    final response = await loadApi(
        apiUrl: SHOP_SERVICE,
        params: {"apiMethod": "serviceList", "storeId": storeId});
    final ServiceResponse serviceResponse =
        ServiceResponse.fromJson(response as Map<String, dynamic>);
    return serviceResponse;
  }

  //Create  Appointment
  static Future<GenericResponse> createAppointment(
     { String slotId, String serviceId,String storeId}) async {
    final response = await loadApi(apiUrl: CREATE_APPOINTMENT, params: {
      "apiMethod": "createAppointment",
      "slotId": slotId,
      "storeId":storeId,
      "serviceId": serviceId
    });
    final GenericResponse genericResponse =
        GenericResponse.fromJson(response as Map<String, dynamic>);
    return genericResponse;
  }

   //Available Dates
  static Future<CalenderAvailableDatesResponse> getAvailabelDates(String storeId) async {
    final response = await loadApi(apiUrl: AVAILABLE_DATES, params: {
      "apiMethod": "dateList",
      "storeId":storeId,
      
    });
    final CalenderAvailableDatesResponse availableDatesResponse =
        CalenderAvailableDatesResponse.fromJson(
            response as Map<String, dynamic>);
    return availableDatesResponse;
  }

  //History Appointments

  static Future<ScheduleListResponse> getUserScheduleHistory() async {
    final response = await loadApi(apiUrl: SCHEDULE_LIST, params: {
      "apiMethod": "userScheduleHistory",
    });


    final ScheduleListResponse scheduleListResponse =
        ScheduleListResponse.fromJson(
            response as Map<String, dynamic>);
    return scheduleListResponse;
  }

  //Upcoming Appointments
 static Future<ScheduleListResponse> getUserUpcomingSchedules() async {
    final response = await loadApi(apiUrl: SCHEDULE_LIST, params: {
      "apiMethod": "userUpcomingSchedules",
    });
    final ScheduleListResponse scheduleListResponse =
        ScheduleListResponse.fromJson(
            response as Map<String, dynamic>);
    return scheduleListResponse;
  }

   //Cancel Appointments
 static Future<ScheduleListResponse> cancelAppointment({String reason,String bookedId}) async {
    final response = await loadApi(apiUrl: CANCEL_APPOINTMENT, params: {
      "apiMethod": "userBookingCancel",
      "bookedId":bookedId,
      "cancelReason":reason
    });
    final ScheduleListResponse scheduleListResponse =
        ScheduleListResponse.fromJson(
            response as Map<String, dynamic>);
    return scheduleListResponse;
  }
}
