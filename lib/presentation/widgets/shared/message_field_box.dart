import 'dart:io';

import 'package:ai_tutor_quiz/presentation/widgets/shared/expanded_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';

class MessageFieldBox extends StatefulWidget {
  // final ValueChanged<String> onValue;
  final Function(String, XFile?) onValue;

  const MessageFieldBox({super.key, required this.onValue});

  @override
  State<MessageFieldBox> createState() => _MessageFieldBoxState();
}

class _MessageFieldBoxState extends State<MessageFieldBox> {
  final textController = TextEditingController();
  final focusNode = FocusNode();
  bool isFocused = false;
  int maxLines = 1;
  bool expanded = false;
  XFile? image;

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

      if (isFocused) {
        maxLines = 5;
      } else {
        maxLines = textController.text.isEmpty ? 1 : 5;
      }

      expanded = maxLines == 5;
    });
  }

  @override
  Widget build(BuildContext context) {
    final outlineInputBorder = UnderlineInputBorder(
      borderSide: const BorderSide(color: Colors.transparent),
      borderRadius: BorderRadius.only(
        topRight: const Radius.circular(40),
        bottomRight: const Radius.circular(40),
        topLeft: expanded ? const Radius.circular(40) : Radius.zero,
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
      suffixIcon: expanded
          ? null
          : IconButton(
              icon: const Icon(Icons.send_outlined),
              onPressed: () {
                final textValue = textController.value.text;
                if (textValue.trim().isEmpty) return;

                textController.clear();
                widget.onValue(textValue, image);
                image = null;
                setState(() {});
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
          image == null
              ? Container()
              : ImagePreview(
                  image: image!,
                  removeImg: () {
                    image = null;
                    setState(() {});
                  }),
          Row(
            children: [
              expanded
                  ? Container()
                  : _NoFocused(
                      onImageSelected: (value) {
                        image = value;
                        setState(() {});
                      },
                    ),
              Flexible(
                child: TextFormField(
                  // onTapOutside: (event) {
                  //   focusNode.unfocus();
                  // },
                  focusNode: focusNode,
                  controller: textController,
                  decoration: inputDecoration,
                  maxLines: maxLines,
                  // style: const TextStyle(fontSize: 20.0),
                  keyboardType: TextInputType.multiline,
                  onFieldSubmitted: (value) {
                    if (value.trim().isEmpty) return;

                    textController.clear();
                    focusNode.requestFocus();
                    widget.onValue(value, image);
                    image = null;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          expanded
              ? _InFocus(
                  textController: textController,
                  onValue: (value) {
                    widget.onValue(value, image);
                    image = null;
                    setState(() {});
                  },
                  onImageSelected: (value) {
                    image = value;
                    setState(() {});
                  },
                )
              : Container(),
        ],
      ),
    );
  }
}

class ImagePreview extends StatelessWidget {
  const ImagePreview({
    super.key,
    required this.image,
    required this.removeImg,
  });

  final XFile image;
  final Function() removeImg;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      InkWell(
        onTap: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              content: InteractiveViewer(
                panEnabled: false, // Set it to false
                boundaryMargin: EdgeInsets.all(100),
                minScale: 0.5,
                maxScale: 2,
                child: Image.file(
                  File(image.path),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Ok'),
                ),
              ],
            ),
          );
        },
        child: Image.file(
          File(image.path),
          width: 100,
          height: 100,
          fit: BoxFit.cover,
        ),
      ),
      IconButton(
          padding: EdgeInsets.zero,
          style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all(Colors.black.withAlpha(100))),
          onPressed: removeImg,
          icon: const Icon(
            Icons.close,
            color: Colors.white,
          ))
    ]);
  }
}

class _InFocus extends StatelessWidget {
  const _InFocus({
    required this.textController,
    required this.onValue,
    required this.onImageSelected,
  });

  final TextEditingController textController;
  final ValueChanged<String> onValue;
  final ValueChanged<XFile?> onImageSelected;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            IconButton(
                onPressed: () async {
                  onImageSelected(await _getImageFromCamera());
                },
                icon: const Icon(Icons.camera_alt_outlined)),
            IconButton(
                onPressed: () async {
                  onImageSelected(await _getImageFromGallery());
                },
                icon: const Icon(Icons.image_outlined)),
          ]),
        ),
        IconButton(
          icon: const Icon(Icons.send_outlined),
          onPressed: () {
            final textValue = textController.value.text;
            if (textController.text.trim().isEmpty) return;
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
    required this.onImageSelected,
  });
  final ValueChanged<XFile?> onImageSelected;

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
              onPressed: () async {
                onImageSelected(await _getImageFromCamera());
              },
              icon: const Icon(Icons.camera_alt_outlined)),
          IconButton(
              onPressed: () async {
                onImageSelected(await _getImageFromGallery());
              },
              icon: const Icon(Icons.image_outlined)),
        ],
      ),
    );
  }
}

Future<XFile?> _getImageFromGallery() async {
  final ImagePicker picker = ImagePicker();
  return await picker.pickImage(source: ImageSource.gallery);
}

Future<XFile?> _getImageFromCamera() async {
  final ImagePicker picker = ImagePicker();
  return await picker.pickImage(source: ImageSource.camera);
}
