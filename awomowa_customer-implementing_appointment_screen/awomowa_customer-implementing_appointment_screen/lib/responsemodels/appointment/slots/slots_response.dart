import 'package:json_annotation/json_annotation.dart';

part 'slots_response.g.dart';

@JsonSerializable(createToJson: false)
class SlotsResponse {
  final String status;
  final String message;
  final List<SlotsGroups> availableGroups;
  SlotsResponse(this.availableGroups, this.message, this.status);

  factory SlotsResponse.fromJson(Map<String, dynamic> map) =>
      _$SlotsResponseFromJson(map);
}

@JsonSerializable(createToJson: false)
class SlotsGroups {
  final String groupId;
  final String vendorId;
  final String groupName;
  final String status;
  final String createdAt;
  final String updatedAt;
  final List<Slots> availSlots;

  SlotsGroups(this.availSlots, this.createdAt, this.groupId, this.groupName,
      this.status, this.updatedAt, this.vendorId);

  factory SlotsGroups.fromJson(Map<String, dynamic> map) =>
      _$SlotsGroupsFromJson(map);
}

@JsonSerializable(createToJson: false)
class Slots {
  final String slotId;
  final String startTime;
  final String endTime;
  final String duration;
  final String startDateStrTime;
  final String endDateStrTime;
  final String stGivenString;
  final String endGivenString;
  final String status;
  final String createdAt;
  final String updatedAt;
  final String isAnyAppointment;
  final BookingDetails bookingDetails;

  Slots(
      this.createdAt,
      this.duration,
      this.endDateStrTime,
      this.endGivenString,
      this.endTime,
      this.slotId,
      this.stGivenString,
      this.bookingDetails,
      this.isAnyAppointment,
      this.startDateStrTime,
      this.startTime,
      this.status,
      this.updatedAt);

  factory Slots.fromJson(Map<String, dynamic> map) => _$SlotsFromJson(map);
}

@JsonSerializable(createToJson: false)
class BookingDetails {
  final String customerName;
  final String serviceName;

  BookingDetails(this.customerName, this.serviceName);

  factory BookingDetails.fromJson(Map<String, dynamic> map) =>
      _$BookingDetailsFromJson(map);
}
