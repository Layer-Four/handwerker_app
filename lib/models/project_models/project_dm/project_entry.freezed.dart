// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'project_entry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ProjectEntry _$ProjectEntryFromJson(Map<String, dynamic> json) {
  return _ProjecEntryt.fromJson(json);
}

/// @nodoc
mixin _$ProjectEntry {
  BigInt get projectID => throw _privateConstructorUsedError;
  BigInt get customerID => throw _privateConstructorUsedError;
  String get customerName => throw _privateConstructorUsedError;
  String? get projectName => throw _privateConstructorUsedError;
  DateTime get createDate => throw _privateConstructorUsedError;
  List<String> get imageUrl => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ProjectEntryCopyWith<ProjectEntry> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProjectEntryCopyWith<$Res> {
  factory $ProjectEntryCopyWith(
          ProjectEntry value, $Res Function(ProjectEntry) then) =
      _$ProjectEntryCopyWithImpl<$Res, ProjectEntry>;
  @useResult
  $Res call(
      {BigInt projectID,
      BigInt customerID,
      String customerName,
      String? projectName,
      DateTime createDate,
      List<String> imageUrl,
      String? description});
}

/// @nodoc
class _$ProjectEntryCopyWithImpl<$Res, $Val extends ProjectEntry>
    implements $ProjectEntryCopyWith<$Res> {
  _$ProjectEntryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? projectID = null,
    Object? customerID = null,
    Object? customerName = null,
    Object? projectName = freezed,
    Object? createDate = null,
    Object? imageUrl = null,
    Object? description = freezed,
  }) {
    return _then(_value.copyWith(
      projectID: null == projectID
          ? _value.projectID
          : projectID // ignore: cast_nullable_to_non_nullable
              as BigInt,
      customerID: null == customerID
          ? _value.customerID
          : customerID // ignore: cast_nullable_to_non_nullable
              as BigInt,
      customerName: null == customerName
          ? _value.customerName
          : customerName // ignore: cast_nullable_to_non_nullable
              as String,
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
abstract class _$$ProjecEntrytImplCopyWith<$Res>
    implements $ProjectEntryCopyWith<$Res> {
  factory _$$ProjecEntrytImplCopyWith(
          _$ProjecEntrytImpl value, $Res Function(_$ProjecEntrytImpl) then) =
      __$$ProjecEntrytImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {BigInt projectID,
      BigInt customerID,
      String customerName,
      String? projectName,
      DateTime createDate,
      List<String> imageUrl,
      String? description});
}

/// @nodoc
class __$$ProjecEntrytImplCopyWithImpl<$Res>
    extends _$ProjectEntryCopyWithImpl<$Res, _$ProjecEntrytImpl>
    implements _$$ProjecEntrytImplCopyWith<$Res> {
  __$$ProjecEntrytImplCopyWithImpl(
      _$ProjecEntrytImpl _value, $Res Function(_$ProjecEntrytImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? projectID = null,
    Object? customerID = null,
    Object? customerName = null,
    Object? projectName = freezed,
    Object? createDate = null,
    Object? imageUrl = null,
    Object? description = freezed,
  }) {
    return _then(_$ProjecEntrytImpl(
      projectID: null == projectID
          ? _value.projectID
          : projectID // ignore: cast_nullable_to_non_nullable
              as BigInt,
      customerID: null == customerID
          ? _value.customerID
          : customerID // ignore: cast_nullable_to_non_nullable
              as BigInt,
      customerName: null == customerName
          ? _value.customerName
          : customerName // ignore: cast_nullable_to_non_nullable
              as String,
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
class _$ProjecEntrytImpl implements _ProjecEntryt {
  const _$ProjecEntrytImpl(
      {required this.projectID,
      required this.customerID,
      required this.customerName,
      this.projectName,
      required this.createDate,
      final List<String> imageUrl = const <String>[],
      this.description})
      : _imageUrl = imageUrl;

  factory _$ProjecEntrytImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProjecEntrytImplFromJson(json);

  @override
  final BigInt projectID;
  @override
  final BigInt customerID;
  @override
  final String customerName;
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
    return 'ProjectEntry(projectID: $projectID, customerID: $customerID, customerName: $customerName, projectName: $projectName, createDate: $createDate, imageUrl: $imageUrl, description: $description)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProjecEntrytImpl &&
            (identical(other.projectID, projectID) ||
                other.projectID == projectID) &&
            (identical(other.customerID, customerID) ||
                other.customerID == customerID) &&
            (identical(other.customerName, customerName) ||
                other.customerName == customerName) &&
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
  int get hashCode => Object.hash(
      runtimeType,
      projectID,
      customerID,
      customerName,
      projectName,
      createDate,
      const DeepCollectionEquality().hash(_imageUrl),
      description);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ProjecEntrytImplCopyWith<_$ProjecEntrytImpl> get copyWith =>
      __$$ProjecEntrytImplCopyWithImpl<_$ProjecEntrytImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProjecEntrytImplToJson(
      this,
    );
  }
}

abstract class _ProjecEntryt implements ProjectEntry {
  const factory _ProjecEntryt(
      {required final BigInt projectID,
      required final BigInt customerID,
      required final String customerName,
      final String? projectName,
      required final DateTime createDate,
      final List<String> imageUrl,
      final String? description}) = _$ProjecEntrytImpl;

  factory _ProjecEntryt.fromJson(Map<String, dynamic> json) =
      _$ProjecEntrytImpl.fromJson;

  @override
  BigInt get projectID;
  @override
  BigInt get customerID;
  @override
  String get customerName;
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
  _$$ProjecEntrytImplCopyWith<_$ProjecEntrytImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
