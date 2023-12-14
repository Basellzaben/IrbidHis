class xRAYM {
  String? sdate;
  String? accN;
  String? report;
  String? descr;

  String? placeholder;
  String? placeholdeR_HTML;

  xRAYM({this.sdate, this.accN, this.report , this.placeholder, this.placeholdeR_HTML,this.descr});

  xRAYM.fromJson(Map<String, dynamic> json) {
    sdate = json['sdate'];
    accN = json['accN'];
    report = json['report'];
    descr=json['descr'];
    placeholder = json['placeholder'];
    placeholdeR_HTML = json['placeholdeR_HTML'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sdate'] = this.sdate;
    data['accN'] = this.accN;
    data['report'] = this.report;
    data['descr']=this.descr;

    data['placeholder'] = this.placeholder;
    data['placeholdeR_HTML'] = this.placeholdeR_HTML;

    return data;
  }
}