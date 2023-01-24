import 'package:batch_student_objbox_api/model/student.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:objectbox/objectbox.dart';

//flutter pub run build_runner build  --delete-conflicting-outputs

@Entity()
@JsonSerializable()
class Batch {
  @Id(assignable: true)
  int id;

  @Unique()
  @JsonKey(name: '_id')
  String? batchId;
  String? batchName;

  @Backlink()
  final student = ToMany<Student>();

  //Constructor
  Batch( this.batchId, this.batchName,{this.id = 0});

//to change dart from json object while sending to server
  factory Batch.fromJson(Map<String, dynamic> json) {
    return Batch(
      json['_id'],
      json['batchName'],
    );
  }

  //convert to json object file from dart while sending to server
  Map<String, dynamic> toJson() => {
        '_id': batchId,
        'batchName': batchName,
      };
}


//flutter pub run build_runner build --delete-conflicting-outputs