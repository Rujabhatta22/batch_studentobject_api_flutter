import 'package:batch_student_objbox_api/model/student.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:objectbox/objectbox.dart';



@Entity()
@JsonSerializable()
class Course {
  @Id(assignable: true)
  int id;

  @Unique()
  @JsonKey(name:'_id')
  String? courseId;
  String? courseName;

  @Backlink()
  final student = ToMany<Student>();

  Course(this.courseId,this.courseName, {this.id = 0});

  factory Course.fromJson(Map<String,dynamic> json){
    return Course(
      json['_id'],
      json['courseName'],
    );
  }
  Map<String, dynamic> tojson()=>{
    '_id':courseId,
    'courseName':courseName,
  };
}