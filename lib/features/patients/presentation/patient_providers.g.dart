// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$patientRepositoryHash() => r'abe203b7415c46553761f8067f644e184f3364d6';

/// See also [patientRepository].
@ProviderFor(patientRepository)
final patientRepositoryProvider =
    AutoDisposeProvider<PatientRepository>.internal(
      patientRepository,
      name: r'patientRepositoryProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$patientRepositoryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef PatientRepositoryRef = AutoDisposeProviderRef<PatientRepository>;
String _$patientsListHash() => r'f6bcbe2ec1b4e967773fb0e519ed48b957292470';

/// See also [patientsList].
@ProviderFor(patientsList)
final patientsListProvider = AutoDisposeFutureProvider<List<Patient>>.internal(
  patientsList,
  name: r'patientsListProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$patientsListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef PatientsListRef = AutoDisposeFutureProviderRef<List<Patient>>;
String _$patientDetailHash() => r'1fbcaebd5d6f19ffe41da4ced7532aa7a575788a';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [patientDetail].
@ProviderFor(patientDetail)
const patientDetailProvider = PatientDetailFamily();

/// See also [patientDetail].
class PatientDetailFamily extends Family<AsyncValue<Patient>> {
  /// See also [patientDetail].
  const PatientDetailFamily();

  /// See also [patientDetail].
  PatientDetailProvider call(String id) {
    return PatientDetailProvider(id);
  }

  @override
  PatientDetailProvider getProviderOverride(
    covariant PatientDetailProvider provider,
  ) {
    return call(provider.id);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'patientDetailProvider';
}

/// See also [patientDetail].
class PatientDetailProvider extends AutoDisposeFutureProvider<Patient> {
  /// See also [patientDetail].
  PatientDetailProvider(String id)
    : this._internal(
        (ref) => patientDetail(ref as PatientDetailRef, id),
        from: patientDetailProvider,
        name: r'patientDetailProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$patientDetailHash,
        dependencies: PatientDetailFamily._dependencies,
        allTransitiveDependencies:
            PatientDetailFamily._allTransitiveDependencies,
        id: id,
      );

  PatientDetailProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final String id;

  @override
  Override overrideWith(
    FutureOr<Patient> Function(PatientDetailRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: PatientDetailProvider._internal(
        (ref) => create(ref as PatientDetailRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Patient> createElement() {
    return _PatientDetailProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PatientDetailProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin PatientDetailRef on AutoDisposeFutureProviderRef<Patient> {
  /// The parameter `id` of this provider.
  String get id;
}

class _PatientDetailProviderElement
    extends AutoDisposeFutureProviderElement<Patient>
    with PatientDetailRef {
  _PatientDetailProviderElement(super.provider);

  @override
  String get id => (origin as PatientDetailProvider).id;
}

String _$patientControllerHash() => r'1e2321ae85e45b5dbfc315b98a2d19cd137fa170';

/// See also [PatientController].
@ProviderFor(PatientController)
final patientControllerProvider =
    AutoDisposeAsyncNotifierProvider<PatientController, void>.internal(
      PatientController.new,
      name: r'patientControllerProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$patientControllerHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$PatientController = AutoDisposeAsyncNotifier<void>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
