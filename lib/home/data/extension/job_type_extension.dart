import '../enums/job_type.dart';

extension JobTypeExtension on JobType {
  static JobType fromId(int id) {
    switch (id) {
      case 1:
        return JobType.fullTime;
      case 2:
        return JobType.partTime;
      default:
        return JobType.freelance;
    }
  }

  String get name {
    switch (this) {
      case JobType.fullTime:
        return 'Full Time';
      case JobType.partTime:
        return 'Part Time';
      case JobType.freelance:
        return 'Freelance';
    }
  }
}
