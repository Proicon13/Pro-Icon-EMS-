import 'add_custom_program_model.dart';

class AddCustomProgramBuilder {
  static final AddCustomProgramBuilder _instance =
      AddCustomProgramBuilder._internal();

  // Singleton Constructor
  factory AddCustomProgramBuilder() {
    return _instance;
  }

  AddCustomProgramBuilder._internal();

  // Fields for AddCustomProgramModel
  int? _id;
  String? _name;
  String? _description;
  int? _duration;
  String? _image;
  int? _pulse;
  int? _hertez;
  int? _categoryId;
  int? _stimulation;
  int? _pauseInterval;
  int? _contraction;
  List<AddProgramMuscleModel>? _programMuscles;
  List<AddCycleModel>? _cycles;

  /// **Reset Method**
  /// Resets all fields to their initial (null) state.
  void reset() {
    _id = null;
    _name = null;
    _description = null;
    _duration = null;
    _image = null;
    _pulse = null;
    _hertez = null;
    _categoryId = null;
    _stimulation = null;
    _pauseInterval = null;
    _contraction = null;
    _programMuscles = null;
    _cycles = null;
  }

  /// **Builder Methods**
  AddCustomProgramBuilder setId(int? id) {
    _id = id;
    return this;
  }

  AddCustomProgramBuilder setName(String? name) {
    _name = name;
    return this;
  }

  AddCustomProgramBuilder setDescription(String? description) {
    _description = description;
    return this;
  }

  AddCustomProgramBuilder setDuration(int? duration) {
    _duration = duration;
    return this;
  }

  AddCustomProgramBuilder setImage(String? image) {
    _image = image;
    return this;
  }

  AddCustomProgramBuilder setPulse(int? pulse) {
    _pulse = pulse;
    return this;
  }

  AddCustomProgramBuilder setHertez(int? hertez) {
    _hertez = hertez;
    return this;
  }

  AddCustomProgramBuilder setCategoryId(int? categoryId) {
    _categoryId = categoryId;
    return this;
  }

  AddCustomProgramBuilder setStimulation(int? stimulation) {
    _stimulation = stimulation;
    return this;
  }

  AddCustomProgramBuilder setPauseInterval(int? pauseInterval) {
    _pauseInterval = pauseInterval;
    return this;
  }

  AddCustomProgramBuilder setContraction(int? contraction) {
    _contraction = contraction;
    return this;
  }

  AddCustomProgramBuilder setProgramMuscles(
      List<AddProgramMuscleModel>? programMuscles) {
    _programMuscles = programMuscles;
    return this;
  }

  AddCustomProgramBuilder setCycles(List<AddCycleModel>? cycles) {
    _cycles = cycles;
    return this;
  }

  /// **Build Method**
  /// Constructs an `AddCustomProgramModel` instance, allowing null values.
  AddCustomProgramModel build() {
    return AddCustomProgramModel(
      id: _id,
      name: _name,
      description: _description,
      duration: _duration,
      image: _image,
      pulse: _pulse,
      hertez: _hertez,
      categoryId: _categoryId,
      stimulation: _stimulation,
      pauseInterval: _pauseInterval,
      contraction: _contraction,
      programMuscles: _programMuscles,
      cycles: _cycles,
    );
  }
}
