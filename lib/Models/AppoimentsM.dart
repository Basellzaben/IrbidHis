import 'package:flutter/cupertino.dart';

//Doctor.dart

class AppoimentsM {
  String? sessionDate;
  String? sessionStatus;
  String? sessionNameA;
  String? sessionNameE;
  String? doctornamEA;
  String? doctornamEE;

  AppoimentsM(
      {this.sessionDate,
        this.sessionStatus,
        this.sessionNameA,
        this.sessionNameE,
        this.doctornamEA,
        this.doctornamEE});

  AppoimentsM.fromJson(Map<String, dynamic> json) {
    sessionDate = json['sessionDate'];
    sessionStatus = json['sessionStatus'];
    sessionNameA = json['sessionNameA'];
    sessionNameE = json['sessionNameE'];
    doctornamEA = json['doctornamE_A'];
    doctornamEE = json['doctornamE_E'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sessionDate'] = this.sessionDate;
    data['sessionStatus'] = this.sessionStatus;
    data['sessionNameA'] = this.sessionNameA;
    data['sessionNameE'] = this.sessionNameE;
    data['doctornamE_A'] = this.doctornamEA;
    data['doctornamE_E'] = this.doctornamEE;
    return data;
  }
}