import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../main.dart';

class LoginProvider extends ChangeNotifier {
  String token="";
  String username="";
  String refreshToken="";
  String id="";
  String custno="";
  String pass="";

  String nameA="";
  String nameE="";
  String userId="";
  String userType="";
  String createdDate="";

  String Bdate="";


  String ParentuserId="";
  String parentnamea="";
  String parentnamee="";


  String FirebaseIp="";

  getparentnamee() {
    return parentnamee;
  }

  setparentnamee(String parentnamee) {
    this.parentnamee = parentnamee;
    notifyListeners();
  }

  getparentnamea() {
    return parentnamea;
  }

  setparentnamea(String parentnamea) {
    this.parentnamea = parentnamea;
    notifyListeners();
  }


  getParentuserId() {
    return ParentuserId;
  }

  setParentuserId(String ParentuserId) {
    this.ParentuserId = ParentuserId;
    notifyListeners();
  }





  getFirebaseIp() {
    return FirebaseIp;
  }

  setFirebaseIp(String FirebaseIp) {
    this.FirebaseIp = FirebaseIp;
    notifyListeners();
  }



  getBdate() {
    return Bdate;
  }

  setBdate(String Bdate) {
    this.Bdate = Bdate;
    notifyListeners();
  }

  getpass() {
    return pass;
  }

  setpass(String pass) {
    this.pass = pass;
    notifyListeners();
  }


  getcreatedDate() {
    return createdDate;
  }

  setcreatedDate(String createdDate) {
    this.createdDate = createdDate;
    notifyListeners();
  }

  getuserType() {
    return userType;
  }

  setuserType(String userType) {
    this.userType = userType;
    notifyListeners();
  }


  getuserId() {
    return userId;
  }

  setuserId(String userId) {
    this.userId = userId;
    notifyListeners();
  }


  getnameE() {
    return nameE;
  }

  setnameE(String nameE) {
    this.nameE = nameE;
    notifyListeners();
  }

  getnameA() {
    return nameA;
  }

  setnameA(String nameA) {
    this.nameA = nameA;
    notifyListeners();
  }


  getcustno() {
    return custno;
  }

  setcustno(String custno) {
    this.custno = custno;
    notifyListeners();
  }

  getid() {
    return id;
  }

  setid(String id) {
    this.id = id;
    notifyListeners();
  }

  getrefreshToken() {
    return username;
  }

  setrefreshToken(String refreshToken) {
    this.refreshToken = refreshToken;
    notifyListeners();
  }

  getusername() {
    return username;
  }

  setusername(String username) {
    this.username = username;
    notifyListeners();
  }
  gettoken() {
    return token;
  }

  settoken(String token) {
    this.token = token;
    notifyListeners();
  }

}