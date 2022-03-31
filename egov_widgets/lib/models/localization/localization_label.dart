import 'package:freezed_annotation/freezed_annotation.dart';
part 'localization_label.g.dart';
part 'localization_label.freezed.dart';

@freezed
class LocalizationLabel with _$LocalizationLabel {
  const factory LocalizationLabel({
    required String code,
    required String message,
    required String module,
    @JsonKey(name: 'locale') String? locale,
  }) = _LocalizationLabel;

  factory LocalizationLabel.fromJson(Map<String, dynamic> json) => _$LocalizationLabelFromJson(json);
}

