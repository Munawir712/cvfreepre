part of 'experiece_data_cubit.dart';

@immutable
abstract class ExperieceDataState {}

class ExperieceDataInitial extends ExperieceDataState {}

class GetExperieceData extends ExperieceDataState {
	final List<Experience> experieces;

  GetExperieceData(this.experieces);

}