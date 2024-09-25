import 'package:clean_arch/common/constants.dart';
import 'package:clean_arch/core/data/dto/item_request_model.dart';
import 'package:clean_arch/presenter/bloc/provider/firebase_list_bloc.dart';
import 'package:clean_arch/presenter/ui/add_item/provider/add_item_blocs_provider.dart';
import 'package:clean_arch/presenter/ui/firebase_list_screen/data_model/item_view_model.dart';
import 'package:clean_arch/presenter/ui/firebase_list_screen/helper/add_button_widget.dart';
import 'package:clean_arch/presenter/ui/firebase_list_screen/helper/firebase_item_tile_widget.dart';
import 'package:clean_arch/presenter/ui/firebase_list_screen/helper/refresh_button_widget.dart';
import 'package:clean_arch/presenter/ui/firebase_list_screen/provider/firebase_screen_blocs_provider.dart';
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
  late FirebaseListBloc firebaseListBloc;

  @override
  void initState() {
    super.initState();
    firebaseListBloc = FirebaseScreenBlocsProvider.instance
        .getBloc(blocType: FirebaseListBloc, newInstance: true);
    firebaseListBloc.add(GetItemListEvent());

    /// just for reference
    // itemListBloc = sl<ItemListBloc>();
  }

  @override
  void dispose() {
    super.dispose();
    FirebaseScreenBlocsProvider.instance.dispose();
    AddItemBlocsProvider.instance.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Screen"),
        actions: [
          RefreshButtonWidget(
              onPressed: () => firebaseListBloc.add(GetItemListEvent())),
          const AddButton(),
        ],
      ),
      body: BlocBuilder<FirebaseListBloc, FirebaseListState>(
        bloc: firebaseListBloc,
        builder: (context, FirebaseListState state) {
          switch (state.runtimeType) {
            case ItemListInitialState:
              return const _BuildLoadingWidget();
            case ItemListLoadingState:
              return const _BuildLoadingWidget();
            case ItemListSuccessState:
              {
                ItemListSuccessState itemListSuccessState =
                    state as ItemListSuccessState;
                List<ItemViewModel> list = itemListSuccessState.data;
                if (list.isEmpty) {
                  return const _BuildEmptyWidget();
                } else {
                  return _buildListWidget(list);
                }
              }
            case ItemListErrorState:
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
  Widget _buildListWidget(List<ItemViewModel> itemList) {
    return AnimatedList(
      key: firebaseListBloc.listKey,
      initialItemCount: itemList.length,
      itemBuilder: (context, index, animation) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(-1, 0),
            end: const Offset(0, 0),
          ).animate(animation),
          child: FirebaseListItemWidget(
            key: Key(index.toString()),
            item: itemList[index],
            onDelete: () async {
              //Animate and delete from the database
              Future.delayed(const Duration(milliseconds: 500), () {
                firebaseListBloc.add(
                    DeleteItemEvent(ItemRequestModel(itemList[index].uid)));
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
