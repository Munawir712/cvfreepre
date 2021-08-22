part of 'item_persone_cubit.dart';

@immutable
abstract class ItemPersoneState {}

class ItemPersoneInitial extends ItemPersoneState {}

class ItemPersoneLoaded extends ItemPersoneState {
	final List<ItemPersone> item;
	ItemPersoneLoaded(this.item);
}

class ItemPersoneLoadedByKeyword extends ItemPersoneState {
	final List<ItemPersone> item;
	ItemPersoneLoadedByKeyword(this.item);
}
