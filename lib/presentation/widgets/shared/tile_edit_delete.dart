import 'package:ai_tutor_quiz/presentation/widgets/shared/create_new_dialog.dart';
import 'package:ai_tutor_quiz/presentation/widgets/shared/dialog_delete.dart';
import 'package:flutter/material.dart';

/// A ListTile with a trailing PopupMenuButton that has
/// options to edit and delete the tile.
///
/// The [name] parameter is the text that will be displayed
/// as the title of the ListTile.
///
/// The [onTap] parameter is a callback that will be called
/// when the ListTile is tapped.
///
/// The [leading] parameter is a widget that will be displayed
/// as the leading icon of the ListTile.
///
/// The [onRename] parameter is a callback that will be called
/// when the "Rename" option is selected from the PopupMenuButton.
/// The callback will be passed the new name of the tile as a
/// String parameter.
///
/// The [onDelete] parameter is a callback that will be called
/// when the "Delete" option is selected from the PopupMenuButton.
class TileEditDelete extends StatelessWidget {
  const TileEditDelete(
      {super.key,
      required this.name,
      this.onTap,
      this.leading,
      this.onRename,
      this.onDelete});

  /// The text that will be displayed as the title of the ListTile.
  final String name;

  /// A callback that will be called when the ListTile is tapped.
  final VoidCallback? onTap;

  /// A widget that will be displayed as the leading icon of the ListTile.
  final Widget? leading;

  /// A callback that will be called when the "Rename" option is selected from the PopupMenuButton.
  /// The callback will be passed the new name of the tile as a String parameter.
  final Function(String)? onRename;

  /// A callback that will be called when the "Delete" option is selected from the PopupMenuButton.
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        onTap: onTap,
        title: Text(name),
        shape: RoundedRectangleBorder(
          side: BorderSide(
              color: Theme.of(context).colorScheme.secondary, width: 1),
          borderRadius: BorderRadius.circular(5),
        ),
        leading: leading,
        trailing: PopupMenuButton(
          itemBuilder: (context) => [
            PopupMenuItem(
              onTap: () {
                if (onRename == null) return;
                dialogCreateNew(
                    context: context,
                    title: "Rename",
                    fieldText: name,
                    onSubmit: onRename!);
              },
              child: const Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 5.0),
                    child: Icon(Icons.edit),
                  ),
                  Text('Rename'),
                ],
              ),
            ),
            PopupMenuItem(
              onTap: () {
                if (onDelete == null) return;
                dialogDelete(context: context, name: name, onSubmit: onDelete!);
              },
              child: const Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 5.0),
                    child: Icon(Icons.delete),
                  ),
                  Text('Delete'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
