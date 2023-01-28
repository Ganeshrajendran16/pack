// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'slots_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SlotsResponse _$SlotsResponseFromJson(Map<String, dynamic> json) {
  return SlotsResponse(
    (json['availableGroups'] as List)
        ?.map((e) =>
            e == null ? null : SlotsGroups.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['message'] as String,
    json['status'] as String,
  );
}

SlotsGroups _$SlotsGroupsFromJson(Map<String, dynamic> json) {
  return SlotsGroups(
    (json['availSlots'] as List)
        ?.map(
            (e) => e == null ? null : Slots.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['createdAt'] as String,
    json['groupId'] as String,
    json['groupName'] as String,
    json['status'] as String,
    json['updatedAt'] as String,
    json['vendorId'] as String,
  );
}

Slots _$SlotsFromJson(Map<String, dynamic> json) {
  return Slots(
    json['createdAt'] as String,
    json['duration'] as String,
    json['endDateStrTime'] as String,
    json['endGivenString'] as String,
    json['endTime'] as String,
    json['slotId'] as String,
    json['stGivenString'] as String,
    json['bookingDetails'] == null
        ? null
        : BookingDetails.fromJson(
            json['bookingDetails'] as Map<String, dynamic>),
    json['isAnyAppointment'] as String,
    json['startDateStrTime'] as String,
    json['startTime'] as String,
    json['status'] as String,
    json['updatedAt'] as String,
  );
}

BookingDetails _$BookingDetailsFromJson(Map<String, dynamic> json) {
  return BookingDetails(
    json['customerName'] as String,
    json['serviceName'] as String,
  );
}
