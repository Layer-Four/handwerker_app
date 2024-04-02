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
  int? get id => throw _privateConstructorUsedError;
  int? get projectID => throw _privateConstructorUsedError;
  String? get projectName => throw _privateConstructorUsedError;
  DateTime get createDate => throw _privateConstructorUsedError;
  List<String> get imageUrl => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;

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
      {int? id,
      int? projectID,
      String? projectName,
      DateTime createDate,
      List<String> imageUrl,
      String? description});
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
    Object? id = freezed,
    Object? projectID = freezed,
    Object? projectName = freezed,
    Object? createDate = null,
    Object? imageUrl = null,
    Object? description = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      projectID: freezed == projectID
          ? _value.projectID
          : projectID // ignore: cast_nullable_to_non_nullable
              as int?,
      projectName: freezed == projectName
          ? _value.projectName
          : projectName // ignore: cast_nullable_to_non_nullable
              as String?,
      createDate: null == createDate
          ? _value.createDate
          : createDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as List<String>,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
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
      {int? id,
      int? projectID,
      String? projectName,
      DateTime createDate,
      List<String> imageUrl,
      String? description});
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
    Object? id = freezed,
    Object? projectID = freezed,
    Object? projectName = freezed,
    Object? createDate = null,
    Object? imageUrl = null,
    Object? description = freezed,
  }) {
    return _then(_$DocumentationEntryImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      projectID: freezed == projectID
          ? _value.projectID
          : projectID // ignore: cast_nullable_to_non_nullable
              as int?,
      projectName: freezed == projectName
          ? _value.projectName
          : projectName // ignore: cast_nullable_to_non_nullable
              as String?,
      createDate: null == createDate
          ? _value.createDate
          : createDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      imageUrl: null == imageUrl
          ? _value._imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as List<String>,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DocumentationEntryImpl implements _DocumentationEntry {
  const _$DocumentationEntryImpl(
      {this.id,
      this.projectID,
      this.projectName,
      required this.createDate,
      final List<String> imageUrl = const <String>[],
      this.description})
      : _imageUrl = imageUrl;

  factory _$DocumentationEntryImpl.fromJson(Map<String, dynamic> json) =>
      _$$DocumentationEntryImplFromJson(json);

  @override
  final int? id;
  @override
  final int? projectID;
  @override
  final String? projectName;
  @override
  final DateTime createDate;
  final List<String> _imageUrl;
  @override
  @JsonKey()
  List<String> get imageUrl {
    if (_imageUrl is EqualUnmodifiableListView) return _imageUrl;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_imageUrl);
  }

  @override
  final String? description;

  @override
  String toString() {
    return 'DocumentationEntry(id: $id, projectID: $projectID, projectName: $projectName, createDate: $createDate, imageUrl: $imageUrl, description: $description)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DocumentationEntryImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.projectID, projectID) ||
                other.projectID == projectID) &&
            (identical(other.projectName, projectName) ||
                other.projectName == projectName) &&
            (identical(other.createDate, createDate) ||
                other.createDate == createDate) &&
            const DeepCollectionEquality().equals(other._imageUrl, _imageUrl) &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, projectID, projectName,
      createDate, const DeepCollectionEquality().hash(_imageUrl), description);

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
      {final int? id,
      final int? projectID,
      final String? projectName,
      required final DateTime createDate,
      final List<String> imageUrl,
      final String? description}) = _$DocumentationEntryImpl;

  factory _DocumentationEntry.fromJson(Map<String, dynamic> json) =
      _$DocumentationEntryImpl.fromJson;

  @override
  int? get id;
  @override
  int? get projectID;
  @override
  String? get projectName;
  @override
  DateTime get createDate;
  @override
  List<String> get imageUrl;
  @override
  String? get description;
  @override
  @JsonKey(ignore: true)
  _$$DocumentationEntryImplCopyWith<_$DocumentationEntryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
