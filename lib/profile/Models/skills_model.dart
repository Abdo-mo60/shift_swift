class SkillsModel {
  final String? message;
  final String? name;

  SkillsModel({this.message, this.name});

  factory SkillsModel.fromJson(json) {
    final datalist = json['data'];
    if (datalist is List &&
        datalist.isNotEmpty &&
        datalist[0] is Map<String, dynamic>) {
      return SkillsModel(name: datalist[0]['name']);
    } else if (datalist is List && datalist.isEmpty) {
      return SkillsModel(message: json['message']);
    } else {
      return SkillsModel(message: 'unexpected format');
    }
  }
}
