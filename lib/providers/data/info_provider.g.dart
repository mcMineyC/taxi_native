// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'info_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$addRecentlyPlayedHash() => r'c980030092321411bb183b613e8d5bbfb2fa3f5f';

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

/// See also [addRecentlyPlayed].
@ProviderFor(addRecentlyPlayed)
const addRecentlyPlayedProvider = AddRecentlyPlayedFamily();

/// See also [addRecentlyPlayed].
class AddRecentlyPlayedFamily extends Family<AsyncValue<bool>> {
  /// See also [addRecentlyPlayed].
  const AddRecentlyPlayedFamily();

  /// See also [addRecentlyPlayed].
  AddRecentlyPlayedProvider call(
    String id,
  ) {
    return AddRecentlyPlayedProvider(
      id,
    );
  }

  @override
  AddRecentlyPlayedProvider getProviderOverride(
    covariant AddRecentlyPlayedProvider provider,
  ) {
    return call(
      provider.id,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'addRecentlyPlayedProvider';
}

/// See also [addRecentlyPlayed].
class AddRecentlyPlayedProvider extends AutoDisposeFutureProvider<bool> {
  /// See also [addRecentlyPlayed].
  AddRecentlyPlayedProvider(
    String id,
  ) : this._internal(
          (ref) => addRecentlyPlayed(
            ref as AddRecentlyPlayedRef,
            id,
          ),
          from: addRecentlyPlayedProvider,
          name: r'addRecentlyPlayedProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$addRecentlyPlayedHash,
          dependencies: AddRecentlyPlayedFamily._dependencies,
          allTransitiveDependencies:
              AddRecentlyPlayedFamily._allTransitiveDependencies,
          id: id,
        );

  AddRecentlyPlayedProvider._internal(
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
    FutureOr<bool> Function(AddRecentlyPlayedRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: AddRecentlyPlayedProvider._internal(
        (ref) => create(ref as AddRecentlyPlayedRef),
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
  AutoDisposeFutureProviderElement<bool> createElement() {
    return _AddRecentlyPlayedProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is AddRecentlyPlayedProvider && other.id == id;
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
mixin AddRecentlyPlayedRef on AutoDisposeFutureProviderRef<bool> {
  /// The parameter `id` of this provider.
  String get id;
}

class _AddRecentlyPlayedProviderElement
    extends AutoDisposeFutureProviderElement<bool> with AddRecentlyPlayedRef {
  _AddRecentlyPlayedProviderElement(super.provider);

  @override
  String get id => (origin as AddRecentlyPlayedProvider).id;
}

String _$fetchRecentlyPlayedHash() =>
    r'ed60eb5b7418bc056ee4b11b77f3bc8e398aa972';

/// See also [fetchRecentlyPlayed].
@ProviderFor(fetchRecentlyPlayed)
final fetchRecentlyPlayedProvider = FutureProvider<List<Song>>.internal(
  fetchRecentlyPlayed,
  name: r'fetchRecentlyPlayedProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$fetchRecentlyPlayedHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FetchRecentlyPlayedRef = FutureProviderRef<List<Song>>;
String _$fetchLandingRecentlyPlayedHash() =>
    r'757eb95ec6d63c0a29ccfc656b42a8fb5953710a';

/// See also [fetchLandingRecentlyPlayed].
@ProviderFor(fetchLandingRecentlyPlayed)
final fetchLandingRecentlyPlayedProvider = FutureProvider<List<Song>>.internal(
  fetchLandingRecentlyPlayed,
  name: r'fetchLandingRecentlyPlayedProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$fetchLandingRecentlyPlayedHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FetchLandingRecentlyPlayedRef = FutureProviderRef<List<Song>>;
String _$fetchFavoritesHash() => r'1dd74bab56f4de4452f98d21b8d3ad1915866bde';

/// See also [fetchFavorites].
@ProviderFor(fetchFavorites)
final fetchFavoritesProvider = FutureProvider<List<Song>>.internal(
  fetchFavorites,
  name: r'fetchFavoritesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$fetchFavoritesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FetchFavoritesRef = FutureProviderRef<List<Song>>;
String _$latestVersionHash() => r'd5b1e803ac9fcd94e258057a4dce7666bdaa9dac';

/// See also [latestVersion].
@ProviderFor(latestVersion)
final latestVersionProvider = AutoDisposeFutureProvider<String>.internal(
  latestVersion,
  name: r'latestVersionProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$latestVersionHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef LatestVersionRef = AutoDisposeFutureProviderRef<String>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
