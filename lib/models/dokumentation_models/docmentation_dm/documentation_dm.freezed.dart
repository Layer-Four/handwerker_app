// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'documentation_dm.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

DocumentationDM _$DocumentationDMFromJson(Map<String, dynamic> json) {
  return _DocumentationDM.fromJson(json);
}

/// @nodoc
mixin _$DocumentationDM {
  String? get description => throw _privateConstructorUsedError;
  List<String> get imagesUrl => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DocumentationDMCopyWith<DocumentationDM> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DocumentationDMCopyWith<$Res> {
  factory $DocumentationDMCopyWith(
          DocumentationDM value, $Res Function(DocumentationDM) then) =
      _$DocumentationDMCopyWithImpl<$Res, DocumentationDM>;
  @useResult
  $Res call({String? description, List<String> imagesUrl});
}

/// @nodoc
class _$DocumentationDMCopyWithImpl<$Res, $Val extends DocumentationDM>
    implements $DocumentationDMCopyWith<$Res> {
  _$DocumentationDMCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? description = freezed,
    Object? imagesUrl = null,
  }) {
    return _then(_value.copyWith(
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      imagesUrl: null == imagesUrl
          ? _value.imagesUrl
          : imagesUrl // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DocumentationDMImplCopyWith<$Res>
    implements $DocumentationDMCopyWith<$Res> {
  factory _$$DocumentationDMImplCopyWith(_$DocumentationDMImpl value,
          $Res Function(_$DocumentationDMImpl) then) =
      __$$DocumentationDMImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? description, List<String> imagesUrl});
}

/// @nodoc
class __$$DocumentationDMImplCopyWithImpl<$Res>
    extends _$DocumentationDMCopyWithImpl<$Res, _$DocumentationDMImpl>
    implements _$$DocumentationDMImplCopyWith<$Res> {
  __$$DocumentationDMImplCopyWithImpl(
      _$DocumentationDMImpl _value, $Res Function(_$DocumentationDMImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? description = freezed,
    Object? imagesUrl = null,
  }) {
    return _then(_$DocumentationDMImpl(
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      imagesUrl: null == imagesUrl
          ? _value._imagesUrl
          : imagesUrl // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DocumentationDMImpl extends _DocumentationDM {
  const _$DocumentationDMImpl(
      {this.description, final List<String> imagesUrl = const <String>[]})
      : _imagesUrl = imagesUrl,
        super._();

  factory _$DocumentationDMImpl.fromJson(Map<String, dynamic> json) =>
      _$$DocumentationDMImplFromJson(json);

  @override
  final String? description;
  final List<String> _imagesUrl;
  @override
  @JsonKey()
  List<String> get imagesUrl {
    if (_imagesUrl is EqualUnmodifiableListView) return _imagesUrl;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_imagesUrl);
  }

  @override
  String toString() {
    return 'DocumentationDM(description: $description, imagesUrl: $imagesUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DocumentationDMImpl &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality()
                .equals(other._imagesUrl, _imagesUrl));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, description,
      const DeepCollectionEquality().hash(_imagesUrl));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DocumentationDMImplCopyWith<_$DocumentationDMImpl> get copyWith =>
      __$$DocumentationDMImplCopyWithImpl<_$DocumentationDMImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DocumentationDMImplToJson(
      this,
    );
  }
}

abstract class _DocumentationDM extends DocumentationDM {
  const factory _DocumentationDM(
      {final String? description,
      final List<String> imagesUrl}) = _$DocumentationDMImpl;
  const _DocumentationDM._() : super._();

  factory _DocumentationDM.fromJson(Map<String, dynamic> json) =
      _$DocumentationDMImpl.fromJson;

  @override
  String? get description;
  @override
  List<String> get imagesUrl;
  @override
  @JsonKey(ignore: true)
  _$$DocumentationDMImplCopyWith<_$DocumentationDMImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
