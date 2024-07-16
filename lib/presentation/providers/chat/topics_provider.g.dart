// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'topics_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$topicRepositoryHash() => r'80e04dfd14ce28ce371208faebe3df1ab193a0f6';

/// See also [topicRepository].
@ProviderFor(topicRepository)
final topicRepositoryProvider =
    AutoDisposeProvider<TopicRepositoryImpl>.internal(
  topicRepository,
  name: r'topicRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$topicRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef TopicRepositoryRef = AutoDisposeProviderRef<TopicRepositoryImpl>;
String _$getAllTopicsHash() => r'1029bebe68c61ea9ea40183fd9155c53eecf958c';

/// See also [getAllTopics].
@ProviderFor(getAllTopics)
final getAllTopicsProvider = AutoDisposeProvider<GetAllTopicsUseCase>.internal(
  getAllTopics,
  name: r'getAllTopicsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$getAllTopicsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GetAllTopicsRef = AutoDisposeProviderRef<GetAllTopicsUseCase>;
String _$addNewTopicHash() => r'162c34d4097f5ea23eace21adeb7c4014e374406';

/// See also [addNewTopic].
@ProviderFor(addNewTopic)
final addNewTopicProvider = AutoDisposeProvider<AddNewTopicsUseCase>.internal(
  addNewTopic,
  name: r'addNewTopicProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$addNewTopicHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef AddNewTopicRef = AutoDisposeProviderRef<AddNewTopicsUseCase>;
String _$topicsHash() => r'095198724177575909ba2cfef751be2ebb5bbad7';

/// See also [Topics].
@ProviderFor(Topics)
final topicsProvider =
    AutoDisposeNotifierProvider<Topics, List<Topic>>.internal(
  Topics.new,
  name: r'topicsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$topicsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$Topics = AutoDisposeNotifier<List<Topic>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
