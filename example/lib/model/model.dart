import 'package:bunker_annotation/bunker_annotation.dart';

import 'sub_model.dart';

part 'model.bunker.dart';
// part 'model.g.dart';

@BunkerAnnotation(isJsonSerializer: false)
class Model {
  String? name_variable;
  int? age_variable;
  List<SubModel>? listVariable;
}
