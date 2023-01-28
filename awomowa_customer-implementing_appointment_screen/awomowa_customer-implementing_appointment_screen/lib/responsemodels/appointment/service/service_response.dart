import 'package:json_annotation/json_annotation.dart';

part 'service_response.g.dart';

@JsonSerializable(createToJson: false)
class ServiceResponse {
  final String status;
  final String message;
  final List<Service> availableServices;
  ServiceResponse(this.availableServices, this.message, this.status);

  factory ServiceResponse.fromJson(Map<String, dynamic> map) =>
      _$ServiceResponseFromJson(map);
}

@JsonSerializable(createToJson: false)
class Service {
  final String serviceId;
  final String vendorId;
  final String serviceName;
  final String status;
  final String createdAt;
  final String updatedAt;

  Service(this.createdAt, this.serviceId, this.serviceName, this.status,
      this.updatedAt, this.vendorId);

  factory Service.fromJson(Map<String, dynamic> map) => _$ServiceFromJson(map);
}
