class RadioQusModel {
  String logo = '';
  String logoBottomLine = '';
  String qusHeadline = '';
  List<dynamic> qusOptions = [];

  RadioQusModel(this.logo,this.logoBottomLine,this.qusHeadline,this.qusOptions);

/*  Question.fromMap(Map<String, dynamic> data):
        logo = '',
        logoBottomLine="",
        qusHeadline = '',
        qusOptions = []
        */


/*  static List<Question> fromData(List<Map<String,dynamic>> data){
    return data.map((question) => Question.fromMap(question)).toList();
  }*/

}


class ReportCodes {
  String textTitle;
  String textLink;

  ReportCodes(this.textTitle,this.textLink);
}