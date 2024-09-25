import 'package:clean_arch/core/domain/usecases/add_item_usescase.dart';
import 'package:clean_arch/core/domain/usecases/delete_item_usecase.dart';
import 'package:clean_arch/core/domain/usecases/get_item_usecase.dart';
import 'package:clean_arch/core/injector.dart';
import 'package:clean_arch/presenter/bloc/provider/add_item_bloc.dart';
import 'package:clean_arch/presenter/bloc/provider/firebase_list_bloc.dart';

import '../../firebase_list_screen/provider/firebase_screen_blocs_provider.dart';

// Singleton Bloc Provider,
// This will help to provide multiple bloc through single instance
class AddItemBlocsProvider {
  FirebaseListBloc? _itemListBloc;
  AddItemBloc? _addItemBloc;
  late AddItemUseCase addItemUseCaseImpl;
  late GetItemsUseCase getItemsUseCaseImpl;
  late DeleteItemUseCase deleteItemUseCaseImpl;

  AddItemBlocsProvider._privateConstructor() {
    addItemUseCaseImpl = sl<AddItemUseCase>();
    getItemsUseCaseImpl = sl<GetItemsUseCase>();
    deleteItemUseCaseImpl = sl<DeleteItemUseCase>();
  }

  static final AddItemBlocsProvider instance =
      AddItemBlocsProvider._privateConstructor();

  dynamic getBloc({dynamic blocType, bool newInstance = false}) {
    if (blocType == AddItemBloc) {
      if (newInstance || _addItemBloc == null) {
        _itemListBloc ??= FirebaseScreenBlocsProvider.instance
            .getBloc(blocType: FirebaseListBloc);
        return _addItemBloc = AddItemBloc(addItemUseCaseImpl, _itemListBloc!);
      }
      if (_addItemBloc != null) {
        return _addItemBloc;
      }
    }
  }

  void dispose() {
    _itemListBloc?.close();
    _addItemBloc?.close();
    _itemListBloc = null;
    _addItemBloc = null;
  }
}
