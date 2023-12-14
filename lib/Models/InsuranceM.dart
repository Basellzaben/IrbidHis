import 'package:flutter/cupertino.dart';


class InsuranceM {
  String? carde;

  double? labPercent;
  double? InPre;
  double? pharmacyPercent;
  double? DischargePercent;
  double? raysPercent;
  double? servicePercent;
  double? suppliesPercent;
  double? dischargePercent;


  String? companyEmpName;
  String? payoRNAMEA;
  String? payoRNAMEE;
  String? pPatientInsurncesModel;

  InsuranceM(
      {

        this.DischargePercent,
        this.raysPercent,
        this.carde,

        this.labPercent,
        this.pharmacyPercent,
        this.servicePercent,
        this.suppliesPercent,
        this.dischargePercent,
        this.companyEmpName,
        this.payoRNAMEA,
        this.payoRNAMEE,
        this.InPre,
        this.pPatientInsurncesModel});

  InsuranceM.fromJson(Map<String, dynamic> json) {


    carde=json['carde'];

   // DischargePercent=json['DischargePercent'];
    raysPercent=json['raysPercent'];
    labPercent = json['labPercent'];
    pharmacyPercent = json['pharmacyPercent'];
    servicePercent = json['servicePercent'];
    suppliesPercent = json['suppliesPercent'];
    dischargePercent = json['dischargePercent'];
    InPre = json['inPre'];

    companyEmpName = json['companyEmpName'];
    payoRNAMEA = json['payoR_NAME_A'];
    payoRNAMEE = json['payoR_NAME_E'];
    pPatientInsurncesModel = json['pPatientInsurncesModel'];


  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['carde'] = this.carde;

    data['labPercent'] = this.labPercent;
   // data['DischargePercent'] = this.DischargePercent;
    data['raysPercent'] = this.raysPercent;
    data['pharmacyPercent'] = this.pharmacyPercent;
    data['servicePercent'] = this.servicePercent;
    data['suppliesPercent'] = this.suppliesPercent;
    data['dischargePercent'] = this.dischargePercent;
    data['inPre'] = this.InPre;


    data['companyEmpName'] = this.companyEmpName;
    data['payoR_NAME_A'] = this.payoRNAMEA;
    data['payoR_NAME_E'] = this.payoRNAMEE;
    data['pPatientInsurncesModel'] = this.pPatientInsurncesModel;


    return data;
  }
}
