import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../infrastructure/datasources/datasources.dart';

part 'databases_providers.g.dart';

@Riverpod(keepAlive: true)
GeminiChatDatasource geminiChatDatasource(GeminiChatDatasourceRef ref) {
  return GeminiChatDatasource();
}

@riverpod
LocalStorageDbChatDatasource localStorageDbChatDatasource(
    LocalStorageDbChatDatasourceRef ref) {
  return LocalStorageDbChatDatasource();
}

@riverpod
LocalStorageDbChatDatasource fakeDatasource(FakeDatasourceRef ref) {
  return FakeDbDatasource();
}
