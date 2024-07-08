import 'package:flutter/material.dart';

class IconButtonDropdown extends StatefulWidget {
  const IconButtonDropdown(
      {super.key,
      required this.children,
      this.iconOpen,
      required this.iconClosed,
      this.decoration,
      this.offset});
  final List<Widget> children;
  final Icon? iconOpen;
  final Icon iconClosed;
  final BoxDecoration? decoration;
  final Offset? offset;

  @override
  State<IconButtonDropdown> createState() => _IconButtonDropdownState();
}

class _IconButtonDropdownState extends State<IconButtonDropdown> {
  bool _isHIde = true;
  OverlayEntry? entry;
  final layerLink = LayerLink();

  void showOverlay(BuildContext context) {
    final overlay = Overlay.of(context);
    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;

    final offset = widget.offset ?? Offset(0, -48.0 * widget.children.length);

    entry = OverlayEntry(
      builder: (context) => Positioned(
        // left: offset.dx,
        // top: offset.dy + size.height,
        width: size.width,
        child: CompositedTransformFollower(
            link: layerLink,
            showWhenUnlinked: false,
            offset: offset,
            child: buildOverlay()),
      ),
    );

    overlay.insert(entry!);
  }

  void hideOverlay() {
    _isHIde = true;

    entry?.remove();
    entry = null;
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: layerLink,
      child: IconButton(
        onPressed: () {
          if (_isHIde) {
            showOverlay(context);
            _isHIde = false;
          }

          setState(() {});
        },
        icon: widget.iconClosed,
      ),
    );
  }

  Widget buildOverlay() {
    final childrenWidgets = <Widget>[];
    final finalDecaration = widget.decoration ??
        BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceVariant,
          borderRadius: BorderRadius.circular(40),
        );

    for (var i = 0; i < widget.children.length; i++) {
      childrenWidgets.add(
        Container(decoration: finalDecaration, child: widget.children[i]),
      );
    }

    return TapRegion(
      onTapOutside: (_) {
        hideOverlay();
      },
      child: Column(
        children: [
          ...childrenWidgets,
          Container(
            decoration: finalDecaration,
            child: IconButton(
              icon: widget.iconOpen ?? widget.iconClosed,
              onPressed: () {
                hideOverlay();
              },
            ),
          ),
        ],
      ),
    );
  }
}
