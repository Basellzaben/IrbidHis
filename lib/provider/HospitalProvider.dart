import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../main.dart';

class HospitalProvider extends ChangeNotifier {
  String desC_A="";
  String desC_E="";
  String addresSEXPA="";
  String addresSEXPE="";
  String email="";
  String websitEADDRESS="";
  String phonE1="";

  String Terms="";
  String Facebook="";
  String Twitter="";
  getTwitter() {
    return Twitter;
  }

  setTwitter(String Twitter) {
    this.Twitter = Twitter;
    notifyListeners();
  }

  getFacebook() {
    return Facebook;
  }

  setFacebook(String Facebook) {
    this.Facebook = Facebook;
    notifyListeners();
  }


  getTerms() {
    return Terms;
  }

  setTerms(String Terms) {
    this.Terms = Terms;
    notifyListeners();
  }

  getphonE1() {
    return phonE1;
  }

  setphonE1(String phonE1) {
    this.phonE1 = phonE1;
    notifyListeners();
  }

  getwebsitEADDRESS() {
    return websitEADDRESS;
  }

  setwebsitEADDRESS(String websitEADDRESS) {
    this.websitEADDRESS = websitEADDRESS;
    notifyListeners();
  }

  getemail() {
    return email;
  }

  setemail(String email) {
    this.email = email;
    notifyListeners();
  }

  getaddresSEXPE() {
    return addresSEXPE;
  }

  setaddresSEXPE(String addresSEXPE) {
    this.addresSEXPE = addresSEXPE;
    notifyListeners();
  }


  getaddresSEXPA() {
    return addresSEXPA;
  }

  setaddresSEXPA(String addresSEXPA) {
    this.addresSEXPA = addresSEXPA;
    notifyListeners();
  }


  getdesC_E() {
    return desC_E;
  }

  setdesC_E(String desC_E) {
    this.desC_E = desC_E;
    notifyListeners();
  }

  getdesC_A() {
    return desC_A;
  }

  setdesC_A(String desC_A) {
    this.desC_A = desC_A;
    notifyListeners();
  }


}