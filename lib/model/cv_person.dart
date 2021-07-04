import 'dart:io';

class CvPerson {
	final String name;
	final String email;
	final String phoneNumber;
	final String address;
	final String about;
	final File imageFile;
	final List<Experience> experiences;
	final List<Education> educations;

  CvPerson({
		this.name, 
		this.email,
		this.phoneNumber,
		this.address, 
		this.about, 
		this.experiences,
		this.educations,
		this.imageFile,
	});

	CvPerson copyWith({
		String name,
		String about,
		String email,
		List<Experience> experiences,
		List<Education> educations,
		File imageFile,
	}) {
		return CvPerson(
			name: name ?? this.name,
			about: about ?? this.about,
			email: email ?? this.email,
			experiences: experiences,
			educations: educations,
			imageFile: imageFile ?? this.imageFile
		);
	}

}

class Experience {
	String title;
	String description;
	List<String> dateStart;
	List<String> dateEnd;
	bool isEdit;

  Experience({this.title, this.description, this.dateStart, this.dateEnd, this.isEdit = false,});
}

class Education {
	String school;
	String description;
	List<String> dateStart;
	List<String> dateEnd;
	bool isEdit;

  Education({this.school, this.description, this.dateStart, this.dateEnd, this.isEdit = false});
}