// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'localization_label.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

LocalizationLabel _$LocalizationLabelFromJson(Map<String, dynamic> json) {
  return _LocalizationLabel.fromJson(json);
}

/// @nodoc
class _$LocalizationLabelTearOff {
  const _$LocalizationLabelTearOff();

  _LocalizationLabel call(
      {required String code,
      required String message,
      required String module,
      @JsonKey(name: 'locale') String? locale}) {
    return _LocalizationLabel(
      code: code,
      message: message,
      module: module,
      locale: locale,
    );
  }

  LocalizationLabel fromJson(Map<String, Object?> json) {
    return LocalizationLabel.fromJson(json);
  }
}

/// @nodoc
const $LocalizationLabel = _$LocalizationLabelTearOff();

/// @nodoc
mixin _$LocalizationLabel {
  String get code => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  String get module => throw _privateConstructorUsedError;
  @JsonKey(name: 'locale')
  String? get locale => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LocalizationLabelCopyWith<LocalizationLabel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LocalizationLabelCopyWith<$Res> {
  factory $LocalizationLabelCopyWith(
          LocalizationLabel value, $Res Function(LocalizationLabel) then) =
      _$LocalizationLabelCopyWithImpl<$Res>;
  $Res call(
      {String code,
      String message,
      String module,
      @JsonKey(name: 'locale') String? locale});
}

/// @nodoc
class _$LocalizationLabelCopyWithImpl<$Res>
    implements $LocalizationLabelCopyWith<$Res> {
  _$LocalizationLabelCopyWithImpl(this._value, this._then);

  final LocalizationLabel _value;
  // ignore: unused_field
  final $Res Function(LocalizationLabel) _then;

  @override
  $Res call({
    Object? code = freezed,
    Object? message = freezed,
    Object? module = freezed,
    Object? locale = freezed,
  }) {
    return _then(_value.copyWith(
      code: code == freezed
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      message: message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      module: module == freezed
          ? _value.module
          : module // ignore: cast_nullable_to_non_nullable
              as String,
      locale: locale == freezed
          ? _value.locale
          : locale // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
abstract class _$LocalizationLabelCopyWith<$Res>
    implements $LocalizationLabelCopyWith<$Res> {
  factory _$LocalizationLabelCopyWith(
          _LocalizationLabel value, $Res Function(_LocalizationLabel) then) =
      __$LocalizationLabelCopyWithImpl<$Res>;
  @override
  $Res call(
      {String code,
      String message,
      String module,
      @JsonKey(name: 'locale') String? locale});
}

/// @nodoc
class __$LocalizationLabelCopyWithImpl<$Res>
    extends _$LocalizationLabelCopyWithImpl<$Res>
    implements _$LocalizationLabelCopyWith<$Res> {
  __$LocalizationLabelCopyWithImpl(
      _LocalizationLabel _value, $Res Function(_LocalizationLabel) _then)
      : super(_value, (v) => _then(v as _LocalizationLabel));

  @override
  _LocalizationLabel get _value => super._value as _LocalizationLabel;

  @override
  $Res call({
    Object? code = freezed,
    Object? message = freezed,
    Object? module = freezed,
    Object? locale = freezed,
  }) {
    return _then(_LocalizationLabel(
      code: code == freezed
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      message: message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      module: module == freezed
          ? _value.module
          : module // ignore: cast_nullable_to_non_nullable
              as String,
      locale: locale == freezed
          ? _value.locale
          : locale // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_LocalizationLabel implements _LocalizationLabel {
  const _$_LocalizationLabel(
      {required this.code,
      required this.message,
      required this.module,
      @JsonKey(name: 'locale') this.locale});

  factory _$_LocalizationLabel.fromJson(Map<String, dynamic> json) =>
      _$$_LocalizationLabelFromJson(json);

  @override
  final String code;
  @override
  final String message;
  @override
  final String module;
  @override
  @JsonKey(name: 'locale')
  final String? locale;

  @override
  String toString() {
    return 'LocalizationLabel(code: $code, message: $message, module: $module, locale: $locale)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _LocalizationLabel &&
            const DeepCollectionEquality().equals(other.code, code) &&
            const DeepCollectionEquality().equals(other.message, message) &&
            const DeepCollectionEquality().equals(other.module, module) &&
            const DeepCollectionEquality().equals(other.locale, locale));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(code),
      const DeepCollectionEquality().hash(message),
      const DeepCollectionEquality().hash(module),
      const DeepCollectionEquality().hash(locale));

  @JsonKey(ignore: true)
  @override
  _$LocalizationLabelCopyWith<_LocalizationLabel> get copyWith =>
      __$LocalizationLabelCopyWithImpl<_LocalizationLabel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_LocalizationLabelToJson(this);
  }
}

abstract class _LocalizationLabel implements LocalizationLabel {
  const factory _LocalizationLabel(
      {required String code,
      required String message,
      required String module,
      @JsonKey(name: 'locale') String? locale}) = _$_LocalizationLabel;

  factory _LocalizationLabel.fromJson(Map<String, dynamic> json) =
      _$_LocalizationLabel.fromJson;

  @override
  String get code;
  @override
  String get message;
  @override
  String get module;
  @override
  @JsonKey(name: 'locale')
  String? get locale;
  @override
  @JsonKey(ignore: true)
  _$LocalizationLabelCopyWith<_LocalizationLabel> get copyWith =>
      throw _privateConstructorUsedError;
}
