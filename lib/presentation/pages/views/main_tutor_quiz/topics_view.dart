import 'package:ai_tutor_quiz/domain/entities/entities.dart';
import 'package:ai_tutor_quiz/presentation/pages/screens/screens.dart';
import 'package:ai_tutor_quiz/presentation/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class TopicsView extends ConsumerStatefulWidget {
  const TopicsView({super.key});

  @override
  TopicsViewState createState() => TopicsViewState();
}

class TopicsViewState extends ConsumerState<TopicsView> {
  @override
  void initState() {
    super.initState();
    ref.read(topicsProvider.notifier).getAllTopics(userId: '1');
  }

  @override
  Widget build(BuildContext context) {
    final topics = ref.watch(topicsProvider);
    // print(topics);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Topics View'),
      ),
      body: GridView.builder(
        itemCount: topics.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
        ),
        itemBuilder: (context, index) {
          return _TopicCard(
            topic: topics[index],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            ref
                .read(topicsProvider.notifier)
                .addTopic(topic: Topic(idDb: null, name: "name", messages: []));
            // ref.read(topicsProvider.notifier).getAllTopics(userId: '1');
          },
          child: const Icon(Icons.add)),
    );
  }
}

class _TopicCard extends StatelessWidget {
  const _TopicCard({required this.topic});

  final Topic topic;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Card(
        child: ListTile(
          title: Text(topic.name),
          subtitle: Text(topic.idDb ?? 'null*'),
        ),
      ),
      onTap: () {
        context.pushNamed(TopicScreen.name, extra: topic);
      },
    );
  }
}
