import '../enums/salary_type.dart';

extension SalaryTypeExtension on SalaryType {
  static SalaryType fromId(int id) {
    switch (id) {
      case 1:
        return SalaryType.month;
      case 2:
        return SalaryType.hour;
      default:
        return SalaryType.contract;
    }
  }

  String get name {
    switch (this) {
      case SalaryType.month:
        return "Month";
      case SalaryType.hour:
        return "Hour";
      case SalaryType.contract:
        return "Contract";
    }
  }
}
