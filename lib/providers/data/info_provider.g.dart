// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'info_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$addRecentlyPlayedHash() => r'2b4ed9e146af008674ecc52c4ef2174febdd8b0a';

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
    r'39e11fa2a2eb760acecd30c0e80d5e3829b118f4';

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

typedef FetchRecentlyPlayedRef = FutureProviderRef<List<Song>>;
String _$fetchFavoritesHash() => r'ce9e6eb270bfe464ccb748759c4b5ca9be11bf64';

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

typedef FetchFavoritesRef = FutureProviderRef<List<Song>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
