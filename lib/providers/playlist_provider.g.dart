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

String _$addIdToPlaylistHash() => r'd96a1c66ae2cd6137cdd3e18641013875b2b7d5e';

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

String _$findPlaylistHash() => r'0f0daae17bf11821534f7a4d0b63f579ef67fe9b';

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
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
