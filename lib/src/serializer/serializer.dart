import 'package:bunker_lib/src/serializer/json_converter.dart';
import 'package:bunker_lib/src/utils/parser.dart';

abstract class Serializer implements JsonConverter<dynamic, dynamic> {
  final RenameFieldEnum fieldEnum;

  final bool isJsonRequired;

  const Serializer({
    this.fieldEnum = RenameFieldEnum.defaultType,
    this.isJsonRequired = false,
  });
}
