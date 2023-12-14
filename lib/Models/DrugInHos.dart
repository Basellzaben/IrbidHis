class DrugInHos {
  String? doctorname;
  String? cdate;
  List<DrugHosAllModelS>? drugHosAllModelS;

  DrugInHos({this.doctorname, this.cdate, this.drugHosAllModelS});

  DrugInHos.fromJson(Map<String, dynamic> json) {
    doctorname = json['doctorname'];
    cdate = json['cdate'];
    if (json['drugHosAllModelS'] != null) {
      drugHosAllModelS = <DrugHosAllModelS>[];
      json['drugHosAllModelS'].forEach((v) {
        drugHosAllModelS!.add(new DrugHosAllModelS.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['doctorname'] = this.doctorname;
    data['cdate'] = this.cdate;
    if (this.drugHosAllModelS != null) {
      data['drugHosAllModelS'] =
          this.drugHosAllModelS!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DrugHosAllModelS {
  String? cname;
  String? qt;
  String? unit;
  String? dose;

  DrugHosAllModelS({this.cname, this.qt, this.unit, this.dose});

  DrugHosAllModelS.fromJson(Map<String, dynamic> json) {
    cname = json['cname'].toString() ??' ';
    qt = json['qt'].toString() ??' ';
    unit = json['unit'].toString() ??' ';
    dose = json['dose'].toString()??'';

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cname'] = this.cname.toString()??' ';
    data['qt'] = this.qt.toString()??' ' ;
    data['unit'] = this.unit.toString()??' ';
    data['dose'] = this.dose.toString()=='null'?? "- : -";
    return data;
  }
}