import 'package:ai_tutor_quiz/presentation/widgets/shared/expanded_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MessageFieldBox extends StatelessWidget {
  final ValueChanged<String> onValue;

  const MessageFieldBox({super.key, required this.onValue});

  @override
  Widget build(BuildContext context) {
    final textController = TextEditingController();
    final focusNode = FocusNode();

    const outlineInputBorder = UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.transparent),
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(40),
          bottomRight: Radius.circular(40),
        ));

    final inputDecoration = InputDecoration(
      hintText: 'End your message with a "?"',
      enabledBorder: outlineInputBorder,
      focusedBorder: outlineInputBorder,
      filled: true,
      // prefixIcon:
      // IconButton(
      //   icon: const Icon(Icons.image_outlined),
      //   onPressed: () {},
      // ),
      suffixIcon: IconButton(
        icon: const Icon(Icons.send_outlined),
        onPressed: () {
          final textValue = textController.value.text;
          textController.clear();
          onValue(textValue);
        },
      ),
    );

    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceVariant,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(40),
              bottomLeft: Radius.circular(40),
            ),
          ),
          child: IconButtonDropdown(
            iconClosed: const Icon(Icons.photo_camera_back),
            children: [
              IconButton(
                  onPressed: () {
                    print('camera');
                  },
                  icon: const Icon(Icons.camera_alt_outlined)),
              IconButton(
                  onPressed: () {
                    print('image');
                  },
                  icon: const Icon(Icons.image_outlined)),
            ],
          ),
        ),
        Flexible(
          child: TextFormField(
            // onTapOutside: (event) {
            //   focusNode.unfocus();
            // },
            focusNode: focusNode,
            controller: textController,
            decoration: inputDecoration,
            maxLines: null,
            onFieldSubmitted: (value) {
              textController.clear();
              focusNode.requestFocus();
              onValue(value);
            },
          ),
        ),
      ],
    );
  }
}
