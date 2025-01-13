import 'package:pro_icon/Core/entities/program_entity.dart';

class AppConstants {
  AppConstants._();
  static const appName = 'Pro-Icon';
  static const baseUrl = 'https://pro-icon-backend.onrender.com/';
  static const tokenLocalKey = 'token';

  //TODO REMOVE THIS LINE CODE AFTER TESTING
  static const programsMock = [
    CustomProgramEntity(
        id: 0,
        name: "Custom Program 1",
        description: "",
        duration: 15,
        image: "",
        createdById: 0,
        pulse: 400,
        hertez: 500,
        categoryId: 1,
        stimulation: 10,
        pauseInterval: 4,
        contraction: 8,
        programMuscles: [],
        cycles: []),
    CustomProgramEntity(
        id: 1,
        name: "Custom Program 2",
        description: "",
        duration: 13,
        image: "",
        createdById: 0,
        pulse: 300,
        hertez: 400,
        categoryId: 1,
        stimulation: 10,
        pauseInterval: 4,
        contraction: 8,
        programMuscles: [],
        cycles: []),
  ];
}
