import 'package:equatable/equatable.dart';

class CategoryModel {
  int? id;
  String? name;
  String? description;
  String? image;
  List<ProgramModel>? programs;

  CategoryModel(
      {this.id, this.name, this.description, this.image, this.programs});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'] ?? "Category";
    description = json['description'] ?? "";
    image = json['image'] ?? "";
    if (json['programs'] != null) {
      programs = <ProgramModel>[];
      (json['programs'] as List<dynamic>).forEach((v) {
        programs!.add(new ProgramModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['image'] = this.image;
    if (this.programs != null) {
      data['programs'] = this.programs!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProgramModel extends Equatable {
  final int? id;
  final String? name;
  final String? description;
  final int? duration;
  final String? image;
  final int? createdById;
  final int? pulse;
  final int? hertez;

  const ProgramModel(
      {this.id,
      this.name,
      this.description,
      this.duration,
      this.image,
      this.createdById,
      this.pulse,
      this.hertez});

  factory ProgramModel.fromJson(Map<String, dynamic> json) {
    return ProgramModel(
        id: json['id'] ?? 0,
        name: json['name'] ?? "Not Definded",
        description: json['description'] ?? '',
        duration: json['duration'] ?? 0,
        image: json['image'] ?? '',
        createdById: json['createdById'] ?? 0,
        pulse: json['pulse'] ?? 0,
        hertez: json['hertez'] ?? 0);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['duration'] = this.duration;
    data['image'] = this.image;
    data['createdById'] = this.createdById;
    data['pulse'] = this.pulse;
    data['hertez'] = this.hertez;
    return data;
  }

  @override
  List<Object?> get props =>
      [id, name, description, duration, image, createdById, pulse, hertez];
}
