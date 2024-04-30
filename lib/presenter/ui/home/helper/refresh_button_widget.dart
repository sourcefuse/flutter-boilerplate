import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clean_arch/presenter/bloc/provider/note_list_bloc.dart';
import 'package:clean_arch/presenter/ui/home/provider/home_blocs_provider.dart';

class RefreshButtonWidget extends StatefulWidget {
  final VoidCallback? onPressed;

  const RefreshButtonWidget({Key? key, this.onPressed}) : super(key: key);

  @override
  State<RefreshButtonWidget> createState() => _RefreshButtonWidgetState();
}

class _RefreshButtonWidgetState extends State<RefreshButtonWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late NoteListBloc noteListBloc;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 5000),
      vsync: this,
    );
    super.initState();
    // noteListBloc = sl<NoteListBloc>();
    noteListBloc = HomeBlocsProvider.instance.getBloc(blocType: NoteListBloc);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
        bloc: noteListBloc,
        builder: (context, state) {
          return RotationTransition(
            turns: Tween(begin: 0.0, end: 5.0).animate(_controller),
            child: IconButton(
              onPressed: widget.onPressed,
              icon: const Icon(
                Icons.sync,
                color: Colors.white,
              ),
            ),
          );
        },
        listener: (context, state) {
          if (state is NoteListLoadingState) {
            _controller.repeat();
          } else {
            _controller.reset();
          }
        });
  }
}
