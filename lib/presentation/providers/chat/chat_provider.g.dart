// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$messageRepositoryHash() => r'5c7c5579640c2051b037641b7d9b7cdaa531a871';

/// See also [messageRepository].
@ProviderFor(messageRepository)
final messageRepositoryProvider =
    AutoDisposeProvider<MessageRepositoryImpl>.internal(
  messageRepository,
  name: r'messageRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$messageRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef MessageRepositoryRef = AutoDisposeProviderRef<MessageRepositoryImpl>;
String _$getBotMessageHash() => r'841540969ed1535437741d93153ee4e983d2ca51';

/// See also [getBotMessage].
@ProviderFor(getBotMessage)
final getBotMessageProvider =
    AutoDisposeProvider<GetBotMessageUseCase>.internal(
  getBotMessage,
  name: r'getBotMessageProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getBotMessageHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GetBotMessageRef = AutoDisposeProviderRef<GetBotMessageUseCase>;
String _$chatHash() => r'aa3f195240e8516e49a4be94491a74022db8b084';

/// See also [Chat].
@ProviderFor(Chat)
final chatProvider = AutoDisposeNotifierProvider<Chat, Topic>.internal(
  Chat.new,
  name: r'chatProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$chatHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$Chat = AutoDisposeNotifier<Topic>;
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
