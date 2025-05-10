import '../../home/data/enums/salary_type.dart';
import '../../home/data/extension/job_type_extension.dart';
import '../../home/data/extension/salary_type_extension.dart';

class JobDataModel {
  final String id;
  final String companyId;
  final String? companyName;
  final String title;
  final String description;
  final String location;
  final DateTime? postedOn;
  final SalaryType salaryTypeId;
  final double salary;
  final String jobTypeTd;

  factory JobDataModel.fromJson(Map<String, dynamic> json) => JobDataModel(
    id: json['id'],
    companyId: json['companyId'],
    companyName: json['companyName'] ?? "Unkown",
    title: json['title'],
    description: json['description'],
    location: json['location'],
    postedOn: DateTime.parse(json['postedOn'] ?? json['savedOn'] as String),
    salaryTypeId: SalaryTypeExtension.fromId(json['salaryTypeId']),
    salary: json['salary'],
    jobTypeTd: JobTypeExtension.fromId(json['jobTypeTd']).name,
  );

  JobDataModel({
    required this.id,
    required this.companyId,
    required this.companyName,
    required this.title,
    required this.description,
    required this.location,
    required this.postedOn,
    required this.salaryTypeId,
    required this.salary,
    required this.jobTypeTd,
  });
}
