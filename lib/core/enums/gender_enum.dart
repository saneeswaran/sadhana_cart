enum GenderEnum { male, female, others }

extension GenderEnumExtension on GenderEnum {
  String get label {
    switch (this) {
      case GenderEnum.male:
        return "Male";
      case GenderEnum.female:
        return "Female";
      case GenderEnum.others:
        return "Others";
    }
  }
}
