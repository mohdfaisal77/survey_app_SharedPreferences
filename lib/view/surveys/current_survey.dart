import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:survey_app/view/bottom_nav/bottom_navbar.dart';
import 'package:survey_app/view/surveys/customer_feedback_survey.dart';
import '../../main.dart';
import '../../models/survey_model.dart';
import '../home/home_screen.dart';

class SurveyForm extends StatefulWidget {
  @override
  _SurveyFormState createState() => _SurveyFormState();
}

class _SurveyFormState extends State<SurveyForm> {
  final _formKey =GlobalKey<FormState>();
  // Controllers for TextFormFields
  TextEditingController totalExperienceController = TextEditingController();
  TextEditingController highestQualificationController = TextEditingController();
  TextEditingController roleAppliedForController = TextEditingController();
  TextEditingController currentCTCController = TextEditingController();
  TextEditingController expectedCTCController = TextEditingController();
  TextEditingController rateYourSelfController = TextEditingController();
  TextEditingController immediateJoinerController = TextEditingController();
  TextEditingController positionAppliedForController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController reasonForCTCChangeController = TextEditingController();
  TextEditingController reasonForLowRatingController = TextEditingController();
  TextEditingController reasonForHighRatingController = TextEditingController();
  TextEditingController amazonLeadershipController = TextEditingController();
  TextEditingController googleProjectController = TextEditingController();
  TextEditingController microsoftProblemController = TextEditingController();
  TextEditingController otherRolesController = TextEditingController();
  TextEditingController developerRoleController = TextEditingController();
  TextEditingController designerRoleController = TextEditingController();
  late SurveyModel surveyModel;

  @override
  void initState() {
    super.initState();
    // Initialize surveyModel with default values
    surveyModel = SurveyModel(
      name: '',
      gender: '',
      age: 0,
      roleAppliedFor: '',
      highestQualification: '',
      CompanyAppliedFor: '',
      totalExperience: 0,
      currentCTC: 0,
      expectedCTC: 0,
      rateYourSelf: 0.0, // Default rating
      immediateJoiner: false,
      reasonForCTCChange: '',
      reasonForLowRating: '',
      reasonForHighRating: '',
      amazonLeadershipExperience: '',
      googleProjectExperience: '',
      microsoftProblemSolvingExperience: '', otherRoles: '', developerRole: '', designerRole: '',
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    ageController.dispose();
    totalExperienceController.dispose();
    highestQualificationController.dispose();
    roleAppliedForController.dispose();
    currentCTCController.dispose();
    expectedCTCController.dispose();
    rateYourSelfController.dispose();
    immediateJoinerController.dispose();
    positionAppliedForController.dispose();
    genderController.dispose();
    reasonForCTCChangeController.dispose();
    reasonForLowRatingController.dispose();
    reasonForHighRatingController.dispose();
    amazonLeadershipController.dispose();
    googleProjectController.dispose();
    microsoftProblemController.dispose();
    super.dispose();
  }

  // Save the survey data
  void saveSurveyData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Ensure that text controllers are parsed safely before using them
    surveyModel = SurveyModel(
      name: nameController.text,
      gender: genderController.text,
      age: int.tryParse(ageController.text) ?? 0, // Safe parsing
      roleAppliedFor: roleAppliedForController.text,
      highestQualification: highestQualificationController.text,
      CompanyAppliedFor: positionAppliedForController.text,
      totalExperience: int.tryParse(totalExperienceController.text) ?? 0,
      currentCTC: int.tryParse(currentCTCController.text) ?? 0,
      expectedCTC: int.tryParse(expectedCTCController.text) ?? 0,
      rateYourSelf: double.tryParse(rateYourSelfController.text) ?? 0.0, // Safe parsing
      immediateJoiner: immediateJoinerController.text.toLowerCase() == 'true',
      reasonForCTCChange: reasonForCTCChangeController.text,
      reasonForLowRating: reasonForLowRatingController.text,
      reasonForHighRating: reasonForHighRatingController.text,
      amazonLeadershipExperience: amazonLeadershipController.text,
      googleProjectExperience: googleProjectController.text,
      microsoftProblemSolvingExperience: microsoftProblemController.text, otherRoles: otherRolesController.text, developerRole: developerRoleController.text, designerRole: designerRoleController.text,
    );

    // Save the survey model to SharedPreferences (JSON encoded)
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
      appBar: AppBar(title: Text("Job Survey"),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
     actions:[ Padding(
       padding: const EdgeInsets.only(right: 8.0),
       child: IconButton(
         icon: Icon(Icons.feedback_outlined),
           onPressed: (){
             Navigator.push(context, MaterialPageRoute(builder: (context)=>FeedbackSurvey()));
           },
        ),
     ),
    ],
      ),

      
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Form(
              key:_formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name Field
                  TextFormField(
                    controller: nameController,
                    onChanged: (value) {
                      setState(() {
                        surveyModel.name = value;
                      });
                    },
                    decoration: InputDecoration(labelText: "Name", border: OutlineInputBorder(),),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null; // Return null if validation is successful
                    },
                  ),
                  SizedBox(height: 20,),
                  // Age Field
                  TextFormField(
                    controller: ageController,
                    onChanged: (value) {
                      setState(() {
                        surveyModel.age = int.tryParse(value) ?? 0; // Safe parse
                      });
                    },
                    decoration: InputDecoration(labelText: "Age",border: OutlineInputBorder(),),
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
                    Text("Gender : ",style: TextStyle(fontWeight: FontWeight.w700),),
                    SizedBox(width: 20,),
                    DropdownButton<String>(
borderRadius: BorderRadius.circular(10),

                      value: surveyModel.gender.isEmpty ? null : surveyModel.gender,
                      hint: Text("Other",),
                      items: ['Other', 'Male', 'Female'].map((gender) {
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
                  SizedBox(height: 10,),
                  TextFormField(
                    controller: highestQualificationController,
                    onChanged: (value) {
                      setState(() {
                        surveyModel.name = value;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your Highest Qualification';
                      }
                      return null; // Return null if validation is successful
                    },
                    decoration: InputDecoration(labelText: "Highest Qualification",border: OutlineInputBorder(),),
                  ),
                  SizedBox(height: 10,),
                  // Position Applied For Dropdown
                  Row(
                    children: [
                      Text("Company Applied for : ",style: TextStyle(fontWeight: FontWeight.w700),),
                      SizedBox(width: 20,),
                      DropdownButton<String>(
                        value: surveyModel.CompanyAppliedFor.isEmpty
                            ? null
                            : surveyModel.CompanyAppliedFor,
                        hint: Text("Google"),
                        items: ['Other','Google', 'Microsoft', 'Amazon'].map((company) {
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
SizedBox(height: 20,),
                  // Show Position-Specific Questions
                  if (surveyModel.CompanyAppliedFor == 'Google') ...[
                    TextFormField(
                      controller: googleProjectController,
                      onChanged: (value) {
                        setState(() {
                          surveyModel.googleProjectExperience = value;
                        });
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                          labelText: "Google SDE Experience"),
                    ),
                  ] else
                    if (surveyModel.CompanyAppliedFor == 'Microsoft') ...[
                      TextFormField(
                        controller: microsoftProblemController,
                        onChanged: (value) {
                          setState(() {
                            surveyModel.microsoftProblemSolvingExperience = value;
                          });
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                            labelText: "Microsoft Problem Solving Experience"),
                      ),
                    ] else
                      if (surveyModel.CompanyAppliedFor == 'Amazon') ...[
                        TextFormField(
                          controller: amazonLeadershipController,
                          onChanged: (value) {
                            setState(() {
                              surveyModel.amazonLeadershipExperience = value;
                            });
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                              labelText: "AWS Cloud Experience"),
                        ),
                      ]else if(surveyModel.CompanyAppliedFor == 'other') ...[
                        Container()
                      ],
              SizedBox(height: 20,),
                  Row(
                    children: [
                      Text("Role Applied for : "),
                      SizedBox(width: 20,),
                      DropdownButton<String>(
                        value: surveyModel.roleAppliedFor.isEmpty ? null : surveyModel.roleAppliedFor,
                        hint: Text("Other"),
                        items: ['Other', 'Developer', 'Designer'].map((roleAppliedFor) {
                          return DropdownMenuItem<String>(
                            value: roleAppliedFor.isNotEmpty ? roleAppliedFor : 'Other',
                            child: Text(roleAppliedFor),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            surveyModel.roleAppliedFor = value!;
                          });
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  if (surveyModel.roleAppliedFor == 'Other') ...[
                    Container(),
                    SizedBox(height: 20,),
                  ] else
                    if (surveyModel.roleAppliedFor == 'Developer') ...[
                      TextFormField(
                        controller: developerRoleController,
                        onChanged: (value) {
                          setState(() {
                            surveyModel.developerRole = value;
                          });
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                            labelText: "Enter your Development Skills"),
                      ),
                      SizedBox(height: 20,),
                    ] else
                      if (surveyModel.roleAppliedFor == 'Designer') ...[
                        TextFormField(

                          controller: designerRoleController,
                          onChanged: (value) {
                            setState(() {
                              surveyModel.designerRole = value;
                            });
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                              labelText: "Enter your UI/UX Experience"),
                        ),
                      ],
                  SizedBox(height: 20,),
                  // CTC Fields
                  TextFormField(
                    controller: currentCTCController,
                    onChanged: (value) {
                      setState(() {
                        surveyModel.currentCTC = int.tryParse(value) ?? 0;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your Current CTC';
                      }
                      return null; // Return null if validation is successful
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Current CTC in LPA"),
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: 20,),
                  TextFormField(
                    controller: expectedCTCController,
                    onChanged: (value) {
                      setState(() {
                        surveyModel.expectedCTC = int.tryParse(value) ?? 0;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your Expected CTC ';
                      }
                      return null; // Return null if validation is successful
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Expected CTC in LPA"),
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: 20,),
                  // Show Reason for CTC Change if Expected CTC != Current CTC
                  if (surveyModel.expectedCTC != surveyModel.currentCTC) ...[
                    TextFormField(
                      controller: reasonForCTCChangeController,
                      onChanged: (value) {
                        setState(() {
                          surveyModel.reasonForCTCChange = value;
                        });
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                          labelText: "Reason for CTC Change"),
                    ),
                  ],
                  // Rating Field
              SizedBox(height: 20,),
                     Text("Rate your Self out of 10: ",style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w500),),
                  SizedBox(height: 10,),
                    Container(

                      width:double.maxFinite,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child:  Slider(
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
                    ),
                  SizedBox(height: 20,),
                  // Show Reason for Low Rating if rating is less than 7
                  if (surveyModel.rateYourSelf <7 && surveyModel.rateYourSelf >=1 ) ...[
                    TextFormField(
                      controller: reasonForLowRatingController,
                      onChanged: (value) {
                        setState(() {
                          surveyModel.reasonForLowRating = value;
                        });
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                          labelText: "Reason for Low Rating"),
                    ),
                  ],

                  // Show Reason for High Rating if rating is 7 or above
                  if (surveyModel.rateYourSelf >= 7) ...[
                    TextFormField(
                      controller: reasonForHighRatingController,
                      onChanged: (value) {
                        setState(() {
                          surveyModel.reasonForHighRating = value;
                        });
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                          labelText: "Reason for High Rating"),
                    ),
                  ],
                  SizedBox(height: 20,),
                  // Immediate Joiner Switch
                  SwitchListTile(
                    title: Text("Are you an Immediate Joiner?"),
                    value: surveyModel.immediateJoiner,
                    onChanged: (value) {
                      setState(() {
                        surveyModel.immediateJoiner = value;
                      });
                    },
                  ),
                  SizedBox(height: 40,),// Submit Button
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent
                    ),
                    onPressed: (){
                      if (_formKey.currentState!.validate()) {
                        // If the form is valid, save the data
                        saveSurveyData();
                      } else {
                        // If the form is not valid, you can handle that here
                        print("Form is not valid");
                      }
                    },
                    child: Text("Submit Survey",style: TextStyle(
                      fontSize: 18, // Adjust the font size as needed
                      fontWeight: FontWeight.bold, // Optional: Add boldness for emphasis
                      color: Colors.white, // Set text color to white for better contrast
                    ),),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
