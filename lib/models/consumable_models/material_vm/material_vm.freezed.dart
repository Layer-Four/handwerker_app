// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'material_vm.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

MaterialVM _$MaterialVMFromJson(Map<String, dynamic> json) {
  return _MaterialVM.fromJson(json);
}

/// @nodoc
mixin _$MaterialVM {
  String get name => throw _privateConstructorUsedError;
  int get id => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MaterialVMCopyWith<MaterialVM> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MaterialVMCopyWith<$Res> {
  factory $MaterialVMCopyWith(
          MaterialVM value, $Res Function(MaterialVM) then) =
      _$MaterialVMCopyWithImpl<$Res, MaterialVM>;
  @useResult
  $Res call({String name, int id});
}

/// @nodoc
class _$MaterialVMCopyWithImpl<$Res, $Val extends MaterialVM>
    implements $MaterialVMCopyWith<$Res> {
  _$MaterialVMCopyWithImpl(this._value, this._then);

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
abstract class _$$MaterialVMImplCopyWith<$Res>
    implements $MaterialVMCopyWith<$Res> {
  factory _$$MaterialVMImplCopyWith(
          _$MaterialVMImpl value, $Res Function(_$MaterialVMImpl) then) =
      __$$MaterialVMImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, int id});
}

/// @nodoc
class __$$MaterialVMImplCopyWithImpl<$Res>
    extends _$MaterialVMCopyWithImpl<$Res, _$MaterialVMImpl>
    implements _$$MaterialVMImplCopyWith<$Res> {
  __$$MaterialVMImplCopyWithImpl(
      _$MaterialVMImpl _value, $Res Function(_$MaterialVMImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? id = null,
  }) {
    return _then(_$MaterialVMImpl(
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
class _$MaterialVMImpl implements _MaterialVM {
  const _$MaterialVMImpl({required this.name, required this.id});

  factory _$MaterialVMImpl.fromJson(Map<String, dynamic> json) =>
      _$$MaterialVMImplFromJson(json);

  @override
  final String name;
  @override
  final int id;

  @override
  String toString() {
    return 'MaterialVM(name: $name, id: $id)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MaterialVMImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.id, id) || other.id == id));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, name, id);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MaterialVMImplCopyWith<_$MaterialVMImpl> get copyWith =>
      __$$MaterialVMImplCopyWithImpl<_$MaterialVMImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MaterialVMImplToJson(
      this,
    );
  }
}

abstract class _MaterialVM implements MaterialVM {
  const factory _MaterialVM(
      {required final String name, required final int id}) = _$MaterialVMImpl;

  factory _MaterialVM.fromJson(Map<String, dynamic> json) =
      _$MaterialVMImpl.fromJson;

  @override
  String get name;
  @override
  int get id;
  @override
  @JsonKey(ignore: true)
  _$$MaterialVMImplCopyWith<_$MaterialVMImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
