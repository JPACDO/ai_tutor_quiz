// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiz_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$quizRepositoryHash() => r'668099836ab630d6ed45de25784ae363ddc72394';

/// See also [quizRepository].
@ProviderFor(quizRepository)
final quizRepositoryProvider = AutoDisposeProvider<QuizRepositoryImpl>.internal(
  quizRepository,
  name: r'quizRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$quizRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef QuizRepositoryRef = AutoDisposeProviderRef<QuizRepositoryImpl>;
String _$getBotQuizHash() => r'ad09d1bbc9ef19d7672108cc44cb6402dd43e18e';

/// See also [getBotQuiz].
@ProviderFor(getBotQuiz)
final getBotQuizProvider = AutoDisposeProvider<GetBotQuizUseCase>.internal(
  getBotQuiz,
  name: r'getBotQuizProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$getBotQuizHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GetBotQuizRef = AutoDisposeProviderRef<GetBotQuizUseCase>;
String _$quizPHash() => r'4cf04a4e2532ce90cb4b3df80e588bc1ddca6e24';

/// See also [QuizP].
@ProviderFor(QuizP)
final quizPProvider = NotifierProvider<QuizP, List<Question>>.internal(
  QuizP.new,
  name: r'quizPProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$quizPHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$QuizP = Notifier<List<Question>>;
String _$promptQuizHash() => r'1bc407baec22d2e2291a9f90aefa44f4701780fd';

/// See also [PromptQuiz].
@ProviderFor(PromptQuiz)
final promptQuizProvider = NotifierProvider<PromptQuiz, String>.internal(
  PromptQuiz.new,
  name: r'promptQuizProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$promptQuizHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$PromptQuiz = Notifier<String>;
String _$quizParamsHash() => r'8baa08029247fe36fa525d54cb09ccca2a22b85b';

/// See also [QuizParams].
@ProviderFor(QuizParams)
final quizParamsProvider = NotifierProvider<QuizParams, Quiz>.internal(
  QuizParams.new,
  name: r'quizParamsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$quizParamsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$QuizParams = Notifier<Quiz>;
String _$quizUserResponseHash() => r'9e4ed85634931a118eee5d1b0d270d652114e9ce';

/// See also [QuizUserResponse].
@ProviderFor(QuizUserResponse)
final quizUserResponseProvider =
    NotifierProvider<QuizUserResponse, List<int?>>.internal(
  QuizUserResponse.new,
  name: r'quizUserResponseProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$quizUserResponseHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$QuizUserResponse = Notifier<List<int?>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
