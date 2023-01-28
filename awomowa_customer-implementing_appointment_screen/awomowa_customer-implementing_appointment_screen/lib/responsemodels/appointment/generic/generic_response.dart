import 'package:json_annotation/json_annotation.dart';

part 'generic_response.g.dart';

@JsonSerializable( createToJson: false)
class GenericResponse {
  final String status;
  final String message;
  GenericResponse(this.message, this.status);

  factory GenericResponse.fromJson(Map<String, dynamic> map) =>
      _$GenericResponseFromJson(map);
}