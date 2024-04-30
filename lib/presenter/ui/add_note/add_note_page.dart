import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:clean_arch/core/data/dto/note_model.dart';
import 'package:clean_arch/presenter/bloc/provider/add_note_bloc.dart';
import 'package:clean_arch/presenter/ui/add_note/helper/text_field_widget.dart';
import 'package:clean_arch/presenter/ui/add_note/provider/note_blocs_provider.dart';
import 'package:clean_arch/utils/priority_util.dart';
import 'package:uuid/uuid.dart';

class AddNotePage extends StatefulWidget {
  const AddNotePage({Key? key}) : super(key: key);

  @override
  State<AddNotePage> createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  late AddNoteBloc addNoteBloc;
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  Priority? _priority;

  @override
  initState() {
    super.initState();
    addNoteBloc = NoteBlocsProvider.instance.getBloc(blocType: AddNoteBloc);

    ///just for reference
    // addNoteBloc = sl<AddNoteBloc>();
  }

  @override
  void dispose() {
    super.dispose();
    // NoteBlocsProvider.instance.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add a new note"),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        child: Column(children: [
          TextFieldWidget(
            controller: titleController,
            hint: "Send mail",
            label: "Title",
          ),
          SizedBox(height: 16.h),
          TextFieldWidget(
            controller: descriptionController,
            hint: "I will not be able to come office",
            label: "Description",
          ),
          SizedBox(height: 16.h),
          const Row(
            children: [
              Text("Set priority"),
            ],
          ),
          SizedBox(height: 16.h),
          ListTile(
            title: const Text("Low"),
            leading: Radio<Priority>(
                value: Priority.low,
                groupValue: _priority,
                onChanged: (value) {
                  setState(() {
                    _priority = value;
                  });
                }),
          ),
          ListTile(
            title: const Text("Medium"),
            leading: Radio<Priority>(
                value: Priority.medium,
                groupValue: _priority,
                onChanged: (value) {
                  setState(() {
                    _priority = value;
                  });
                }),
          ),
          ListTile(
            title: const Text("High"),
            leading: Radio<Priority>(
                value: Priority.high,
                groupValue: _priority,
                onChanged: (value) {
                  setState(() {
                    _priority = value;
                  });
                }),
          ),
        ]),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            /// The `addNoteBloc.add()` method is used to add an event to the `addNoteBloc` instance. In
            /// this specific case, the event being added is an `AddNoteSubmitEvent` which contains a
            /// `NoteModel` object with the following properties:
            /// - `title`: The text entered in the title text field (`titleController.text`).
            /// - `description`: The text entered in the description text field
            /// (`descriptionController.text`).
            /// - `date`: The current date and time (`DateTime.now()`).
            /// - `uid`: A unique identifier generated using the `Uuid` package (`const Uuid().v1()`).
            /// - `priority`: The priority level selected by the user, converted to a numerical value
            /// using `PriorityUtil.getPriorityCount(_priority)`.
            addNoteBloc.add(
              AddNoteSubmitEvent(
                NoteModel(
                  title: titleController.text,
                  description: descriptionController.text,
                  date: DateTime.now(),
                  uid: const Uuid().v1(),
                  priority: PriorityUtil.getPriorityCount(_priority),
                ),
              ),
            );
            Navigator.pop(context);
          },
          child: const Icon(Icons.check)),
    );
  }
}
