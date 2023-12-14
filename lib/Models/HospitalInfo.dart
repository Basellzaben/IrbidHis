class HospitalInfo {
  String? desCA;
  String? desCE;
  String? addresSEXPA;
  String? addresSEXPE;
  String? email;
  String? websitEADDRESS;
  String? phonE1;

  String? Terms;
  String? Facebook;
  String? Twitter;


  HospitalInfo(
      {
        this.desCA,
        this.desCE,
        this.addresSEXPA,
        this.addresSEXPE,
        this.email,
        this.websitEADDRESS,
        this.phonE1,
        this.Terms,
        this.Facebook,
        this.Twitter
      });

  HospitalInfo.fromJson(Map<String, dynamic> json) {
    desCA = json['desC_A'];
    desCE = json['desC_E'];
    addresSEXPA = json['addresS_EXP_A'];
    addresSEXPE = json['addresS_EXP_E'];
    email = json['email'];
    websitEADDRESS = json['websitE_ADDRESS'];
    phonE1 = json['phonE_1'];

    Terms = json['terms'];
    Facebook = json['facebook'];
    Twitter = json['twitter'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['desC_A'] = this.desCA.toString()??'';
    data['desC_E'] = this.desCE.toString()??'';
    data['addresS_EXP_A'] = this.addresSEXPA.toString()??'';
    data['addresS_EXP_E'] = this.addresSEXPE.toString()??'';
    data['email'] = this.email.toString()??'';
    data['websitE_ADDRESS'] = this.websitEADDRESS.toString()??'';
    data['phonE_1'] = this.phonE1.toString()??'';

    data['terms'] = this.Terms.toString()??'';
    data['facebook'] = this.Facebook.toString()??'';
    data['twitter'] = this.Twitter.toString()??'';

    return data;
  }
}