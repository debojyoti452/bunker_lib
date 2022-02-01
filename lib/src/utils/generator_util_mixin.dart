import 'package:bunker_lib/src/constants/constants.dart';
import 'package:bunker_lib/src/constants/enums.dart';
import 'package:bunker_lib/src/data/model_visitor.dart';
import 'package:bunker_lib/src/mixin/communicator.dart';
import 'package:bunker_lib/src/utils/parser.dart';
import 'package:bunker_lib/src/utils/string_manipulation.dart';

mixin GeneratorUtilMixin implements Communicator {
  @override
  void generateCopyWith(ModelVisitor visitor, StringBuffer classBuffer, String className) {
    classBuffer.writeln('$className ${Constants.copyWithOpening}');

    visitor.fields.forEach((value, dynamic key) {
      final variable = value.removeUnderScore;
      classBuffer.write('$key ${variable.camelCase},');
    });

    classBuffer.writeln('${Constants.closeFirstBracket}${Constants.closeRoundedBracket} ${Constants.openFirstBracket}');
    classBuffer.writeln('${Constants.returnMark} $className${Constants.openRoundedBracket}');

    visitor.fields.forEach((value, dynamic key) {
      final variable = value.removeUnderScore;
      classBuffer.writeln('${value.camelCase} : ${variable.camelCase} ?? \$this.${variable.camelCase},');
    });

    classBuffer.writeln('${Constants.closeRoundedBracket}${Constants.semiColonMark}');
    classBuffer.writeln(Constants.closeFirstBracket);
  }

  @override
  void generateGetterAndSetter(ModelVisitor visitor, StringBuffer classBuffer) {
    Parser.setter(visitor.fields, classBuffer, type: RenameFieldEnum.defaultType);
  }

  @override
  Object fromJson(Map<String, dynamic> map) {
    throw UnimplementedError();
  }

  @override
  Map<String, dynamic> toJson(Object data) {
    throw UnimplementedError();
  }
}
