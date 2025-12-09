// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'soin_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$soinRepositoryHash() => r'7e80310d37fc142009f660dccb363e3e19e5b2ab';

/// See also [soinRepository].
@ProviderFor(soinRepository)
final soinRepositoryProvider = AutoDisposeProvider<SoinRepository>.internal(
  soinRepository,
  name: r'soinRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$soinRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SoinRepositoryRef = AutoDisposeProviderRef<SoinRepository>;
String _$soinsListHash() => r'c9d64c336df34482edbd76fd46f3ae5d3168e84c';

/// See also [soinsList].
@ProviderFor(soinsList)
final soinsListProvider = AutoDisposeFutureProvider<List<Soin>>.internal(
  soinsList,
  name: r'soinsListProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$soinsListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SoinsListRef = AutoDisposeFutureProviderRef<List<Soin>>;
String _$soinsByPatientHash() => r'5a04992642fe91df94387a74795554ad907afb7f';

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

/// See also [soinsByPatient].
@ProviderFor(soinsByPatient)
const soinsByPatientProvider = SoinsByPatientFamily();

/// See also [soinsByPatient].
class SoinsByPatientFamily extends Family<AsyncValue<List<Soin>>> {
  /// See also [soinsByPatient].
  const SoinsByPatientFamily();

  /// See also [soinsByPatient].
  SoinsByPatientProvider call(String patientId) {
    return SoinsByPatientProvider(patientId);
  }

  @override
  SoinsByPatientProvider getProviderOverride(
    covariant SoinsByPatientProvider provider,
  ) {
    return call(provider.patientId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'soinsByPatientProvider';
}

/// See also [soinsByPatient].
class SoinsByPatientProvider extends AutoDisposeFutureProvider<List<Soin>> {
  /// See also [soinsByPatient].
  SoinsByPatientProvider(String patientId)
    : this._internal(
        (ref) => soinsByPatient(ref as SoinsByPatientRef, patientId),
        from: soinsByPatientProvider,
        name: r'soinsByPatientProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$soinsByPatientHash,
        dependencies: SoinsByPatientFamily._dependencies,
        allTransitiveDependencies:
            SoinsByPatientFamily._allTransitiveDependencies,
        patientId: patientId,
      );

  SoinsByPatientProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.patientId,
  }) : super.internal();

  final String patientId;

  @override
  Override overrideWith(
    FutureOr<List<Soin>> Function(SoinsByPatientRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SoinsByPatientProvider._internal(
        (ref) => create(ref as SoinsByPatientRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        patientId: patientId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<Soin>> createElement() {
    return _SoinsByPatientProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SoinsByPatientProvider && other.patientId == patientId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, patientId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin SoinsByPatientRef on AutoDisposeFutureProviderRef<List<Soin>> {
  /// The parameter `patientId` of this provider.
  String get patientId;
}

class _SoinsByPatientProviderElement
    extends AutoDisposeFutureProviderElement<List<Soin>>
    with SoinsByPatientRef {
  _SoinsByPatientProviderElement(super.provider);

  @override
  String get patientId => (origin as SoinsByPatientProvider).patientId;
}

String _$soinsByServiceHash() => r'cb7ed5a04ad4a3af2bf83cad234d49fbfbaf5841';

/// See also [soinsByService].
@ProviderFor(soinsByService)
const soinsByServiceProvider = SoinsByServiceFamily();

/// See also [soinsByService].
class SoinsByServiceFamily extends Family<AsyncValue<List<Soin>>> {
  /// See also [soinsByService].
  const SoinsByServiceFamily();

  /// See also [soinsByService].
  SoinsByServiceProvider call(String serviceId) {
    return SoinsByServiceProvider(serviceId);
  }

  @override
  SoinsByServiceProvider getProviderOverride(
    covariant SoinsByServiceProvider provider,
  ) {
    return call(provider.serviceId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'soinsByServiceProvider';
}

/// See also [soinsByService].
class SoinsByServiceProvider extends AutoDisposeFutureProvider<List<Soin>> {
  /// See also [soinsByService].
  SoinsByServiceProvider(String serviceId)
    : this._internal(
        (ref) => soinsByService(ref as SoinsByServiceRef, serviceId),
        from: soinsByServiceProvider,
        name: r'soinsByServiceProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$soinsByServiceHash,
        dependencies: SoinsByServiceFamily._dependencies,
        allTransitiveDependencies:
            SoinsByServiceFamily._allTransitiveDependencies,
        serviceId: serviceId,
      );

  SoinsByServiceProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.serviceId,
  }) : super.internal();

  final String serviceId;

  @override
  Override overrideWith(
    FutureOr<List<Soin>> Function(SoinsByServiceRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SoinsByServiceProvider._internal(
        (ref) => create(ref as SoinsByServiceRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        serviceId: serviceId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<Soin>> createElement() {
    return _SoinsByServiceProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SoinsByServiceProvider && other.serviceId == serviceId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, serviceId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin SoinsByServiceRef on AutoDisposeFutureProviderRef<List<Soin>> {
  /// The parameter `serviceId` of this provider.
  String get serviceId;
}

class _SoinsByServiceProviderElement
    extends AutoDisposeFutureProviderElement<List<Soin>>
    with SoinsByServiceRef {
  _SoinsByServiceProviderElement(super.provider);

  @override
  String get serviceId => (origin as SoinsByServiceProvider).serviceId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
