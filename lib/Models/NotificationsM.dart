import 'package:flutter/cupertino.dart';

//Doctor.dart

class NotificationsM {
  String? patientid;
  String? hdr;
  String? dtl;
  String? date;
  String? type;
  String? show;

  NotificationsM(
      {this.patientid,
        this.hdr,
        this.dtl,
        this.date,
        this.show,
        this.type});

  NotificationsM.fromJson(Map<String, dynamic> json) {
    patientid = json['patientid'];
    hdr = json['hdr'];
    dtl = json['dtl'];
    date = json['date'];
    type = json['type'];
    show = json['show'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['patientid'] = this.patientid;
    data['hdr'] = this.hdr;
    data['dtl'] = this.dtl;
    data['date'] = this.date;
    data['type'] = this.type;
    data['show'] = this.show;
    return data;
  }
}