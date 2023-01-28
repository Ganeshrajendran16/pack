// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServiceResponse _$ServiceResponseFromJson(Map<String, dynamic> json) {
  return ServiceResponse(
    (json['availableServices'] as List)
        ?.map((e) =>
            e == null ? null : Service.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['message'] as String,
    json['status'] as String,
  );
}

Service _$ServiceFromJson(Map<String, dynamic> json) {
  return Service(
    json['createdAt'] as String,
    json['serviceId'] as String,
    json['serviceName'] as String,
    json['status'] as String,
    json['updatedAt'] as String,
    json['vendorId'] as String,
  );
}
