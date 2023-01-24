import 'package:batch_student_objbox_api/model/batch.dart';
import 'package:json_annotation/json_annotation.dart';

part 'batch_response.g.dart';

//g-generetd file
@JsonSerializable()
class BatchResponse {
  bool? success;
  String? message;
  List<Batch>? data;

  BatchResponse({this.success, this.message, this.data});

  factory BatchResponse.fromjson(Map<String, dynamic> json) =>
      _$BatchResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BatchResponseToJson(this);
}
