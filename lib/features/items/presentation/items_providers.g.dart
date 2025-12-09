// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'items_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$itemsRepositoryHash() => r'7d07fa872161b77aa0dc2e154295fb70adfbc869';

/// See also [itemsRepository].
@ProviderFor(itemsRepository)
final itemsRepositoryProvider = AutoDisposeProvider<ItemsRepository>.internal(
  itemsRepository,
  name: r'itemsRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$itemsRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ItemsRepositoryRef = AutoDisposeProviderRef<ItemsRepository>;
String _$itemsListHash() => r'43b2425c08e5ba2afa7ed46fa8c2f112397f77d7';

/// See also [itemsList].
@ProviderFor(itemsList)
final itemsListProvider = AutoDisposeFutureProvider<List<Item>>.internal(
  itemsList,
  name: r'itemsListProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$itemsListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ItemsListRef = AutoDisposeFutureProviderRef<List<Item>>;
String _$itemDetailHash() => r'55a493d7a3d81d5f43f13cd1478c8d418d54155c';

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

/// See also [itemDetail].
@ProviderFor(itemDetail)
const itemDetailProvider = ItemDetailFamily();

/// See also [itemDetail].
class ItemDetailFamily extends Family<AsyncValue<Item>> {
  /// See also [itemDetail].
  const ItemDetailFamily();

  /// See also [itemDetail].
  ItemDetailProvider call(String id) {
    return ItemDetailProvider(id);
  }

  @override
  ItemDetailProvider getProviderOverride(
    covariant ItemDetailProvider provider,
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
  String? get name => r'itemDetailProvider';
}

/// See also [itemDetail].
class ItemDetailProvider extends AutoDisposeFutureProvider<Item> {
  /// See also [itemDetail].
  ItemDetailProvider(String id)
    : this._internal(
        (ref) => itemDetail(ref as ItemDetailRef, id),
        from: itemDetailProvider,
        name: r'itemDetailProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$itemDetailHash,
        dependencies: ItemDetailFamily._dependencies,
        allTransitiveDependencies: ItemDetailFamily._allTransitiveDependencies,
        id: id,
      );

  ItemDetailProvider._internal(
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
    FutureOr<Item> Function(ItemDetailRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ItemDetailProvider._internal(
        (ref) => create(ref as ItemDetailRef),
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
  AutoDisposeFutureProviderElement<Item> createElement() {
    return _ItemDetailProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ItemDetailProvider && other.id == id;
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
mixin ItemDetailRef on AutoDisposeFutureProviderRef<Item> {
  /// The parameter `id` of this provider.
  String get id;
}

class _ItemDetailProviderElement extends AutoDisposeFutureProviderElement<Item>
    with ItemDetailRef {
  _ItemDetailProviderElement(super.provider);

  @override
  String get id => (origin as ItemDetailProvider).id;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
