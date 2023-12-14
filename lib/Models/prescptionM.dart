class prescptionM {
  String? cdate;
  String? doctorname;

  List<PrescptionHdrModels>? prescptionHdrModels;

  prescptionM({this.cdate, this.prescptionHdrModels,this.doctorname});

  prescptionM.fromJson(Map<String, dynamic> json) {
    cdate = json['cdate'];
    doctorname = json['doctorname'];

    if (json['prescptionHdrModels'] != null) {
      prescptionHdrModels = <PrescptionHdrModels>[];
      json['prescptionHdrModels'].forEach((v) {
        prescptionHdrModels!.add(new PrescptionHdrModels.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cdate'] = this.cdate;
    data['doctorname'] = this.doctorname;

    if (this.prescptionHdrModels != null) {
      data['prescptionHdrModels'] =
          this.prescptionHdrModels!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PrescptionHdrModels {

  String? cdate;
  String? cname;
  String? dos;

  String? qt;
  String? unit;


  PrescptionHdrModels({this.cdate, this.cname, this.dos, this.qt, this.unit});


  PrescptionHdrModels.fromJson(Map<String, dynamic> json) {
    cdate = json['cdate'];
    cname = json['cname'];
    dos = json['dos'];

    qt = json['qt'];
    unit = json['unit'];

  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cdate'] = this.cdate;
    data['cname'] = this.cname;
    data['dos'] = this.dos;

    data['qt'] = this.qt;
    data['unit'] = this.unit;

    return data;
  }
}