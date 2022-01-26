import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:bunker/src/data/model_visitor.dart';
import 'package:bunker/src/utils/string_manipulation.dart';
import 'package:bunker_annotation/bunker_annotation.dart';
import 'package:source_gen/source_gen.dart';

class BunkerGenerator extends GeneratorForAnnotation<BunkerAnnotation> {
  @override
  String generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    final visitor = ModelVisitor();

    var isJsonSerializer = annotation.peek('isJsonSerializer')?.boolValue;

    element.visitChildren(visitor);

    final _className = '${visitor.className}';
    final _classBuffer = StringBuffer();

    if (_isJsonSerializer(isJsonSerializer ?? false) == true) {
      _classBuffer.writeln('@JsonSerializable()');
    }
    _classBuffer
        .writeln('class $_className extends _${visitor.className}Bunker {');

    _classBuffer.writeln('Map<String, dynamic> _variables = {};');

    _classBuffer.writeln('$_className() {');

    visitor.fields.forEach((value, dynamic key) {
      final variable =
          value.startsWith('_') ? value.replaceFirst('_', '') : value;
      _classBuffer.write('$variable = super.$variable;');
    });

    _classBuffer.writeln('}');

    _generateGettersAndSetters(visitor, _classBuffer);
    _copyWithFunctions(visitor, _classBuffer, '${visitor.className}');

    _classBuffer.writeln('}');

    return _classBuffer.toString();
  }

  bool _isJsonSerializer(bool value) {
    return value;
  }

  void _copyWithFunctions(
    ModelVisitor visitor,
    StringBuffer classBuffer,
    String className,
  ) {
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

  void _generateGettersAndSetters(
    ModelVisitor visitor,
    StringBuffer classBuffer,
  ) {
    visitor.fields.forEach((value, dynamic key) {
      final variable =
          value.startsWith('_') ? value.replaceFirst('_', '') : value;
      classBuffer.writeln(
          "$key get ${variable.camelCase} => _variables['$variable'];");
      classBuffer.writeln('set ${variable.camelCase}($key $variable) {');
      classBuffer.writeln('super.$variable = $variable;');
      classBuffer.writeln("_variables['$variable'] = $variable;");
      classBuffer.writeln('}');
    });

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
  }
}
