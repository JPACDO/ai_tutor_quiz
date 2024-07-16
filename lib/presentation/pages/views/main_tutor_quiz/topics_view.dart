import 'package:ai_tutor_quiz/config/constants/values.dart';
import 'package:ai_tutor_quiz/presentation/widgets/shared/tile_edit_delete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ai_tutor_quiz/domain/entities/entities.dart';
import 'package:ai_tutor_quiz/presentation/pages/screens/screens.dart';
import 'package:ai_tutor_quiz/presentation/providers/providers.dart';
import 'package:ai_tutor_quiz/presentation/widgets/widgets.dart';

class TopicsView extends ConsumerStatefulWidget {
  const TopicsView({super.key});

  @override
  TopicsViewState createState() => TopicsViewState();
}

class TopicsViewState extends ConsumerState<TopicsView> {
  @override
  void initState() {
    super.initState();
    ref.read(topicsProvider.notifier).getAllTopics(userId: user.id);
  }

  @override
  Widget build(BuildContext context) {
    final topics = ref.watch(topicsProvider);
    // print(topics);

    return Scaffold(
      endDrawer: const DrawerMenu(),
      appBar: AppBar(
        title: const Text('Topics'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: topics.length,
        itemBuilder: (context, index) {
          final topic = topics[index];
          return TileEditDelete(
              name: topic.name,
              leading: const Icon(Icons.bubble_chart_sharp),
              onTap: () {
                context.pushNamed(ChatScreen.name, extra: topic);
              },
              onRename: (name) {
                ref
                    .read(topicsProvider.notifier)
                    .updateTopic(topic: topic.copyWith(name: name));
              },
              onDelete: () {
                ref.read(topicsProvider.notifier).removeTopic(topic: topic);
              });
        },
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () => dialogCreateNew(
              context: context,
              title: 'Create new topic',
              onSubmit: (name) {
                ref.read(topicsProvider.notifier).addTopic(
                    topic: Topic(
                        id: null, name: name, messages: [], userId: user.id));
              }),
          child: const Icon(Icons.add)),
    );
  }
}

// class _TopicCard extends StatelessWidget {
//   const _TopicCard({required this.topic});

//   final Topic topic;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: ListTile(
//         onTap: () {
//           context.pushNamed(ChatScreen.name, extra: topic);
//         },
//         title: Text(topic.name),
//         shape: RoundedRectangleBorder(
//           side: BorderSide(
//               color: Theme.of(context).colorScheme.secondary, width: 1),
//           borderRadius: BorderRadius.circular(5),
//         ),
//         leading: const Icon(Icons.bubble_chart_sharp),
//         trailing: PopupMenuButton(
//           itemBuilder: (context) => [
//             PopupMenuItem(
//               onTap: () {},
//               child: const Row(
//                 children: [
//                   Padding(
//                     padding: EdgeInsets.only(right: 5.0),
//                     child: Icon(Icons.edit),
//                   ),
//                   Text('Rename'),
//                 ],
//               ),
//             ),
//             PopupMenuItem(
//               onTap: () {},
//               child: const Row(
//                 children: [
//                   Padding(
//                     padding: EdgeInsets.only(right: 5.0),
//                     child: Icon(Icons.delete),
//                   ),
//                   Text('Delete'),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
