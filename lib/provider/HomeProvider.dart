import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../main.dart';

class HomeProvider extends ChangeNotifier {
  String VisitDate="";
  String visitNo="";
  String visittype="";

  getvisitNo() {
    return visitNo;
  }

  setvisitNo(String visitNo) {
    this.visitNo = visitNo;
    notifyListeners();
  }

  getvisittype() {
    return visittype;
  }

  setvisittype(String visittype) {
    this.visittype = visittype;
    notifyListeners();
  }



  getVisitDate() {
    return VisitDate;
  }

  setVisitDate(String VisitDate) {
    this.VisitDate = VisitDate;
    notifyListeners();
  }


}