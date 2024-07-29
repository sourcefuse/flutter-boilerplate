import 'package:clean_arch/common/constants.dart';
import 'package:clean_arch/core/data/dto/note_request_model.dart';
import 'package:clean_arch/presenter/bloc/provider/note_list_bloc.dart';
import 'package:clean_arch/presenter/ui/add_note/provider/note_blocs_provider.dart';
import 'package:clean_arch/presenter/ui/home/data_model/note_view_model.dart';
import 'package:clean_arch/presenter/ui/home/helper/add_button_widget.dart';
import 'package:clean_arch/presenter/ui/home/helper/note_tile_widget.dart';
import 'package:clean_arch/presenter/ui/home/helper/refresh_button_widget.dart';
import 'package:clean_arch/presenter/ui/home/provider/home_blocs_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late NoteListBloc noteListBloc;

  @override
  void initState() {
    super.initState();
    noteListBloc = HomeBlocsProvider.instance.getBloc(blocType: NoteListBloc);
    noteListBloc.add(GetNoteListEvent());

    /// just for reference
    // noteListBloc = sl<NoteListBloc>();
  }

  @override
  void dispose() {
    super.dispose();
    HomeBlocsProvider.instance.dispose();
    NoteBlocsProvider.instance.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Screen"),
        actions: [
          RefreshButtonWidget(
              onPressed: () => noteListBloc.add(GetNoteListEvent())),
          const AddButton(),
        ],
      ),
      body: BlocBuilder<NoteListBloc, NoteListState>(
        bloc: noteListBloc,
        builder: (context, NoteListState state) {
          switch (state.runtimeType) {
            case NoteListInitialState:
              return const _BuildLoadingWidget();
            case NoteListLoadingState:
              return const _BuildLoadingWidget();
            case NoteListSuccessState:
              {
                NoteListSuccessState noteListSuccessState =
                    state as NoteListSuccessState;
                List<NoteViewModel> list = noteListSuccessState.data;
                if (list.isEmpty) {
                  return const _BuildEmptyWidget();
                } else {
                  return _buildListWidget(list);
                }
              }
            case NoteListErrorState:
              return const _BuildFailureEvent();
            default:
              return const Center(child: Text("Unknown - Error"));
          }
        },
      ),
    );
  }

  /// The _buildListWidget function creates an AnimatedList widget with slide transition animations for
  /// displaying a list of NoteModel objects.
  ///
  /// Args:
  ///   noteList (List<NoteModel>): The `noteList` parameter in the `_buildListWidget` function is a
  /// list of `NoteModel` objects. This list contains the data that will be used to populate the
  /// `AnimatedList` widget with `NoteTile` widgets. Each `NoteTile` widget represents a single note
  /// from the
  ///
  /// Returns:
  ///   A widget of type AnimatedList is being returned.
  Widget _buildListWidget(List<NoteViewModel> noteList) {
    return AnimatedList(
      key: noteListBloc.listKey,
      initialItemCount: noteList.length,
      itemBuilder: (context, index, animation) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(-1, 0),
            end: const Offset(0, 0),
          ).animate(animation),
          child: NoteTile(
            key: Key(index.toString()),
            note: noteList[index],
            onDelete: () async {
              //Animate and delete from the database
              Future.delayed(const Duration(milliseconds: 500), () {
                noteListBloc.add(
                    DeleteNoteEvent(NoteRequestModel(noteList[index].uid)));
              });
            },
          ),
        );
      },
    );
  }
}

class _BuildLoadingWidget extends StatelessWidget {
  const _BuildLoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Lottie.network(
        kLoadingURL,
        height: 160.h,
      ),
    );
  }
}

class _BuildFailureEvent extends StatelessWidget {
  const _BuildFailureEvent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("Sorry, Something went wrong :("));
  }
}

class _BuildEmptyWidget extends StatelessWidget {
  const _BuildEmptyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Lottie.network(
        kEmptyURL,
        height: 160.h,
      ),
    );
  }
}
