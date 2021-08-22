import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pdf_generate_example/model/cv_person.dart';

part 'experiece_data_state.dart';

class ExperieceDataCubit extends Cubit<ExperieceDataState> {
  ExperieceDataCubit() : super(ExperieceDataInitial());

	List<Experience> experiences = [
		// Experience(
		// 	title: "KERJA Di PT Sederhaan",
		// 	description: "BIsa aja ngap",
		// 	dateStart: ['Desember', '2018'],
		// 	dateEnd: ['July', '2021']
		// ),
	];

	getExperieces() {
		emit(GetExperieceData(experiences));
	}

	addExperiece(Experience experience) {
		experiences.add(experience);
	}

	removeAll() => experiences.clear();

	removeExperience(Experience experience) {
		experiences.remove(experience);
	}

	updateExperience(Experience experience, String title, String description, List<String> dateStart, List<String> dateEnd) {
		experience.title = 	title;
		experience.description = description;
		experience.dateStart = dateStart;
		experience.dateEnd = dateEnd;
		return experience;
	}

	List<Skill> _skills = [];

	addSkill(Skill skill) => _skills.add(skill);

	getSkills() => _skills;

}
