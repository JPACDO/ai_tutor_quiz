// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$messageRepositoryHash() => r'35e5def1a66b1e54c96a38646842dd39a9819ed0';

/// See also [messageRepository].
@ProviderFor(messageRepository)
final messageRepositoryProvider = Provider<MessageRepositoryImpl>.internal(
  messageRepository,
  name: r'messageRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$messageRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef MessageRepositoryRef = ProviderRef<MessageRepositoryImpl>;
String _$getBotMessageHash() => r'f67593547c809528d31759168757c2bd7529791f';

/// See also [getBotMessage].
@ProviderFor(getBotMessage)
final getBotMessageProvider = Provider<GetBotMessageUseCase>.internal(
  getBotMessage,
  name: r'getBotMessageProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getBotMessageHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GetBotMessageRef = ProviderRef<GetBotMessageUseCase>;
String _$chatHash() => r'e853a925a32f8e74789a146e3cd509f9bdc1b394';

/// See also [Chat].
@ProviderFor(Chat)
final chatProvider = NotifierProvider<Chat, Topic>.internal(
  Chat.new,
  name: r'chatProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$chatHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$Chat = Notifier<Topic>;
String _$chatScrollControllerHash() =>
    r'2acba7139ae6a315483a266d79bb57546bd05d1e';

/// See also [ChatScrollController].
@ProviderFor(ChatScrollController)
final chatScrollControllerProvider = AutoDisposeNotifierProvider<
    ChatScrollController, ScrollController>.internal(
  ChatScrollController.new,
  name: r'chatScrollControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$chatScrollControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ChatScrollController = AutoDisposeNotifier<ScrollController>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
