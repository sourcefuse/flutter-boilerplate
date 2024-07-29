import 'package:clean_arch/presenter/ui/home/data_model/note_view_model.dart';
import 'package:flutter/material.dart';

// coverage:ignore-file
class NoteTile extends StatelessWidget {
  final NoteViewModel note;
  final VoidCallback? onDelete;

  const NoteTile({
    Key? key,
    required this.note,
    this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 3,
      shadowColor: Colors.grey,
      child: ListTile(
        title: Text(
          note.title ?? "",
          style: const TextStyle(
            fontSize: 20,
            color: Colors.black,
          ),
        ),
        subtitle: Text(
          note.description ?? "",
        ),
        trailing:
            IconButton(icon: const Icon(Icons.delete), onPressed: onDelete),
      ),
    );
  }
}
