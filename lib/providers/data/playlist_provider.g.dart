// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'playlist_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$fetchPlaylistsHash() => r'f06f2b7732e853860d7a8988a36f4d37820702c0';

/// See also [fetchPlaylists].
@ProviderFor(fetchPlaylists)
final fetchPlaylistsProvider = FutureProvider<List<Playlist>>.internal(
  fetchPlaylists,
  name: r'fetchPlaylistsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$fetchPlaylistsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef FetchPlaylistsRef = FutureProviderRef<List<Playlist>>;
String _$fetchNewPlaylistsHash() => r'217b67b408420cb4a0b3910787cac0263ca61908';

/// See also [fetchNewPlaylists].
@ProviderFor(fetchNewPlaylists)
final fetchNewPlaylistsProvider = FutureProvider<List<Playlist>>.internal(
  fetchNewPlaylists,
  name: r'fetchNewPlaylistsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$fetchNewPlaylistsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef FetchNewPlaylistsRef = FutureProviderRef<List<Playlist>>;
String _$addPlaylistHash() => r'cacf4f6084987d9f08599b65709b25cc95d23932';

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

/// See also [addPlaylist].
@ProviderFor(addPlaylist)
const addPlaylistProvider = AddPlaylistFamily();

/// See also [addPlaylist].
class AddPlaylistFamily extends Family<AsyncValue<bool>> {
  /// See also [addPlaylist].
  const AddPlaylistFamily();

  /// See also [addPlaylist].
  AddPlaylistProvider call(
    Playlist playlist,
  ) {
    return AddPlaylistProvider(
      playlist,
    );
  }

  @override
  AddPlaylistProvider getProviderOverride(
    covariant AddPlaylistProvider provider,
  ) {
    return call(
      provider.playlist,
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
  String? get name => r'addPlaylistProvider';
}

/// See also [addPlaylist].
class AddPlaylistProvider extends AutoDisposeFutureProvider<bool> {
  /// See also [addPlaylist].
  AddPlaylistProvider(
    Playlist playlist,
  ) : this._internal(
          (ref) => addPlaylist(
            ref as AddPlaylistRef,
            playlist,
          ),
          from: addPlaylistProvider,
          name: r'addPlaylistProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$addPlaylistHash,
          dependencies: AddPlaylistFamily._dependencies,
          allTransitiveDependencies:
              AddPlaylistFamily._allTransitiveDependencies,
          playlist: playlist,
        );

  AddPlaylistProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.playlist,
  }) : super.internal();

  final Playlist playlist;

  @override
  Override overrideWith(
    FutureOr<bool> Function(AddPlaylistRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: AddPlaylistProvider._internal(
        (ref) => create(ref as AddPlaylistRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        playlist: playlist,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<bool> createElement() {
    return _AddPlaylistProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is AddPlaylistProvider && other.playlist == playlist;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, playlist.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin AddPlaylistRef on AutoDisposeFutureProviderRef<bool> {
  /// The parameter `playlist` of this provider.
  Playlist get playlist;
}

class _AddPlaylistProviderElement extends AutoDisposeFutureProviderElement<bool>
    with AddPlaylistRef {
  _AddPlaylistProviderElement(super.provider);

  @override
  Playlist get playlist => (origin as AddPlaylistProvider).playlist;
}

String _$addIdToPlaylistHash() => r'ed38fcd4e5ad1b90752d4e3c253191aa1df682af';

/// See also [addIdToPlaylist].
@ProviderFor(addIdToPlaylist)
const addIdToPlaylistProvider = AddIdToPlaylistFamily();

/// See also [addIdToPlaylist].
class AddIdToPlaylistFamily extends Family<AsyncValue<bool>> {
  /// See also [addIdToPlaylist].
  const AddIdToPlaylistFamily();

  /// See also [addIdToPlaylist].
  AddIdToPlaylistProvider call(
    String playlistId,
    String id,
  ) {
    return AddIdToPlaylistProvider(
      playlistId,
      id,
    );
  }

  @override
  AddIdToPlaylistProvider getProviderOverride(
    covariant AddIdToPlaylistProvider provider,
  ) {
    return call(
      provider.playlistId,
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
  String? get name => r'addIdToPlaylistProvider';
}

/// See also [addIdToPlaylist].
class AddIdToPlaylistProvider extends AutoDisposeFutureProvider<bool> {
  /// See also [addIdToPlaylist].
  AddIdToPlaylistProvider(
    String playlistId,
    String id,
  ) : this._internal(
          (ref) => addIdToPlaylist(
            ref as AddIdToPlaylistRef,
            playlistId,
            id,
          ),
          from: addIdToPlaylistProvider,
          name: r'addIdToPlaylistProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$addIdToPlaylistHash,
          dependencies: AddIdToPlaylistFamily._dependencies,
          allTransitiveDependencies:
              AddIdToPlaylistFamily._allTransitiveDependencies,
          playlistId: playlistId,
          id: id,
        );

  AddIdToPlaylistProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.playlistId,
    required this.id,
  }) : super.internal();

  final String playlistId;
  final String id;

  @override
  Override overrideWith(
    FutureOr<bool> Function(AddIdToPlaylistRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: AddIdToPlaylistProvider._internal(
        (ref) => create(ref as AddIdToPlaylistRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        playlistId: playlistId,
        id: id,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<bool> createElement() {
    return _AddIdToPlaylistProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is AddIdToPlaylistProvider &&
        other.playlistId == playlistId &&
        other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, playlistId.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin AddIdToPlaylistRef on AutoDisposeFutureProviderRef<bool> {
  /// The parameter `playlistId` of this provider.
  String get playlistId;

  /// The parameter `id` of this provider.
  String get id;
}

class _AddIdToPlaylistProviderElement
    extends AutoDisposeFutureProviderElement<bool> with AddIdToPlaylistRef {
  _AddIdToPlaylistProviderElement(super.provider);

  @override
  String get playlistId => (origin as AddIdToPlaylistProvider).playlistId;
  @override
  String get id => (origin as AddIdToPlaylistProvider).id;
}

String _$addIdsToPlaylistHash() => r'6a3bb96a360ed38b90b20576c2ccefdd7696e5a7';

/// See also [addIdsToPlaylist].
@ProviderFor(addIdsToPlaylist)
const addIdsToPlaylistProvider = AddIdsToPlaylistFamily();

/// See also [addIdsToPlaylist].
class AddIdsToPlaylistFamily extends Family<AsyncValue<bool>> {
  /// See also [addIdsToPlaylist].
  const AddIdsToPlaylistFamily();

  /// See also [addIdsToPlaylist].
  AddIdsToPlaylistProvider call(
    String playlistId,
    List<String> ids,
  ) {
    return AddIdsToPlaylistProvider(
      playlistId,
      ids,
    );
  }

  @override
  AddIdsToPlaylistProvider getProviderOverride(
    covariant AddIdsToPlaylistProvider provider,
  ) {
    return call(
      provider.playlistId,
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
  String? get name => r'addIdsToPlaylistProvider';
}

/// See also [addIdsToPlaylist].
class AddIdsToPlaylistProvider extends AutoDisposeFutureProvider<bool> {
  /// See also [addIdsToPlaylist].
  AddIdsToPlaylistProvider(
    String playlistId,
    List<String> ids,
  ) : this._internal(
          (ref) => addIdsToPlaylist(
            ref as AddIdsToPlaylistRef,
            playlistId,
            ids,
          ),
          from: addIdsToPlaylistProvider,
          name: r'addIdsToPlaylistProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$addIdsToPlaylistHash,
          dependencies: AddIdsToPlaylistFamily._dependencies,
          allTransitiveDependencies:
              AddIdsToPlaylistFamily._allTransitiveDependencies,
          playlistId: playlistId,
          ids: ids,
        );

  AddIdsToPlaylistProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.playlistId,
    required this.ids,
  }) : super.internal();

  final String playlistId;
  final List<String> ids;

  @override
  Override overrideWith(
    FutureOr<bool> Function(AddIdsToPlaylistRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: AddIdsToPlaylistProvider._internal(
        (ref) => create(ref as AddIdsToPlaylistRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        playlistId: playlistId,
        ids: ids,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<bool> createElement() {
    return _AddIdsToPlaylistProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is AddIdsToPlaylistProvider &&
        other.playlistId == playlistId &&
        other.ids == ids;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, playlistId.hashCode);
    hash = _SystemHash.combine(hash, ids.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin AddIdsToPlaylistRef on AutoDisposeFutureProviderRef<bool> {
  /// The parameter `playlistId` of this provider.
  String get playlistId;

  /// The parameter `ids` of this provider.
  List<String> get ids;
}

class _AddIdsToPlaylistProviderElement
    extends AutoDisposeFutureProviderElement<bool> with AddIdsToPlaylistRef {
  _AddIdsToPlaylistProviderElement(super.provider);

  @override
  String get playlistId => (origin as AddIdsToPlaylistProvider).playlistId;
  @override
  List<String> get ids => (origin as AddIdsToPlaylistProvider).ids;
}

String _$deleteIndexFromPlaylistHash() =>
    r'dd1d77c615b1cf10691c1deff9b48210690a0234';

/// See also [deleteIndexFromPlaylist].
@ProviderFor(deleteIndexFromPlaylist)
const deleteIndexFromPlaylistProvider = DeleteIndexFromPlaylistFamily();

/// See also [deleteIndexFromPlaylist].
class DeleteIndexFromPlaylistFamily extends Family<AsyncValue<bool>> {
  /// See also [deleteIndexFromPlaylist].
  const DeleteIndexFromPlaylistFamily();

  /// See also [deleteIndexFromPlaylist].
  DeleteIndexFromPlaylistProvider call(
    String playlistId,
    int index,
  ) {
    return DeleteIndexFromPlaylistProvider(
      playlistId,
      index,
    );
  }

  @override
  DeleteIndexFromPlaylistProvider getProviderOverride(
    covariant DeleteIndexFromPlaylistProvider provider,
  ) {
    return call(
      provider.playlistId,
      provider.index,
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
  String? get name => r'deleteIndexFromPlaylistProvider';
}

/// See also [deleteIndexFromPlaylist].
class DeleteIndexFromPlaylistProvider extends AutoDisposeFutureProvider<bool> {
  /// See also [deleteIndexFromPlaylist].
  DeleteIndexFromPlaylistProvider(
    String playlistId,
    int index,
  ) : this._internal(
          (ref) => deleteIndexFromPlaylist(
            ref as DeleteIndexFromPlaylistRef,
            playlistId,
            index,
          ),
          from: deleteIndexFromPlaylistProvider,
          name: r'deleteIndexFromPlaylistProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$deleteIndexFromPlaylistHash,
          dependencies: DeleteIndexFromPlaylistFamily._dependencies,
          allTransitiveDependencies:
              DeleteIndexFromPlaylistFamily._allTransitiveDependencies,
          playlistId: playlistId,
          index: index,
        );

  DeleteIndexFromPlaylistProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.playlistId,
    required this.index,
  }) : super.internal();

  final String playlistId;
  final int index;

  @override
  Override overrideWith(
    FutureOr<bool> Function(DeleteIndexFromPlaylistRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: DeleteIndexFromPlaylistProvider._internal(
        (ref) => create(ref as DeleteIndexFromPlaylistRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        playlistId: playlistId,
        index: index,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<bool> createElement() {
    return _DeleteIndexFromPlaylistProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is DeleteIndexFromPlaylistProvider &&
        other.playlistId == playlistId &&
        other.index == index;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, playlistId.hashCode);
    hash = _SystemHash.combine(hash, index.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin DeleteIndexFromPlaylistRef on AutoDisposeFutureProviderRef<bool> {
  /// The parameter `playlistId` of this provider.
  String get playlistId;

  /// The parameter `index` of this provider.
  int get index;
}

class _DeleteIndexFromPlaylistProviderElement
    extends AutoDisposeFutureProviderElement<bool>
    with DeleteIndexFromPlaylistRef {
  _DeleteIndexFromPlaylistProviderElement(super.provider);

  @override
  String get playlistId =>
      (origin as DeleteIndexFromPlaylistProvider).playlistId;
  @override
  int get index => (origin as DeleteIndexFromPlaylistProvider).index;
}

String _$deletePlaylistHash() => r'0d1f278bb9fc7d56c9013c36bfa690407d638f65';

/// See also [deletePlaylist].
@ProviderFor(deletePlaylist)
const deletePlaylistProvider = DeletePlaylistFamily();

/// See also [deletePlaylist].
class DeletePlaylistFamily extends Family<AsyncValue<bool>> {
  /// See also [deletePlaylist].
  const DeletePlaylistFamily();

  /// See also [deletePlaylist].
  DeletePlaylistProvider call(
    String playlistId,
  ) {
    return DeletePlaylistProvider(
      playlistId,
    );
  }

  @override
  DeletePlaylistProvider getProviderOverride(
    covariant DeletePlaylistProvider provider,
  ) {
    return call(
      provider.playlistId,
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
  String? get name => r'deletePlaylistProvider';
}

/// See also [deletePlaylist].
class DeletePlaylistProvider extends AutoDisposeFutureProvider<bool> {
  /// See also [deletePlaylist].
  DeletePlaylistProvider(
    String playlistId,
  ) : this._internal(
          (ref) => deletePlaylist(
            ref as DeletePlaylistRef,
            playlistId,
          ),
          from: deletePlaylistProvider,
          name: r'deletePlaylistProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$deletePlaylistHash,
          dependencies: DeletePlaylistFamily._dependencies,
          allTransitiveDependencies:
              DeletePlaylistFamily._allTransitiveDependencies,
          playlistId: playlistId,
        );

  DeletePlaylistProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.playlistId,
  }) : super.internal();

  final String playlistId;

  @override
  Override overrideWith(
    FutureOr<bool> Function(DeletePlaylistRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: DeletePlaylistProvider._internal(
        (ref) => create(ref as DeletePlaylistRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        playlistId: playlistId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<bool> createElement() {
    return _DeletePlaylistProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is DeletePlaylistProvider && other.playlistId == playlistId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, playlistId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin DeletePlaylistRef on AutoDisposeFutureProviderRef<bool> {
  /// The parameter `playlistId` of this provider.
  String get playlistId;
}

class _DeletePlaylistProviderElement
    extends AutoDisposeFutureProviderElement<bool> with DeletePlaylistRef {
  _DeletePlaylistProviderElement(super.provider);

  @override
  String get playlistId => (origin as DeletePlaylistProvider).playlistId;
}

String _$findPlaylistHash() => r'fe9a4cf55d36cebee9cc88247b5c173bd1ef9800';

/// See also [findPlaylist].
@ProviderFor(findPlaylist)
const findPlaylistProvider = FindPlaylistFamily();

/// See also [findPlaylist].
class FindPlaylistFamily extends Family<AsyncValue<FilledPlaylist>> {
  /// See also [findPlaylist].
  const FindPlaylistFamily();

  /// See also [findPlaylist].
  FindPlaylistProvider call(
    String id,
  ) {
    return FindPlaylistProvider(
      id,
    );
  }

  @override
  FindPlaylistProvider getProviderOverride(
    covariant FindPlaylistProvider provider,
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
  String? get name => r'findPlaylistProvider';
}

/// See also [findPlaylist].
class FindPlaylistProvider extends AutoDisposeFutureProvider<FilledPlaylist> {
  /// See also [findPlaylist].
  FindPlaylistProvider(
    String id,
  ) : this._internal(
          (ref) => findPlaylist(
            ref as FindPlaylistRef,
            id,
          ),
          from: findPlaylistProvider,
          name: r'findPlaylistProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$findPlaylistHash,
          dependencies: FindPlaylistFamily._dependencies,
          allTransitiveDependencies:
              FindPlaylistFamily._allTransitiveDependencies,
          id: id,
        );

  FindPlaylistProvider._internal(
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
    FutureOr<FilledPlaylist> Function(FindPlaylistRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FindPlaylistProvider._internal(
        (ref) => create(ref as FindPlaylistRef),
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
  AutoDisposeFutureProviderElement<FilledPlaylist> createElement() {
    return _FindPlaylistProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FindPlaylistProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin FindPlaylistRef on AutoDisposeFutureProviderRef<FilledPlaylist> {
  /// The parameter `id` of this provider.
  String get id;
}

class _FindPlaylistProviderElement
    extends AutoDisposeFutureProviderElement<FilledPlaylist>
    with FindPlaylistRef {
  _FindPlaylistProviderElement(super.provider);

  @override
  String get id => (origin as FindPlaylistProvider).id;
}

String _$findSongsByPlaylistHash() =>
    r'2ee52e8797da7054a8b8a7bb6a4c7799ae782805';

/// See also [findSongsByPlaylist].
@ProviderFor(findSongsByPlaylist)
const findSongsByPlaylistProvider = FindSongsByPlaylistFamily();

/// See also [findSongsByPlaylist].
class FindSongsByPlaylistFamily extends Family<AsyncValue<List<Song>>> {
  /// See also [findSongsByPlaylist].
  const FindSongsByPlaylistFamily();

  /// See also [findSongsByPlaylist].
  FindSongsByPlaylistProvider call(
    String id,
  ) {
    return FindSongsByPlaylistProvider(
      id,
    );
  }

  @override
  FindSongsByPlaylistProvider getProviderOverride(
    covariant FindSongsByPlaylistProvider provider,
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
  String? get name => r'findSongsByPlaylistProvider';
}

/// See also [findSongsByPlaylist].
class FindSongsByPlaylistProvider
    extends AutoDisposeFutureProvider<List<Song>> {
  /// See also [findSongsByPlaylist].
  FindSongsByPlaylistProvider(
    String id,
  ) : this._internal(
          (ref) => findSongsByPlaylist(
            ref as FindSongsByPlaylistRef,
            id,
          ),
          from: findSongsByPlaylistProvider,
          name: r'findSongsByPlaylistProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$findSongsByPlaylistHash,
          dependencies: FindSongsByPlaylistFamily._dependencies,
          allTransitiveDependencies:
              FindSongsByPlaylistFamily._allTransitiveDependencies,
          id: id,
        );

  FindSongsByPlaylistProvider._internal(
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
    FutureOr<List<Song>> Function(FindSongsByPlaylistRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FindSongsByPlaylistProvider._internal(
        (ref) => create(ref as FindSongsByPlaylistRef),
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
    return _FindSongsByPlaylistProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FindSongsByPlaylistProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin FindSongsByPlaylistRef on AutoDisposeFutureProviderRef<List<Song>> {
  /// The parameter `id` of this provider.
  String get id;
}

class _FindSongsByPlaylistProviderElement
    extends AutoDisposeFutureProviderElement<List<Song>>
    with FindSongsByPlaylistRef {
  _FindSongsByPlaylistProviderElement(super.provider);

  @override
  String get id => (origin as FindSongsByPlaylistProvider).id;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
