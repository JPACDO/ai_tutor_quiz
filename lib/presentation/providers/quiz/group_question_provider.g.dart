// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_question_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$groupQuestionRepositoryHash() =>
    r'6933955eae672a5e44972b467e1805c8b3fd9a51';

/// See also [groupQuestionRepository].
@ProviderFor(groupQuestionRepository)
final groupQuestionRepositoryProvider =
    AutoDisposeProvider<GroupQuestionsRepositoryImpl>.internal(
  groupQuestionRepository,
  name: r'groupQuestionRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$groupQuestionRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GroupQuestionRepositoryRef
    = AutoDisposeProviderRef<GroupQuestionsRepositoryImpl>;
String _$getAllGroupQuestionsHash() =>
    r'45528554dc24a4686ab0703d78a211d93459ad62';

/// See also [getAllGroupQuestions].
@ProviderFor(getAllGroupQuestions)
final getAllGroupQuestionsProvider =
    AutoDisposeProvider<GetAllGroupQuestionsUseCase>.internal(
  getAllGroupQuestions,
  name: r'getAllGroupQuestionsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getAllGroupQuestionsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GetAllGroupQuestionsRef
    = AutoDisposeProviderRef<GetAllGroupQuestionsUseCase>;
String _$createGroupQuestionHash() =>
    r'a25c55c9a06119c342236fe979882469761f35d6';

/// See also [createGroupQuestion].
@ProviderFor(createGroupQuestion)
final createGroupQuestionProvider =
    AutoDisposeProvider<AddNewGroupQuestionsUseCase>.internal(
  createGroupQuestion,
  name: r'createGroupQuestionProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$createGroupQuestionHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef CreateGroupQuestionRef
    = AutoDisposeProviderRef<AddNewGroupQuestionsUseCase>;
String _$addQuestionInGroupHash() =>
    r'adf55c2889e24a6589f2383b82a9fab090e553f5';

/// See also [addQuestionInGroup].
@ProviderFor(addQuestionInGroup)
final addQuestionInGroupProvider =
    AutoDisposeProvider<AddQuestionInGoroupUseCase>.internal(
  addQuestionInGroup,
  name: r'addQuestionInGroupProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$addQuestionInGroupHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef AddQuestionInGroupRef
    = AutoDisposeProviderRef<AddQuestionInGoroupUseCase>;
String _$deleteQuestionOfGroupHash() =>
    r'40115b2e0f869db695687f6f996daafd29f24225';

/// See also [deleteQuestionOfGroup].
@ProviderFor(deleteQuestionOfGroup)
final deleteQuestionOfGroupProvider =
    AutoDisposeProvider<DeleteQuestionOfGoroupUseCase>.internal(
  deleteQuestionOfGroup,
  name: r'deleteQuestionOfGroupProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$deleteQuestionOfGroupHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef DeleteQuestionOfGroupRef
    = AutoDisposeProviderRef<DeleteQuestionOfGoroupUseCase>;
String _$groupQuestionHash() => r'e49edc69006f1b2a02bdfadb685d66689fb2fa10';

/// See also [GroupQuestion].
@ProviderFor(GroupQuestion)
final groupQuestionProvider =
    AutoDisposeNotifierProvider<GroupQuestion, List<GroupQuestions>>.internal(
  GroupQuestion.new,
  name: r'groupQuestionProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$groupQuestionHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$GroupQuestion = AutoDisposeNotifier<List<GroupQuestions>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
