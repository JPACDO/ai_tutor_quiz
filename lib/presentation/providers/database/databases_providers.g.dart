// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'databases_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$geminiChatDatasourceHash() =>
    r'b2de907e433a9e3a1df6e11704a4e583fe7eaa6e';

/// See also [geminiChatDatasource].
@ProviderFor(geminiChatDatasource)
final geminiChatDatasourceProvider = Provider<GeminiChatDatasource>.internal(
  geminiChatDatasource,
  name: r'geminiChatDatasourceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$geminiChatDatasourceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GeminiChatDatasourceRef = ProviderRef<GeminiChatDatasource>;
String _$localStorageDbChatDatasourceHash() =>
    r'd4ca6d0ee95586af56ebf67bd060292f46ad761c';

/// See also [localStorageDbChatDatasource].
@ProviderFor(localStorageDbChatDatasource)
final localStorageDbChatDatasourceProvider =
    AutoDisposeProvider<LocalStorageDbChatDatasource>.internal(
  localStorageDbChatDatasource,
  name: r'localStorageDbChatDatasourceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$localStorageDbChatDatasourceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef LocalStorageDbChatDatasourceRef
    = AutoDisposeProviderRef<LocalStorageDbChatDatasource>;
String _$fakeDatasourceHash() => r'230ab66b2cca33c57eff66d8c3f8f27a826d4e10';

/// See also [fakeDatasource].
@ProviderFor(fakeDatasource)
final fakeDatasourceProvider =
    AutoDisposeProvider<LocalStorageDbChatDatasource>.internal(
  fakeDatasource,
  name: r'fakeDatasourceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$fakeDatasourceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef FakeDatasourceRef
    = AutoDisposeProviderRef<LocalStorageDbChatDatasource>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
