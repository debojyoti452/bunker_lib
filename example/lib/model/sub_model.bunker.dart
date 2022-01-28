// Bunker Generated Files
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

part of 'sub_model.dart';

// **************************************************************************
// BunkerGenerator
// **************************************************************************

class SubModel extends _$SubModelBunker {
  Map<String, dynamic> _variables = {};
  SubModel() {
    name_variable = super.name_variable;
    age_variable = super.age_variable;
  }
  String? get getNameVariable => _variables['name_variable'];
  set setNameVariable(String? name_variable) {
    super.name_variable = name_variable;
    _variables['name_variable'] = name_variable;
  }

  int? get getAgeVariable => _variables['age_variable'];
  set setAgeVariable(int? age_variable) {
    super.age_variable = age_variable;
    _variables['age_variable'] = age_variable;
  }

  SubModel copyWith({
    String? nameVariable,
    int? ageVariable,
  }) {
    return SubModel(
      nameVariable: nameVariable ?? $this.nameVariable,
      ageVariable: ageVariable ?? $this.ageVariable,
    );
  }
}
