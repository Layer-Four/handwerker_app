// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'consumable.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Consumable _$ConsumableFromJson(Map<String, dynamic> json) {
  return _Consumable.fromJson(json);
}

/// @nodoc
mixin _$Consumable {
  String get name => throw _privateConstructorUsedError;
  int get amount => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ConsumableCopyWith<Consumable> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConsumableCopyWith<$Res> {
  factory $ConsumableCopyWith(
          Consumable value, $Res Function(Consumable) then) =
      _$ConsumableCopyWithImpl<$Res, Consumable>;
  @useResult
  $Res call({String name, int amount});
}

/// @nodoc
class _$ConsumableCopyWithImpl<$Res, $Val extends Consumable>
    implements $ConsumableCopyWith<$Res> {
  _$ConsumableCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? amount = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ConsumableImplCopyWith<$Res>
    implements $ConsumableCopyWith<$Res> {
  factory _$$ConsumableImplCopyWith(
          _$ConsumableImpl value, $Res Function(_$ConsumableImpl) then) =
      __$$ConsumableImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, int amount});
}

/// @nodoc
class __$$ConsumableImplCopyWithImpl<$Res>
    extends _$ConsumableCopyWithImpl<$Res, _$ConsumableImpl>
    implements _$$ConsumableImplCopyWith<$Res> {
  __$$ConsumableImplCopyWithImpl(
      _$ConsumableImpl _value, $Res Function(_$ConsumableImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? amount = null,
  }) {
    return _then(_$ConsumableImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ConsumableImpl implements _Consumable {
  const _$ConsumableImpl({required this.name, this.amount = 1});

  factory _$ConsumableImpl.fromJson(Map<String, dynamic> json) =>
      _$$ConsumableImplFromJson(json);

  @override
  final String name;
  @override
  @JsonKey()
  final int amount;

  @override
  String toString() {
    return 'Consumable(name: $name, amount: $amount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConsumableImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.amount, amount) || other.amount == amount));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, name, amount);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ConsumableImplCopyWith<_$ConsumableImpl> get copyWith =>
      __$$ConsumableImplCopyWithImpl<_$ConsumableImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ConsumableImplToJson(
      this,
    );
  }
}

abstract class _Consumable implements Consumable {
  const factory _Consumable({required final String name, final int amount}) =
      _$ConsumableImpl;

  factory _Consumable.fromJson(Map<String, dynamic> json) =
      _$ConsumableImpl.fromJson;

  @override
  String get name;
  @override
  int get amount;
  @override
  @JsonKey(ignore: true)
  _$$ConsumableImplCopyWith<_$ConsumableImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
