// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'status_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getChecklistItemsHash() => r'1b3d0884ff5e067f570a14afa8ac7ecdfc86bf68';

/// See also [getChecklistItems].
@ProviderFor(getChecklistItems)
final getChecklistItemsProvider =
    AutoDisposeFutureProvider<List<ChecklistItem>>.internal(
  getChecklistItems,
  name: r'getChecklistItemsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getChecklistItemsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef GetChecklistItemsRef
    = AutoDisposeFutureProviderRef<List<ChecklistItem>>;
String _$addChecklistItemHash() => r'd6ef2ee6dc593aa5ecea8141c4c34eae9e033adf';

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

/// See also [addChecklistItem].
@ProviderFor(addChecklistItem)
const addChecklistItemProvider = AddChecklistItemFamily();

/// See also [addChecklistItem].
class AddChecklistItemFamily extends Family<AsyncValue<bool>> {
  /// See also [addChecklistItem].
  const AddChecklistItemFamily();

  /// See also [addChecklistItem].
  AddChecklistItemProvider call(
    List<String> data,
  ) {
    return AddChecklistItemProvider(
      data,
    );
  }

  @override
  AddChecklistItemProvider getProviderOverride(
    covariant AddChecklistItemProvider provider,
  ) {
    return call(
      provider.data,
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
  String? get name => r'addChecklistItemProvider';
}

/// See also [addChecklistItem].
class AddChecklistItemProvider extends AutoDisposeFutureProvider<bool> {
  /// See also [addChecklistItem].
  AddChecklistItemProvider(
    List<String> data,
  ) : this._internal(
          (ref) => addChecklistItem(
            ref as AddChecklistItemRef,
            data,
          ),
          from: addChecklistItemProvider,
          name: r'addChecklistItemProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$addChecklistItemHash,
          dependencies: AddChecklistItemFamily._dependencies,
          allTransitiveDependencies:
              AddChecklistItemFamily._allTransitiveDependencies,
          data: data,
        );

  AddChecklistItemProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.data,
  }) : super.internal();

  final List<String> data;

  @override
  Override overrideWith(
    FutureOr<bool> Function(AddChecklistItemRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: AddChecklistItemProvider._internal(
        (ref) => create(ref as AddChecklistItemRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        data: data,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<bool> createElement() {
    return _AddChecklistItemProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is AddChecklistItemProvider && other.data == data;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, data.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin AddChecklistItemRef on AutoDisposeFutureProviderRef<bool> {
  /// The parameter `data` of this provider.
  List<String> get data;
}

class _AddChecklistItemProviderElement
    extends AutoDisposeFutureProviderElement<bool> with AddChecklistItemRef {
  _AddChecklistItemProviderElement(super.provider);

  @override
  List<String> get data => (origin as AddChecklistItemProvider).data;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
