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

ConsumalbeEntry _$ConsumalbeEntryFromJson(Map<String, dynamic> json) {
  return _ConsumalbeEntry.fromJson(json);
}

/// @nodoc
mixin _$ConsumalbeEntry {
  DateTime? get createDate => throw _privateConstructorUsedError;
  int? get projectID => throw _privateConstructorUsedError;
  List<ConsumableDM> get consumables => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ConsumalbeEntryCopyWith<ConsumalbeEntry> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConsumalbeEntryCopyWith<$Res> {
  factory $ConsumalbeEntryCopyWith(
          ConsumalbeEntry value, $Res Function(ConsumalbeEntry) then) =
      _$ConsumalbeEntryCopyWithImpl<$Res, ConsumalbeEntry>;
  @useResult
  $Res call(
      {DateTime? createDate, int? projectID, List<ConsumableDM> consumables});
}

/// @nodoc
class _$ConsumalbeEntryCopyWithImpl<$Res, $Val extends ConsumalbeEntry>
    implements $ConsumalbeEntryCopyWith<$Res> {
  _$ConsumalbeEntryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? createDate = freezed,
    Object? projectID = freezed,
    Object? consumables = null,
  }) {
    return _then(_value.copyWith(
      createDate: freezed == createDate
          ? _value.createDate
          : createDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      projectID: freezed == projectID
          ? _value.projectID
          : projectID // ignore: cast_nullable_to_non_nullable
              as int?,
      consumables: null == consumables
          ? _value.consumables
          : consumables // ignore: cast_nullable_to_non_nullable
              as List<ConsumableDM>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ConsumalbeEntryImplCopyWith<$Res>
    implements $ConsumalbeEntryCopyWith<$Res> {
  factory _$$ConsumalbeEntryImplCopyWith(_$ConsumalbeEntryImpl value,
          $Res Function(_$ConsumalbeEntryImpl) then) =
      __$$ConsumalbeEntryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {DateTime? createDate, int? projectID, List<ConsumableDM> consumables});
}

/// @nodoc
class __$$ConsumalbeEntryImplCopyWithImpl<$Res>
    extends _$ConsumalbeEntryCopyWithImpl<$Res, _$ConsumalbeEntryImpl>
    implements _$$ConsumalbeEntryImplCopyWith<$Res> {
  __$$ConsumalbeEntryImplCopyWithImpl(
      _$ConsumalbeEntryImpl _value, $Res Function(_$ConsumalbeEntryImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? createDate = freezed,
    Object? projectID = freezed,
    Object? consumables = null,
  }) {
    return _then(_$ConsumalbeEntryImpl(
      createDate: freezed == createDate
          ? _value.createDate
          : createDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      projectID: freezed == projectID
          ? _value.projectID
          : projectID // ignore: cast_nullable_to_non_nullable
              as int?,
      consumables: null == consumables
          ? _value._consumables
          : consumables // ignore: cast_nullable_to_non_nullable
              as List<ConsumableDM>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ConsumalbeEntryImpl implements _ConsumalbeEntry {
  const _$ConsumalbeEntryImpl(
      {this.createDate,
      this.projectID,
      final List<ConsumableDM> consumables = const <ConsumableDM>[]})
      : _consumables = consumables;

  factory _$ConsumalbeEntryImpl.fromJson(Map<String, dynamic> json) =>
      _$$ConsumalbeEntryImplFromJson(json);

  @override
  final DateTime? createDate;
  @override
  final int? projectID;
  final List<ConsumableDM> _consumables;
  @override
  @JsonKey()
  List<ConsumableDM> get consumables {
    if (_consumables is EqualUnmodifiableListView) return _consumables;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_consumables);
  }

  @override
  String toString() {
    return 'ConsumalbeEntry(createDate: $createDate, projectID: $projectID, consumables: $consumables)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConsumalbeEntryImpl &&
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
  _$$ConsumalbeEntryImplCopyWith<_$ConsumalbeEntryImpl> get copyWith =>
      __$$ConsumalbeEntryImplCopyWithImpl<_$ConsumalbeEntryImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ConsumalbeEntryImplToJson(
      this,
    );
  }
}

abstract class _ConsumalbeEntry implements ConsumalbeEntry {
  const factory _ConsumalbeEntry(
      {final DateTime? createDate,
      final int? projectID,
      final List<ConsumableDM> consumables}) = _$ConsumalbeEntryImpl;

  factory _ConsumalbeEntry.fromJson(Map<String, dynamic> json) =
      _$ConsumalbeEntryImpl.fromJson;

  @override
  DateTime? get createDate;
  @override
  int? get projectID;
  @override
  List<ConsumableDM> get consumables;
  @override
  @JsonKey(ignore: true)
  _$$ConsumalbeEntryImplCopyWith<_$ConsumalbeEntryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
