class RadioQusModel {
  final String backGroundColor;
  final String parentFrom;
  final String childFrom;
  final String logo;
  final String logoBottomLine;
  final String qusHeadline;
  final List<dynamic> qusOptions;

  RadioQusModel({this.backGroundColor,this.parentFrom,this.childFrom ,this.logo,this.logoBottomLine,this.qusHeadline,this.qusOptions});

  RadioQusModel.fromMap(Map<String, dynamic> data):
        parentFrom = data["parentFrom"],
        childFrom = data["childFrom"],
        backGroundColor = data["backGroundColor"],
        logo = data["logo"],
        logoBottomLine= data["logoBottomLine"],
        qusHeadline = data["qusHeadline"],
        qusOptions = data["qusOptions"];

  static List<RadioQusModel> fromData(List<Map<String,dynamic>> data){
    return data.map((question) => RadioQusModel.fromMap(question)).toList();
  }

}