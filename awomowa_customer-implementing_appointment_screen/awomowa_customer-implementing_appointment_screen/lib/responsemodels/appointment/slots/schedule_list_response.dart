import 'package:json_annotation/json_annotation.dart';

part 'schedule_list_response.g.dart';

@JsonSerializable(createToJson: false)
class ScheduleListResponse {
  final String status;
  final String message;
  final String responseFor;

  final List<BookingHistory> bookingHistory;
  ScheduleListResponse(this.bookingHistory, this.message, this.status,this.responseFor);

  factory ScheduleListResponse.fromJson(Map<String, dynamic> map) =>
      _$ScheduleListResponseFromJson(map);
}

@JsonSerializable(createToJson: false)
class BookingHistory {
  final String bookedId;
  final String bookingNo;
  final String storeId;
  final String scheduleId;
  final String slotId;
  final String serviceId;
  final String bookingStatus;
  final String cancelReason;
  final String cancelledBy;

  final String shopName;
  final String serviceName;
  final String day;
  final String bookedDate;

  final String startTime;
  final String endTime;
  final String startDateStrTime;
  final String endDateStrTime;
  final String stGivenString;
  final String endGivenString;

  BookingHistory(
      {this.bookedDate,
      this.bookedId,
      this.bookingNo,
      this.bookingStatus,
      this.day,
      this.endDateStrTime,
      this.cancelledBy,
      this.endGivenString,
      this.endTime,
      this.cancelReason,
      this.scheduleId,
      this.serviceId,
      this.serviceName,
      this.shopName,
      this.slotId,
      this.stGivenString,
      this.startDateStrTime,
      this.startTime,
      this.storeId});

  factory BookingHistory.fromJson(Map<String, dynamic> map) =>
      _$BookingHistoryFromJson(map);
}
