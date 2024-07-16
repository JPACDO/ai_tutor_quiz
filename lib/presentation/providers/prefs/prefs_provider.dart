// REPOSITORY PROVIDER  -----------------------------------------------------
import 'package:ai_tutor_quiz/infrastructure/repositories/repositories.dart';
import 'package:ai_tutor_quiz/presentation/providers/database/databases_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'prefs_provider.g.dart';

@riverpod
PrefsRepositoryImpl prefs(PrefsRef ref) {
  final prefsDS = ref.read(sharePreferencesProvider);

  return PrefsRepositoryImpl(prefsDS);
}
