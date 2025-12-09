// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'service.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Service _$ServiceFromJson(Map<String, dynamic> json) {
  return _Service.fromJson(json);
}

/// @nodoc
mixin _$Service {
  String get id => throw _privateConstructorUsedError;
  String get nom => throw _privateConstructorUsedError;
  double get budgetMensuel => throw _privateConstructorUsedError;
  double get budgetAnnuel => throw _privateConstructorUsedError;
  double get coutActuel => throw _privateConstructorUsedError;

  /// Serializes this Service to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Service
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ServiceCopyWith<Service> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ServiceCopyWith<$Res> {
  factory $ServiceCopyWith(Service value, $Res Function(Service) then) =
      _$ServiceCopyWithImpl<$Res, Service>;
  @useResult
  $Res call({
    String id,
    String nom,
    double budgetMensuel,
    double budgetAnnuel,
    double coutActuel,
  });
}

/// @nodoc
class _$ServiceCopyWithImpl<$Res, $Val extends Service>
    implements $ServiceCopyWith<$Res> {
  _$ServiceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Service
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? nom = null,
    Object? budgetMensuel = null,
    Object? budgetAnnuel = null,
    Object? coutActuel = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            nom: null == nom
                ? _value.nom
                : nom // ignore: cast_nullable_to_non_nullable
                      as String,
            budgetMensuel: null == budgetMensuel
                ? _value.budgetMensuel
                : budgetMensuel // ignore: cast_nullable_to_non_nullable
                      as double,
            budgetAnnuel: null == budgetAnnuel
                ? _value.budgetAnnuel
                : budgetAnnuel // ignore: cast_nullable_to_non_nullable
                      as double,
            coutActuel: null == coutActuel
                ? _value.coutActuel
                : coutActuel // ignore: cast_nullable_to_non_nullable
                      as double,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ServiceImplCopyWith<$Res> implements $ServiceCopyWith<$Res> {
  factory _$$ServiceImplCopyWith(
    _$ServiceImpl value,
    $Res Function(_$ServiceImpl) then,
  ) = __$$ServiceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String nom,
    double budgetMensuel,
    double budgetAnnuel,
    double coutActuel,
  });
}

/// @nodoc
class __$$ServiceImplCopyWithImpl<$Res>
    extends _$ServiceCopyWithImpl<$Res, _$ServiceImpl>
    implements _$$ServiceImplCopyWith<$Res> {
  __$$ServiceImplCopyWithImpl(
    _$ServiceImpl _value,
    $Res Function(_$ServiceImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Service
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? nom = null,
    Object? budgetMensuel = null,
    Object? budgetAnnuel = null,
    Object? coutActuel = null,
  }) {
    return _then(
      _$ServiceImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        nom: null == nom
            ? _value.nom
            : nom // ignore: cast_nullable_to_non_nullable
                  as String,
        budgetMensuel: null == budgetMensuel
            ? _value.budgetMensuel
            : budgetMensuel // ignore: cast_nullable_to_non_nullable
                  as double,
        budgetAnnuel: null == budgetAnnuel
            ? _value.budgetAnnuel
            : budgetAnnuel // ignore: cast_nullable_to_non_nullable
                  as double,
        coutActuel: null == coutActuel
            ? _value.coutActuel
            : coutActuel // ignore: cast_nullable_to_non_nullable
                  as double,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ServiceImpl implements _Service {
  const _$ServiceImpl({
    required this.id,
    required this.nom,
    required this.budgetMensuel,
    required this.budgetAnnuel,
    this.coutActuel = 0.0,
  });

  factory _$ServiceImpl.fromJson(Map<String, dynamic> json) =>
      _$$ServiceImplFromJson(json);

  @override
  final String id;
  @override
  final String nom;
  @override
  final double budgetMensuel;
  @override
  final double budgetAnnuel;
  @override
  @JsonKey()
  final double coutActuel;

  @override
  String toString() {
    return 'Service(id: $id, nom: $nom, budgetMensuel: $budgetMensuel, budgetAnnuel: $budgetAnnuel, coutActuel: $coutActuel)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ServiceImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.nom, nom) || other.nom == nom) &&
            (identical(other.budgetMensuel, budgetMensuel) ||
                other.budgetMensuel == budgetMensuel) &&
            (identical(other.budgetAnnuel, budgetAnnuel) ||
                other.budgetAnnuel == budgetAnnuel) &&
            (identical(other.coutActuel, coutActuel) ||
                other.coutActuel == coutActuel));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    nom,
    budgetMensuel,
    budgetAnnuel,
    coutActuel,
  );

  /// Create a copy of Service
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ServiceImplCopyWith<_$ServiceImpl> get copyWith =>
      __$$ServiceImplCopyWithImpl<_$ServiceImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ServiceImplToJson(this);
  }
}

abstract class _Service implements Service {
  const factory _Service({
    required final String id,
    required final String nom,
    required final double budgetMensuel,
    required final double budgetAnnuel,
    final double coutActuel,
  }) = _$ServiceImpl;

  factory _Service.fromJson(Map<String, dynamic> json) = _$ServiceImpl.fromJson;

  @override
  String get id;
  @override
  String get nom;
  @override
  double get budgetMensuel;
  @override
  double get budgetAnnuel;
  @override
  double get coutActuel;

  /// Create a copy of Service
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ServiceImplCopyWith<_$ServiceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
