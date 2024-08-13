// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fetched_data_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$fetchSongsHash() => r'e734cf15a1a29381f938165778e308d2ec5c46ec';

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
String _$fetchAlbumsHash() => r'34c67f71d8ca6468d2540cb8ccc85c7b0f87dcb9';

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
String _$fetchArtistsHash() => r'27ff9afac70222e926b0f1b90ea4e727d0a4d990';

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
String _$findBatchSongsHash() => r'201123f41ff4c841063761250d0319d92c0d006e';

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

String _$findSongHash() => r'7c98b3906d371a167312e1cae3d51ded3432c703';

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

String _$findSongsByAlbumHash() => r'048bf2c0af339054d6e504e94516ae853f4f9466';

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

String _$findSongsByArtistHash() => r'ebcfceb33f8213dbb9ff4e66ea0108bb1bbf5f9d';

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

String _$findAlbumsByArtistHash() =>
    r'29b1d6e729f17dfed2e1f07f08894c9f16669978';

/// See also [findAlbumsByArtist].
@ProviderFor(findAlbumsByArtist)
const findAlbumsByArtistProvider = FindAlbumsByArtistFamily();

/// See also [findAlbumsByArtist].
class FindAlbumsByArtistFamily extends Family<AsyncValue<List<Album>>> {
  /// See also [findAlbumsByArtist].
  const FindAlbumsByArtistFamily();

  /// See also [findAlbumsByArtist].
  FindAlbumsByArtistProvider call(
    String id,
  ) {
    return FindAlbumsByArtistProvider(
      id,
    );
  }

  @override
  FindAlbumsByArtistProvider getProviderOverride(
    covariant FindAlbumsByArtistProvider provider,
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
  String? get name => r'findAlbumsByArtistProvider';
}

/// See also [findAlbumsByArtist].
class FindAlbumsByArtistProvider
    extends AutoDisposeFutureProvider<List<Album>> {
  /// See also [findAlbumsByArtist].
  FindAlbumsByArtistProvider(
    String id,
  ) : this._internal(
          (ref) => findAlbumsByArtist(
            ref as FindAlbumsByArtistRef,
            id,
          ),
          from: findAlbumsByArtistProvider,
          name: r'findAlbumsByArtistProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$findAlbumsByArtistHash,
          dependencies: FindAlbumsByArtistFamily._dependencies,
          allTransitiveDependencies:
              FindAlbumsByArtistFamily._allTransitiveDependencies,
          id: id,
        );

  FindAlbumsByArtistProvider._internal(
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
    FutureOr<List<Album>> Function(FindAlbumsByArtistRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FindAlbumsByArtistProvider._internal(
        (ref) => create(ref as FindAlbumsByArtistRef),
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
  AutoDisposeFutureProviderElement<List<Album>> createElement() {
    return _FindAlbumsByArtistProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FindAlbumsByArtistProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin FindAlbumsByArtistRef on AutoDisposeFutureProviderRef<List<Album>> {
  /// The parameter `id` of this provider.
  String get id;
}

class _FindAlbumsByArtistProviderElement
    extends AutoDisposeFutureProviderElement<List<Album>>
    with FindAlbumsByArtistRef {
  _FindAlbumsByArtistProviderElement(super.provider);

  @override
  String get id => (origin as FindAlbumsByArtistProvider).id;
}

String _$findNoSinglesByArtistHash() =>
    r'5c4ddf64a47427968f832093ad94b74667a5a6fc';

/// See also [findNoSinglesByArtist].
@ProviderFor(findNoSinglesByArtist)
const findNoSinglesByArtistProvider = FindNoSinglesByArtistFamily();

/// See also [findNoSinglesByArtist].
class FindNoSinglesByArtistFamily extends Family<AsyncValue<List<Album>>> {
  /// See also [findNoSinglesByArtist].
  const FindNoSinglesByArtistFamily();

  /// See also [findNoSinglesByArtist].
  FindNoSinglesByArtistProvider call(
    String id,
  ) {
    return FindNoSinglesByArtistProvider(
      id,
    );
  }

  @override
  FindNoSinglesByArtistProvider getProviderOverride(
    covariant FindNoSinglesByArtistProvider provider,
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
  String? get name => r'findNoSinglesByArtistProvider';
}

/// See also [findNoSinglesByArtist].
class FindNoSinglesByArtistProvider
    extends AutoDisposeFutureProvider<List<Album>> {
  /// See also [findNoSinglesByArtist].
  FindNoSinglesByArtistProvider(
    String id,
  ) : this._internal(
          (ref) => findNoSinglesByArtist(
            ref as FindNoSinglesByArtistRef,
            id,
          ),
          from: findNoSinglesByArtistProvider,
          name: r'findNoSinglesByArtistProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$findNoSinglesByArtistHash,
          dependencies: FindNoSinglesByArtistFamily._dependencies,
          allTransitiveDependencies:
              FindNoSinglesByArtistFamily._allTransitiveDependencies,
          id: id,
        );

  FindNoSinglesByArtistProvider._internal(
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
    FutureOr<List<Album>> Function(FindNoSinglesByArtistRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FindNoSinglesByArtistProvider._internal(
        (ref) => create(ref as FindNoSinglesByArtistRef),
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
  AutoDisposeFutureProviderElement<List<Album>> createElement() {
    return _FindNoSinglesByArtistProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FindNoSinglesByArtistProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin FindNoSinglesByArtistRef on AutoDisposeFutureProviderRef<List<Album>> {
  /// The parameter `id` of this provider.
  String get id;
}

class _FindNoSinglesByArtistProviderElement
    extends AutoDisposeFutureProviderElement<List<Album>>
    with FindNoSinglesByArtistRef {
  _FindNoSinglesByArtistProviderElement(super.provider);

  @override
  String get id => (origin as FindNoSinglesByArtistProvider).id;
}

String _$findSinglesByArtistHash() =>
    r'767d6119199d0bcd664c77949369b5500f13a1ec';

/// See also [findSinglesByArtist].
@ProviderFor(findSinglesByArtist)
const findSinglesByArtistProvider = FindSinglesByArtistFamily();

/// See also [findSinglesByArtist].
class FindSinglesByArtistFamily extends Family<AsyncValue<List<Song>>> {
  /// See also [findSinglesByArtist].
  const FindSinglesByArtistFamily();

  /// See also [findSinglesByArtist].
  FindSinglesByArtistProvider call(
    String id,
  ) {
    return FindSinglesByArtistProvider(
      id,
    );
  }

  @override
  FindSinglesByArtistProvider getProviderOverride(
    covariant FindSinglesByArtistProvider provider,
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
  String? get name => r'findSinglesByArtistProvider';
}

/// See also [findSinglesByArtist].
class FindSinglesByArtistProvider
    extends AutoDisposeFutureProvider<List<Song>> {
  /// See also [findSinglesByArtist].
  FindSinglesByArtistProvider(
    String id,
  ) : this._internal(
          (ref) => findSinglesByArtist(
            ref as FindSinglesByArtistRef,
            id,
          ),
          from: findSinglesByArtistProvider,
          name: r'findSinglesByArtistProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$findSinglesByArtistHash,
          dependencies: FindSinglesByArtistFamily._dependencies,
          allTransitiveDependencies:
              FindSinglesByArtistFamily._allTransitiveDependencies,
          id: id,
        );

  FindSinglesByArtistProvider._internal(
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
    FutureOr<List<Song>> Function(FindSinglesByArtistRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FindSinglesByArtistProvider._internal(
        (ref) => create(ref as FindSinglesByArtistRef),
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
    return _FindSinglesByArtistProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FindSinglesByArtistProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin FindSinglesByArtistRef on AutoDisposeFutureProviderRef<List<Song>> {
  /// The parameter `id` of this provider.
  String get id;
}

class _FindSinglesByArtistProviderElement
    extends AutoDisposeFutureProviderElement<List<Song>>
    with FindSinglesByArtistRef {
  _FindSinglesByArtistProviderElement(super.provider);

  @override
  String get id => (origin as FindSinglesByArtistProvider).id;
}

String _$findAlbumHash() => r'10972ead24cdcf31f190d0bc6e32e75a5350d554';

/// See also [findAlbum].
@ProviderFor(findAlbum)
const findAlbumProvider = FindAlbumFamily();

/// See also [findAlbum].
class FindAlbumFamily extends Family<AsyncValue<Album>> {
  /// See also [findAlbum].
  const FindAlbumFamily();

  /// See also [findAlbum].
  FindAlbumProvider call(
    String id,
  ) {
    return FindAlbumProvider(
      id,
    );
  }

  @override
  FindAlbumProvider getProviderOverride(
    covariant FindAlbumProvider provider,
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
  String? get name => r'findAlbumProvider';
}

/// See also [findAlbum].
class FindAlbumProvider extends AutoDisposeFutureProvider<Album> {
  /// See also [findAlbum].
  FindAlbumProvider(
    String id,
  ) : this._internal(
          (ref) => findAlbum(
            ref as FindAlbumRef,
            id,
          ),
          from: findAlbumProvider,
          name: r'findAlbumProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$findAlbumHash,
          dependencies: FindAlbumFamily._dependencies,
          allTransitiveDependencies: FindAlbumFamily._allTransitiveDependencies,
          id: id,
        );

  FindAlbumProvider._internal(
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
    FutureOr<Album> Function(FindAlbumRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FindAlbumProvider._internal(
        (ref) => create(ref as FindAlbumRef),
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
  AutoDisposeFutureProviderElement<Album> createElement() {
    return _FindAlbumProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FindAlbumProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin FindAlbumRef on AutoDisposeFutureProviderRef<Album> {
  /// The parameter `id` of this provider.
  String get id;
}

class _FindAlbumProviderElement extends AutoDisposeFutureProviderElement<Album>
    with FindAlbumRef {
  _FindAlbumProviderElement(super.provider);

  @override
  String get id => (origin as FindAlbumProvider).id;
}

String _$findArtistHash() => r'a8dbaf5a77c301855af2c062ed54b040491b36d6';

/// See also [findArtist].
@ProviderFor(findArtist)
const findArtistProvider = FindArtistFamily();

/// See also [findArtist].
class FindArtistFamily extends Family<AsyncValue<Artist>> {
  /// See also [findArtist].
  const FindArtistFamily();

  /// See also [findArtist].
  FindArtistProvider call(
    String id,
  ) {
    return FindArtistProvider(
      id,
    );
  }

  @override
  FindArtistProvider getProviderOverride(
    covariant FindArtistProvider provider,
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
  String? get name => r'findArtistProvider';
}

/// See also [findArtist].
class FindArtistProvider extends AutoDisposeFutureProvider<Artist> {
  /// See also [findArtist].
  FindArtistProvider(
    String id,
  ) : this._internal(
          (ref) => findArtist(
            ref as FindArtistRef,
            id,
          ),
          from: findArtistProvider,
          name: r'findArtistProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$findArtistHash,
          dependencies: FindArtistFamily._dependencies,
          allTransitiveDependencies:
              FindArtistFamily._allTransitiveDependencies,
          id: id,
        );

  FindArtistProvider._internal(
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
    FutureOr<Artist> Function(FindArtistRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FindArtistProvider._internal(
        (ref) => create(ref as FindArtistRef),
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
  AutoDisposeFutureProviderElement<Artist> createElement() {
    return _FindArtistProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FindArtistProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin FindArtistRef on AutoDisposeFutureProviderRef<Artist> {
  /// The parameter `id` of this provider.
  String get id;
}

class _FindArtistProviderElement
    extends AutoDisposeFutureProviderElement<Artist> with FindArtistRef {
  _FindArtistProviderElement(super.provider);

  @override
  String get id => (origin as FindArtistProvider).id;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
