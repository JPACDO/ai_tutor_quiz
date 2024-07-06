import 'package:ai_tutor_quiz/domain/entities/entities.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:ai_tutor_quiz/presentation/pages/screens/screens.dart';

part 'app_router.g.dart';

@riverpod
GoRouter appRouter(AppRouterRef ref) {
  return GoRouter(
    initialLocation: '/home/0',
    routes: [
      GoRoute(
        path: '/home/:page',
        name: HomeScreen.name,
        builder: (context, state) {
          final pageIndex = int.parse(state.pathParameters['page'] ?? '0');
          return HomeScreen(pageIndex);
        },
        // routes: [
        //   GoRoute(
        //     path: 'topic/:id',
        //     name: TopicScreen.name,
        //     builder: (context, state) {
        //       // final movieId = state.params['id'] ?? 'no-id';
        //       final topic = state.extra as Topic;
        //       return TopicScreen(
        //           topicId: topic.idDb, topic: state.extra as Topic);
        //     },
        //   ),
        // ],
      ),
      GoRoute(
          path: '/topic',
          name: TopicScreen.name,
          builder: (context, state) {
            final topic = state.extra as Topic;

            return TopicScreen(topicId: topic.idDb);
          }),
      GoRoute(
        path: '/',
        redirect: (_, __) => '/home/0',
      ),
    ],
    // redirect: (context, state) {},
  );
}


// final appRouter = GoRouter(
//   initialLocation: '/home/0',
//   routes: [
    
//     GoRoute(
//       path: '/home/:page',
//       name: HomeScreen.name,
//       builder: (context, state) {
//         final pageIndex = int.parse( state.pathParameters['page'] ?? '0' );
      
//         return HomeScreen( pageIndex: pageIndex );
//       },
//       routes: [
//          GoRoute(
//           path: 'movie/:id',
//           name: TopicScreen.name,
//           builder: (context, state) {
//             final movieId = state.params['id'] ?? 'no-id';

//             return MovieScreen( movieId: movieId );
//           },
//         ),
//       ]
//     ),

//     GoRoute(
//       path: '/',
//       redirect: ( _ , __ ) => '/home/0',
//     ),

//   ]
// );