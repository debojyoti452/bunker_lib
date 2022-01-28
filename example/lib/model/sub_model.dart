import 'package:bunker_annotation/bunker_annotation.dart';

part 'sub_model.bunker.dart';
// part 'sub_model.g.dart';

@BunkerAnnotation(isJsonSerializer: false)
class SubModel {
  String? name_variable;
  int? age_variable;
}
