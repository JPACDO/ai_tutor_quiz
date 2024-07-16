import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../infrastructure/datasources/datasources.dart';

part 'databases_providers.g.dart';

@Riverpod(keepAlive: true)
GeminiChatDatasource geminiChatDatasource(GeminiChatDatasourceRef ref) {
  return GeminiChatDatasource();
}

@riverpod
IsarDatasource isarDatasource(IsarDatasourceRef ref) {
  return IsarDatasource();
}

@riverpod
IsarDatasource fakeDatasource(FakeDatasourceRef ref) {
  return FakeDbDatasource();
}
