import 'package:easy_localization/easy_localization.dart';

enum TrainingTypes { staticTraining, dynamicTraining, powerTrainig }

const trainingTypesMap = {
  "STATIC": TrainingTypes.staticTraining,
  "DYNAMIC": TrainingTypes.dynamicTraining,
  "POWER": TrainingTypes.powerTrainig
};

extension TrainingTypesExtension on TrainingTypes {
  String get jsonName {
    switch (this) {
      case TrainingTypes.staticTraining:
        return "STATIC";
      case TrainingTypes.dynamicTraining:
        return "DYNAMIC";
      case TrainingTypes.powerTrainig:
        return "POWER";
    }
  }

  String get title {
    switch (this) {
      case TrainingTypes.staticTraining:
        return "static.type".tr();
      case TrainingTypes.dynamicTraining:
        return "dynamic.type".tr();
      case TrainingTypes.powerTrainig:
        return "Power".tr();
    }
  }
}
