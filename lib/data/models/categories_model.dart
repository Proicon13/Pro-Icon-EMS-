
class Categories {
  int? id;
  String? name;
  String? description;
  String? image;
  List<Programs>? programs;

  Categories({this.id, this.name, this.description, this.image, this.programs});

  Categories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    image = json['image'];
    if (json['programs'] != null) {
      programs = <Programs>[];
      (json['programs'] as List<dynamic>).forEach((v) {
        programs!.add(new Programs.fromJson(v));
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

class Programs {
  int? id;
  String? name;
  String? description;
  int? duration;
  String? image;
  int? createdById;
  int? pulse;
  int? hertez;

  Programs(
      {this.id,
        this.name,
        this.description,
        this.duration,
        this.image,
        this.createdById,
        this.pulse,
        this.hertez});

  Programs.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    duration = json['duration'];
    image = json['image'];
    createdById = json['createdById'];
    pulse = json['pulse'];
    hertez = json['hertez'];
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
}