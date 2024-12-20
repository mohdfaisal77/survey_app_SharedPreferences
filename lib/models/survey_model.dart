class SurveyModel {
  String name;
  String gender; // Drop Down
  int age;
  String roleAppliedFor;
  String otherRoles;
  String developerRole;
  String designerRole;
  String highestQualification;
  int totalExperience; // Total years of experience
  // For CurrentCTC and Expected- i have dependent options.
  int currentCTC; // Current CTC
  int expectedCTC; // Expected CTC

  // Dependent - if expected CTC != currentCTC -
  String reasonForCTCChange;

  // For rating there is one dependent question
  double rateYourSelf; // For slider, self-rating
  // if Rating < 7
  String reasonForLowRating;
  // if Rating >7 && Rating <=10
  String reasonForHighRating;

  bool immediateJoiner; // Whether they are an immediate joiner (Yes/No)

  // For Position - I have dependent options.
  String CompanyAppliedFor;

  // Options -
  String amazonLeadershipExperience; // For Amazon specific leadership questions
  String googleProjectExperience; // For Google-specific creativity and project-related questions
  String microsoftProblemSolvingExperience; // For Microsoft-specific problem-solving questions



  SurveyModel({

    required this.name,
    required this.gender,
    required this.age,
    required this.roleAppliedFor,
  required this.otherRoles,
  required this.developerRole,
  required this.designerRole,
    required this.highestQualification,
    required this.CompanyAppliedFor,
    required this.totalExperience,
    required this.currentCTC,
    required this.expectedCTC,
    required this.rateYourSelf,
    required this.immediateJoiner,
    this.reasonForCTCChange = '',
    this.reasonForLowRating = '',
    this.reasonForHighRating = '',
    this.amazonLeadershipExperience = '',
    this.googleProjectExperience = '',
    this.microsoftProblemSolvingExperience = '',

  });

  // Convert the model to a map for storing
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'gender': gender,
      'age': age,
      'otherRoles':otherRoles,
      'developerRole':developerRole,
      'designerRole':designerRole,
      'roleAppliedFor': roleAppliedFor,
      'highestQualification': highestQualification,
      'positionAppliedFor': CompanyAppliedFor,
      'totalExperience': totalExperience,
      'currentCTC': currentCTC,
      'expectedCTC': expectedCTC,
      'rateYourSelf': rateYourSelf,
      'immediateJoiner': immediateJoiner,
      'reasonForCTCChange': reasonForCTCChange,
      'reasonForLowRating': reasonForLowRating,
      'reasonForHighRating': reasonForHighRating,
      'amazonLeadershipExperience': amazonLeadershipExperience,
      'googleProjectExperience': googleProjectExperience,
      'microsoftProblemSolvingExperience': microsoftProblemSolvingExperience,
    };
  }

  // Factory constructor to create SurveyModel from map
  factory SurveyModel.fromMap(Map<String, dynamic> map) {
    return SurveyModel(
      name: map['name'] as String,
      gender: map['gender'] as String,
      age: map['age'] as int,
      roleAppliedFor: map['roleAppliedFor'] as String,
      highestQualification: map['highestQualification'] as String,
      CompanyAppliedFor: map['positionAppliedFor'] as String,
      totalExperience: map['totalExperience'] as int,
      currentCTC: map['currentCTC'] as int,
      expectedCTC: map['expectedCTC'] as int,
      rateYourSelf: map['rateYourSelf']?.toDouble() ?? 0.0,
      immediateJoiner: map['immediateJoiner'] ?? false,
      reasonForCTCChange: map['reasonForCTCChange'] ?? '',
      reasonForLowRating: map['reasonForLowRating'] ?? '',
      reasonForHighRating: map['reasonForHighRating'] ?? '',
      amazonLeadershipExperience: map['amazonLeadershipExperience'] ?? '',
      googleProjectExperience: map['googleProjectExperience'] ?? '',
      microsoftProblemSolvingExperience: map['microsoftProblemSolvingExperience'] ?? '', otherRoles: map['otherRoles'] ?? '', developerRole:map['developerRole'] ?? '', designerRole: map['designerRole'] ?? '',
    );
  }
}

