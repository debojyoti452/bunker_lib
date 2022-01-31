import 'package:bunker_lib/src/constants/exception_message.dart';
import 'package:bunker_lib/src/exception/custom_exception.dart';
import 'package:bunker_lib/src/utils/string_manipulation.dart';

enum RenameFieldEnum { defaultType, header, snake, pascal }

mixin Parser {
  static String setter(String variable, dynamic key, StringBuffer classBuffer,
      {RenameFieldEnum type = RenameFieldEnum.defaultType}) {
    var parsedVar = getType(type, source: variable);

    visitor.fields.forEach((String value, dynamic key) {
      final variable =
          value.startsWith('_') ? value.replaceFirst('_', '') : value;
      classBuffer.writeln(
          "$key get get${variable.pascalCase} => _variables['$variable'];");
      classBuffer.writeln('set set${variable.pascalCase}($key $variable) {');
      classBuffer.writeln('super.$variable = $variable;');
      classBuffer.writeln("_variables['$variable'] = $variable;");
      classBuffer.writeln('}');
    });

    throw CustomException(ExceptionMessage.setterError);
  }

  static String getType(RenameFieldEnum type, {required String source}) {
    String style = 'default';
    String result = '';

    switch (type) {
      case RenameFieldEnum.defaultType:
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
