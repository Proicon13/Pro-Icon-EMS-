import 'package:easy_localization/easy_localization.dart';

enum Gender {
  male,
  female,
}

extension GenderExtension on Gender {
  String get name {
    switch (this) {
      case Gender.male:
        return "male".tr();
      case Gender.female:
        return "female".tr();
    }
  }
}
