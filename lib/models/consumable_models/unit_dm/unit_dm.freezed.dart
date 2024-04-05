// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'unit_dm.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

UnitDM _$UnitDMFromJson(Map<String, dynamic> json) {
  return _UnitDM.fromJson(json);
}

/// @nodoc
mixin _$UnitDM {
  String get name => throw _privateConstructorUsedError;
  int get id => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UnitDMCopyWith<UnitDM> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UnitDMCopyWith<$Res> {
  factory $UnitDMCopyWith(UnitDM value, $Res Function(UnitDM) then) =
      _$UnitDMCopyWithImpl<$Res, UnitDM>;
  @useResult
  $Res call({String name, int id});
}

/// @nodoc
class _$UnitDMCopyWithImpl<$Res, $Val extends UnitDM>
    implements $UnitDMCopyWith<$Res> {
  _$UnitDMCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? id = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UnitDMImplCopyWith<$Res> implements $UnitDMCopyWith<$Res> {
  factory _$$UnitDMImplCopyWith(
          _$UnitDMImpl value, $Res Function(_$UnitDMImpl) then) =
      __$$UnitDMImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, int id});
}

/// @nodoc
class __$$UnitDMImplCopyWithImpl<$Res>
    extends _$UnitDMCopyWithImpl<$Res, _$UnitDMImpl>
    implements _$$UnitDMImplCopyWith<$Res> {
  __$$UnitDMImplCopyWithImpl(
      _$UnitDMImpl _value, $Res Function(_$UnitDMImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? id = null,
  }) {
    return _then(_$UnitDMImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UnitDMImpl implements _UnitDM {
  const _$UnitDMImpl({required this.name, required this.id});

  factory _$UnitDMImpl.fromJson(Map<String, dynamic> json) =>
      _$$UnitDMImplFromJson(json);

  @override
  final String name;
  @override
  final int id;

  @override
  String toString() {
    return 'UnitDM(name: $name, id: $id)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UnitDMImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.id, id) || other.id == id));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, name, id);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UnitDMImplCopyWith<_$UnitDMImpl> get copyWith =>
      __$$UnitDMImplCopyWithImpl<_$UnitDMImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UnitDMImplToJson(
      this,
    );
  }
}

abstract class _UnitDM implements UnitDM {
  const factory _UnitDM({required final String name, required final int id}) =
      _$UnitDMImpl;

  factory _UnitDM.fromJson(Map<String, dynamic> json) = _$UnitDMImpl.fromJson;

  @override
  String get name;
  @override
  int get id;
  @override
  @JsonKey(ignore: true)
  _$$UnitDMImplCopyWith<_$UnitDMImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
