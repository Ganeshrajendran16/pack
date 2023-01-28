// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScheduleListResponse _$ScheduleListResponseFromJson(Map<String, dynamic> json) {
  return ScheduleListResponse(
    (json['bookingHistory'] as List)
        ?.map((e) => e == null
            ? null
            : BookingHistory.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['message'] as String,
    json['status'] as String,
    json['responseFor'] as String,
  );
}

BookingHistory _$BookingHistoryFromJson(Map<String, dynamic> json) {
  return BookingHistory(
    bookedDate: json['bookedDate'] as String,
    bookedId: json['bookedId'] as String,
    bookingNo: json['bookingNo'] as String,
    bookingStatus: json['bookingStatus'] as String,
    day: json['day'] as String,
    endDateStrTime: json['endDateStrTime'] as String,
    cancelledBy: json['cancelledBy'] as String,
    endGivenString: json['endGivenString'] as String,
    endTime: json['endTime'] as String,
    cancelReason: json['cancelReason'] as String,
    scheduleId: json['scheduleId'] as String,
    serviceId: json['serviceId'] as String,
    serviceName: json['serviceName'] as String,
    shopName: json['shopName'] as String,
    slotId: json['slotId'] as String,
    stGivenString: json['stGivenString'] as String,
    startDateStrTime: json['startDateStrTime'] as String,
    startTime: json['startTime'] as String,
    storeId: json['storeId'] as String,
  );
}
