import 'package:bunker_lib/src/constants/constants.dart';

class StringManipulation {
  final RegExp _upperAlphaRegex = RegExp(r'[A-Z]');

  final symbolSet = {' ', '.', '/', '_', '\\', '-'};

  late String originalText;
  late List<String> _words;

  StringManipulation(String? text) {
    originalText = text ?? '';
    _words = _groupIntoWords(text ?? '');
  }

  List<String> _groupIntoWords(String text) {
    var sb = StringBuffer();
    var words = <String>[];
    var isAllCaps = text.toUpperCase() == text;

    for (var i = 0; i < text.length; i++) {
      var char = text[i];
      var nextChar = i + 1 == text.length ? null : text[i + 1];

      if (symbolSet.contains(char)) {
        continue;
      }

      sb.write(char);

      var isEndOfWord =
          nextChar == null || (_upperAlphaRegex.hasMatch(nextChar) && !isAllCaps) || symbolSet.contains(nextChar);

      if (isEndOfWord) {
        words.add(sb.toString());
        sb.clear();
      }
    }

    return words;
  }

  /// camelCase
  String get camelCase => _getCamelCase();

  /// CONSTANT_CASE
  String get constantCase => _getConstantCase();

  /// Sentence case
  String get sentenceCase => _getSentenceCase();

  /// snake_case
  String get snakeCase => _getSnakeCase();

  /// dot.case
  String get dotCase => _getSnakeCase(separator: '.');

  /// param-case
  String get paramCase => _getSnakeCase(separator: '-');

  /// path/case
  String get pathCase => _getSnakeCase(separator: '/');

  /// PascalCase
  String get pascalCase => _getPascalCase();

  /// Header-Case
  String get headerCase => _getPascalCase(separator: '-');

  /// Title Case
  String get titleCase => _getPascalCase(separator: ' ');

  /// Remove UnderScore
  String get removeUnderScore => _removeUnderScore();

  String _getCamelCase({String separator = ''}) {
    var words = _words.map(_upperCaseFirstLetter).toList();
    if (_words.isNotEmpty) {
      words[0] = words[0].toLowerCase();
    }

    return words.join(separator);
  }

  String _getConstantCase({String separator = '_'}) {
    var words = _words.map((word) => word.toUpperCase()).toList();

    return words.join(separator);
  }

  String _getPascalCase({String separator = ''}) {
    var words = _words.map(_upperCaseFirstLetter).toList();

    return words.join(separator);
  }

  String _getSentenceCase({String separator = ' '}) {
    var words = _words.map((word) => word.toLowerCase()).toList();
    if (_words.isNotEmpty) {
      words[0] = _upperCaseFirstLetter(words[0]);
    }

    return words.join(separator);
  }

  String _getSnakeCase({String separator = '_'}) {
    var words = _words.map((word) => word.toLowerCase()).toList();

    return words.join(separator);
  }

  String _upperCaseFirstLetter(String word) {
    return '${word.substring(0, 1).toUpperCase()}${word.substring(1).toLowerCase()}';
  }

  String _removeUnderScore() {
    return originalText.startsWith('$Constants.underScoreMark')
        ? originalText.replaceFirst('$Constants.underScoreMark', '')
        : originalText;
  }
}

extension StringReCase on String {
  String get camelCase => StringManipulation(this).camelCase;

  String get constantCase => StringManipulation(this).constantCase;

  String get sentenceCase => StringManipulation(this).sentenceCase;

  String get snakeCase => StringManipulation(this).snakeCase;

  String get dotCase => StringManipulation(this).dotCase;

  String get paramCase => StringManipulation(this).paramCase;

  String get pathCase => StringManipulation(this).pathCase;

  String get pascalCase => StringManipulation(this).pascalCase;

  String get headerCase => StringManipulation(this).headerCase;

  String get titleCase => StringManipulation(this).titleCase;

  String get removeUnderScore => StringManipulation(this).removeUnderScore;
}
