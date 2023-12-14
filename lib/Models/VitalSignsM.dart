import 'package:flutter/cupertino.dart';

  class VitalSignsM {
    String? datee;
    String? VisitID;
  List<VITALSIGNSAllModelS>? vITALSIGNSAllModelS;

  VitalSignsM({this.datee,this.VisitID, this.vITALSIGNSAllModelS});

  VitalSignsM.fromJson(Map<String, dynamic> json) {
    datee = json['datee'];
    VisitID = json['VisitID'];

  if (json['vITAL_SIGNS_AllModelS'] != null) {
  vITALSIGNSAllModelS = <VITALSIGNSAllModelS>[];
  json['vITAL_SIGNS_AllModelS'].forEach((v) {
  vITALSIGNSAllModelS!.add(new VITALSIGNSAllModelS.fromJson(v));
  });
  }
  }

  Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['datee'] = this.datee;
  data['VisitID'] = this.VisitID;


  if (this.vITALSIGNSAllModelS != null) {
  data['vITAL_SIGNS_AllModelS'] =
  this.vITALSIGNSAllModelS!.map((v) => v.toJson()).toList();
  }
  return data;
  }
  }

  class VITALSIGNSAllModelS {
  String? VisitID;
  String? reaDDATE;
  String? reaDTIME;
  String? vitaLSIGNREAD;
  String? vitaLSIGNCODE;
  String? desCA;
  Null? vITALSIGNSAllModel;

  VITALSIGNSAllModelS(
  {this.VisitID,
  this.reaDDATE,
  this.reaDTIME,
  this.vitaLSIGNREAD,
  this.vitaLSIGNCODE,
  this.desCA,
  this.vITALSIGNSAllModel});

  VITALSIGNSAllModelS.fromJson(Map<String, dynamic> json) {
    VisitID = json['VisitID'].toString() ??"";
  reaDDATE = json['reaD_DATE'].toString() ??"";
  reaDTIME = json['reaD_TIME'].toString() ??"";
  vitaLSIGNREAD = json['vitaL_SIGN_READ'].toString() ??"";
  vitaLSIGNCODE = json['vitaL_SIGN_CODE'].toString() ??"";
  desCA = json['desC_A'].toString() ??"";
  vITALSIGNSAllModel = json['vITAL_SIGNS_AllModel'];
  }

  Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['VisitID'] = this.VisitID;
  data['reaD_DATE'] = this.reaDDATE;
  data['reaD_TIME'] = this.reaDTIME;
  data['vitaL_SIGN_READ'] = this.vitaLSIGNREAD;
  data['vitaL_SIGN_CODE'] = this.vitaLSIGNCODE;
  data['desC_A'] = this.desCA;
  data['vITAL_SIGNS_AllModel'] = this.vITALSIGNSAllModel;
  return data;
  }
  }