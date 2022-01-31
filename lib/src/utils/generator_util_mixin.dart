import 'package:bunker_lib/src/data/model_visitor.dart';
import 'package:bunker_lib/src/mixin/communicator.dart';
import 'package:bunker_lib/src/serializer/json_converter.dart';
import 'package:bunker_lib/src/utils/string_manipulation.dart';

mixin GeneratorUtilMixin
    implements Communicator, JsonConverter<Map<dynamic, dynamic>, Object> {
  @override
  void generateCopyWith(
      ModelVisitor visitor, StringBuffer classBuffer, String className) {
    classBuffer.writeln('$className copyWith({');

    visitor.fields.forEach((value, dynamic key) {
      final variable =
          value.startsWith('_') ? value.replaceFirst('_', '') : value;
      classBuffer.write('$key ${variable.camelCase},');
    });

    classBuffer.writeln('}) {');

    classBuffer.writeln('return $className(');

    visitor.fields.forEach((value, dynamic key) {
      final variable =
          value.startsWith('_') ? value.replaceFirst('_', '') : value;
      classBuffer.writeln(
          '${value.camelCase} : ${variable.camelCase} ?? \$this.${variable.camelCase},');
    });

    classBuffer.writeln(');');

    /*for (final field in visitor.fields.keys) {
      //ignore:cascade_invocations
      classBuffer.writeln('${visitor.fields[field]} ${variable.camelCase}}), ');
    }*/

    classBuffer.writeln('}');

    //Eg: ClassName copyWith(variable) {
    //    return ClassName(
    //      variable: variable ?? this.variable,
    //    );
    // }
  }

  @override
  void generateGetterAndSetter(ModelVisitor visitor, StringBuffer classBuffer) {
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
  }

  @override
  Map fromJson(Object json) {
    // TODO: implement fromJson
    throw UnimplementedError();
  }

  @override
  Object toJson(Map object) {
    // TODO: implement toJson
    throw UnimplementedError();
  }

/*void generateGettersAndSetters(
    ModelVisitor visitor,
    StringBuffer classBuffer,
  ) {


    // for (final field in visitor.fields.keys) {
    //   final variable =
    //       field.startsWith('_') ? field.replaceFirst('_', '') : field;
    //
    //   classBuffer.writeln(
    //       "${visitor.fields[field]} get ${variable.camelCase} => variables['$variable'];");
    //   // EX: String get name => variables['name'];
    //
    //   //ignore:cascade_invocations
    //   classBuffer.writeln(
    //       'set ${variable.camelCase}(${visitor.fields[field]} $variable) {');
    //   //ignore:cascade_invocations
    //   classBuffer.writeln('super.$field = $variable;');
    //   //ignore:cascade_invocations
    //   classBuffer.writeln("variables['$variable'] = $variable;");
    //   //ignore:cascade_invocations
    //   classBuffer.writeln('}');
    //
    //   // EX: set name(String name) {
    //   //       super._name = name;
    //   //       variables['name'] = name;
    //   //     }
    // }
  }*/
}
