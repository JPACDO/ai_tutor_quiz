import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:ai_tutor_quiz/domain/entities/entities.dart';
import 'package:ai_tutor_quiz/presentation/pages/screens/screens.dart';

part 'app_router.g.dart';

@riverpod
GoRouter appRouter(AppRouterRef ref) {
  return GoRouter(
    initialLocation: '/upgrade',
    routes: [
      GoRoute(
        path: '/upgrade',
        name: ForceUpgradePage.routeName,
        builder: (context, state) {
          return const ForceUpgradePage();
        },
      ),
      GoRoute(
        path: '/home/:page',
        name: HomeScreen.name,
        builder: (context, state) {
          final pageIndex = int.parse(state.pathParameters['page'] ?? '0');
          return HomeScreen(pageIndex);
        },
      ),
      GoRoute(
        path: '/topic',
        name: ChatScreen.name,
        builder: (context, state) {
          final topic = state.extra as Topic;

          return ChatScreen(topicId: topic.id);
        },
      ),
      GoRoute(
        path: '/quiz',
        name: QuizLoadScreen.name,
        builder: (context, state) {
          return const QuizLoadScreen();
        },
      ),
      GoRoute(
        path: '/favorites',
        name: QuestionsOfList.name,
        builder: (context, state) {
          return QuestionsOfList(
            group: state.extra as GroupQuestions,
          );
        },
        routes: [
          GoRoute(
            path: 'take',
            name: TakeQuizSaved.name,
            builder: (context, state) {
              final questiions = state.extra as GroupQuestions;

              return TakeQuizSaved(
                quiz: questiions,
              );
            },
          ),
        ],
      ),
      GoRoute(
        path: '/result',
        name: ResultQuizScreen.name,
        builder: (context, state) {
          final quiz = state.extra as List<Question>;
          return ResultQuizScreen(quiz: quiz);
        },
      ),
      GoRoute(
        path: '/',
        redirect: (_, __) => '/home/0',
      ),
    ],
    // redirect: (context, state) {},
  );
}
