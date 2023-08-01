// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:mtracker/services/gsheet_service.dart';

class CategoryModel {
  static const dbLink =
      "https://docs.google.com/spreadsheets/d/1SE5pbs8gcUBVQUxHMvfKvNl2p53hJ0iwa6y2-NitPIU/edit#gid=421690909";

  static Future<List<CategoryModel>> getAllCategory() async {
    List<Map<String, String>>? rows =
        await GSheetService.categorySheet!.values.map.allRows();
    return rows!.map((e) => CategoryModel.fromMap(e)).toList();
  }

  String category;

  CategoryModel({
    required this.category,
  });

  CategoryModel copyWith({
    String? category,
  }) {
    return CategoryModel(
      category: category ?? this.category,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'category': category,
    };
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      category: map['category'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CategoryModel.fromJson(String source) =>
      CategoryModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'CategoryModel(category: $category)';

  @override
  bool operator ==(covariant CategoryModel other) {
    if (identical(this, other)) return true;

    return other.category == category;
  }

  @override
  int get hashCode => category.hashCode;
}
