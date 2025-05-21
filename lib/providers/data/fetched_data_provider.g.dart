// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fetched_data_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$fetchSongsHash() => r'f50ba7fe7e2ce7cb2106cabe9d9d2c129db42563';

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

/// See also [fetchSongs].
@ProviderFor(fetchSongs)
const fetchSongsProvider = FetchSongsFamily();

/// See also [fetchSongs].
class FetchSongsFamily extends Family<AsyncValue<List<Song>>> {
  /// See also [fetchSongs].
  const FetchSongsFamily();

  /// See also [fetchSongs].
  FetchSongsProvider call({
    bool? ignore = false,
  }) {
    return FetchSongsProvider(
      ignore: ignore,
    );
  }

  @override
  FetchSongsProvider getProviderOverride(
    covariant FetchSongsProvider provider,
  ) {
    return call(
      ignore: provider.ignore,
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
  String? get name => r'fetchSongsProvider';
}

/// See also [fetchSongs].
class FetchSongsProvider extends FutureProvider<List<Song>> {
  /// See also [fetchSongs].
  FetchSongsProvider({
    bool? ignore = false,
  }) : this._internal(
          (ref) => fetchSongs(
            ref as FetchSongsRef,
            ignore: ignore,
          ),
          from: fetchSongsProvider,
          name: r'fetchSongsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$fetchSongsHash,
          dependencies: FetchSongsFamily._dependencies,
          allTransitiveDependencies:
              FetchSongsFamily._allTransitiveDependencies,
          ignore: ignore,
        );

  FetchSongsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.ignore,
  }) : super.internal();

  final bool? ignore;

  @override
  Override overrideWith(
    FutureOr<List<Song>> Function(FetchSongsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FetchSongsProvider._internal(
        (ref) => create(ref as FetchSongsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        ignore: ignore,
      ),
    );
  }

  @override
  FutureProviderElement<List<Song>> createElement() {
    return _FetchSongsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FetchSongsProvider && other.ignore == ignore;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, ignore.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin FetchSongsRef on FutureProviderRef<List<Song>> {
  /// The parameter `ignore` of this provider.
  bool? get ignore;
}

class _FetchSongsProviderElement extends FutureProviderElement<List<Song>>
    with FetchSongsRef {
  _FetchSongsProviderElement(super.provider);

  @override
  bool? get ignore => (origin as FetchSongsProvider).ignore;
}

String _$fetchAlbumsHash() => r'25073bd97bc2af927e17d544dd1ab645b63dd1e3';

/// See also [fetchAlbums].
@ProviderFor(fetchAlbums)
const fetchAlbumsProvider = FetchAlbumsFamily();

/// See also [fetchAlbums].
class FetchAlbumsFamily extends Family<AsyncValue<List<Album>>> {
  /// See also [fetchAlbums].
  const FetchAlbumsFamily();

  /// See also [fetchAlbums].
  FetchAlbumsProvider call({
    bool ignore = false,
  }) {
    return FetchAlbumsProvider(
      ignore: ignore,
    );
  }

  @override
  FetchAlbumsProvider getProviderOverride(
    covariant FetchAlbumsProvider provider,
  ) {
    return call(
      ignore: provider.ignore,
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
  String? get name => r'fetchAlbumsProvider';
}

/// See also [fetchAlbums].
class FetchAlbumsProvider extends FutureProvider<List<Album>> {
  /// See also [fetchAlbums].
  FetchAlbumsProvider({
    bool ignore = false,
  }) : this._internal(
          (ref) => fetchAlbums(
            ref as FetchAlbumsRef,
            ignore: ignore,
          ),
          from: fetchAlbumsProvider,
          name: r'fetchAlbumsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$fetchAlbumsHash,
          dependencies: FetchAlbumsFamily._dependencies,
          allTransitiveDependencies:
              FetchAlbumsFamily._allTransitiveDependencies,
          ignore: ignore,
        );

  FetchAlbumsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.ignore,
  }) : super.internal();

  final bool ignore;

  @override
  Override overrideWith(
    FutureOr<List<Album>> Function(FetchAlbumsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FetchAlbumsProvider._internal(
        (ref) => create(ref as FetchAlbumsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        ignore: ignore,
      ),
    );
  }

  @override
  FutureProviderElement<List<Album>> createElement() {
    return _FetchAlbumsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FetchAlbumsProvider && other.ignore == ignore;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, ignore.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin FetchAlbumsRef on FutureProviderRef<List<Album>> {
  /// The parameter `ignore` of this provider.
  bool get ignore;
}

class _FetchAlbumsProviderElement extends FutureProviderElement<List<Album>>
    with FetchAlbumsRef {
  _FetchAlbumsProviderElement(super.provider);

  @override
  bool get ignore => (origin as FetchAlbumsProvider).ignore;
}

String _$fetchArtistsHash() => r'4747ebd56ba5e9e389ab58cebf8be0df4baab95e';

/// See also [fetchArtists].
@ProviderFor(fetchArtists)
const fetchArtistsProvider = FetchArtistsFamily();

/// See also [fetchArtists].
class FetchArtistsFamily extends Family<AsyncValue<List<Artist>>> {
  /// See also [fetchArtists].
  const FetchArtistsFamily();

  /// See also [fetchArtists].
  FetchArtistsProvider call({
    bool ignore = false,
  }) {
    return FetchArtistsProvider(
      ignore: ignore,
    );
  }

  @override
  FetchArtistsProvider getProviderOverride(
    covariant FetchArtistsProvider provider,
  ) {
    return call(
      ignore: provider.ignore,
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
  String? get name => r'fetchArtistsProvider';
}

/// See also [fetchArtists].
class FetchArtistsProvider extends FutureProvider<List<Artist>> {
  /// See also [fetchArtists].
  FetchArtistsProvider({
    bool ignore = false,
  }) : this._internal(
          (ref) => fetchArtists(
            ref as FetchArtistsRef,
            ignore: ignore,
          ),
          from: fetchArtistsProvider,
          name: r'fetchArtistsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$fetchArtistsHash,
          dependencies: FetchArtistsFamily._dependencies,
          allTransitiveDependencies:
              FetchArtistsFamily._allTransitiveDependencies,
          ignore: ignore,
        );

  FetchArtistsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.ignore,
  }) : super.internal();

  final bool ignore;

  @override
  Override overrideWith(
    FutureOr<List<Artist>> Function(FetchArtistsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FetchArtistsProvider._internal(
        (ref) => create(ref as FetchArtistsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        ignore: ignore,
      ),
    );
  }

  @override
  FutureProviderElement<List<Artist>> createElement() {
    return _FetchArtistsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FetchArtistsProvider && other.ignore == ignore;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, ignore.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin FetchArtistsRef on FutureProviderRef<List<Artist>> {
  /// The parameter `ignore` of this provider.
  bool get ignore;
}

class _FetchArtistsProviderElement extends FutureProviderElement<List<Artist>>
    with FetchArtistsRef {
  _FetchArtistsProviderElement(super.provider);

  @override
  bool get ignore => (origin as FetchArtistsProvider).ignore;
}

String _$findBatchSongsHash() => r'69e4d147e3b8bd5dfc01eab4dc6c144978245340';

/// See also [findBatchSongs].
@ProviderFor(findBatchSongs)
const findBatchSongsProvider = FindBatchSongsFamily();

/// See also [findBatchSongs].
class FindBatchSongsFamily extends Family<AsyncValue<List<Song>>> {
  /// See also [findBatchSongs].
  const FindBatchSongsFamily();

  /// See also [findBatchSongs].
  FindBatchSongsProvider call(
    List<String> ids, {
    bool ignore = false,
  }) {
    return FindBatchSongsProvider(
      ids,
      ignore: ignore,
    );
  }

  @override
  FindBatchSongsProvider getProviderOverride(
    covariant FindBatchSongsProvider provider,
  ) {
    return call(
      provider.ids,
      ignore: provider.ignore,
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
    List<String> ids, {
    bool ignore = false,
  }) : this._internal(
          (ref) => findBatchSongs(
            ref as FindBatchSongsRef,
            ids,
            ignore: ignore,
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
          ignore: ignore,
        );

  FindBatchSongsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.ids,
    required this.ignore,
  }) : super.internal();

  final List<String> ids;
  final bool ignore;

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
        ignore: ignore,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<Song>> createElement() {
    return _FindBatchSongsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FindBatchSongsProvider &&
        other.ids == ids &&
        other.ignore == ignore;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, ids.hashCode);
    hash = _SystemHash.combine(hash, ignore.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin FindBatchSongsRef on AutoDisposeFutureProviderRef<List<Song>> {
  /// The parameter `ids` of this provider.
  List<String> get ids;

  /// The parameter `ignore` of this provider.
  bool get ignore;
}

class _FindBatchSongsProviderElement
    extends AutoDisposeFutureProviderElement<List<Song>>
    with FindBatchSongsRef {
  _FindBatchSongsProviderElement(super.provider);

  @override
  List<String> get ids => (origin as FindBatchSongsProvider).ids;
  @override
  bool get ignore => (origin as FindBatchSongsProvider).ignore;
}

String _$externalIdsToInternalHash() =>
    r'be1140e2137b0cdc53fa6596d7535ca22f643ee2';

/// See also [externalIdsToInternal].
@ProviderFor(externalIdsToInternal)
const externalIdsToInternalProvider = ExternalIdsToInternalFamily();

/// See also [externalIdsToInternal].
class ExternalIdsToInternalFamily extends Family<AsyncValue<List<String>>> {
  /// See also [externalIdsToInternal].
  const ExternalIdsToInternalFamily();

  /// See also [externalIdsToInternal].
  ExternalIdsToInternalProvider call(
    List<String> externalIds,
  ) {
    return ExternalIdsToInternalProvider(
      externalIds,
    );
  }

  @override
  ExternalIdsToInternalProvider getProviderOverride(
    covariant ExternalIdsToInternalProvider provider,
  ) {
    return call(
      provider.externalIds,
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
  String? get name => r'externalIdsToInternalProvider';
}

/// See also [externalIdsToInternal].
class ExternalIdsToInternalProvider
    extends AutoDisposeFutureProvider<List<String>> {
  /// See also [externalIdsToInternal].
  ExternalIdsToInternalProvider(
    List<String> externalIds,
  ) : this._internal(
          (ref) => externalIdsToInternal(
            ref as ExternalIdsToInternalRef,
            externalIds,
          ),
          from: externalIdsToInternalProvider,
          name: r'externalIdsToInternalProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$externalIdsToInternalHash,
          dependencies: ExternalIdsToInternalFamily._dependencies,
          allTransitiveDependencies:
              ExternalIdsToInternalFamily._allTransitiveDependencies,
          externalIds: externalIds,
        );

  ExternalIdsToInternalProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.externalIds,
  }) : super.internal();

  final List<String> externalIds;

  @override
  Override overrideWith(
    FutureOr<List<String>> Function(ExternalIdsToInternalRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ExternalIdsToInternalProvider._internal(
        (ref) => create(ref as ExternalIdsToInternalRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        externalIds: externalIds,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<String>> createElement() {
    return _ExternalIdsToInternalProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ExternalIdsToInternalProvider &&
        other.externalIds == externalIds;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, externalIds.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ExternalIdsToInternalRef on AutoDisposeFutureProviderRef<List<String>> {
  /// The parameter `externalIds` of this provider.
  List<String> get externalIds;
}

class _ExternalIdsToInternalProviderElement
    extends AutoDisposeFutureProviderElement<List<String>>
    with ExternalIdsToInternalRef {
  _ExternalIdsToInternalProviderElement(super.provider);

  @override
  List<String> get externalIds =>
      (origin as ExternalIdsToInternalProvider).externalIds;
}

String _$findSongHash() => r'29445173cc04032ece1057dfab1e426fb0f373bd';

/// See also [findSong].
@ProviderFor(findSong)
const findSongProvider = FindSongFamily();

/// See also [findSong].
class FindSongFamily extends Family<AsyncValue<Song>> {
  /// See also [findSong].
  const FindSongFamily();

  /// See also [findSong].
  FindSongProvider call(
    String id, {
    bool ignore = false,
  }) {
    return FindSongProvider(
      id,
      ignore: ignore,
    );
  }

  @override
  FindSongProvider getProviderOverride(
    covariant FindSongProvider provider,
  ) {
    return call(
      provider.id,
      ignore: provider.ignore,
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
    String id, {
    bool ignore = false,
  }) : this._internal(
          (ref) => findSong(
            ref as FindSongRef,
            id,
            ignore: ignore,
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
          ignore: ignore,
        );

  FindSongProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
    required this.ignore,
  }) : super.internal();

  final String id;
  final bool ignore;

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
        ignore: ignore,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Song> createElement() {
    return _FindSongProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FindSongProvider &&
        other.id == id &&
        other.ignore == ignore;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);
    hash = _SystemHash.combine(hash, ignore.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin FindSongRef on AutoDisposeFutureProviderRef<Song> {
  /// The parameter `id` of this provider.
  String get id;

  /// The parameter `ignore` of this provider.
  bool get ignore;
}

class _FindSongProviderElement extends AutoDisposeFutureProviderElement<Song>
    with FindSongRef {
  _FindSongProviderElement(super.provider);

  @override
  String get id => (origin as FindSongProvider).id;
  @override
  bool get ignore => (origin as FindSongProvider).ignore;
}

String _$findSongsByAlbumHash() => r'6366f7b65779493cb607b55a231867fadb9552ad';

/// See also [findSongsByAlbum].
@ProviderFor(findSongsByAlbum)
const findSongsByAlbumProvider = FindSongsByAlbumFamily();

/// See also [findSongsByAlbum].
class FindSongsByAlbumFamily extends Family<AsyncValue<List<Song>>> {
  /// See also [findSongsByAlbum].
  const FindSongsByAlbumFamily();

  /// See also [findSongsByAlbum].
  FindSongsByAlbumProvider call(
    String id, {
    bool ignore = false,
  }) {
    return FindSongsByAlbumProvider(
      id,
      ignore: ignore,
    );
  }

  @override
  FindSongsByAlbumProvider getProviderOverride(
    covariant FindSongsByAlbumProvider provider,
  ) {
    return call(
      provider.id,
      ignore: provider.ignore,
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
    String id, {
    bool ignore = false,
  }) : this._internal(
          (ref) => findSongsByAlbum(
            ref as FindSongsByAlbumRef,
            id,
            ignore: ignore,
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
          ignore: ignore,
        );

  FindSongsByAlbumProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
    required this.ignore,
  }) : super.internal();

  final String id;
  final bool ignore;

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
        ignore: ignore,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<Song>> createElement() {
    return _FindSongsByAlbumProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FindSongsByAlbumProvider &&
        other.id == id &&
        other.ignore == ignore;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);
    hash = _SystemHash.combine(hash, ignore.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin FindSongsByAlbumRef on AutoDisposeFutureProviderRef<List<Song>> {
  /// The parameter `id` of this provider.
  String get id;

  /// The parameter `ignore` of this provider.
  bool get ignore;
}

class _FindSongsByAlbumProviderElement
    extends AutoDisposeFutureProviderElement<List<Song>>
    with FindSongsByAlbumRef {
  _FindSongsByAlbumProviderElement(super.provider);

  @override
  String get id => (origin as FindSongsByAlbumProvider).id;
  @override
  bool get ignore => (origin as FindSongsByAlbumProvider).ignore;
}

String _$findSongsByArtistHash() => r'02b3fbcdf9b16d7572e4b5eaf1d9a22d64c1cc85';

/// See also [findSongsByArtist].
@ProviderFor(findSongsByArtist)
const findSongsByArtistProvider = FindSongsByArtistFamily();

/// See also [findSongsByArtist].
class FindSongsByArtistFamily extends Family<AsyncValue<List<Song>>> {
  /// See also [findSongsByArtist].
  const FindSongsByArtistFamily();

  /// See also [findSongsByArtist].
  FindSongsByArtistProvider call(
    String id, {
    bool ignore = false,
  }) {
    return FindSongsByArtistProvider(
      id,
      ignore: ignore,
    );
  }

  @override
  FindSongsByArtistProvider getProviderOverride(
    covariant FindSongsByArtistProvider provider,
  ) {
    return call(
      provider.id,
      ignore: provider.ignore,
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
    String id, {
    bool ignore = false,
  }) : this._internal(
          (ref) => findSongsByArtist(
            ref as FindSongsByArtistRef,
            id,
            ignore: ignore,
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
          ignore: ignore,
        );

  FindSongsByArtistProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
    required this.ignore,
  }) : super.internal();

  final String id;
  final bool ignore;

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
        ignore: ignore,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<Song>> createElement() {
    return _FindSongsByArtistProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FindSongsByArtistProvider &&
        other.id == id &&
        other.ignore == ignore;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);
    hash = _SystemHash.combine(hash, ignore.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin FindSongsByArtistRef on AutoDisposeFutureProviderRef<List<Song>> {
  /// The parameter `id` of this provider.
  String get id;

  /// The parameter `ignore` of this provider.
  bool get ignore;
}

class _FindSongsByArtistProviderElement
    extends AutoDisposeFutureProviderElement<List<Song>>
    with FindSongsByArtistRef {
  _FindSongsByArtistProviderElement(super.provider);

  @override
  String get id => (origin as FindSongsByArtistProvider).id;
  @override
  bool get ignore => (origin as FindSongsByArtistProvider).ignore;
}

String _$findAlbumsByArtistHash() =>
    r'140b4a7e0848615851583244ff6a33ae1f859110';

/// See also [findAlbumsByArtist].
@ProviderFor(findAlbumsByArtist)
const findAlbumsByArtistProvider = FindAlbumsByArtistFamily();

/// See also [findAlbumsByArtist].
class FindAlbumsByArtistFamily extends Family<AsyncValue<List<Album>>> {
  /// See also [findAlbumsByArtist].
  const FindAlbumsByArtistFamily();

  /// See also [findAlbumsByArtist].
  FindAlbumsByArtistProvider call(
    String id, {
    bool ignore = false,
  }) {
    return FindAlbumsByArtistProvider(
      id,
      ignore: ignore,
    );
  }

  @override
  FindAlbumsByArtistProvider getProviderOverride(
    covariant FindAlbumsByArtistProvider provider,
  ) {
    return call(
      provider.id,
      ignore: provider.ignore,
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
    String id, {
    bool ignore = false,
  }) : this._internal(
          (ref) => findAlbumsByArtist(
            ref as FindAlbumsByArtistRef,
            id,
            ignore: ignore,
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
          ignore: ignore,
        );

  FindAlbumsByArtistProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
    required this.ignore,
  }) : super.internal();

  final String id;
  final bool ignore;

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
        ignore: ignore,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<Album>> createElement() {
    return _FindAlbumsByArtistProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FindAlbumsByArtistProvider &&
        other.id == id &&
        other.ignore == ignore;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);
    hash = _SystemHash.combine(hash, ignore.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin FindAlbumsByArtistRef on AutoDisposeFutureProviderRef<List<Album>> {
  /// The parameter `id` of this provider.
  String get id;

  /// The parameter `ignore` of this provider.
  bool get ignore;
}

class _FindAlbumsByArtistProviderElement
    extends AutoDisposeFutureProviderElement<List<Album>>
    with FindAlbumsByArtistRef {
  _FindAlbumsByArtistProviderElement(super.provider);

  @override
  String get id => (origin as FindAlbumsByArtistProvider).id;
  @override
  bool get ignore => (origin as FindAlbumsByArtistProvider).ignore;
}

String _$findNoSinglesByArtistHash() =>
    r'7b11a8958e91d996026928d80731094b84b2e30c';

/// See also [findNoSinglesByArtist].
@ProviderFor(findNoSinglesByArtist)
const findNoSinglesByArtistProvider = FindNoSinglesByArtistFamily();

/// See also [findNoSinglesByArtist].
class FindNoSinglesByArtistFamily extends Family<AsyncValue<List<Album>>> {
  /// See also [findNoSinglesByArtist].
  const FindNoSinglesByArtistFamily();

  /// See also [findNoSinglesByArtist].
  FindNoSinglesByArtistProvider call(
    String id, {
    bool ignore = false,
  }) {
    return FindNoSinglesByArtistProvider(
      id,
      ignore: ignore,
    );
  }

  @override
  FindNoSinglesByArtistProvider getProviderOverride(
    covariant FindNoSinglesByArtistProvider provider,
  ) {
    return call(
      provider.id,
      ignore: provider.ignore,
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
    String id, {
    bool ignore = false,
  }) : this._internal(
          (ref) => findNoSinglesByArtist(
            ref as FindNoSinglesByArtistRef,
            id,
            ignore: ignore,
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
          ignore: ignore,
        );

  FindNoSinglesByArtistProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
    required this.ignore,
  }) : super.internal();

  final String id;
  final bool ignore;

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
        ignore: ignore,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<Album>> createElement() {
    return _FindNoSinglesByArtistProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FindNoSinglesByArtistProvider &&
        other.id == id &&
        other.ignore == ignore;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);
    hash = _SystemHash.combine(hash, ignore.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin FindNoSinglesByArtistRef on AutoDisposeFutureProviderRef<List<Album>> {
  /// The parameter `id` of this provider.
  String get id;

  /// The parameter `ignore` of this provider.
  bool get ignore;
}

class _FindNoSinglesByArtistProviderElement
    extends AutoDisposeFutureProviderElement<List<Album>>
    with FindNoSinglesByArtistRef {
  _FindNoSinglesByArtistProviderElement(super.provider);

  @override
  String get id => (origin as FindNoSinglesByArtistProvider).id;
  @override
  bool get ignore => (origin as FindNoSinglesByArtistProvider).ignore;
}

String _$findSinglesByArtistHash() =>
    r'0e0b3844f08797b3967bc7724e9d83e22d24e6ba';

/// See also [findSinglesByArtist].
@ProviderFor(findSinglesByArtist)
const findSinglesByArtistProvider = FindSinglesByArtistFamily();

/// See also [findSinglesByArtist].
class FindSinglesByArtistFamily extends Family<AsyncValue<List<Song>>> {
  /// See also [findSinglesByArtist].
  const FindSinglesByArtistFamily();

  /// See also [findSinglesByArtist].
  FindSinglesByArtistProvider call(
    String id, {
    bool ignore = false,
  }) {
    return FindSinglesByArtistProvider(
      id,
      ignore: ignore,
    );
  }

  @override
  FindSinglesByArtistProvider getProviderOverride(
    covariant FindSinglesByArtistProvider provider,
  ) {
    return call(
      provider.id,
      ignore: provider.ignore,
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
    String id, {
    bool ignore = false,
  }) : this._internal(
          (ref) => findSinglesByArtist(
            ref as FindSinglesByArtistRef,
            id,
            ignore: ignore,
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
          ignore: ignore,
        );

  FindSinglesByArtistProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
    required this.ignore,
  }) : super.internal();

  final String id;
  final bool ignore;

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
        ignore: ignore,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<Song>> createElement() {
    return _FindSinglesByArtistProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FindSinglesByArtistProvider &&
        other.id == id &&
        other.ignore == ignore;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);
    hash = _SystemHash.combine(hash, ignore.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin FindSinglesByArtistRef on AutoDisposeFutureProviderRef<List<Song>> {
  /// The parameter `id` of this provider.
  String get id;

  /// The parameter `ignore` of this provider.
  bool get ignore;
}

class _FindSinglesByArtistProviderElement
    extends AutoDisposeFutureProviderElement<List<Song>>
    with FindSinglesByArtistRef {
  _FindSinglesByArtistProviderElement(super.provider);

  @override
  String get id => (origin as FindSinglesByArtistProvider).id;
  @override
  bool get ignore => (origin as FindSinglesByArtistProvider).ignore;
}

String _$findAlbumHash() => r'199a38a8346b1b3cc292483f3aca157cb86cab23';

/// See also [findAlbum].
@ProviderFor(findAlbum)
const findAlbumProvider = FindAlbumFamily();

/// See also [findAlbum].
class FindAlbumFamily extends Family<AsyncValue<Album>> {
  /// See also [findAlbum].
  const FindAlbumFamily();

  /// See also [findAlbum].
  FindAlbumProvider call(
    String id, {
    bool ignore = false,
  }) {
    return FindAlbumProvider(
      id,
      ignore: ignore,
    );
  }

  @override
  FindAlbumProvider getProviderOverride(
    covariant FindAlbumProvider provider,
  ) {
    return call(
      provider.id,
      ignore: provider.ignore,
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
    String id, {
    bool ignore = false,
  }) : this._internal(
          (ref) => findAlbum(
            ref as FindAlbumRef,
            id,
            ignore: ignore,
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
          ignore: ignore,
        );

  FindAlbumProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
    required this.ignore,
  }) : super.internal();

  final String id;
  final bool ignore;

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
        ignore: ignore,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Album> createElement() {
    return _FindAlbumProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FindAlbumProvider &&
        other.id == id &&
        other.ignore == ignore;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);
    hash = _SystemHash.combine(hash, ignore.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin FindAlbumRef on AutoDisposeFutureProviderRef<Album> {
  /// The parameter `id` of this provider.
  String get id;

  /// The parameter `ignore` of this provider.
  bool get ignore;
}

class _FindAlbumProviderElement extends AutoDisposeFutureProviderElement<Album>
    with FindAlbumRef {
  _FindAlbumProviderElement(super.provider);

  @override
  String get id => (origin as FindAlbumProvider).id;
  @override
  bool get ignore => (origin as FindAlbumProvider).ignore;
}

String _$findArtistHash() => r'f73d8e5e02bff87988b8434f5ce8a31924200bc4';

/// See also [findArtist].
@ProviderFor(findArtist)
const findArtistProvider = FindArtistFamily();

/// See also [findArtist].
class FindArtistFamily extends Family<AsyncValue<Artist>> {
  /// See also [findArtist].
  const FindArtistFamily();

  /// See also [findArtist].
  FindArtistProvider call(
    String id, {
    bool ignore = false,
  }) {
    return FindArtistProvider(
      id,
      ignore: ignore,
    );
  }

  @override
  FindArtistProvider getProviderOverride(
    covariant FindArtistProvider provider,
  ) {
    return call(
      provider.id,
      ignore: provider.ignore,
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
    String id, {
    bool ignore = false,
  }) : this._internal(
          (ref) => findArtist(
            ref as FindArtistRef,
            id,
            ignore: ignore,
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
          ignore: ignore,
        );

  FindArtistProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
    required this.ignore,
  }) : super.internal();

  final String id;
  final bool ignore;

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
        ignore: ignore,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Artist> createElement() {
    return _FindArtistProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FindArtistProvider &&
        other.id == id &&
        other.ignore == ignore;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);
    hash = _SystemHash.combine(hash, ignore.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin FindArtistRef on AutoDisposeFutureProviderRef<Artist> {
  /// The parameter `id` of this provider.
  String get id;

  /// The parameter `ignore` of this provider.
  bool get ignore;
}

class _FindArtistProviderElement
    extends AutoDisposeFutureProviderElement<Artist> with FindArtistRef {
  _FindArtistProviderElement(super.provider);

  @override
  String get id => (origin as FindArtistProvider).id;
  @override
  bool get ignore => (origin as FindArtistProvider).ignore;
}

String _$updateSongHash() => r'ef5463f3fa7e79c37d2bd1a9d121047fb7ab1fe8';

/// See also [updateSong].
@ProviderFor(updateSong)
const updateSongProvider = UpdateSongFamily();

/// See also [updateSong].
class UpdateSongFamily extends Family<AsyncValue<bool>> {
  /// See also [updateSong].
  const UpdateSongFamily();

  /// See also [updateSong].
  UpdateSongProvider call(
    Song s,
  ) {
    return UpdateSongProvider(
      s,
    );
  }

  @override
  UpdateSongProvider getProviderOverride(
    covariant UpdateSongProvider provider,
  ) {
    return call(
      provider.s,
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
  String? get name => r'updateSongProvider';
}

/// See also [updateSong].
class UpdateSongProvider extends AutoDisposeFutureProvider<bool> {
  /// See also [updateSong].
  UpdateSongProvider(
    Song s,
  ) : this._internal(
          (ref) => updateSong(
            ref as UpdateSongRef,
            s,
          ),
          from: updateSongProvider,
          name: r'updateSongProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$updateSongHash,
          dependencies: UpdateSongFamily._dependencies,
          allTransitiveDependencies:
              UpdateSongFamily._allTransitiveDependencies,
          s: s,
        );

  UpdateSongProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.s,
  }) : super.internal();

  final Song s;

  @override
  Override overrideWith(
    FutureOr<bool> Function(UpdateSongRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: UpdateSongProvider._internal(
        (ref) => create(ref as UpdateSongRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        s: s,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<bool> createElement() {
    return _UpdateSongProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is UpdateSongProvider && other.s == s;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, s.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin UpdateSongRef on AutoDisposeFutureProviderRef<bool> {
  /// The parameter `s` of this provider.
  Song get s;
}

class _UpdateSongProviderElement extends AutoDisposeFutureProviderElement<bool>
    with UpdateSongRef {
  _UpdateSongProviderElement(super.provider);

  @override
  Song get s => (origin as UpdateSongProvider).s;
}

String _$updateAlbumHash() => r'b60d3b7f67632ac1f8cf145ce5ecc900430d9eef';

/// See also [updateAlbum].
@ProviderFor(updateAlbum)
const updateAlbumProvider = UpdateAlbumFamily();

/// See also [updateAlbum].
class UpdateAlbumFamily extends Family<AsyncValue<bool>> {
  /// See also [updateAlbum].
  const UpdateAlbumFamily();

  /// See also [updateAlbum].
  UpdateAlbumProvider call(
    Album a,
    List<Song> songs,
  ) {
    return UpdateAlbumProvider(
      a,
      songs,
    );
  }

  @override
  UpdateAlbumProvider getProviderOverride(
    covariant UpdateAlbumProvider provider,
  ) {
    return call(
      provider.a,
      provider.songs,
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
  String? get name => r'updateAlbumProvider';
}

/// See also [updateAlbum].
class UpdateAlbumProvider extends AutoDisposeFutureProvider<bool> {
  /// See also [updateAlbum].
  UpdateAlbumProvider(
    Album a,
    List<Song> songs,
  ) : this._internal(
          (ref) => updateAlbum(
            ref as UpdateAlbumRef,
            a,
            songs,
          ),
          from: updateAlbumProvider,
          name: r'updateAlbumProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$updateAlbumHash,
          dependencies: UpdateAlbumFamily._dependencies,
          allTransitiveDependencies:
              UpdateAlbumFamily._allTransitiveDependencies,
          a: a,
          songs: songs,
        );

  UpdateAlbumProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.a,
    required this.songs,
  }) : super.internal();

  final Album a;
  final List<Song> songs;

  @override
  Override overrideWith(
    FutureOr<bool> Function(UpdateAlbumRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: UpdateAlbumProvider._internal(
        (ref) => create(ref as UpdateAlbumRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        a: a,
        songs: songs,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<bool> createElement() {
    return _UpdateAlbumProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is UpdateAlbumProvider && other.a == a && other.songs == songs;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, a.hashCode);
    hash = _SystemHash.combine(hash, songs.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin UpdateAlbumRef on AutoDisposeFutureProviderRef<bool> {
  /// The parameter `a` of this provider.
  Album get a;

  /// The parameter `songs` of this provider.
  List<Song> get songs;
}

class _UpdateAlbumProviderElement extends AutoDisposeFutureProviderElement<bool>
    with UpdateAlbumRef {
  _UpdateAlbumProviderElement(super.provider);

  @override
  Album get a => (origin as UpdateAlbumProvider).a;
  @override
  List<Song> get songs => (origin as UpdateAlbumProvider).songs;
}

String _$updateArtistHash() => r'9812e0c4c3a987cecf3f9774e51def2b71ca93fd';

/// See also [updateArtist].
@ProviderFor(updateArtist)
const updateArtistProvider = UpdateArtistFamily();

/// See also [updateArtist].
class UpdateArtistFamily extends Family<AsyncValue<bool>> {
  /// See also [updateArtist].
  const UpdateArtistFamily();

  /// See also [updateArtist].
  UpdateArtistProvider call(
    Artist a,
  ) {
    return UpdateArtistProvider(
      a,
    );
  }

  @override
  UpdateArtistProvider getProviderOverride(
    covariant UpdateArtistProvider provider,
  ) {
    return call(
      provider.a,
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
  String? get name => r'updateArtistProvider';
}

/// See also [updateArtist].
class UpdateArtistProvider extends AutoDisposeFutureProvider<bool> {
  /// See also [updateArtist].
  UpdateArtistProvider(
    Artist a,
  ) : this._internal(
          (ref) => updateArtist(
            ref as UpdateArtistRef,
            a,
          ),
          from: updateArtistProvider,
          name: r'updateArtistProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$updateArtistHash,
          dependencies: UpdateArtistFamily._dependencies,
          allTransitiveDependencies:
              UpdateArtistFamily._allTransitiveDependencies,
          a: a,
        );

  UpdateArtistProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.a,
  }) : super.internal();

  final Artist a;

  @override
  Override overrideWith(
    FutureOr<bool> Function(UpdateArtistRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: UpdateArtistProvider._internal(
        (ref) => create(ref as UpdateArtistRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        a: a,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<bool> createElement() {
    return _UpdateArtistProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is UpdateArtistProvider && other.a == a;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, a.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin UpdateArtistRef on AutoDisposeFutureProviderRef<bool> {
  /// The parameter `a` of this provider.
  Artist get a;
}

class _UpdateArtistProviderElement
    extends AutoDisposeFutureProviderElement<bool> with UpdateArtistRef {
  _UpdateArtistProviderElement(super.provider);

  @override
  Artist get a => (origin as UpdateArtistProvider).a;
}

String _$deleteItemHash() => r'53f1875780edcc9fd312eef5a3cc88bccd2edccc';

/// See also [deleteItem].
@ProviderFor(deleteItem)
const deleteItemProvider = DeleteItemFamily();

/// See also [deleteItem].
class DeleteItemFamily extends Family<AsyncValue<bool>> {
  /// See also [deleteItem].
  const DeleteItemFamily();

  /// See also [deleteItem].
  DeleteItemProvider call(
    String type,
    String id,
    String extraParams,
  ) {
    return DeleteItemProvider(
      type,
      id,
      extraParams,
    );
  }

  @override
  DeleteItemProvider getProviderOverride(
    covariant DeleteItemProvider provider,
  ) {
    return call(
      provider.type,
      provider.id,
      provider.extraParams,
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
  String? get name => r'deleteItemProvider';
}

/// See also [deleteItem].
class DeleteItemProvider extends AutoDisposeFutureProvider<bool> {
  /// See also [deleteItem].
  DeleteItemProvider(
    String type,
    String id,
    String extraParams,
  ) : this._internal(
          (ref) => deleteItem(
            ref as DeleteItemRef,
            type,
            id,
            extraParams,
          ),
          from: deleteItemProvider,
          name: r'deleteItemProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$deleteItemHash,
          dependencies: DeleteItemFamily._dependencies,
          allTransitiveDependencies:
              DeleteItemFamily._allTransitiveDependencies,
          type: type,
          id: id,
          extraParams: extraParams,
        );

  DeleteItemProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.type,
    required this.id,
    required this.extraParams,
  }) : super.internal();

  final String type;
  final String id;
  final String extraParams;

  @override
  Override overrideWith(
    FutureOr<bool> Function(DeleteItemRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: DeleteItemProvider._internal(
        (ref) => create(ref as DeleteItemRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        type: type,
        id: id,
        extraParams: extraParams,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<bool> createElement() {
    return _DeleteItemProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is DeleteItemProvider &&
        other.type == type &&
        other.id == id &&
        other.extraParams == extraParams;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, type.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);
    hash = _SystemHash.combine(hash, extraParams.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin DeleteItemRef on AutoDisposeFutureProviderRef<bool> {
  /// The parameter `type` of this provider.
  String get type;

  /// The parameter `id` of this provider.
  String get id;

  /// The parameter `extraParams` of this provider.
  String get extraParams;
}

class _DeleteItemProviderElement extends AutoDisposeFutureProviderElement<bool>
    with DeleteItemRef {
  _DeleteItemProviderElement(super.provider);

  @override
  String get type => (origin as DeleteItemProvider).type;
  @override
  String get id => (origin as DeleteItemProvider).id;
  @override
  String get extraParams => (origin as DeleteItemProvider).extraParams;
}

String _$fetchUsernamesHash() => r'3e90f4ed468ed1b9932e141a8aaefba61a7db6b9';

/// See also [fetchUsernames].
@ProviderFor(fetchUsernames)
final fetchUsernamesProvider = FutureProvider<List<String>>.internal(
  fetchUsernames,
  name: r'fetchUsernamesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$fetchUsernamesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FetchUsernamesRef = FutureProviderRef<List<String>>;
String _$editItemVisibilityHash() =>
    r'cd096030698449d316a050c0861bde221570f8d6';

/// See also [editItemVisibility].
@ProviderFor(editItemVisibility)
const editItemVisibilityProvider = EditItemVisibilityFamily();

/// See also [editItemVisibility].
class EditItemVisibilityFamily extends Family<AsyncValue<bool>> {
  /// See also [editItemVisibility].
  const EditItemVisibilityFamily();

  /// See also [editItemVisibility].
  EditItemVisibilityProvider call(
    String type,
    String id,
    List<String> users,
  ) {
    return EditItemVisibilityProvider(
      type,
      id,
      users,
    );
  }

  @override
  EditItemVisibilityProvider getProviderOverride(
    covariant EditItemVisibilityProvider provider,
  ) {
    return call(
      provider.type,
      provider.id,
      provider.users,
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
  String? get name => r'editItemVisibilityProvider';
}

/// See also [editItemVisibility].
class EditItemVisibilityProvider extends AutoDisposeFutureProvider<bool> {
  /// See also [editItemVisibility].
  EditItemVisibilityProvider(
    String type,
    String id,
    List<String> users,
  ) : this._internal(
          (ref) => editItemVisibility(
            ref as EditItemVisibilityRef,
            type,
            id,
            users,
          ),
          from: editItemVisibilityProvider,
          name: r'editItemVisibilityProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$editItemVisibilityHash,
          dependencies: EditItemVisibilityFamily._dependencies,
          allTransitiveDependencies:
              EditItemVisibilityFamily._allTransitiveDependencies,
          type: type,
          id: id,
          users: users,
        );

  EditItemVisibilityProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.type,
    required this.id,
    required this.users,
  }) : super.internal();

  final String type;
  final String id;
  final List<String> users;

  @override
  Override overrideWith(
    FutureOr<bool> Function(EditItemVisibilityRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: EditItemVisibilityProvider._internal(
        (ref) => create(ref as EditItemVisibilityRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        type: type,
        id: id,
        users: users,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<bool> createElement() {
    return _EditItemVisibilityProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is EditItemVisibilityProvider &&
        other.type == type &&
        other.id == id &&
        other.users == users;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, type.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);
    hash = _SystemHash.combine(hash, users.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin EditItemVisibilityRef on AutoDisposeFutureProviderRef<bool> {
  /// The parameter `type` of this provider.
  String get type;

  /// The parameter `id` of this provider.
  String get id;

  /// The parameter `users` of this provider.
  List<String> get users;
}

class _EditItemVisibilityProviderElement
    extends AutoDisposeFutureProviderElement<bool> with EditItemVisibilityRef {
  _EditItemVisibilityProviderElement(super.provider);

  @override
  String get type => (origin as EditItemVisibilityProvider).type;
  @override
  String get id => (origin as EditItemVisibilityProvider).id;
  @override
  List<String> get users => (origin as EditItemVisibilityProvider).users;
}

String _$addToLibraryHash() => r'be5aa35dbd9e4bf7bfbfdd55856ecce3069ccbf4';

/// See also [addToLibrary].
@ProviderFor(addToLibrary)
const addToLibraryProvider = AddToLibraryFamily();

/// See also [addToLibrary].
class AddToLibraryFamily extends Family<AsyncValue<bool>> {
  /// See also [addToLibrary].
  const AddToLibraryFamily();

  /// See also [addToLibrary].
  AddToLibraryProvider call(
    String id,
    String type,
  ) {
    return AddToLibraryProvider(
      id,
      type,
    );
  }

  @override
  AddToLibraryProvider getProviderOverride(
    covariant AddToLibraryProvider provider,
  ) {
    return call(
      provider.id,
      provider.type,
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
  String? get name => r'addToLibraryProvider';
}

/// See also [addToLibrary].
class AddToLibraryProvider extends AutoDisposeFutureProvider<bool> {
  /// See also [addToLibrary].
  AddToLibraryProvider(
    String id,
    String type,
  ) : this._internal(
          (ref) => addToLibrary(
            ref as AddToLibraryRef,
            id,
            type,
          ),
          from: addToLibraryProvider,
          name: r'addToLibraryProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$addToLibraryHash,
          dependencies: AddToLibraryFamily._dependencies,
          allTransitiveDependencies:
              AddToLibraryFamily._allTransitiveDependencies,
          id: id,
          type: type,
        );

  AddToLibraryProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
    required this.type,
  }) : super.internal();

  final String id;
  final String type;

  @override
  Override overrideWith(
    FutureOr<bool> Function(AddToLibraryRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: AddToLibraryProvider._internal(
        (ref) => create(ref as AddToLibraryRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
        type: type,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<bool> createElement() {
    return _AddToLibraryProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is AddToLibraryProvider &&
        other.id == id &&
        other.type == type;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);
    hash = _SystemHash.combine(hash, type.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin AddToLibraryRef on AutoDisposeFutureProviderRef<bool> {
  /// The parameter `id` of this provider.
  String get id;

  /// The parameter `type` of this provider.
  String get type;
}

class _AddToLibraryProviderElement
    extends AutoDisposeFutureProviderElement<bool> with AddToLibraryRef {
  _AddToLibraryProviderElement(super.provider);

  @override
  String get id => (origin as AddToLibraryProvider).id;
  @override
  String get type => (origin as AddToLibraryProvider).type;
}

String _$removeFromLibraryHash() => r'c655d4265c54804192b9776f1c840551f7b0bb1a';

/// See also [removeFromLibrary].
@ProviderFor(removeFromLibrary)
const removeFromLibraryProvider = RemoveFromLibraryFamily();

/// See also [removeFromLibrary].
class RemoveFromLibraryFamily extends Family<AsyncValue<bool>> {
  /// See also [removeFromLibrary].
  const RemoveFromLibraryFamily();

  /// See also [removeFromLibrary].
  RemoveFromLibraryProvider call(
    String id,
    String type,
  ) {
    return RemoveFromLibraryProvider(
      id,
      type,
    );
  }

  @override
  RemoveFromLibraryProvider getProviderOverride(
    covariant RemoveFromLibraryProvider provider,
  ) {
    return call(
      provider.id,
      provider.type,
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
  String? get name => r'removeFromLibraryProvider';
}

/// See also [removeFromLibrary].
class RemoveFromLibraryProvider extends AutoDisposeFutureProvider<bool> {
  /// See also [removeFromLibrary].
  RemoveFromLibraryProvider(
    String id,
    String type,
  ) : this._internal(
          (ref) => removeFromLibrary(
            ref as RemoveFromLibraryRef,
            id,
            type,
          ),
          from: removeFromLibraryProvider,
          name: r'removeFromLibraryProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$removeFromLibraryHash,
          dependencies: RemoveFromLibraryFamily._dependencies,
          allTransitiveDependencies:
              RemoveFromLibraryFamily._allTransitiveDependencies,
          id: id,
          type: type,
        );

  RemoveFromLibraryProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
    required this.type,
  }) : super.internal();

  final String id;
  final String type;

  @override
  Override overrideWith(
    FutureOr<bool> Function(RemoveFromLibraryRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: RemoveFromLibraryProvider._internal(
        (ref) => create(ref as RemoveFromLibraryRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
        type: type,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<bool> createElement() {
    return _RemoveFromLibraryProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is RemoveFromLibraryProvider &&
        other.id == id &&
        other.type == type;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);
    hash = _SystemHash.combine(hash, type.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin RemoveFromLibraryRef on AutoDisposeFutureProviderRef<bool> {
  /// The parameter `id` of this provider.
  String get id;

  /// The parameter `type` of this provider.
  String get type;
}

class _RemoveFromLibraryProviderElement
    extends AutoDisposeFutureProviderElement<bool> with RemoveFromLibraryRef {
  _RemoveFromLibraryProviderElement(super.provider);

  @override
  String get id => (origin as RemoveFromLibraryProvider).id;
  @override
  String get type => (origin as RemoveFromLibraryProvider).type;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
