class ExamnationGroupM {
  String? id;
  String? serVNO;
  String? orederNo;
  String? serVDESC;
  String? testflag;
  String? doctorName;
  String? unitDesc;
  String? result;
  String? normalRange;
  String? ExDate;
  String? parentNo;
  String? servNo;

  ExamnationGroupM(
      {
        this.id,
        this.serVNO,
        this.orederNo,
        this.serVDESC,
        this.testflag,
        this.doctorName,
        this.unitDesc,
        this.result,
        this.normalRange,
        this.parentNo,
        this.ExDate,
        this.servNo


      });

  ExamnationGroupM.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString() ;
    serVNO = json['serV_NO'].toString();
    orederNo = json['orederNo'].toString();
    serVDESC = json['serV_DESC'].toString();
    testflag = json['testflag'].toString();
    doctorName = json['doctorName'].toString();
    unitDesc = json['unitDesc'].toString();
    result = json['result'].toString();
    normalRange = json['normalRange'].toString();
    ExDate = json['exDate'].toString();
    parentNo = json['parentNo'].toString();
    servNo = json['servNo'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['serV_NO'] = this.serVNO;
    data['orederNo'] = this.orederNo;
    data['serV_DESC'] = this.serVDESC;
    data['testflag'] = this.testflag;
    data['doctorName'] = this.doctorName;
    data['unitDesc'] = this.unitDesc;
    data['result'] = this.result;
    data['normalRange'] = this.normalRange;
    data['exDate'] = this.ExDate;
    data['parentNo'] = this.parentNo;
    data['servNo'] = this.servNo;
    return data;
  }
}