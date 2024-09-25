import 'package:clean_arch/presenter/ui/firebase_list_screen/data_model/item_view_model.dart';
import 'package:flutter/material.dart';

// coverage:ignore-file
class FirebaseListItemWidget extends StatelessWidget {
  final ItemViewModel item;
  final VoidCallback? onDelete;

  const FirebaseListItemWidget({
    Key? key,
    required this.item,
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
          item.title ?? "",
          style: const TextStyle(
            fontSize: 20,
            color: Colors.black,
          ),
        ),
        subtitle: Text(
          item.description ?? "",
        ),
        trailing:
            IconButton(icon: const Icon(Icons.delete), onPressed: onDelete),
      ),
    );
  }
}
