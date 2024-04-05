// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'consumable_entry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ConsumealbeEntry _$ConsumealbeEntryFromJson(Map<String, dynamic> json) {
  return _ConsumealbeEntry.fromJson(json);
}

/// @nodoc
mixin _$ConsumealbeEntry {
  DateTime get createDate =>
      throw _privateConstructorUsedError; // @Default('') String entryID,
// String? projectName,
  int? get projectID => throw _privateConstructorUsedError;
  List<Consumable> get consumables => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ConsumealbeEntryCopyWith<ConsumealbeEntry> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConsumealbeEntryCopyWith<$Res> {
  factory $ConsumealbeEntryCopyWith(
          ConsumealbeEntry value, $Res Function(ConsumealbeEntry) then) =
      _$ConsumealbeEntryCopyWithImpl<$Res, ConsumealbeEntry>;
  @useResult
  $Res call(
      {DateTime createDate, int? projectID, List<Consumable> consumables});
}

/// @nodoc
class _$ConsumealbeEntryCopyWithImpl<$Res, $Val extends ConsumealbeEntry>
    implements $ConsumealbeEntryCopyWith<$Res> {
  _$ConsumealbeEntryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? createDate = null,
    Object? projectID = freezed,
    Object? consumables = null,
  }) {
    return _then(_value.copyWith(
      createDate: null == createDate
          ? _value.createDate
          : createDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      projectID: freezed == projectID
          ? _value.projectID
          : projectID // ignore: cast_nullable_to_non_nullable
              as int?,
      consumables: null == consumables
          ? _value.consumables
          : consumables // ignore: cast_nullable_to_non_nullable
              as List<Consumable>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ConsumealbeEntryImplCopyWith<$Res>
    implements $ConsumealbeEntryCopyWith<$Res> {
  factory _$$ConsumealbeEntryImplCopyWith(_$ConsumealbeEntryImpl value,
          $Res Function(_$ConsumealbeEntryImpl) then) =
      __$$ConsumealbeEntryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {DateTime createDate, int? projectID, List<Consumable> consumables});
}

/// @nodoc
class __$$ConsumealbeEntryImplCopyWithImpl<$Res>
    extends _$ConsumealbeEntryCopyWithImpl<$Res, _$ConsumealbeEntryImpl>
    implements _$$ConsumealbeEntryImplCopyWith<$Res> {
  __$$ConsumealbeEntryImplCopyWithImpl(_$ConsumealbeEntryImpl _value,
      $Res Function(_$ConsumealbeEntryImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? createDate = null,
    Object? projectID = freezed,
    Object? consumables = null,
  }) {
    return _then(_$ConsumealbeEntryImpl(
      createDate: null == createDate
          ? _value.createDate
          : createDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      projectID: freezed == projectID
          ? _value.projectID
          : projectID // ignore: cast_nullable_to_non_nullable
              as int?,
      consumables: null == consumables
          ? _value._consumables
          : consumables // ignore: cast_nullable_to_non_nullable
              as List<Consumable>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ConsumealbeEntryImpl implements _ConsumealbeEntry {
  const _$ConsumealbeEntryImpl(
      {required this.createDate,
      this.projectID,
      final List<Consumable> consumables = const <Consumable>[]})
      : _consumables = consumables;

  factory _$ConsumealbeEntryImpl.fromJson(Map<String, dynamic> json) =>
      _$$ConsumealbeEntryImplFromJson(json);

  @override
  final DateTime createDate;
// @Default('') String entryID,
// String? projectName,
  @override
  final int? projectID;
  final List<Consumable> _consumables;
  @override
  @JsonKey()
  List<Consumable> get consumables {
    if (_consumables is EqualUnmodifiableListView) return _consumables;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_consumables);
  }

  @override
  String toString() {
    return 'ConsumealbeEntry(createDate: $createDate, projectID: $projectID, consumables: $consumables)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConsumealbeEntryImpl &&
            (identical(other.createDate, createDate) ||
                other.createDate == createDate) &&
            (identical(other.projectID, projectID) ||
                other.projectID == projectID) &&
            const DeepCollectionEquality()
                .equals(other._consumables, _consumables));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, createDate, projectID,
      const DeepCollectionEquality().hash(_consumables));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ConsumealbeEntryImplCopyWith<_$ConsumealbeEntryImpl> get copyWith =>
      __$$ConsumealbeEntryImplCopyWithImpl<_$ConsumealbeEntryImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ConsumealbeEntryImplToJson(
      this,
    );
  }
}

abstract class _ConsumealbeEntry implements ConsumealbeEntry {
  const factory _ConsumealbeEntry(
      {required final DateTime createDate,
      final int? projectID,
      final List<Consumable> consumables}) = _$ConsumealbeEntryImpl;

  factory _ConsumealbeEntry.fromJson(Map<String, dynamic> json) =
      _$ConsumealbeEntryImpl.fromJson;

  @override
  DateTime get createDate;
  @override // @Default('') String entryID,
// String? projectName,
  int? get projectID;
  @override
  List<Consumable> get consumables;
  @override
  @JsonKey(ignore: true)
  _$$ConsumealbeEntryImplCopyWith<_$ConsumealbeEntryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
