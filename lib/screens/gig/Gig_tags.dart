import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../components/AppColors.dart';
import 'Create_first_gig.dart';

class GigTags extends StatefulWidget {
  final PageController pageController;
  final InputData inputData;
  GigTags({Key? key, required this.pageController, required this.inputData})
      : super(key: key);
  @override
  State<GigTags> createState() => _GigTagsState();
}

class _GigTagsState extends State<GigTags> {
  FocusNode skillFocusNode = FocusNode();

  void _onDataCollected(List<String> data) {
    widget.inputData.skills = data;

    // You can perform other operations with the data if needed
    // ...

    // Move to the next page
    widget.pageController.nextPage(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  TextEditingController skillController = TextEditingController();

  bool loading = false;
  List<String> addedSkills = [];
  List<String> suggestedSkills = [
    'Hard Working',
    'Reliable',
    'Efficient',
    'Punctual',
    'Responsive',
    'Customer-focused',
    'Quality work',
  ];
  @override
  void dispose() {
    // TODO: implement dispose

    super.dispose();
  }

  bool addSkill() {
    String skill = skillController.text.trim();
    if (skill.isNotEmpty && !addedSkills.contains(skill)) {
      setState(() {
        addedSkills.add(skill);
        widget.inputData.setSkills(addedSkills);
        skillController.clear();
      });
      skillFocusNode.requestFocus();
    } else if (addedSkills.contains(skill)) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Same Tag already added')));
      skillFocusNode.requestFocus();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Please write or choose from suggested tags')));
      skillFocusNode.requestFocus();
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {
              // Navigator.pop(context);
              // Navigate back to the previous page
              widget.pageController.previousPage(
                duration: Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            },
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: Colors.black,
            )),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Add Tags to your\nGiG',
                style: TextStyle(
                    fontFamily: 'Raleway',
                    fontSize: 25,
                    color: Colors.black,
                    fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.04,
              ),
              const Text(
                'Use tags to spotlight your skills.\nThese are keyboards clients seek\nin a provider',
                style: TextStyle(
                    fontFamily: 'Raleway',
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.04,
              ),
              const Text('Add Tags :',
                  style: TextStyle(
                      color: Color(0xff656565),
                      fontFamily: 'Raleway',
                      fontSize: 16)),
              SizedBox(height: 8.0),
              TextFormField(
                autofocus: false,
                controller: skillController,
                decoration: InputDecoration(
                  hintText: 'Add your skills',
                  // hintStyle: TextStyle(),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.add),
                    onPressed: addSkill,
                    color: Colors.blue,
                  ),
                ),
                onFieldSubmitted: (value) {
                  addSkill();

                  // FocusScope.of(context).unfocus();
                  // return;
                },
                onChanged: (value) {
                  setState(() {});
                },
              ),
              SizedBox(height: 16.0),
              const Text('Added Skills :',
                  style: TextStyle(
                      color: Color(0xff656565),
                      fontFamily: 'Raleway',
                      fontSize: 16)),
              SizedBox(height: 8.0),
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 6.0,
                runSpacing: 5.0,
                children: widget.inputData.skills?.map((skill) {
                      return Chip(
                        shadowColor: Colors.lightBlue,
                        // labelPadding: EdgeInsets.symmetric(horizontal: 10),
                        deleteIconColor: Colors.blue,
                        label: Text(
                          skill,
                          style: TextStyle(color: Colors.blue),
                        ),
                        backgroundColor: Colors.blue[50],
                        deleteIcon: Icon(Icons.close),
                        onDeleted: () {
                          setState(() {
                            addedSkills.remove(skill);
                            widget.inputData.setSkills(addedSkills);
                          });
                        },
                      );
                    }).toList() ??
                    [],
              ),
              SizedBox(height: 16.0),
              const Text('Suggested Skills :',
                  style: TextStyle(
                      color: Color(0xff656565),
                      fontFamily: 'Raleway',
                      fontSize: 16)),
              SizedBox(height: 8.0),
              Wrap(
                spacing: 6.0,
                runSpacing: 5.0,
                children: suggestedSkills.map((skill) {
                  return ActionChip(
                    avatar: Icon(Icons.add),
                    label: Text(skill),
                    onPressed: () {
                      setState(() {
                        if (!addedSkills.contains(skill)) {
                          addedSkills.add(skill);
                          widget.inputData.setSkills(addedSkills);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('Same Skill already added')));
                        }
                      });
                    },
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).size.height * 0.01,
            right: 20,
            left: 20),
        child: SizedBox(
          height: 40,
          width: double.infinity,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50))),
              onPressed: () {
                widget.pageController.nextPage(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              },
              child: Text('Next')),
        ),
      ),
    );
  }
}
