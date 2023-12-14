import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../main.dart';

class MedicalREPProvider extends ChangeNotifier {
  String timee="";
  String datee="";
  String doctorname="";
  String visitno="";
  String html="";


  gettimee() {
    return timee;
  }

  settimee(String timee) {
    this.timee = timee;
    notifyListeners();
  }

  getdatee() {
    return datee;
  }

  setdatee(String datee) {
    this.datee = datee;
    notifyListeners();
  }

  getdoctorname() {
    return doctorname;
  }

  setdoctorname(String doctorname) {
    this.doctorname = doctorname;
    notifyListeners();
  }

  getvisitno() {
    return visitno;
  }

  setvisitno(String visitno) {
    this.visitno = visitno;
    notifyListeners();
  }

  getRESULT() {
    return html;
  }

  sethtml(String html) {
    this.html = html;
    notifyListeners();
  }

}