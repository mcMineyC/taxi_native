// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fetched_data_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$fetchSongsHash() => r'f5d0987a75bc9e41361b66af9eb828eba70747f0';

/// See also [fetchSongs].
@ProviderFor(fetchSongs)
final fetchSongsProvider = FutureProvider<List<Song>>.internal(
  fetchSongs,
  name: r'fetchSongsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$fetchSongsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef FetchSongsRef = FutureProviderRef<List<Song>>;
String _$fetchAlbumsHash() => r'd22223e5fe54004fc7419a88af635e73c61f8095';

/// See also [fetchAlbums].
@ProviderFor(fetchAlbums)
final fetchAlbumsProvider = FutureProvider<List<Album>>.internal(
  fetchAlbums,
  name: r'fetchAlbumsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$fetchAlbumsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef FetchAlbumsRef = FutureProviderRef<List<Album>>;
String _$fetchArtistsHash() => r'4a774bbc0771055ab9ffe56a7636a454b21a6d38';

/// See also [fetchArtists].
@ProviderFor(fetchArtists)
final fetchArtistsProvider = FutureProvider<List<Artist>>.internal(
  fetchArtists,
  name: r'fetchArtistsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$fetchArtistsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef FetchArtistsRef = FutureProviderRef<List<Artist>>;
String _$findBatchSongsHash() => r'10ee4bf144e4276a708077ee9dff0b517fcb0d6a';

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

/// See also [findBatchSongs].
@ProviderFor(findBatchSongs)
const findBatchSongsProvider = FindBatchSongsFamily();

/// See also [findBatchSongs].
class FindBatchSongsFamily extends Family<AsyncValue<List<Song>>> {
  /// See also [findBatchSongs].
  const FindBatchSongsFamily();

  /// See also [findBatchSongs].
  FindBatchSongsProvider call(
    List<String> ids,
  ) {
    return FindBatchSongsProvider(
      ids,
    );
  }

  @override
  FindBatchSongsProvider getProviderOverride(
    covariant FindBatchSongsProvider provider,
  ) {
    return call(
      provider.ids,
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
  String? get name => r'findBatchSongsProvider';
}

/// See also [findBatchSongs].
class FindBatchSongsProvider extends AutoDisposeFutureProvider<List<Song>> {
  /// See also [findBatchSongs].
  FindBatchSongsProvider(
    List<String> ids,
  ) : this._internal(
          (ref) => findBatchSongs(
            ref as FindBatchSongsRef,
            ids,
          ),
          from: findBatchSongsProvider,
          name: r'findBatchSongsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$findBatchSongsHash,
          dependencies: FindBatchSongsFamily._dependencies,
          allTransitiveDependencies:
              FindBatchSongsFamily._allTransitiveDependencies,
          ids: ids,
        );

  FindBatchSongsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.ids,
  }) : super.internal();

  final List<String> ids;

  @override
  Override overrideWith(
    FutureOr<List<Song>> Function(FindBatchSongsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FindBatchSongsProvider._internal(
        (ref) => create(ref as FindBatchSongsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        ids: ids,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<Song>> createElement() {
    return _FindBatchSongsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FindBatchSongsProvider && other.ids == ids;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, ids.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin FindBatchSongsRef on AutoDisposeFutureProviderRef<List<Song>> {
  /// The parameter `ids` of this provider.
  List<String> get ids;
}

class _FindBatchSongsProviderElement
    extends AutoDisposeFutureProviderElement<List<Song>>
    with FindBatchSongsRef {
  _FindBatchSongsProviderElement(super.provider);

  @override
  List<String> get ids => (origin as FindBatchSongsProvider).ids;
}

String _$findSongHash() => r'222e36ca6c34033ebb337291e87c920af809dc3d';

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

String _$findSongsByAlbumHash() => r'c31a1318dd37fca7905fc0cc45813fe4b204d761';

/// See also [findSongsByAlbum].
@ProviderFor(findSongsByAlbum)
const findSongsByAlbumProvider = FindSongsByAlbumFamily();

/// See also [findSongsByAlbum].
class FindSongsByAlbumFamily extends Family<AsyncValue<List<Song>>> {
  /// See also [findSongsByAlbum].
  const FindSongsByAlbumFamily();

  /// See also [findSongsByAlbum].
  FindSongsByAlbumProvider call(
    String id,
  ) {
    return FindSongsByAlbumProvider(
      id,
    );
  }

  @override
  FindSongsByAlbumProvider getProviderOverride(
    covariant FindSongsByAlbumProvider provider,
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
  String? get name => r'findSongsByAlbumProvider';
}

/// See also [findSongsByAlbum].
class FindSongsByAlbumProvider extends AutoDisposeFutureProvider<List<Song>> {
  /// See also [findSongsByAlbum].
  FindSongsByAlbumProvider(
    String id,
  ) : this._internal(
          (ref) => findSongsByAlbum(
            ref as FindSongsByAlbumRef,
            id,
          ),
          from: findSongsByAlbumProvider,
          name: r'findSongsByAlbumProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$findSongsByAlbumHash,
          dependencies: FindSongsByAlbumFamily._dependencies,
          allTransitiveDependencies:
              FindSongsByAlbumFamily._allTransitiveDependencies,
          id: id,
        );

  FindSongsByAlbumProvider._internal(
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
    FutureOr<List<Song>> Function(FindSongsByAlbumRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FindSongsByAlbumProvider._internal(
        (ref) => create(ref as FindSongsByAlbumRef),
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
  AutoDisposeFutureProviderElement<List<Song>> createElement() {
    return _FindSongsByAlbumProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FindSongsByAlbumProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin FindSongsByAlbumRef on AutoDisposeFutureProviderRef<List<Song>> {
  /// The parameter `id` of this provider.
  String get id;
}

class _FindSongsByAlbumProviderElement
    extends AutoDisposeFutureProviderElement<List<Song>>
    with FindSongsByAlbumRef {
  _FindSongsByAlbumProviderElement(super.provider);

  @override
  String get id => (origin as FindSongsByAlbumProvider).id;
}

String _$findSongsByArtistHash() => r'41fe276751564de0d223cbb1e465070eb789a6c4';

/// See also [findSongsByArtist].
@ProviderFor(findSongsByArtist)
const findSongsByArtistProvider = FindSongsByArtistFamily();

/// See also [findSongsByArtist].
class FindSongsByArtistFamily extends Family<AsyncValue<List<Song>>> {
  /// See also [findSongsByArtist].
  const FindSongsByArtistFamily();

  /// See also [findSongsByArtist].
  FindSongsByArtistProvider call(
    String id,
  ) {
    return FindSongsByArtistProvider(
      id,
    );
  }

  @override
  FindSongsByArtistProvider getProviderOverride(
    covariant FindSongsByArtistProvider provider,
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
  String? get name => r'findSongsByArtistProvider';
}

/// See also [findSongsByArtist].
class FindSongsByArtistProvider extends AutoDisposeFutureProvider<List<Song>> {
  /// See also [findSongsByArtist].
  FindSongsByArtistProvider(
    String id,
  ) : this._internal(
          (ref) => findSongsByArtist(
            ref as FindSongsByArtistRef,
            id,
          ),
          from: findSongsByArtistProvider,
          name: r'findSongsByArtistProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$findSongsByArtistHash,
          dependencies: FindSongsByArtistFamily._dependencies,
          allTransitiveDependencies:
              FindSongsByArtistFamily._allTransitiveDependencies,
          id: id,
        );

  FindSongsByArtistProvider._internal(
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
    FutureOr<List<Song>> Function(FindSongsByArtistRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FindSongsByArtistProvider._internal(
        (ref) => create(ref as FindSongsByArtistRef),
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
  AutoDisposeFutureProviderElement<List<Song>> createElement() {
    return _FindSongsByArtistProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FindSongsByArtistProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin FindSongsByArtistRef on AutoDisposeFutureProviderRef<List<Song>> {
  /// The parameter `id` of this provider.
  String get id;
}

class _FindSongsByArtistProviderElement
    extends AutoDisposeFutureProviderElement<List<Song>>
    with FindSongsByArtistRef {
  _FindSongsByArtistProviderElement(super.provider);

  @override
  String get id => (origin as FindSongsByArtistProvider).id;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
