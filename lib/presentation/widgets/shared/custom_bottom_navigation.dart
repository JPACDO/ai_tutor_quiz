import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomBottomNavigation extends StatelessWidget {
  final int currentIndex;

  const CustomBottomNavigation({super.key, required this.currentIndex});

  void onItemTapped(BuildContext context, int index) {
    // context.go('');
    context.go('/home/$index');

    // switch(index) {
    //   case 0:
    //     context.go('/home/0');
    //     break;

    //   case 1:
    //     context.go('/home/1');
    //     break;

    //   case 2:
    //     context.go('/home/2');
    //     break;
    // }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (value) => onItemTapped(context, value),
        elevation: 0,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.chat_outlined), label: 'Tutor'),
          BottomNavigationBarItem(
              icon: Icon(Icons.quiz_outlined), label: 'Quiz'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite_outline), label: 'Favoritos'),
        ]);
  }
}