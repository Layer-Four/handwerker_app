// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'documentation_entry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

DocumentationEntry _$DocumentationEntryFromJson(Map<String, dynamic> json) {
  return _DocumentationEntry.fromJson(json);
}

/// @nodoc
mixin _$DocumentationEntry {
  DateTime? get createDate => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError; // int? id,
  int? get projectID =>
      throw _privateConstructorUsedError; // String? projectName,
  String? get signature => throw _privateConstructorUsedError;
  List<String> get imageUrl => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DocumentationEntryCopyWith<DocumentationEntry> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DocumentationEntryCopyWith<$Res> {
  factory $DocumentationEntryCopyWith(
          DocumentationEntry value, $Res Function(DocumentationEntry) then) =
      _$DocumentationEntryCopyWithImpl<$Res, DocumentationEntry>;
  @useResult
  $Res call(
      {DateTime? createDate,
      String? description,
      int? projectID,
      String? signature,
      List<String> imageUrl});
}

/// @nodoc
class _$DocumentationEntryCopyWithImpl<$Res, $Val extends DocumentationEntry>
    implements $DocumentationEntryCopyWith<$Res> {
  _$DocumentationEntryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? createDate = freezed,
    Object? description = freezed,
    Object? projectID = freezed,
    Object? signature = freezed,
    Object? imageUrl = null,
  }) {
    return _then(_value.copyWith(
      createDate: freezed == createDate
          ? _value.createDate
          : createDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      projectID: freezed == projectID
          ? _value.projectID
          : projectID // ignore: cast_nullable_to_non_nullable
              as int?,
      signature: freezed == signature
          ? _value.signature
          : signature // ignore: cast_nullable_to_non_nullable
              as String?,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DocumentationEntryImplCopyWith<$Res>
    implements $DocumentationEntryCopyWith<$Res> {
  factory _$$DocumentationEntryImplCopyWith(_$DocumentationEntryImpl value,
          $Res Function(_$DocumentationEntryImpl) then) =
      __$$DocumentationEntryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {DateTime? createDate,
      String? description,
      int? projectID,
      String? signature,
      List<String> imageUrl});
}

/// @nodoc
class __$$DocumentationEntryImplCopyWithImpl<$Res>
    extends _$DocumentationEntryCopyWithImpl<$Res, _$DocumentationEntryImpl>
    implements _$$DocumentationEntryImplCopyWith<$Res> {
  __$$DocumentationEntryImplCopyWithImpl(_$DocumentationEntryImpl _value,
      $Res Function(_$DocumentationEntryImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? createDate = freezed,
    Object? description = freezed,
    Object? projectID = freezed,
    Object? signature = freezed,
    Object? imageUrl = null,
  }) {
    return _then(_$DocumentationEntryImpl(
      createDate: freezed == createDate
          ? _value.createDate
          : createDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      projectID: freezed == projectID
          ? _value.projectID
          : projectID // ignore: cast_nullable_to_non_nullable
              as int?,
      signature: freezed == signature
          ? _value.signature
          : signature // ignore: cast_nullable_to_non_nullable
              as String?,
      imageUrl: null == imageUrl
          ? _value._imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DocumentationEntryImpl implements _DocumentationEntry {
  const _$DocumentationEntryImpl(
      {this.createDate,
      this.description,
      this.projectID,
      this.signature,
      final List<String> imageUrl = const <String>[]})
      : _imageUrl = imageUrl;

  factory _$DocumentationEntryImpl.fromJson(Map<String, dynamic> json) =>
      _$$DocumentationEntryImplFromJson(json);

  @override
  final DateTime? createDate;
  @override
  final String? description;
// int? id,
  @override
  final int? projectID;
// String? projectName,
  @override
  final String? signature;
  final List<String> _imageUrl;
  @override
  @JsonKey()
  List<String> get imageUrl {
    if (_imageUrl is EqualUnmodifiableListView) return _imageUrl;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_imageUrl);
  }

  @override
  String toString() {
    return 'DocumentationEntry(createDate: $createDate, description: $description, projectID: $projectID, signature: $signature, imageUrl: $imageUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DocumentationEntryImpl &&
            (identical(other.createDate, createDate) ||
                other.createDate == createDate) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.projectID, projectID) ||
                other.projectID == projectID) &&
            (identical(other.signature, signature) ||
                other.signature == signature) &&
            const DeepCollectionEquality().equals(other._imageUrl, _imageUrl));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, createDate, description,
      projectID, signature, const DeepCollectionEquality().hash(_imageUrl));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DocumentationEntryImplCopyWith<_$DocumentationEntryImpl> get copyWith =>
      __$$DocumentationEntryImplCopyWithImpl<_$DocumentationEntryImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DocumentationEntryImplToJson(
      this,
    );
  }
}

abstract class _DocumentationEntry implements DocumentationEntry {
  const factory _DocumentationEntry(
      {final DateTime? createDate,
      final String? description,
      final int? projectID,
      final String? signature,
      final List<String> imageUrl}) = _$DocumentationEntryImpl;

  factory _DocumentationEntry.fromJson(Map<String, dynamic> json) =
      _$DocumentationEntryImpl.fromJson;

  @override
  DateTime? get createDate;
  @override
  String? get description;
  @override // int? id,
  int? get projectID;
  @override // String? projectName,
  String? get signature;
  @override
  List<String> get imageUrl;
  @override
  @JsonKey(ignore: true)
  _$$DocumentationEntryImplCopyWith<_$DocumentationEntryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
