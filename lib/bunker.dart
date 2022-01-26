library bunker;

import 'package:build/build.dart';
import 'package:bunker_lib/src/builder/extension_generator.dart';
import 'package:source_gen/source_gen.dart';

import 'src/builder/bunker_generator.dart';

Builder generateExtension(BuilderOptions options) =>
    SharedPartBuilder([ExtensionGenerator()], 'extension_generator');

// Builder bunker(BuilderOptions options) =>
//     SharedPartBuilder([BunkerGenerator()], 'bunker');

Builder bunkerBuilder(BuilderOptions options) =>
    PartBuilder([BunkerGenerator()], '.bunker.dart',
        header: '''
        // Bunker Generated Files
        // coverage:ignore-file
        // GENERATED CODE - DO NOT MODIFY BY HAND
        // ignore_for_file: type=lint
        ''',
        options: options);

/*Builder bunker(BuilderOptions options) {
  return PartBuilder([SubclassGenerator()], '.bunker.dart',
      header: '''
      // Bunker Generated Files
      // coverage:ignore-file
      // GENERATED CODE - DO NOT MODIFY BY HAND
      // ignore_for_file: type=lint
      // ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target
      ''',
      options: options);
}*/
