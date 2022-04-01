// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'metric.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Metric _$MetricFromJson(Map<String, dynamic> json) {
  return _Metric.fromJson(json);
}

/// @nodoc
class _$MetricTearOff {
  const _$MetricTearOff();

  _Metric call({required String label, required String value, String? type}) {
    return _Metric(
      label: label,
      value: value,
      type: type,
    );
  }

  Metric fromJson(Map<String, Object?> json) {
    return Metric.fromJson(json);
  }
}

/// @nodoc
const $Metric = _$MetricTearOff();

/// @nodoc
mixin _$Metric {
  String get label => throw _privateConstructorUsedError;
  String get value => throw _privateConstructorUsedError;
  String? get type => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MetricCopyWith<Metric> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MetricCopyWith<$Res> {
  factory $MetricCopyWith(Metric value, $Res Function(Metric) then) =
      _$MetricCopyWithImpl<$Res>;
  $Res call({String label, String value, String? type});
}

/// @nodoc
class _$MetricCopyWithImpl<$Res> implements $MetricCopyWith<$Res> {
  _$MetricCopyWithImpl(this._value, this._then);

  final Metric _value;
  // ignore: unused_field
  final $Res Function(Metric) _then;

  @override
  $Res call({
    Object? label = freezed,
    Object? value = freezed,
    Object? type = freezed,
  }) {
    return _then(_value.copyWith(
      label: label == freezed
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
      value: value == freezed
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
abstract class _$MetricCopyWith<$Res> implements $MetricCopyWith<$Res> {
  factory _$MetricCopyWith(_Metric value, $Res Function(_Metric) then) =
      __$MetricCopyWithImpl<$Res>;
  @override
  $Res call({String label, String value, String? type});
}

/// @nodoc
class __$MetricCopyWithImpl<$Res> extends _$MetricCopyWithImpl<$Res>
    implements _$MetricCopyWith<$Res> {
  __$MetricCopyWithImpl(_Metric _value, $Res Function(_Metric) _then)
      : super(_value, (v) => _then(v as _Metric));

  @override
  _Metric get _value => super._value as _Metric;

  @override
  $Res call({
    Object? label = freezed,
    Object? value = freezed,
    Object? type = freezed,
  }) {
    return _then(_Metric(
      label: label == freezed
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
      value: value == freezed
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Metric implements _Metric {
  const _$_Metric({required this.label, required this.value, this.type});

  factory _$_Metric.fromJson(Map<String, dynamic> json) =>
      _$$_MetricFromJson(json);

  @override
  final String label;
  @override
  final String value;
  @override
  final String? type;

  @override
  String toString() {
    return 'Metric(label: $label, value: $value, type: $type)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Metric &&
            const DeepCollectionEquality().equals(other.label, label) &&
            const DeepCollectionEquality().equals(other.value, value) &&
            const DeepCollectionEquality().equals(other.type, type));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(label),
      const DeepCollectionEquality().hash(value),
      const DeepCollectionEquality().hash(type));

  @JsonKey(ignore: true)
  @override
  _$MetricCopyWith<_Metric> get copyWith =>
      __$MetricCopyWithImpl<_Metric>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_MetricToJson(this);
  }
}

abstract class _Metric implements Metric {
  const factory _Metric(
      {required String label, required String value, String? type}) = _$_Metric;

  factory _Metric.fromJson(Map<String, dynamic> json) = _$_Metric.fromJson;

  @override
  String get label;
  @override
  String get value;
  @override
  String? get type;
  @override
  @JsonKey(ignore: true)
  _$MetricCopyWith<_Metric> get copyWith => throw _privateConstructorUsedError;
}
