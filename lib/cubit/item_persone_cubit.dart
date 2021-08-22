import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pdf_generate_example/model/item_persone.dart';

part 'item_persone_state.dart';

class ItemPersoneCubit extends Cubit<ItemPersoneState> {
  ItemPersoneCubit() : super(ItemPersoneInitial());

	List<ItemPersone> _listItemPersone = [
		ItemPersone(
			name: "Munawir",
			old: 18
		),
		ItemPersone(
			name: "Mauriza",
			old: 20
		),
		ItemPersone(
			name: "Yafi Azka",
			old: 18
		),
	];

	List<ItemPersone> get listItemPersone => _listItemPersone;

	List<ItemPersone> _listItemPersoneByKeyword = [];
	List<ItemPersone> get listItemPersoneByKeyword => _listItemPersoneByKeyword;

	getAllItemPersone() {
		emit(ItemPersoneLoaded(listItemPersone));
	}

	getAllItemPersoneByKeword(String keyword) {
		final keywordLowerCase = keyword.toLowerCase();
		var list = _listItemPersone.where((element) => element.name.toLowerCase().contains(keywordLowerCase)).toList();
		// _listItemPersoneByKeyword = list;
		emit(ItemPersoneLoadedByKeyword(list));
	}

}
