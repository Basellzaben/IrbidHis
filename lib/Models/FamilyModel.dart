class FamilyModel {
  String? childID;
  String? chilD_FULL_A_NAME;
  String? chilD_FULL_E_NAME;
  String? relation;

  FamilyModel(
      { this.childID,
        this.chilD_FULL_A_NAME,
        this.chilD_FULL_E_NAME,
        this.relation,
      });

  FamilyModel.fromJson(Map<String, dynamic> json) {
    childID = json['childID'].toString() ;
    chilD_FULL_A_NAME = json['chilD_FULL_A_NAME'].toString();
    chilD_FULL_E_NAME = json['chilD_FULL_E_NAME'].toString();
    relation = json['relation'].toString();
  }



  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['childID'] = this.childID;
    data['chilD_FULL_A_NAME'] = this.chilD_FULL_A_NAME;
    data['chilD_FULL_E_NAME'] = this.chilD_FULL_E_NAME;
    data['relation'] = this.relation;

    return data;
  }
}