// 1
import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:bunker_annotation/bunker_annotation.dart';
import 'package:bunker_lib/src/data/model_visitor.dart';
import 'package:source_gen/source_gen.dart';

// 2
class ExtensionGenerator extends GeneratorForAnnotation<ExtensionAnnotation> {
  // 3
  @override
  String generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) {
    // 4
    final visitor = ModelVisitor();
    element.visitChildren(visitor);

    final classBuffer = StringBuffer();

    // 5
    //ignore:cascade_invocations
    classBuffer.writeln('extension GeneratedModel on ${visitor.className} {');
    // EX: extension GeneratedModel on Model {

    // 6
    //ignore:cascade_invocations
    classBuffer.writeln('Map<String, dynamic> get variables => {');

    // 7
    for (final field in visitor.fields.keys) {
      final variable =
          field.startsWith('_') ? field.replaceFirst('_', '') : field;

      classBuffer.writeln("'$variable': $field,"); // EX: 'name': _name,
    }

    // 8
    classBuffer.writeln('};');

    // 9
    generateGettersAndSetters(visitor, classBuffer);

    // 10
    classBuffer.writeln('}');

    // 11
    return classBuffer.toString();
  }

  void generateGettersAndSetters(
      ModelVisitor visitor, StringBuffer classBuffer) {
// 1
    for (final field in visitor.fields.keys) {
      // 2
      final variable =
          field.startsWith('_') ? field.replaceFirst('_', '') : field;

      // 3 getter
      classBuffer.writeln(
          "${visitor.fields[field]} get $variable => variables['$variable'];");
      // EX: String get name => variables['name'];

      // 4 setter
      //ignore:cascade_invocations
      classBuffer.writeln('set $variable(${visitor.fields[field]} $variable)');
      //ignore:cascade_invocations
      classBuffer.writeln('=> $field = $variable;');
      // EX: set name(String name) => _name = name;
    }
  }
}
