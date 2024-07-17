import 'package:flutter/material.dart';

/// A button that shows a dropdown menu when pressed.
///
/// This widget is used to create a dropdown menu that appears when a button is
/// pressed.
///
/// The [children] parameter is a list of widgets that will be displayed in the
/// dropdown menu.
///
/// The [iconOpen] parameter is an optional icon that will be displayed when
/// the dropdown menu is open. If not provided, a [iconClosed] will be used.
///
/// The [iconClosed] parameter is an required icon that will be displayed when
/// the dropdown menu is closed.
///
/// The [decoration] parameter is an optional decoration that can be used to
/// customize the appearance of the elements in the dropdown menu.
///
/// The [offset] parameter is an optional offset that can be used to customize
/// the position of the dropdown menu.
///
/// The [separation] parameter is the distance between the elements in the
/// dropdown menu.
///
/// The [elevation] parameter is the elevation of the dropdown menu.
class IconButtonDropdown extends StatefulWidget {
  const IconButtonDropdown(
      {super.key,
      required this.children,
      this.iconOpen,
      required this.iconClosed,
      this.decoration,
      this.offset,
      this.separation = 5.0,
      this.elevation = 2.0});

  /// The list of widgets that will be displayed in the dropdown menu.
  final List<Widget> children;

  /// An optional icon that will be displayed when the dropdown menu is open.
  /// If not provided, a [iconClosed] will be used.
  final Icon? iconOpen;

  /// An optional icon that will be displayed when the dropdown menu is closed.
  final Icon iconClosed;

  /// An optional decoration that can be used to customize the appearance of the
  /// elements in the dropdown menu.
  final BoxDecoration? decoration;

  /// An optional offset that can be used to customize the position of the
  /// dropdown menu.
  final Offset? offset;

  /// The distance between the elements in the dropdown menu.
  final double separation;

  /// The elevation of the dropdown menu.
  final double elevation;

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

    final offset = widget.offset ??
        Offset(0, -(48.0 + widget.separation) * widget.children.length);

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
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).colorScheme.shadow.withAlpha(100),
              blurRadius: widget.elevation,
              spreadRadius: 0.0,
              offset: Offset(0.0, widget.elevation),
            ),
          ],
        );

    for (var i = 0; i < widget.children.length; i++) {
      childrenWidgets.add(
        Container(
            margin: EdgeInsets.only(bottom: widget.separation),
            decoration: finalDecaration,
            child: widget.children[i]),
      );
    }

    return TapRegion(
      onTapOutside: (_) {
        hideOverlay();
      },
      child: Column(
        children: [
          ...childrenWidgets,
          IconButton(
            icon: widget.iconOpen ?? widget.iconClosed,
            onPressed: () {
              hideOverlay();
            },
          ),
        ],
      ),
    );
  }
}
