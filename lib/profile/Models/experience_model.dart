import 'package:intl/intl.dart';

class ExperienceModel {
  final String? title;
  final String? companyName;
  final String? startDate;
  final String? endDate;
  final String? description;
  final String? message;
  ExperienceModel({
    this.title,
    this.companyName,
    this.endDate,
    this.startDate,
    this.description,
    this.message,
  });

  factory ExperienceModel.fromJson(json) {

    final dataList=json['data'];
    if (dataList is List&&dataList.isNotEmpty && dataList[0] is Map<String, dynamic>) {
      String endDateString = dataList[0]['endDate'];
      DateTime endDate = DateTime.parse(endDateString);
      String formattedEndDate = DateFormat('MMM yyyy').format(endDate);
      String startDateString = dataList[0]['startDate'];
      DateTime startDate = DateTime.parse(startDateString);
      String formattedStartDate = DateFormat('MMM yyyy').format(startDate);
      return ExperienceModel(
        title: dataList[0]['title'],
        companyName: dataList[0]['companyName'],
        startDate: formattedStartDate,
        endDate: formattedEndDate,
        description: dataList[0]['description'],
      );
    } else if(dataList is List&& dataList.isEmpty) {
      return ExperienceModel(message: json['message']);
    }
    else{
      return ExperienceModel(message: 'un expected format');
    }
  }
}
