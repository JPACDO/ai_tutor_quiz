import 'package:ai_tutor_quiz/presentation/widgets/shared/create_new_dialog.dart';
import 'package:ai_tutor_quiz/presentation/widgets/shared/dialog_delete.dart';
import 'package:flutter/material.dart';

class TileEditDelete extends StatelessWidget {
  const TileEditDelete(
      {super.key,
      required this.name,
      this.onTap,
      this.leading,
      this.onRename,
      this.onDelete});

  final String name;
  final VoidCallback? onTap;
  final Widget? leading;
  final Function(String)? onRename;
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
