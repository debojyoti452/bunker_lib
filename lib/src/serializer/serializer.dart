import 'package:bunker_lib/src/constants/enums.dart';
import 'package:bunker_lib/src/serializer/json_converter.dart';

abstract class Serializer implements JsonConverter<dynamic, dynamic> {
  final RenameFieldEnum fieldEnum;

  final bool isJsonRequired;

  const Serializer({
    this.fieldEnum = RenameFieldEnum.defaultType,
    this.isJsonRequired = false,
  });
}
