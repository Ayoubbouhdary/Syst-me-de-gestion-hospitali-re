// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'soin.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Soin _$SoinFromJson(Map<String, dynamic> json) {
  return _Soin.fromJson(json);
}

/// @nodoc
mixin _$Soin {
  String get id => throw _privateConstructorUsedError;
  String get patientId => throw _privateConstructorUsedError;
  String get serviceId => throw _privateConstructorUsedError;
  String get typeSoin => throw _privateConstructorUsedError;
  double get cout => throw _privateConstructorUsedError;
  DateTime get dateSoin => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;

  /// Serializes this Soin to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Soin
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SoinCopyWith<Soin> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SoinCopyWith<$Res> {
  factory $SoinCopyWith(Soin value, $Res Function(Soin) then) =
      _$SoinCopyWithImpl<$Res, Soin>;
  @useResult
  $Res call({
    String id,
    String patientId,
    String serviceId,
    String typeSoin,
    double cout,
    DateTime dateSoin,
    String? description,
  });
}

/// @nodoc
class _$SoinCopyWithImpl<$Res, $Val extends Soin>
    implements $SoinCopyWith<$Res> {
  _$SoinCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Soin
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? patientId = null,
    Object? serviceId = null,
    Object? typeSoin = null,
    Object? cout = null,
    Object? dateSoin = null,
    Object? description = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            patientId: null == patientId
                ? _value.patientId
                : patientId // ignore: cast_nullable_to_non_nullable
                      as String,
            serviceId: null == serviceId
                ? _value.serviceId
                : serviceId // ignore: cast_nullable_to_non_nullable
                      as String,
            typeSoin: null == typeSoin
                ? _value.typeSoin
                : typeSoin // ignore: cast_nullable_to_non_nullable
                      as String,
            cout: null == cout
                ? _value.cout
                : cout // ignore: cast_nullable_to_non_nullable
                      as double,
            dateSoin: null == dateSoin
                ? _value.dateSoin
                : dateSoin // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SoinImplCopyWith<$Res> implements $SoinCopyWith<$Res> {
  factory _$$SoinImplCopyWith(
    _$SoinImpl value,
    $Res Function(_$SoinImpl) then,
  ) = __$$SoinImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String patientId,
    String serviceId,
    String typeSoin,
    double cout,
    DateTime dateSoin,
    String? description,
  });
}

/// @nodoc
class __$$SoinImplCopyWithImpl<$Res>
    extends _$SoinCopyWithImpl<$Res, _$SoinImpl>
    implements _$$SoinImplCopyWith<$Res> {
  __$$SoinImplCopyWithImpl(_$SoinImpl _value, $Res Function(_$SoinImpl) _then)
    : super(_value, _then);

  /// Create a copy of Soin
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? patientId = null,
    Object? serviceId = null,
    Object? typeSoin = null,
    Object? cout = null,
    Object? dateSoin = null,
    Object? description = freezed,
  }) {
    return _then(
      _$SoinImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        patientId: null == patientId
            ? _value.patientId
            : patientId // ignore: cast_nullable_to_non_nullable
                  as String,
        serviceId: null == serviceId
            ? _value.serviceId
            : serviceId // ignore: cast_nullable_to_non_nullable
                  as String,
        typeSoin: null == typeSoin
            ? _value.typeSoin
            : typeSoin // ignore: cast_nullable_to_non_nullable
                  as String,
        cout: null == cout
            ? _value.cout
            : cout // ignore: cast_nullable_to_non_nullable
                  as double,
        dateSoin: null == dateSoin
            ? _value.dateSoin
            : dateSoin // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SoinImpl implements _Soin {
  const _$SoinImpl({
    required this.id,
    required this.patientId,
    required this.serviceId,
    required this.typeSoin,
    required this.cout,
    required this.dateSoin,
    this.description,
  });

  factory _$SoinImpl.fromJson(Map<String, dynamic> json) =>
      _$$SoinImplFromJson(json);

  @override
  final String id;
  @override
  final String patientId;
  @override
  final String serviceId;
  @override
  final String typeSoin;
  @override
  final double cout;
  @override
  final DateTime dateSoin;
  @override
  final String? description;

  @override
  String toString() {
    return 'Soin(id: $id, patientId: $patientId, serviceId: $serviceId, typeSoin: $typeSoin, cout: $cout, dateSoin: $dateSoin, description: $description)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SoinImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.patientId, patientId) ||
                other.patientId == patientId) &&
            (identical(other.serviceId, serviceId) ||
                other.serviceId == serviceId) &&
            (identical(other.typeSoin, typeSoin) ||
                other.typeSoin == typeSoin) &&
            (identical(other.cout, cout) || other.cout == cout) &&
            (identical(other.dateSoin, dateSoin) ||
                other.dateSoin == dateSoin) &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    patientId,
    serviceId,
    typeSoin,
    cout,
    dateSoin,
    description,
  );

  /// Create a copy of Soin
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SoinImplCopyWith<_$SoinImpl> get copyWith =>
      __$$SoinImplCopyWithImpl<_$SoinImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SoinImplToJson(this);
  }
}

abstract class _Soin implements Soin {
  const factory _Soin({
    required final String id,
    required final String patientId,
    required final String serviceId,
    required final String typeSoin,
    required final double cout,
    required final DateTime dateSoin,
    final String? description,
  }) = _$SoinImpl;

  factory _Soin.fromJson(Map<String, dynamic> json) = _$SoinImpl.fromJson;

  @override
  String get id;
  @override
  String get patientId;
  @override
  String get serviceId;
  @override
  String get typeSoin;
  @override
  double get cout;
  @override
  DateTime get dateSoin;
  @override
  String? get description;

  /// Create a copy of Soin
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SoinImplCopyWith<_$SoinImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
