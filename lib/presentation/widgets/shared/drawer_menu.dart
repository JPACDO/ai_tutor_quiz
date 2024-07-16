import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ai_tutor_quiz/presentation/providers/providers.dart';
import 'package:flex_color_picker/flex_color_picker.dart';

class DrawerMenu extends ConsumerWidget {
  const DrawerMenu({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(darkModeProvider);

    return Drawer(
      child: Column(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
                // color: seedColor,
                ),
            child: Text('WELCOME TO AI TUTOR QUIZ'),
          ),
          const Spacer(),
          ListTile(
            title: const Text("Dark Mode"),
            trailing: Switch(
                value: isDarkMode,
                onChanged: (data) {
                  ref.read(darkModeProvider.notifier).toggle();
                }),
          ),
          ListTile(
              title: const Text("Color Theme:"),
              subtitle: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                      onPressed: () {
                        ref
                            .read(colorThemeProvider.notifier)
                            .changeColor(Colors.purple);
                      },
                      icon: const Icon(
                        Icons.circle,
                        color: Colors.purple,
                      )),
                  IconButton(
                      onPressed: () {
                        ref
                            .read(colorThemeProvider.notifier)
                            .changeColor(Colors.blue);
                      },
                      icon: const Icon(
                        Icons.circle,
                        color: Colors.blue,
                      )),
                  IconButton(
                      onPressed: () {
                        ref
                            .read(colorThemeProvider.notifier)
                            .changeColor(Colors.green);
                      },
                      icon: const Icon(
                        Icons.circle,
                        color: Colors.green,
                      )),
                  IconButton(
                      onPressed: () {
                        ref
                            .read(colorThemeProvider.notifier)
                            .changeColor(Colors.red);
                      },
                      icon: const Icon(
                        Icons.circle,
                        color: Colors.red,
                      )),
                  IconButton(
                      onPressed: () async {
                        ColorPicker(
                            pickersEnabled: const <ColorPickerType, bool>{
                              ColorPickerType.wheel: true,
                            },
                            onColorChanged: (color) {
                              ref
                                  .read(colorThemeProvider.notifier)
                                  .changeColor(color);
                            }).showPickerDialog(context);
                      },
                      icon: Icon(
                        Icons.color_lens_outlined,
                        color: Theme.of(context).colorScheme.primary,
                      )),
                ],
              )),
          const Text("", style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
