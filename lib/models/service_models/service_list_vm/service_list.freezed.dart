// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'service_list.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ServiceListVM _$ServiceListVMFromJson(Map<String, dynamic> json) {
  return _ServiceListVM.fromJson(json);
}

/// @nodoc
mixin _$ServiceListVM {
  String get name => throw _privateConstructorUsedError;
  int get id => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ServiceListVMCopyWith<ServiceListVM> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ServiceListVMCopyWith<$Res> {
  factory $ServiceListVMCopyWith(
          ServiceListVM value, $Res Function(ServiceListVM) then) =
      _$ServiceListVMCopyWithImpl<$Res, ServiceListVM>;
  @useResult
  $Res call({String name, int id});
}

/// @nodoc
class _$ServiceListVMCopyWithImpl<$Res, $Val extends ServiceListVM>
    implements $ServiceListVMCopyWith<$Res> {
  _$ServiceListVMCopyWithImpl(this._value, this._then);

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
abstract class _$$ServiceListVMImplCopyWith<$Res>
    implements $ServiceListVMCopyWith<$Res> {
  factory _$$ServiceListVMImplCopyWith(
          _$ServiceListVMImpl value, $Res Function(_$ServiceListVMImpl) then) =
      __$$ServiceListVMImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, int id});
}

/// @nodoc
class __$$ServiceListVMImplCopyWithImpl<$Res>
    extends _$ServiceListVMCopyWithImpl<$Res, _$ServiceListVMImpl>
    implements _$$ServiceListVMImplCopyWith<$Res> {
  __$$ServiceListVMImplCopyWithImpl(
      _$ServiceListVMImpl _value, $Res Function(_$ServiceListVMImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? id = null,
  }) {
    return _then(_$ServiceListVMImpl(
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
class _$ServiceListVMImpl implements _ServiceListVM {
  const _$ServiceListVMImpl({required this.name, required this.id});

  factory _$ServiceListVMImpl.fromJson(Map<String, dynamic> json) =>
      _$$ServiceListVMImplFromJson(json);

  @override
  final String name;
  @override
  final int id;

  @override
  String toString() {
    return 'ServiceListVM(name: $name, id: $id)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ServiceListVMImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.id, id) || other.id == id));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, name, id);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ServiceListVMImplCopyWith<_$ServiceListVMImpl> get copyWith =>
      __$$ServiceListVMImplCopyWithImpl<_$ServiceListVMImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ServiceListVMImplToJson(
      this,
    );
  }
}

abstract class _ServiceListVM implements ServiceListVM {
  const factory _ServiceListVM(
      {required final String name,
      required final int id}) = _$ServiceListVMImpl;

  factory _ServiceListVM.fromJson(Map<String, dynamic> json) =
      _$ServiceListVMImpl.fromJson;

  @override
  String get name;
  @override
  int get id;
  @override
  @JsonKey(ignore: true)
  _$$ServiceListVMImplCopyWith<_$ServiceListVMImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
