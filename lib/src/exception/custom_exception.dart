import 'package:bunker_lib/src/constants/exception_message.dart';

class CustomException implements Exception {
  final ExceptionMessage type;

  CustomException(this.type);

  @override
  String toString() {
    var result = 'Serialize Error';

    switch (type) {
      case ExceptionMessage.serializeError:
        {
          result = 'Failed to parse json map';
        }
        break;

      case ExceptionMessage.setterError:
        {
          result = 'Failed to create setter error';
        }
        break;

      default:
        {
          result = 'default error';
        }
    }

    return result;
  }
}
