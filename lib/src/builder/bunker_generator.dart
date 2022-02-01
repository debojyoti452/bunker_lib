import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:bunker_annotation/bunker_annotation.dart';
import 'package:bunker_lib/src/constants/constants.dart';
import 'package:bunker_lib/src/data/model_visitor.dart';
import 'package:bunker_lib/src/utils/generator_util_mixin.dart';
import 'package:bunker_lib/src/utils/string_manipulation.dart';
import 'package:source_gen/source_gen.dart';

class BunkerGenerator extends GeneratorForAnnotation<BunkerAnnotation> with GeneratorUtilMixin {
  @override
  String generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    final _modelVisitor = ModelVisitor();

    var isJsonSerializer = annotation.peek('isJsonSerializer')?.boolValue;

    element.visitChildren(_modelVisitor);

    final _className = '${_modelVisitor.className}';
    final _classBuffer = StringBuffer();

    _classBuffer.writeln('class $_className extends _\$${_modelVisitor.className}Bunker {');

    _classBuffer.writeln('Map<String, dynamic> _variables = {};');

    _classBuffer.writeln('$_className() {');

    _modelVisitor.dataMap.forEach((value, dynamic key) {
      final variable = value.removeUnderScore;
      _classBuffer.write('$variable = super.$variable;');
    });

    _classBuffer.writeln('}');

    generateGetterAndSetter(_modelVisitor, _classBuffer);

    generateCopyWith(_modelVisitor, _classBuffer, '${_modelVisitor.className}');

    if (_isJsonSerializer(isJsonSerializer ?? false) == true) {
      toJson(_modelVisitor, _classBuffer);
      // fromJson(json);
    }

    _classBuffer.writeln(Constants.closeFirstBracket);

    return _classBuffer.toString();
  }

  bool _isJsonSerializer(bool value) {
    return value;
  }
}
