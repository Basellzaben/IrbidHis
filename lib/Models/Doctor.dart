import 'package:flutter/cupertino.dart';

//work state data
class Doctor {

  int doctoR_NO;
  String? firsT_NAME_E;
  String? fatheR_NAME_E;
  String? grandfatheR_NAME_E;
  String? lasT_NAME_E;
  String? firsT_NAME_A;
  String? fatheR_NAME_A;
  String? fulL_NAME_A;
  String? grandfatheR_NAME_A;
  String? lasT_NAME_A;
  String? fulL_NAME_E;
  String? mobile;
  String? email;
  int depT_NO;
  String? depName;
  String? doctorTransHistoryModel;


  Doctor({
    required this.doctoR_NO,
    required this.firsT_NAME_E,
    required this.fatheR_NAME_E,
    required this.grandfatheR_NAME_E,
    required this.lasT_NAME_E,
    required this.firsT_NAME_A,
    required this.fatheR_NAME_A,
    required this.fulL_NAME_A,
    required this.grandfatheR_NAME_A,
    required this.lasT_NAME_A,
    required this.fulL_NAME_E,
    required this.mobile,
    required this.email,
    required this.depT_NO,
    required this.depName,
    required this.doctorTransHistoryModel
  });

  factory Doctor.fromJson(Map<String?, dynamic> json) {
    return Doctor(
     doctoR_NO: json['doctoR_NO'] ?? 0,
      firsT_NAME_E: json['firsT_NAME_E'] ?? "",
      fatheR_NAME_E: json['fatheR_NAME_E'] ?? "",
      grandfatheR_NAME_E: json['grandfatheR_NAME_E'] ?? "",
      lasT_NAME_E: json['lasT_NAME_E'] ?? "",
      firsT_NAME_A: json['firsT_NAME_A'] ?? "",
      fatheR_NAME_A: json['fatheR_NAME_A'] ?? "",
      fulL_NAME_A: json['fulL_NAME_A'] ?? "",
      grandfatheR_NAME_A: json['grandfatheR_NAME_A'] ?? "",
      lasT_NAME_A: json['lasT_NAME_A'] ?? "",
      fulL_NAME_E: json['fulL_NAME_E'] ?? "",
      mobile: json['mobile']  ?? "",
      email: json['email']  ?? "",
      depT_NO: json['depT_NO'] ?? 0,
      depName: json['depName'] ,
      doctorTransHistoryModel: json['doctorTransHistoryModel']  ?? "",

    );
  }
}
