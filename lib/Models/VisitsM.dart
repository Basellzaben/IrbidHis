class VisitsM {
  String? visitDate;
  String? visitName;
  String? VisitType;

  VisitsM({this.visitDate, this.visitName,this.VisitType});

  VisitsM.fromJson(Map<String, dynamic> json) {
    visitDate = json['visitDate'];
    visitName = json['visitName'];
    VisitType = json['visitType'];




  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['visitDate'] = this.visitDate;
    data['visitName'] = this.visitName;
    data['visitType'] = this.VisitType;


    return data;
  }
}