import 'package:ai_tutor_quiz/presentation/providers/prefs/prefs_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dark_mode_provider.g.dart';

@riverpod
class DarkMode extends _$DarkMode {
  @override
  bool build() {
    return ref.read(prefsProvider).isDark;
  }

  void toggle() {
    state = !state;
    ref.read(prefsProvider).isDark = state;
  }
}
