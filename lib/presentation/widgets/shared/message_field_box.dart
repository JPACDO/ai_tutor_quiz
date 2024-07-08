import 'package:ai_tutor_quiz/presentation/widgets/shared/expanded_icon.dart';
import 'package:flutter/material.dart';

class MessageFieldBox extends StatefulWidget {
  final ValueChanged<String> onValue;

  const MessageFieldBox({super.key, required this.onValue});

  @override
  State<MessageFieldBox> createState() => _MessageFieldBoxState();
}

class _MessageFieldBoxState extends State<MessageFieldBox> {
  final textController = TextEditingController();
  final focusNode = FocusNode();
  bool isFocused = false;

  @override
  void initState() {
    super.initState();
    focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    super.dispose();
    focusNode.removeListener(_onFocusChange);
    focusNode.dispose();
  }

  void _onFocusChange() {
    debugPrint("Focus: ${focusNode.hasFocus.toString()}");
    setState(() {
      isFocused = focusNode.hasFocus;
    });
  }

  @override
  Widget build(BuildContext context) {
    final outlineInputBorder = UnderlineInputBorder(
      borderSide: const BorderSide(color: Colors.transparent),
      borderRadius: BorderRadius.only(
        topRight: const Radius.circular(40),
        bottomRight: const Radius.circular(40),
        topLeft: isFocused ? const Radius.circular(40) : Radius.zero,
      ),
    );

    final inputDecoration = InputDecoration(
      hintText: 'Message',
      enabledBorder: outlineInputBorder,
      focusedBorder: outlineInputBorder,
      filled: true,
      // prefixIcon:
      // IconButton(
      //   icon: const Icon(Icons.image_outlined),
      //   onPressed: () {},
      // ),
      suffixIcon: isFocused
          ? null
          : IconButton(
              icon: const Icon(Icons.send_outlined),
              onPressed: () {
                final textValue = textController.value.text;
                textController.clear();
                widget.onValue(textValue);
              },
            ),
    );

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceVariant,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Column(
        children: [
          Row(
            children: [
              isFocused ? Container() : const _NoFocused(),
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
                    widget.onValue(value);
                  },
                ),
              ),
            ],
          ),
          isFocused
              ? _InFocus(
                  textController: textController, onValue: widget.onValue)
              : Container(),
        ],
      ),
    );
  }
}

class _InFocus extends StatelessWidget {
  const _InFocus({
    super.key,
    required this.textController,
    required this.onValue,
  });

  final TextEditingController textController;
  final ValueChanged<String> onValue;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
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
          ]),
        ),
        IconButton(
          icon: const Icon(Icons.send_outlined),
          onPressed: () {
            final textValue = textController.value.text;
            textController.clear();
            onValue(textValue);
          },
        ),
        const SizedBox(width: 5),
      ],
    );
  }
}

class _NoFocused extends StatelessWidget {
  const _NoFocused({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
