// ignore_for_file: unused_import

import 'package:clean_arch/common/constants.dart';
import 'package:clean_arch/core/domain/entities/task_model.dart';
import 'package:clean_arch/presenter/bloc/provider/api_list_bloc.dart';
import 'package:clean_arch/presenter/bloc/provider/firebase_list_bloc.dart';
import 'package:clean_arch/presenter/ui/add_item/provider/add_item_blocs_provider.dart';
import 'package:clean_arch/presenter/ui/api_list_screen/provider/api_screen_blocs_provider.dart';
import 'package:clean_arch/presenter/ui/firebase_list_screen/helper/add_button_widget.dart';
import 'package:clean_arch/presenter/ui/api_list_screen/helper/api_list_item_widget.dart';
import 'package:clean_arch/presenter/ui/firebase_list_screen/helper/refresh_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class TaskListPage extends StatefulWidget {
  const TaskListPage({Key? key}) : super(key: key);

  @override
  State<TaskListPage> createState() => _TaskListPageState();
}

class _TaskListPageState extends State<TaskListPage>
    with TickerProviderStateMixin {
  late APIListBloc apiListBloc;

  @override
  void initState() {
    super.initState();
    apiListBloc = APIScreenBlocsProvider.instance
        .getBloc(blocType: APIListBloc, newInstance: true);
    apiListBloc.add(GetTasksListEvent());

    /// just for reference
    // itemListBloc = sl<ItemListBloc>();
  }

  @override
  void dispose() {
    super.dispose();
    APIScreenBlocsProvider.instance.dispose();
    AddItemBlocsProvider.instance.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("API List Screen"),
      ),
      body: BlocBuilder<APIListBloc, APIListState>(
        bloc: apiListBloc,
        builder: (context, APIListState state) {
          switch (state.runtimeType) {
            case InitialState:
              return const _BuildLoadingWidget();
            case LoadingState:
              return const _BuildLoadingWidget();
            case TasksListSuccessState:
              {
                TasksListSuccessState itemListSuccessState =
                    state as TasksListSuccessState;
                List<Task> list = itemListSuccessState.data;
                if (list.isEmpty) {
                  return const _BuildEmptyWidget();
                } else {
                  return _buildListWidget(list);
                }
              }
            case TasksListErrorState:
              return const _BuildFailureEvent();
            default:
              return const Center(child: Text("Unknown - Error"));
          }
        },
      ),
    );
  }

  /// The _buildListWidget function creates an AnimatedList widget with slide transition animations for
  /// displaying a list of ItemModel objects.
  ///
  /// Args:
  ///   itemList (List<ItemModel>): The `itemList` parameter in the `_buildListWidget` function is a
  /// list of `ItemModel` objects. This list contains the data that will be used to populate the
  /// `AnimatedList` widget with `ItemTile` widgets. Each `ItemTile` widget represents a single item
  /// from the
  ///
  /// Returns:
  ///   A widget of type AnimatedList is being returned.
  Widget _buildListWidget(List<Task> itemList) {
    return AnimatedList(
      key: apiListBloc.listKey,
      initialItemCount: itemList.length,
      itemBuilder: (context, index, animation) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(-1, 0),
            end: const Offset(0, 0),
          ).animate(animation),
          child: ApiListItemWidget(
            key: Key(index.toString()),
            task: itemList[index],
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
