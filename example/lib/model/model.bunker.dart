// Bunker Generated Files
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

part of 'model.dart';

// **************************************************************************
// BunkerGenerator
// **************************************************************************

class Model extends _$ModelBunker {
  Map<String, dynamic> _variables = {};
  Model() {
    name_variable = super.name_variable;
    age_variable = super.age_variable;
    listVariable = super.listVariable;
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

  List<SubModel>? get getListVariable => _variables['listVariable'];
  set setListVariable(List<SubModel>? listVariable) {
    super.listVariable = listVariable;
    _variables['listVariable'] = listVariable;
  }

  Model copyWith({
    String? nameVariable,
    int? ageVariable,
    List<SubModel>? listVariable,
  }) {
    return Model(
      nameVariable: nameVariable ?? $this.nameVariable,
      ageVariable: ageVariable ?? $this.ageVariable,
      listVariable: listVariable ?? $this.listVariable,
    );
  }
}
