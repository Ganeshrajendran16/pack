// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calendar_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CalenderResponse _$CalenderResponseFromJson(Map<String, dynamic> json) {
  return CalenderResponse(
    json['createdAt'] as String,
    json['dayInWeek'] as String,
    json['isHavingSlot'] as String,
    json['message'] as String,
    json['schedulerId'] as String,
    json['selectedDate'] as String,
    (json['slotTimings'] as List)
        ?.map(
            (e) => e == null ? null : Slots.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['status'] as String,
    json['updatedAt'] as String,
  );
}

CalenderAvailableDatesResponse _$CalenderAvailableDatesResponseFromJson(
    Map<String, dynamic> json) {
  return CalenderAvailableDatesResponse(
    (json['dateList'] as List)?.map((e) => e as String)?.toList(),
    json['message'] as String,
    json['status'] as String,
  );
}
