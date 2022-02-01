import 'package:bunker_lib/src/constants/constants.dart';
import 'package:bunker_lib/src/constants/enums.dart';
import 'package:bunker_lib/src/constants/exception_message.dart';
import 'package:bunker_lib/src/exception/custom_exception.dart';
import 'package:bunker_lib/src/utils/string_manipulation.dart';

mixin Parser {
  static void setter(Map<String, dynamic> fields, StringBuffer classBuffer,
      {RenameFieldEnum type = RenameFieldEnum.defaultType}) {
    try {
      fields.forEach((String value, dynamic key) {
        final variable = value.removeUnderScore;

        var parsedVar = _getType(type, source: variable);

        classBuffer.writeln("$key ${Constants.getterMark} get$parsedVar => _variables['$variable'];");
        classBuffer.writeln('${Constants.setterMark} set$parsedVar($key $variable) {');
        classBuffer.writeln('${Constants.superMark}.$variable = $variable;');
        classBuffer.writeln("_variables['$variable'] = $variable;");
        classBuffer.writeln(Constants.closeFirstBracket);
      });
    } catch (e) {
      throw CustomException(ExceptionMessage.setterError);
    }
  }

  static Map<String, dynamic> toJson() {
    var jsonMap = <String, dynamic>{};
    return jsonMap;
  }

  static void fromJson(Map<String, dynamic> fields) {}

  static String _getType(RenameFieldEnum type, {required String source}) {
    String result = '';

    switch (type) {
      case RenameFieldEnum.defaultType:
        result = source.pascalCase;
        break;
      case RenameFieldEnum.header:
        result = source.headerCase;
        break;
      case RenameFieldEnum.snake:
        result = source.snakeCase;
        break;
      case RenameFieldEnum.pascal:
        result = source.pascalCase;
        break;
      case RenameFieldEnum.camelcase:
        result = source.camelCase;
        break;
    }

    return result;
  }
}
