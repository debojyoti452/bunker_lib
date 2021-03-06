Welcome to [Bunker].

[![Pub Version](https://img.shields.io/pub/v/bunker_lib?style=for-the-badge)](https://pub.dev/packages/bunker_lib)
[![GitHub issues](https://img.shields.io/github/issues/debojyoti452/bunker_lib?style=for-the-badge)](https://github.com/debojyoti452/bunker_lib/issues)
[![GitHub stars](https://img.shields.io/github/stars/debojyoti452/bunker_lib?style=for-the-badge)](https://github.com/debojyoti452/bunker_lib/stargazers)
[![GitHub license](https://img.shields.io/github/license/debojyoti452/bunker_lib?style=for-the-badge)](https://github.com/debojyoti452/bunker_lib/blob/main/LICENSE)

# 1.0.5 and null-safety

**Important note**:

```yaml
dependencies:
  bunker_annotation: ^0.0.3

dev_dependencies:
  bunker_lib: ^1.0.5
```

## Run the generator

To run the code generator you have two possibilities:

- If your package depends on Flutter:
    - `flutter pub run build_runner build`
- If your package _does not_ depend on Flutter:
    - `dart pub run build_runner build`

Note that like most code-generators, [Bunker] will need you to both import the annotation ([meta])
and use the `part` keyword on the top of your files.

## copyWith

As stated in the very beginning of this readme, [Bunker] does not compromise
on the syntax to have a powerful copy.

The `copyWith` method generated by [Bunker] **does** support assigning a value
to `null`.\
For example, if we take our previous `Model` class:

```dart
@BunkerAnnotation()
class Model with _$Model {
  factory Model(String name, int age);
}
```
