import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ai_tutor_quiz/presentation/pages/screens/screens.dart';
import 'package:ai_tutor_quiz/presentation/providers/providers.dart';
import 'package:ai_tutor_quiz/presentation/widgets/widgets.dart';
import 'package:ai_tutor_quiz/domain/entities/entities.dart';
import 'package:ai_tutor_quiz/config/constants/values.dart';

class FavoritesView extends ConsumerStatefulWidget {
  const FavoritesView({super.key});

  @override
  ConsumerState<FavoritesView> createState() => _SavedViewState();
}

class _SavedViewState extends ConsumerState<FavoritesView> {
  @override
  void initState() {
    super.initState();
    ref.read(groupQuestionProvider.notifier).getAllGroup(userId: user.id);
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
          padding: const EdgeInsets.all(20),
          itemCount: list.length,
          itemBuilder: (context, index) {
            final group = list[index];
            return TileEditDelete(
                name: group.name,
                leading: const Icon(Icons.checklist_outlined),
                onTap: () {
                  context.pushNamed(QuestionsOfList.name, extra: list[index]);
                },
                onRename: (name) {
                  ref
                      .read(groupQuestionProvider.notifier)
                      .updateGroup(group.copyWith(name: name));
                },
                onDelete: () {
                  ref.read(groupQuestionProvider.notifier).removeGroup(group);
                });
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => dialogCreateNew(
          context: context,
          title: 'Create New List',
          onSubmit: (name) {
            ref.read(groupQuestionProvider.notifier).createGroup(
                  GroupQuestions(questions: [], name: name, userId: user.id),
                );
          },
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}
