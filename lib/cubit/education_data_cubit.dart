import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pdf_generate_example/model/cv_person.dart';

part 'education_data_state.dart';

class EducationDataCubit extends Cubit<EducationDataState> {
  EducationDataCubit() : super(EducationDataInitial());

	List<Education> _educations = [];

	void addEducation(Education education) {
		_educations.add(education);
	}

	List<Education> getEducations() => _educations;

	void updateEducation(Education education, String school, String desc, List<String> dateStart, List<String> dateEnd) {
		education.school = school;
		education.description = desc;
		education.dateStart = dateStart;
		education.dateEnd = dateEnd;
	}

}
