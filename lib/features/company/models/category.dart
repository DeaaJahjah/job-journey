import 'package:equatable/equatable.dart';

class Category extends Equatable {
  final int id;
  final String name;
  final String enName;
  const Category({
    required this.id,
    required this.name,
    required this.enName,
  });

  Category copyWith({
    int? id,
    String? name,
    String? enName,
  }) {
    return Category(
      id: id ?? this.id,
      name: name ?? this.name,
      enName: enName ?? this.enName,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'en_name': enName,
    };
  }

  factory Category.fromJson(Map<String, dynamic> map) {
    return Category(
      id: map['id'] as int,
      name: map['name'] as String,
      enName: map['en_name'] as String,
    );
  }
  @override
  String toString() => 'Category(id: $id, name: $name, enName: $enName)';

  @override
  List<Object?> get props => [id, name, enName];
}

extension GetByName on List<Category> {
  Category getCategory(String name) => firstWhere((e) => e.name == name || e.enName == name);
}
