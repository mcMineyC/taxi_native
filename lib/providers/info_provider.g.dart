// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'info_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$fetchRecentlyPlayedHash() =>
    r'47ce3ff0f4eafc7028b8b7aa8d6525ee3570973f';

/// See also [fetchRecentlyPlayed].
@ProviderFor(fetchRecentlyPlayed)
final fetchRecentlyPlayedProvider =
    AutoDisposeFutureProvider<List<Song>>.internal(
  fetchRecentlyPlayed,
  name: r'fetchRecentlyPlayedProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$fetchRecentlyPlayedHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef FetchRecentlyPlayedRef = AutoDisposeFutureProviderRef<List<Song>>;
String _$fetchFavoritesHash() => r'f9746e64e37cd0ef07f492de42f89a8284bda961';

/// See also [fetchFavorites].
@ProviderFor(fetchFavorites)
final fetchFavoritesProvider = AutoDisposeFutureProvider<List<Song>>.internal(
  fetchFavorites,
  name: r'fetchFavoritesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$fetchFavoritesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef FetchFavoritesRef = AutoDisposeFutureProviderRef<List<Song>>;
String _$findSongHash() => r'5183504d54ffba4e871834bf5a9d013873bb1af3';

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

/// See also [findSong].
@ProviderFor(findSong)
const findSongProvider = FindSongFamily();

/// See also [findSong].
class FindSongFamily extends Family<AsyncValue<Song>> {
  /// See also [findSong].
  const FindSongFamily();

  /// See also [findSong].
  FindSongProvider call(
    String id,
  ) {
    return FindSongProvider(
      id,
    );
  }

  @override
  FindSongProvider getProviderOverride(
    covariant FindSongProvider provider,
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
  String? get name => r'findSongProvider';
}

/// See also [findSong].
class FindSongProvider extends AutoDisposeFutureProvider<Song> {
  /// See also [findSong].
  FindSongProvider(
    String id,
  ) : this._internal(
          (ref) => findSong(
            ref as FindSongRef,
            id,
          ),
          from: findSongProvider,
          name: r'findSongProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$findSongHash,
          dependencies: FindSongFamily._dependencies,
          allTransitiveDependencies: FindSongFamily._allTransitiveDependencies,
          id: id,
        );

  FindSongProvider._internal(
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
    FutureOr<Song> Function(FindSongRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FindSongProvider._internal(
        (ref) => create(ref as FindSongRef),
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
  AutoDisposeFutureProviderElement<Song> createElement() {
    return _FindSongProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FindSongProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin FindSongRef on AutoDisposeFutureProviderRef<Song> {
  /// The parameter `id` of this provider.
  String get id;
}

class _FindSongProviderElement extends AutoDisposeFutureProviderElement<Song>
    with FindSongRef {
  _FindSongProviderElement(super.provider);

  @override
  String get id => (origin as FindSongProvider).id;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
