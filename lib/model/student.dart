import 'package:batch_student_objbox_api/model/batch.dart';
import 'package:batch_student_objbox_api/model/course.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:objectbox/objectbox.dart';
part 'student.g.dart';

@Entity()
@JsonSerializable()
class Student {
  @Id(assignable: true)
  int stdId;

  @Unique()
  @Index()
  @JsonKey(name: '_id')
  String? studentId;
  String? fname;
  String? lname;
  String? username;
  String? password;

  @JsonKey(name: 'batch')
  Batch? batches;
  @JsonKey(name: 'course')
  List<Course>? courses;
  final batch = ToOne<Batch>();
  final course = ToMany<Course>();

  Student(
      {this.studentId,
      this.fname,
      this.lname,
      this.username,
      this.password,
      this.stdId = 0});

  factory Student.fromJson(Map<String, dynamic> json) =>
      _$StudentFromJson(json);

  Map<String, dynamic> toJson() => _$StudentToJson(this);
}
