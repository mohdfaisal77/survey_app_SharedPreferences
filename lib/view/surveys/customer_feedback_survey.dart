import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/survey_model.dart';
import '../bottom_nav/bottom_navbar.dart';

class FeedbackSurvey extends StatefulWidget {
  @override
  _FeedbackSurveyState createState() => _FeedbackSurveyState();
}

class _FeedbackSurveyState extends State<FeedbackSurvey> {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController experienceController = TextEditingController();
  TextEditingController rateYourSelfController = TextEditingController();
  TextEditingController reasonForHighRatingController = TextEditingController();
  TextEditingController reasonForLowRatingController = TextEditingController();
  TextEditingController productUsingController = TextEditingController();
  TextEditingController gogglesyearExperienceController = TextEditingController();
  TextEditingController watchesyearExperienceController = TextEditingController();


  late SurveyModel surveyModel;

  @override
  void initState() {
    super.initState();
    surveyModel = SurveyModel(
      name: '',
      gender: '',
      age: 0,
      roleAppliedFor: '',
      otherRoles: '',
      developerRole: '',
      designerRole: '',
      highestQualification: '',
      CompanyAppliedFor: '',
      totalExperience: 0,
      currentCTC: 0,
      expectedCTC: 0,
      rateYourSelf: 0.0,
      immediateJoiner: false,
        googleProjectExperience:'',
        microsoftProblemSolvingExperience:''
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    ageController.dispose();
    experienceController.dispose();
    rateYourSelfController.dispose();
    reasonForHighRatingController.dispose();
    reasonForLowRatingController.dispose();
    productUsingController.dispose();
    gogglesyearExperienceController.dispose();
    watchesyearExperienceController.dispose();
    super.dispose();
  }

  // Save feedback data
  void saveFeedbackData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Save the current survey data to the SurveyModel
    surveyModel = SurveyModel(
      name: nameController.text,
      gender: surveyModel.gender,
      age: int.tryParse(ageController.text) ?? 0,
      roleAppliedFor: surveyModel.roleAppliedFor,
      otherRoles: '', // Add value if you have it
      developerRole: '', // Add value if you have it
      designerRole: '', // Add value if you have it
      highestQualification: '', // Add value if you have it
      CompanyAppliedFor: surveyModel.CompanyAppliedFor,
      totalExperience: int.tryParse(experienceController.text) ?? 0,
      currentCTC: 0,
      expectedCTC: 0,
      reasonForLowRating: reasonForLowRatingController.text,
      reasonForHighRating: reasonForHighRatingController.text,
      rateYourSelf: double.tryParse(rateYourSelfController.text) ?? 0.0,
      immediateJoiner: surveyModel.immediateJoiner,
      amazonLeadershipExperience: surveyModel.amazonLeadershipExperience,
      googleProjectExperience: surveyModel.googleProjectExperience,
      microsoftProblemSolvingExperience: surveyModel.microsoftProblemSolvingExperience,
    );

    // Save feedback in SharedPreferences
    List<String> surveys = prefs.getStringList('surveys') ?? [];
    surveys.add(surveyModel.toMap().toString());
    await prefs.setStringList('surveys', surveys);

    // Update survey count
    int surveyCount = surveys.length;
    await prefs.setInt('survey_count', surveyCount);

    print("Survey Data Submitted: ${surveyModel.toMap()}");

    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Survey Data Saved!")));

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => BottomNavBar()),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Customer Feedback"),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        child: SafeArea(child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Name
                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(labelText: "Name", border: OutlineInputBorder(),),
                  onChanged: (value) {
                    setState(() {
                      surveyModel.name = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null; // Return null if validation is successful
                  },
                ),
SizedBox(height: 10,),
                // Age
                TextFormField(
                  controller: ageController,
                  decoration: InputDecoration(labelText: "Age", border: OutlineInputBorder(),),
                  onChanged: (value) {
                    setState(() {
                      surveyModel.age = int.tryParse(value) ?? 0; // Safe parse
                    });
                  },
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your Age';
                    }
                    return null; // Return null if validation is successful
                  },
                ),
                SizedBox(height: 10,),
                // Gender Dropdown
                Row(
                  children: [
                    Text("Gender: "),
                    SizedBox(width: 20,),
                    DropdownButton<String>(
                      value: surveyModel.gender.isEmpty ? null : surveyModel.gender,
                      hint: Text("Other"),
                      items: ['Male', 'Female','Other'].map((gender) {
                        return DropdownMenuItem<String>(
                          value: gender.isNotEmpty ? gender : 'Other',
                          child: Text(gender),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          surveyModel.gender = value!;
                        });
                      },
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text("Product Used: "),
                    SizedBox(width: 20,),
                    DropdownButton<String>(
                      value: surveyModel.CompanyAppliedFor.isEmpty
                          ? null
                          : surveyModel.CompanyAppliedFor,
                      hint: Text("Other"),
                      items: ['Other','Goggles', 'Watches'].map((company) {
                        return DropdownMenuItem<String>(
                          value: company.isNotEmpty ? company: 'Other' ,
                          child: Text(company),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          surveyModel.CompanyAppliedFor = value!;
                        });
                      },
                    ),
                  ],
                ),

                // Show Position-Specific Questions
                if (surveyModel.CompanyAppliedFor == 'Goggles') ...[
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: gogglesyearExperienceController,
                    onChanged: (value) {
                      setState(() {
                        surveyModel.googleProjectExperience = value;
                      });
                    },
                    decoration: InputDecoration(
                        labelText: "Experince in years of using goggles", border: OutlineInputBorder(),),
                  ),
                ] else
                  if (surveyModel.CompanyAppliedFor == 'Watches') ...[
                    TextFormField(
                      keyboardType: TextInputType.number,
                      controller: watchesyearExperienceController,
                      onChanged: (value) {
                        setState(() {
                          surveyModel.microsoftProblemSolvingExperience = value;
                        });
                      },
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Experince in years of using Watches"),
                    ),
                  ]
    else
    if (surveyModel.CompanyAppliedFor == 'Other') ...[
    Container()
    ],
                // Overall experience (years)

                SizedBox(height: 10,),
                // Product Rating (slider)
                Text("Rate our Product out of 10:"),
                Slider(
                  value: surveyModel.rateYourSelf,
                  min: 0,
                  max: 10,
                  divisions: 10,
                  label: surveyModel.rateYourSelf.toString(),

                  onChanged: (value) {
                    setState(() {
                      surveyModel.rateYourSelf = value;
                    });
                  },
                ),

                // Dependent - If Rating < 7, ask for improvement feedback
                if (surveyModel.rateYourSelf < 7) ...[
                  TextFormField(
                    controller: reasonForLowRatingController,
                    onChanged: (value) {
                      setState(() {
                        surveyModel.reasonForLowRating = value;
                      });
                    },
                    decoration: InputDecoration(
                        labelText: "Feedback on Quality improvement", border: OutlineInputBorder(),),
                  ),
                ],

                // Dependent - If Rating > 7, ask for feature feedback
                if (surveyModel.rateYourSelf >= 7) ...[
                  TextFormField(
                    controller: reasonForHighRatingController,
                    decoration: InputDecoration(labelText: "What features did you like?", border: OutlineInputBorder(),),
                    onChanged: (value) {
                      setState(() {
                        surveyModel.reasonForHighRating = value;
                      });
                    },
                  ),
                ],
                SizedBox(height: 10,),
                // Dependent - If Rating >= 9, ask for additional comments

                SizedBox(height: 30,),
                // Submit Button
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.blueAccent
                  ),
               onPressed: (){
                 if (_formKey.currentState!.validate()) {
    // If the form is valid, save the data
                 saveFeedbackData();
    } else {
    // If the form is not valid, you can handle that here
    print("Form is not valid");
    }
  },


                  child: Text("Submit Feedback",  style: TextStyle(
                    fontSize: 18, // Adjust the font size as needed
                    fontWeight: FontWeight.bold, // Optional: Add boldness for emphasis
                    color: Colors.white, // Set text color to white for better contrast
                  ),),
                ),
              ],
            ),
          ),
        ),)
      ),
    );
  }
}
