import 'package:equatable/equatable.dart';

import 'program_entity.dart';

class CategoryEntity extends Equatable {
  final int? id;
  final String? name;
  final String? description;
  final String? image;
  final List<ProgramEntity>? programs;

  CategoryEntity(
      {this.id, this.name, this.description, this.image, this.programs});

  @override
  List<Object?> get props => throw UnimplementedError();
}
