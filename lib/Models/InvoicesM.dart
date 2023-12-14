class InvoicesM {
  String? invId;
  String? invDate;
  String? bilLTOTALVALUE;
  String? patienTTOTALVALUE;
  String? patienTTOTALDISCOUNT;
  String? payoRTOTALVALUE;
  String? payoRTOTALDISCOUNT;
  List<INVOICESAllModelS>? iNVOICESAllModelS;

  InvoicesM(
      {this.invId,
        this.invDate,
        this.bilLTOTALVALUE,
        this.patienTTOTALVALUE,
        this.patienTTOTALDISCOUNT,
        this.payoRTOTALVALUE,
        this.payoRTOTALDISCOUNT,
        this.iNVOICESAllModelS});

  InvoicesM.fromJson(Map<String, dynamic> json) {
    invId = json['invId'].toString()??"";
    invDate = json['invDate'].toString()??"";
    bilLTOTALVALUE = json['bilL_TOTAL_VALUE'].toString()??"";
    patienTTOTALVALUE = json['patienT_TOTAL_VALUE'].toString()??"";
    patienTTOTALDISCOUNT = json['patienT_TOTAL_DISCOUNT'].toString()??"";
    payoRTOTALVALUE = json['payoR_TOTAL_VALUE'].toString()??"";
    payoRTOTALDISCOUNT = json['payoR_TOTAL_DISCOUNT'].toString()??"";
    if (json['iNVOICES_AllModelS'] != null) {
      iNVOICESAllModelS = <INVOICESAllModelS>[];
      json['iNVOICES_AllModelS'].forEach((v) {
        iNVOICESAllModelS!.add(new INVOICESAllModelS.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['invId'] = this.invId;
    data['invDate'] = this.invDate;
    data['bilL_TOTAL_VALUE'] = this.bilLTOTALVALUE;
    data['patienT_TOTAL_VALUE'] = this.patienTTOTALVALUE;
    data['patienT_TOTAL_DISCOUNT'] = this.patienTTOTALDISCOUNT;
    data['payoR_TOTAL_VALUE'] = this.payoRTOTALVALUE;
    data['payoR_TOTAL_DISCOUNT'] = this.payoRTOTALDISCOUNT;
    if (this.iNVOICESAllModelS != null) {
      data['iNVOICES_AllModelS'] =
          this.iNVOICESAllModelS!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class INVOICESAllModelS {
  String? deptNo;
  String? servicETOTALAMT;
  String? servicEPATIENTAMT;
  String? servicEPAYORAMT;
  String? servicEDETAILSDESC;

  INVOICESAllModelS(
      {this.deptNo,
        this.servicETOTALAMT,
        this.servicEPATIENTAMT,
        this.servicEPAYORAMT,
        this.servicEDETAILSDESC});

  INVOICESAllModelS.fromJson(Map<String, dynamic> json) {
    deptNo = json['deptNo'].toString()??"";
    servicETOTALAMT = json['servicE_TOTAL_AMT'].toString()??"";
    servicEPATIENTAMT = json['servicE_PATIENT_AMT'].toString()??"";
    servicEPAYORAMT = json['servicE_PAYOR_AMT'].toString()??"";
    servicEDETAILSDESC = json['servicE_DETAILS_DESC'].toString()??"";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['deptNo'] = this.deptNo;
    data['servicE_TOTAL_AMT'] = this.servicETOTALAMT;
   // data['servicE_PATIENT_AMT'] = this.servicEPATIENTAMT;
    data['servicE_PATIENT_AMT']=double.parse(this.servicETOTALAMT.toString())
        - double.parse(this.servicEPAYORAMT.toString());
    data['servicE_PAYOR_AMT'] = this.servicEPAYORAMT;
    data['servicE_DETAILS_DESC'] = this.servicEDETAILSDESC;
    return data;
  }
}