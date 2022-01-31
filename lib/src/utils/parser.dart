import 'package:bunker_lib/src/constants/exception_message.dart';
import 'package:bunker_lib/src/exception/custom_exception.dart';
import 'package:bunker_lib/src/utils/string_manipulation.dart';

enum RenameFieldEnum { defaultType, header, snake, pascal }

mixin Parser {
  static void setter(Map<String, dynamic> fields, StringBuffer classBuffer,
      {RenameFieldEnum type = RenameFieldEnum.defaultType}) {
    try {
      fields.forEach((String value, dynamic key) {
        final variable = value.startsWith('_') ? value.replaceFirst('_', '') : value;

        var parsedVar = _getType(type, source: variable);

        classBuffer.writeln("$key get get$parsedVar => _variables['$variable'];");
        classBuffer.writeln('set set$parsedVar($key $variable) {');
        classBuffer.writeln('super.$variable = $variable;');
        classBuffer.writeln("_variables['$variable'] = $variable;");
        classBuffer.writeln('}');
      });
    } catch (e) {
      throw CustomException(ExceptionMessage.setterError);
    }
  }

  static void toJson() {}

  static void fromJson() {}

  static String _getType(RenameFieldEnum type, {required String source}) {
    String style = 'default';
    String result = '';

    switch (type) {
      case RenameFieldEnum.defaultType:
        result = source.pascalCase;
        style = 'default';
        break;
      case RenameFieldEnum.header:
        result = source.headerCase;
        style = 'kebab';
        break;
      case RenameFieldEnum.snake:
        result = source.snakeCase;
        style = 'snake';
        break;
      case RenameFieldEnum.pascal:
        result = source.pascalCase;
        style = 'pascal';
        break;
    }

    return result;
  }
}
