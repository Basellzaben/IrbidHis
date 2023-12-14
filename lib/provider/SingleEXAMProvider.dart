import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../main.dart';

class SingleEXAMProvider extends ChangeNotifier {
  String DOCTORNAME="";
  String DATE="";
  String SERVDESC="";
  String RESULT="";
  String NORMALRANGE="";
  String UNIT="";

  String OrderNo="";
  String ServNo="";

  getServNo() {
    return ServNo;
  }

  setServNo(String ServNo) {
    this.ServNo = ServNo;
    notifyListeners();
  }

  getOrderNo() {
    return OrderNo;
  }

  setOrderNo(String OrderNo) {
    this.OrderNo = OrderNo;
    notifyListeners();
  }

  getUNIT() {
    return UNIT;
  }

  setUNIT(String UNIT) {
    this.UNIT = UNIT;
    notifyListeners();
  }

  getNORMALRANGE() {
    return NORMALRANGE;
  }

  setNORMALRANGE(String NORMALRANGE) {
    this.NORMALRANGE = NORMALRANGE;
    notifyListeners();
  }

  getRESULT() {
    return RESULT;
  }

  setRESULT(String RESULT) {
    this.RESULT = RESULT;
    notifyListeners();
  }

  getSERVDESC() {
    return SERVDESC;
  }

  setSERVDESC(String SERVDESC) {
    this.SERVDESC = SERVDESC;
    notifyListeners();
  }

  getDATE() {
    return DATE;
  }

  setDATE(String DATE) {
    this.DATE = DATE;
    notifyListeners();
  }
  getDOCTORNAME() {
    return DOCTORNAME;
  }

  setDOCTORNAME(String DOCTORNAME) {
    this.DOCTORNAME = DOCTORNAME;
    notifyListeners();
  }



}