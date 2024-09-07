// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$loginPasswordHash() => r'5ab98728508fac08aa73ea19b570394242285e56';

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

/// See also [loginPassword].
@ProviderFor(loginPassword)
const loginPasswordProvider = LoginPasswordFamily();

/// See also [loginPassword].
class LoginPasswordFamily extends Family<AsyncValue<int>> {
  /// See also [loginPassword].
  const LoginPasswordFamily();

  /// See also [loginPassword].
  LoginPasswordProvider call(
    String username,
    String password,
  ) {
    return LoginPasswordProvider(
      username,
      password,
    );
  }

  @override
  LoginPasswordProvider getProviderOverride(
    covariant LoginPasswordProvider provider,
  ) {
    return call(
      provider.username,
      provider.password,
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
  String? get name => r'loginPasswordProvider';
}

/// See also [loginPassword].
class LoginPasswordProvider extends AutoDisposeFutureProvider<int> {
  /// See also [loginPassword].
  LoginPasswordProvider(
    String username,
    String password,
  ) : this._internal(
          (ref) => loginPassword(
            ref as LoginPasswordRef,
            username,
            password,
          ),
          from: loginPasswordProvider,
          name: r'loginPasswordProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$loginPasswordHash,
          dependencies: LoginPasswordFamily._dependencies,
          allTransitiveDependencies:
              LoginPasswordFamily._allTransitiveDependencies,
          username: username,
          password: password,
        );

  LoginPasswordProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.username,
    required this.password,
  }) : super.internal();

  final String username;
  final String password;

  @override
  Override overrideWith(
    FutureOr<int> Function(LoginPasswordRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: LoginPasswordProvider._internal(
        (ref) => create(ref as LoginPasswordRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        username: username,
        password: password,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<int> createElement() {
    return _LoginPasswordProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is LoginPasswordProvider &&
        other.username == username &&
        other.password == password;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, username.hashCode);
    hash = _SystemHash.combine(hash, password.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin LoginPasswordRef on AutoDisposeFutureProviderRef<int> {
  /// The parameter `username` of this provider.
  String get username;

  /// The parameter `password` of this provider.
  String get password;
}

class _LoginPasswordProviderElement
    extends AutoDisposeFutureProviderElement<int> with LoginPasswordRef {
  _LoginPasswordProviderElement(super.provider);

  @override
  String get username => (origin as LoginPasswordProvider).username;
  @override
  String get password => (origin as LoginPasswordProvider).password;
}

String _$loginTokenHash() => r'c0f1a8ac8768934a55c257af100634c34559eefc';

/// See also [loginToken].
@ProviderFor(loginToken)
const loginTokenProvider = LoginTokenFamily();

/// See also [loginToken].
class LoginTokenFamily extends Family<AsyncValue<int>> {
  /// See also [loginToken].
  const LoginTokenFamily();

  /// See also [loginToken].
  LoginTokenProvider call(
    String token,
  ) {
    return LoginTokenProvider(
      token,
    );
  }

  @override
  LoginTokenProvider getProviderOverride(
    covariant LoginTokenProvider provider,
  ) {
    return call(
      provider.token,
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
  String? get name => r'loginTokenProvider';
}

/// See also [loginToken].
class LoginTokenProvider extends AutoDisposeFutureProvider<int> {
  /// See also [loginToken].
  LoginTokenProvider(
    String token,
  ) : this._internal(
          (ref) => loginToken(
            ref as LoginTokenRef,
            token,
          ),
          from: loginTokenProvider,
          name: r'loginTokenProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$loginTokenHash,
          dependencies: LoginTokenFamily._dependencies,
          allTransitiveDependencies:
              LoginTokenFamily._allTransitiveDependencies,
          token: token,
        );

  LoginTokenProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.token,
  }) : super.internal();

  final String token;

  @override
  Override overrideWith(
    FutureOr<int> Function(LoginTokenRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: LoginTokenProvider._internal(
        (ref) => create(ref as LoginTokenRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        token: token,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<int> createElement() {
    return _LoginTokenProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is LoginTokenProvider && other.token == token;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, token.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin LoginTokenRef on AutoDisposeFutureProviderRef<int> {
  /// The parameter `token` of this provider.
  String get token;
}

class _LoginTokenProviderElement extends AutoDisposeFutureProviderElement<int>
    with LoginTokenRef {
  _LoginTokenProviderElement(super.provider);

  @override
  String get token => (origin as LoginTokenProvider).token;
}

String _$authtokenHash() => r'58bed1944a30e243f1df807d499670d726c2e65d';

/// See also [authtoken].
@ProviderFor(authtoken)
final authtokenProvider = AutoDisposeFutureProvider<String>.internal(
  authtoken,
  name: r'authtokenProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$authtokenHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef AuthtokenRef = AutoDisposeFutureProviderRef<String>;
String _$getRolesHash() => r'0c870d051c6afd96af5546dddb97cc4a2bc61fab';

/// See also [getRoles].
@ProviderFor(getRoles)
final getRolesProvider = FutureProvider<List<String>>.internal(
  getRoles,
  name: r'getRolesProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$getRolesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GetRolesRef = FutureProviderRef<List<String>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
