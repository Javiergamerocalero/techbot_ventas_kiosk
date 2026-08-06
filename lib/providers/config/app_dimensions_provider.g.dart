// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_dimensions_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$appDimensionsHash() => r'd70e431fdb165cbb09c04a266543d095c0c9d91b';

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

/// See also [appDimensions].
@ProviderFor(appDimensions)
const appDimensionsProvider = AppDimensionsFamily();

/// See also [appDimensions].
class AppDimensionsFamily extends Family<AppDimensions> {
  /// See also [appDimensions].
  const AppDimensionsFamily();

  /// See also [appDimensions].
  AppDimensionsProvider call(BuildContext context) {
    return AppDimensionsProvider(context);
  }

  @override
  AppDimensionsProvider getProviderOverride(
    covariant AppDimensionsProvider provider,
  ) {
    return call(provider.context);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'appDimensionsProvider';
}

/// See also [appDimensions].
class AppDimensionsProvider extends AutoDisposeProvider<AppDimensions> {
  /// See also [appDimensions].
  AppDimensionsProvider(BuildContext context)
    : this._internal(
        (ref) => appDimensions(ref as AppDimensionsRef, context),
        from: appDimensionsProvider,
        name: r'appDimensionsProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$appDimensionsHash,
        dependencies: AppDimensionsFamily._dependencies,
        allTransitiveDependencies:
            AppDimensionsFamily._allTransitiveDependencies,
        context: context,
      );

  AppDimensionsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.context,
  }) : super.internal();

  final BuildContext context;

  @override
  Override overrideWith(
    AppDimensions Function(AppDimensionsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: AppDimensionsProvider._internal(
        (ref) => create(ref as AppDimensionsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        context: context,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<AppDimensions> createElement() {
    return _AppDimensionsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is AppDimensionsProvider && other.context == context;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, context.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin AppDimensionsRef on AutoDisposeProviderRef<AppDimensions> {
  /// The parameter `context` of this provider.
  BuildContext get context;
}

class _AppDimensionsProviderElement
    extends AutoDisposeProviderElement<AppDimensions>
    with AppDimensionsRef {
  _AppDimensionsProviderElement(super.provider);

  @override
  BuildContext get context => (origin as AppDimensionsProvider).context;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
