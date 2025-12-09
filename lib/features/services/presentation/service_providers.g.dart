// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$serviceRepositoryHash() => r'd5d53245faadb8a939bc01e69d3aae50ff1b806a';

/// See also [serviceRepository].
@ProviderFor(serviceRepository)
final serviceRepositoryProvider =
    AutoDisposeProvider<ServiceRepository>.internal(
      serviceRepository,
      name: r'serviceRepositoryProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$serviceRepositoryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ServiceRepositoryRef = AutoDisposeProviderRef<ServiceRepository>;
String _$servicesListHash() => r'4ab8fd29cb4f3a4b6ef971270f9340a6f351aee3';

/// See also [servicesList].
@ProviderFor(servicesList)
final servicesListProvider = AutoDisposeFutureProvider<List<Service>>.internal(
  servicesList,
  name: r'servicesListProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$servicesListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ServicesListRef = AutoDisposeFutureProviderRef<List<Service>>;
String _$serviceDetailHash() => r'0a2b8c58102e84d4c42b5dd428e471a211ba1346';

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

/// See also [serviceDetail].
@ProviderFor(serviceDetail)
const serviceDetailProvider = ServiceDetailFamily();

/// See also [serviceDetail].
class ServiceDetailFamily extends Family<AsyncValue<Service>> {
  /// See also [serviceDetail].
  const ServiceDetailFamily();

  /// See also [serviceDetail].
  ServiceDetailProvider call(String id) {
    return ServiceDetailProvider(id);
  }

  @override
  ServiceDetailProvider getProviderOverride(
    covariant ServiceDetailProvider provider,
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
  String? get name => r'serviceDetailProvider';
}

/// See also [serviceDetail].
class ServiceDetailProvider extends AutoDisposeFutureProvider<Service> {
  /// See also [serviceDetail].
  ServiceDetailProvider(String id)
    : this._internal(
        (ref) => serviceDetail(ref as ServiceDetailRef, id),
        from: serviceDetailProvider,
        name: r'serviceDetailProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$serviceDetailHash,
        dependencies: ServiceDetailFamily._dependencies,
        allTransitiveDependencies:
            ServiceDetailFamily._allTransitiveDependencies,
        id: id,
      );

  ServiceDetailProvider._internal(
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
    FutureOr<Service> Function(ServiceDetailRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ServiceDetailProvider._internal(
        (ref) => create(ref as ServiceDetailRef),
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
  AutoDisposeFutureProviderElement<Service> createElement() {
    return _ServiceDetailProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ServiceDetailProvider && other.id == id;
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
mixin ServiceDetailRef on AutoDisposeFutureProviderRef<Service> {
  /// The parameter `id` of this provider.
  String get id;
}

class _ServiceDetailProviderElement
    extends AutoDisposeFutureProviderElement<Service>
    with ServiceDetailRef {
  _ServiceDetailProviderElement(super.provider);

  @override
  String get id => (origin as ServiceDetailProvider).id;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
