import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pdf_generate_example/model/cv_person.dart';

part 'datacv_state.dart';

class DatacvCubit extends Cubit<DatacvState> {
  DatacvCubit() : super(DatacvInitial());

	getDataCv(CvPerson dataPerson) {
		if(dataPerson != null){
			emit(DatacvGetData(dataPerson));
		} else {
			emit(DatacvGetDataFaild("No data or Faild"));
		}
	}
}
