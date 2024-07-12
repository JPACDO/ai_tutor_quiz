import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ai_tutor_quiz/presentation/pages/views/views.dart';
import 'package:ai_tutor_quiz/presentation/widgets/widgets.dart';

class HomeScreen extends ConsumerStatefulWidget {
  static const name = 'home-screen';
  final int pageIndex;

  const HomeScreen(
    this.pageIndex, {
    super.key,
  });

  @override
  HomeScreenState createState() => HomeScreenState();
}

//* Este Mixin es necesario para mantener el estado en el PageView
class HomeScreenState extends ConsumerState<HomeScreen>
    with AutomaticKeepAliveClientMixin {
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController =
        PageController(initialPage: widget.pageIndex, keepPage: true);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  final viewRoutes = const <Widget>[
    TopicsView(),
    QuizGeneratorView(), // <--- categorias View
    QuizGeneratorView(), // <--- categorias View
  ];

  @override
  Widget build(BuildContext context) {
    super.build(context);

    if (pageController.hasClients) {
      pageController.animateToPage(
        widget.pageIndex,
        curve: Curves.easeInOut,
        duration: const Duration(milliseconds: 250),
      );
    }

    return Scaffold(
      body: PageView(
        //* Esto evitará que rebote
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        // index: pageIndex,
        children: viewRoutes,
      ),
      bottomNavigationBar: CustomBottomNavigation(
        currentIndex: widget.pageIndex,
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
