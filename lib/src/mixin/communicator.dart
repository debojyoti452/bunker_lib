import 'package:bunker_lib/src/data/model_visitor.dart';

abstract class Communicator {
  void generateGetterAndSetter(ModelVisitor visitor, StringBuffer classBuffer);

  void generateCopyWith(ModelVisitor visitor, StringBuffer classBuffer, String className);

  Map<String, dynamic> toJson(ModelVisitor data, StringBuffer classBuffer);

  Object fromJson(Map<String, dynamic> map, StringBuffer classBuffer);
}
