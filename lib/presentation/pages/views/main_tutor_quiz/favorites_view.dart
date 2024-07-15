import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ai_tutor_quiz/presentation/pages/screens/screens.dart';
import 'package:ai_tutor_quiz/presentation/providers/providers.dart';
import 'package:ai_tutor_quiz/presentation/widgets/widgets.dart';

class FavoritesView extends ConsumerStatefulWidget {
  const FavoritesView({super.key});

  @override
  ConsumerState<FavoritesView> createState() => _SavedViewState();
}

class _SavedViewState extends ConsumerState<FavoritesView> {
  @override
  void initState() {
    super.initState();
    ref.read(groupQuestionProvider.notifier).getAllGroupQuestions(userId: '0');
  }

  @override
  Widget build(BuildContext context) {
    final list = ref.watch(groupQuestionProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites Lists'),
      ),
      endDrawer: const DrawerMenu(),
      body: ListView.builder(
          itemCount: list.length,
          itemBuilder: (context, index) {
            return ListTile(
              onTap: () =>
                  context.pushNamed(QuestionsOfList.name, extra: list[index]),
              title: Text(list[index].name),
              subtitle: Text(list[index].description ?? ''),
              leading: const Icon(Icons.grading_rounded),
            );
          }),
    );
  }
}
