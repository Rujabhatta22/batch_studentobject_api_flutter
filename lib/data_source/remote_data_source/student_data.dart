import 'dart:io';

import 'package:batch_student_objbox_api/app/constants.dart';
import 'package:batch_student_objbox_api/data_source/remote_data_source/response/login_response.dart';
import 'package:batch_student_objbox_api/data_source/remote_data_source/response/student_response.dart';
import 'package:batch_student_objbox_api/helper/http_service.dart';
import 'package:batch_student_objbox_api/model/student.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

class StudentRemoteDataSource {
  final Dio _httpServices = HttpServices().getDioInstance();

  Future<int> addStudent(File? file, Student student) async {
    try {
      MultipartFile? image;
      if (file != null) {
        var mimeType = lookupMimeType(file.path);
        image = await MultipartFile.fromFile(
          file.path,
          filename: file.path.split('/').last,
          contentType: MediaType("image", mimeType!.split('/')[1]),
        );
      }
      FormData formData = FormData.fromMap({
        'fname': student.fname,
        'lname': student.lname,
        'username': student.username,
        'password': student.password,
        'batch': student.batch.target!.batchId,
        'course': student.course.map((course) => course.courseId).toList(),
        'image': image,
      });
      Response response = await _httpServices.post(
        Constant.studentURL,
        data: formData,
      );
      if (response.statusCode == 201) {
        return 1;
      } else {
        return 0;
      }
    } catch (e) {
      return 0;
    }
  }

  Future<bool> loginStudent(username, password) async {
    try {
      Response response = await _httpServices.post(
        Constant.studentLoginURL,
        data: {
          'username': username,
          'password': password,
        },
      );
      if (response.statusCode == 200) {
        LoginResponse loginResponse = LoginResponse.fromJson(response.data);
        Constant.token = "Bearer ${loginResponse.token}";
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<List<Student>?> getStudentByCourse(String courseID) async {
    try {
      Response response =
          await _httpServices.get(Constant.searchStudentByCourseURL,
              queryParameters: {
                'courseID': courseID,
              },
              options: Options(
                headers: {
                  "Authorization": Constant.token,
                },
              ));
      List<Student> lstStudents = [];
      if (response.statusCode == 200) {
        StudentResponse stdResponse = StudentResponse.fromJson(response.data);
        lstStudents = stdResponse.data!;
        return lstStudents;
      } else {
        return [];
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
