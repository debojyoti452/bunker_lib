import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:bunker_annotation/bunker_annotation.dart';
import 'package:bunker_lib/src/data/model_visitor.dart';
import 'package:bunker_lib/src/utils/getter_setter.dart';
import 'package:source_gen/source_gen.dart';

class BunkerGenerator extends GeneratorForAnnotation<BunkerAnnotation>
    with GeneratorUtilMixin {
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
        .writeln('class $_className extends _\$${visitor.className}Bunker {');

    _classBuffer.writeln('Map<String, dynamic> _variables = {};');

    _classBuffer.writeln('$_className() {');

    visitor.fields.forEach((value, dynamic key) {
      final variable =
          value.startsWith('_') ? value.replaceFirst('_', '') : value;
      _classBuffer.write('$variable = super.$variable;');
    });

    _classBuffer.writeln('}');

    generateGetterAndSetter(visitor, _classBuffer);

    generateCopyWith(visitor, _classBuffer, '${visitor.className}');

    _classBuffer.writeln('}');

    return _classBuffer.toString();
  }

  bool _isJsonSerializer(bool value) {
    return value;
  }
}
