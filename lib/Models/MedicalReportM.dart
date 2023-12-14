class MedicalReportM {
  String? datee;
  String? timee;
  String? html;
  String? doctorname;
  String? visitno;

  MedicalReportM(
      {
        this.datee,
        this.timee,
        this.html,
        this.doctorname,
        this.visitno

      });

  MedicalReportM.fromJson(Map<String, dynamic> json) {
    datee = json['datee'];
    timee = json['timee'];
    html = json['html'];
    doctorname = json['doctorname'];
    visitno = json['visitno'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['datee'] = this.datee.toString()??'';
    data['timee'] = this.timee.toString()??'';
    data['html'] = this.html.toString()??'';
    data['doctorname'] = this.doctorname.toString()??'';
    data['visitno'] = this.visitno.toString()??'';


    return data;
  }
}