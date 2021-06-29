part of 'datacv_cubit.dart';

@immutable
abstract class DatacvState {}

class DatacvInitial extends DatacvState {}

class DatacvGetData extends DatacvState {
	final CvPerson cvPerson;

	DatacvGetData(this.cvPerson);
}

class DatacvGetDataFaild extends DatacvState {
	final String message;

	DatacvGetDataFaild(this.message);
}