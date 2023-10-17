import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:kappu/components/AppColors.dart';
import 'package:kappu/models/serializable_model/CategoryResponse.dart';
import 'package:kappu/models/serializable_model/GigListResponse.dart';

import '../../net/base_dio.dart';
import '../../net/http_client.dart';
import '../gig/Create_first_gig.dart';
import '../gig/choose_category.dart';

class RegisterMore extends StatefulWidget {
  final Map<String, dynamic> bodyprovider;
  final InputData inputData;
  bool? isFromAddGig = false;
  bool? isFromEditGig = false;
  GigListResponse? myGig;
  final PageController pageController;

  //  final PageController pageController;
  // final InputData inputData;

  RegisterMore(
      {Key? key,
      required this.bodyprovider,
      this.isFromAddGig,
      this.isFromEditGig,
      this.myGig,
      required this.inputData,
      required this.pageController})
      : super(key: key);

  @override
  _RegisterMoreState createState() => _RegisterMoreState();
}

class _RegisterMoreState extends State<RegisterMore>
    with SingleTickerProviderStateMixin {
  FocusNode skillFocusNode = FocusNode();

  TextEditingController _descriptionController = TextEditingController();
  String _generatedDescription = '';
  String apiUri = 'https://api.openai.com/v1/models/text-davinci-003';
  String apiUrl = 'https://api.openai.com/v1/completions';
  String apiKey = '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';

  // String apiKey = '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';
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

  Future<String> generateDescription(
    String skills,
  ) async {
    Map<String, dynamic> body = {
      "model": "text-davinci-003",
      "prompt":
          "suggest professional description depending upon my knowledge and skills, ${skills}",
      "max_tokens": 40,
      "temperature": 0
    };
    var response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey',
      },
      body: jsonEncode(body),
    );

    print('Printing response: ${response.body}');

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      String generatedText = data['choices'][0]['text'];
      return generatedText.substring(2);
    } else {
      return 'Failed to generate description.';
    }
  }

  TextEditingController skillController = TextEditingController();
  final _formState = GlobalKey<FormState>();
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _rateController = TextEditingController();
  final TextEditingController _extraRateController = TextEditingController();

  late AnimationController _controller;
  late Animation<double> _animation;
  bool isValidDesc = true;
  bool isValidTitle = true;

  bool isValidRate = true;
  bool isValidExtraRate = true;
  bool isLoading = false;

  List<Category> catagories = [
    Category(
        id: -1,
        name: "Select a Service",
        createdAt: "",
        image: "",
        description: "")
  ];

  Category selectedcatagory = Category(
      id: -1,
      name: "Select a Service",
      createdAt: "",
      image: "",
      description: "");

  @override
  void initState() {
    super.initState();
    print('bbbb');
    getcatagory();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 5),
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    _controller.repeat(reverse: true);

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          currentHintIndex = (currentHintIndex + 1) % hintTexts.length;
        });
        _controller.reset();
        _controller.forward();
      }
    });

    _controller.forward();
  }

  // @override
  // void dispose() {
  //   _controller.dispose(); // Stop the animation controller
  //   super.dispose();
  // }

  bool addSkill() {
    String skill = skillController.text.trim();
    if (skill.isNotEmpty && !addedSkills.contains(skill)) {
      setState(() {
        addedSkills.add(skill);
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

  getcatagory() async {
    setState(() {
      this.loading = true;
    });
    await HttpClient()
        .getCatagory()
        .then((value) => {
              setState(() {
                this.loading = false;
              }),
              // print(value),
              if (value.status)
                {
                  print(widget.inputData.categoryId),
                  if (widget.isFromEditGig ??
                      false || widget.inputData.categoryId != null)
                    {
                      for (var value1 in value.data)
                        {
                          // print(value1.id),
                          // print(widget.inputData.categoryId),
                          if (widget.inputData.categoryId ==
                              value1.id.toString())
                            {
                              setState(() {
                                this.catagories = value.data;
                                this.selectedcatagory = value1;
                              })
                            }
                        }
                    }
                  else
                    {
                      setState(() {
                        this.catagories = value.data;
                        // this.selectedcatagory = value.data[0];
                      })
                    }
                }
            })
        .catchError((e) {
      setState(() {
        this.loading = true;
      });
      BaseDio.getDioError(e);
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _descriptionController.dispose();
    _controller.dispose();
    super.dispose();
  }

  bool isFinished = false;

  bool AlltextFiled() {
    return _descController.text.isEmpty ||
        _titleController.text.isEmpty ||
        _rateController.text.isEmpty;
  }

  void openCategorySelectionScreen() async {
    final selectedCategory = await Navigator.push<Category>(
      context,
      MaterialPageRoute(
        builder: (context) => CategorySelectionScreen(categories: catagories),
      ),
    );
    print(selectedCategory);
    if (selectedCategory != null) {
      print(selectedCategory.name);
      setState(() {
        widget.inputData.setCategory(selectedCategory.id.toString());
        selectedcatagory = selectedCategory;
      });
    }
  }

  //   late AnimationController _controller;
  // late Animation<double> _animation;
  List<String> hintTexts = [
    'I will clean your home',
    'I will install your air conditioner',
    'I will repair your plumbing',
    'I will deep clean every room',
    'I will tackle all your furniture fixes promptly',
  ];
  int currentHintIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                if (Navigator.canPop(context)) {
                  Navigator.pop(context);
                }
              },
              icon: Icon(
                Icons.arrow_back_ios_new,
                color: Colors.black,
              )),
          shadowColor: Colors.white,
          elevation: 0,
        ),
        body: SafeArea(
            child: Container(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Create your\nfirst GiG',
                style: TextStyle(
                    fontFamily: 'Raleway',
                    fontSize: 25,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.08,
              ),
              const Text(
                'Select a Service\nfor Your First\nGig',
                style: TextStyle(
                    fontFamily: 'Raleway',
                    fontSize: 25,
                    color: Color(0xff374151),
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.04,
              ),
              const Text(
                'pick the service you excel in, and\nstart creating your first gig to\nshowcase your expertise to\npotential clients',
                style: TextStyle(
                    fontFamily: 'Raleway',
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.06,
              ),
              Material(
                borderRadius:
                    BorderRadius.circular(ScreenUtil().screenHeight * 0.03),
                elevation: 3,
                shadowColor: Colors.black.withOpacity(0.14),
                child: InkWell(
                  onTap: () {
                    openCategorySelectionScreen();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: ScreenUtil().setHeight(40),
                          child: Row(
                            children: [
                              const Padding(
                                padding: EdgeInsetsDirectional.only(
                                  start: 15,
                                  end: 10,
                                ),
                                child: ImageIcon(
                                  AssetImage('assets/icons/service.png'),
                                  color: AppColors.app_color,
                                ),
                              ),
                              Flexible(
                                child: Text(
                                  selectedcatagory.name ?? 'Select a Category',
                                  style: TextStyle(
                                    color: Colors.black,
                                    // fontFamily: "Montserrat-Medium",
                                    fontSize: ScreenUtil().setSp(15),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          // Navigator.push(context, MaterialPageRoute(builder: (context){
                          //   return GigTitle();
                          // }));
                        },
                        child: Container(
                            padding: EdgeInsets.only(right: 15),
                            child: const Icon(
                              Icons.arrow_forward,
                              size: 25,
                            )),
                      )
                    ],
                  ),
                ),
              ),
              Spacer(),
              SizedBox(
                height: 40,
                width: double.infinity,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50))),
                    onPressed: () {
                      //   Navigator.push(context,
                      //       MaterialPageRoute(builder: (context) {
                      //     return GigTags(pageController: pageController,);
                      //   }));
                      // Navigator.push(context, route)
                      widget.pageController.nextPage(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },
                    child: Text('Next')),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
                // height: 15,
              ),
            ],
          ),
        ))

        //     SingleChildScrollView(
        //   child: Container(
        //     child: Stack(
        //       children: [
        //         Column(
        //           crossAxisAlignment: CrossAxisAlignment.start,
        //           children: [
        //             Padding(
        //               padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 0),
        //               child: Form(
        //                 key: _formState,
        //                 child: Column(
        //                   crossAxisAlignment: CrossAxisAlignment.start,
        //                   children: [
        //                     Material(
        //                       borderRadius: BorderRadius.circular(
        //                           ScreenUtil().screenHeight * 0.03),
        //                       elevation: 3,
        //                       shadowColor: Colors.black.withOpacity(0.14),
        //                       child: InkWell(
        //                         onTap: () {
        //                           if (!(widget.isFromEditGig ?? false)) {
        //                             openCategorySelectionScreen();
        //                           }
        //                         },
        //                         child: Row(
        //                           mainAxisAlignment:
        //                               MainAxisAlignment.spaceBetween,
        //                           children: [
        //                             Expanded(
        //                               child: SizedBox(
        //                                 height: ScreenUtil().setHeight(40),
        //                                 child: Row(
        //                                   children: [
        //                                     Padding(
        //                                       padding: EdgeInsetsDirectional.only(
        //                                         start: 15,
        //                                         end: 10,
        //                                       ),
        //                                       child: ImageIcon(
        //                                         AssetImage(
        //                                             'assets/icons/service.png'),
        //                                         color: AppColors.app_color,
        //                                       ),
        //                                     ),
        //                                     Flexible(
        //                                       child: Text(
        //                                         selectedcatagory.name ??
        //                                             'Select a Category',
        //                                         style: TextStyle(
        //                                           color: Colors.black,
        //                                           fontFamily: "Montserrat-Medium",
        //                                           fontSize:
        //                                               ScreenUtil().setSp(15),
        //                                         ),
        //                                       ),
        //                                     ),
        //                                   ],
        //                                 ),
        //                               ),
        //                             ),
        //                           ],
        //                         ),
        //                       ),
        //                     ),

        //                     // Material(
        //                     //   borderRadius: BorderRadius.circular(
        //                     //       ScreenUtil().screenHeight * 0.03),
        //                     //   elevation: 3,
        //                     //   shadowColor: Colors.black.withOpacity(0.14),
        //                     //   child: Row(
        //                     //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                     //     children: [
        //                     //       Expanded(
        //                     //         child: SizedBox(
        //                     //           height: ScreenUtil().setHeight(40),
        //                     //           child:

        //                     //           //  DropdownButtonFormField<Category>(
        //                     //           //   isExpanded: true,
        //                     //           //   decoration: InputDecoration(
        //                     //           //     border: InputBorder.none,
        //                     //           //     prefixIcon: Padding(
        //                     //           //       padding:
        //                     //           //           const EdgeInsetsDirectional.only(
        //                     //           //               start: 15, end: 10),
        //                     //           //       child: ImageIcon(
        //                     //           //         AssetImage(
        //                     //           //             'assets/icons/service.png'),
        //                     //           //         color: AppColors.app_color,
        //                     //           //       ),
        //                     //           //     ),
        //                     //           //     hintStyle: TextStyle(
        //                     //           //       color: Colors.grey[100],
        //                     //           //       fontFamily: "Montserrat-Medium",
        //                     //           //     ),
        //                     //           //     labelStyle: TextStyle(
        //                     //           //       color: AppColors.text_desc,
        //                     //           //       fontFamily: "Montserrat-Medium",
        //                     //           //     ),
        //                     //           //     hintText: "Choose category",
        //                     //           //     fillColor: Colors.red[100],
        //                     //           //   ),
        //                     //           //   style: TextStyle(
        //                     //           //     color: Colors.grey.shade600,
        //                     //           //     fontWeight: FontWeight.w500,
        //                     //           //     fontSize: ScreenUtil().setSp(15),
        //                     //           //   ),
        //                     //           //   value: widget.isFromEditGig ?? false
        //                     //           //       ? selectedcatagory
        //                     //           //       : catagories.first,
        //                     //           //   onChanged: widget.isFromEditGig ?? false
        //                     //           //       ? null
        //                     //           //       : (value) {
        //                     //           //           setState(() {
        //                     //           //             selectedcatagory = value!;
        //                     //           //           });
        //                     //           //         },
        //                     //           //   selectedItemBuilder:
        //                     //           //       (BuildContext context) {
        //                     //           //     return catagories.map((Category value) {
        //                     //           //       return Align(
        //                     //           //         alignment: Alignment.centerLeft,
        //                     //           //         child: Text(
        //                     //           //           value.name,
        //                     //           //           style: const TextStyle(
        //                     //           //             color: Colors.black,
        //                     //           //             fontFamily: "Montserrat-Medium",
        //                     //           //           ),
        //                     //           //         ),
        //                     //           //       );
        //                     //           //     }).toList();
        //                     //           //   },
        //                     //           //   items: catagories
        //                     //           //       .map(
        //                     //           //         (value) =>
        //                     //           //             DropdownMenuItem<Category>(
        //                     //           //           value: value,
        //                     //           //           child: Text(value.name),
        //                     //           //         ),
        //                     //           //       )
        //                     //           //       .toList(),
        //                     //           // ),
        //                     //         ),
        //                     //       ),
        //                     //     ],
        //                     //   ),
        //                     // ),

        //                     10.verticalSpace,
        //                     Padding(
        //                       padding: EdgeInsets.all(8.0),
        //                       child:
        //                           Text('Title:', style: TextStyle(fontSize: 16)),
        //                     ),
        //                     AnimatedBuilder(
        //                       animation: _animation,
        //                       builder: (context, child) {
        //                         int endIndex = (_animation.value *
        //                                 hintTexts[currentHintIndex].length)
        //                             .ceil();
        //                         return CustomTextFormField(
        //                           addGigTitle: "yes",
        //                           controller: _titleController,
        //                           // hintText: 'Title',
        //                           hintText: hintTexts[currentHintIndex]
        //                               .substring(0, endIndex),
        //                           keyboardType: TextInputType.text,
        //                           prefixIcon: const ImageIcon(
        //                             AssetImage('assets/icons/price.png'),
        //                             color: AppColors.app_color,
        //                           ),
        //                           isValid: isValidTitle,
        //                           onChanged: (value) {
        //                             if (value.isNotEmpty) {
        //                               isValidTitle = true;
        //                             } else {
        //                               isValidTitle = false;
        //                             }
        //                             setState(() {});
        //                           },
        //                           validator: (value) =>
        //                               value!.isEmpty ? "Enter Title" : null,
        //                         );
        //                       },
        //                     ),

        //                     // CustomTextFormField(
        //                     //   controller: _titleController,
        //                     //   hintText: 'Title',
        //                     //   keyboardType: TextInputType.text,
        //                     //   prefixIcon: ImageIcon(
        //                     //     AssetImage('assets/icons/price.png'),
        //                     //     color: AppColors.app_color,
        //                     //   ),
        //                     //   isValid: isValidTitle,
        //                     //   onChanged: (value) {
        //                     //     if (value.isNotEmpty) {
        //                     //       isValidTitle = true;
        //                     //     } else {
        //                     //       isValidTitle = false;
        //                     //     }
        //                     //     setState(() {});
        //                     //   },
        //                     //   validator: (value) =>
        //                     //       value!.isEmpty ? "Enter Title" : null,
        //                     // ),

        //                     10.verticalSpace,

        //                     Padding(
        //                       padding: EdgeInsets.all(16.0),
        //                       child: Column(
        //                         crossAxisAlignment: CrossAxisAlignment.start,
        //                         children: [
        //                           Text('Add Tags:',
        //                               style: TextStyle(fontSize: 16)),
        //                           SizedBox(height: 8.0),
        //                           TextFormField(
        //                             autofocus: false,
        //                             focusNode: skillFocusNode,
        //                             controller: skillController,
        //                             decoration: InputDecoration(
        //                               hintText: 'Add your skills',
        //                               border: OutlineInputBorder(
        //                                 borderRadius: BorderRadius.circular(10.0),
        //                               ),
        //                               suffixIcon: IconButton(
        //                                 icon: Icon(Icons.add),
        //                                 onPressed: addSkill,
        //                                 color: Colors.blue,
        //                               ),
        //                             ),
        //                             onFieldSubmitted: (value) {
        //                               addSkill();

        //                               // FocusScope.of(context).unfocus();
        //                               // return;
        //                             },
        //                             onChanged: (value) {
        //                               setState(() {});
        //                             },
        //                           ),
        //                           SizedBox(height: 16.0),
        //                           Text('Added Skills:',
        //                               style: TextStyle(fontSize: 16)),
        //                           SizedBox(height: 8.0),
        //                           Wrap(
        //                             alignment: WrapAlignment.center,
        //                             spacing: 8.0,
        //                             runSpacing: 8.0,
        //                             children: addedSkills.map((skill) {
        //                               return Chip(
        //                                 shadowColor: Colors.lightBlue,
        //                                 labelPadding:
        //                                     EdgeInsets.symmetric(horizontal: 10),
        //                                 deleteIconColor: Colors.blue,
        //                                 label: Text(
        //                                   skill,
        //                                   style: TextStyle(color: Colors.blue),
        //                                 ),
        //                                 backgroundColor: Colors.blue[50],
        //                                 deleteIcon: Icon(Icons.close),
        //                                 onDeleted: () {
        //                                   setState(() {
        //                                     addedSkills.remove(skill);
        //                                   });
        //                                 },
        //                               );
        //                             }).toList(),
        //                           ),
        //                           SizedBox(height: 16.0),
        //                           Text('Suggested Skills:',
        //                               style: TextStyle(fontSize: 16)),
        //                           SizedBox(height: 8.0),
        //                           Wrap(
        //                             spacing: 8.0,
        //                             runSpacing: 8.0,
        //                             children: suggestedSkills.map((skill) {
        //                               return ActionChip(
        //                                 avatar: Icon(Icons.add),
        //                                 label: Text(skill),
        //                                 onPressed: () {
        //                                   setState(() {
        //                                     if (!addedSkills.contains(skill)) {
        //                                       addedSkills.add(skill);
        //                                     } else {
        //                                       ScaffoldMessenger.of(context)
        //                                           .showSnackBar(SnackBar(
        //                                               content: Text(
        //                                                   'Same Skill already added')));
        //                                     }
        //                                   });
        //                                 },
        //                               );
        //                             }).toList(),
        //                           ),
        //                         ],
        //                       ),
        //                     ),

        //                     10.verticalSpace,

        //                     CustomTextFormField(
        //                       controller: _descController,
        //                       hintText:
        //                           "Highlight what you offer, why you're the best choice, and how you differentiate. Make it appealing to grab customer's attention!",
        //                       // 'Description | Cover letter – why should user hire you?',
        //                       suffixIcon: IconButton(
        //                         icon: isLoading
        //                             ? SizedBox(
        //                                 height: 20,
        //                                 width: 20,
        //                                 child: CircularProgressIndicator(),
        //                               )
        //                             : Icon(Icons.replay_circle_filled),
        //                         onPressed: () async {
        //                           String skills =
        //                               'i am ${selectedcatagory} and my job title is ${_titleController.text} and my skills are the following : ${addedSkills.toString()}';
        //                           setState(() {
        //                             isLoading = true;
        //                           });
        //                           String description =
        //                               await generateDescription(skills);

        //                           setState(() {
        //                             isLoading = false;
        //                             _generatedDescription = description;
        //                             _descController.text = _generatedDescription;
        //                           });
        //                         },
        //                         color: Colors.blue,
        //                       ),
        //                       keyboardType: TextInputType.text,
        //                       maxlines: 5,
        //                       isValid: isValidDesc,
        //                       onChanged: (value) {
        //                         if (value.isNotEmpty) {
        //                           isValidDesc = true;
        //                         } else {
        //                           isValidDesc = false;
        //                         }

        //                         setState(() {});
        //                       },
        //                       validator: (value) => value!.isEmpty
        //                           ? "Enter Your Description"
        //                           : null,
        //                     ),
        //                     10.verticalSpace,
        //                     Center(
        //                         child: ElevatedButton(
        //                             onPressed: () async {
        //                               String skills =
        //                                   'i am ${selectedcatagory} and my job title is ${_titleController.text} and my skills are the following : ${addedSkills.toString()}';
        //                               setState(() {
        //                                 isLoading = true;
        //                               });
        //                               String description =
        //                                   await generateDescription(skills);

        //                               if (description.contains('Failed')) {
        //                                 ScaffoldMessenger.of(context)
        //                                     .showSnackBar(SnackBar(
        //                                         content: Text(
        //                                             'Sorry, auto-description is unavailable. Please write your description manually. Thank you')));
        //                                 setState(() {
        //                                   isLoading = false;
        //                                 });
        //                               } else {
        //                                 setState(() {
        //                                   isLoading = false;
        //                                   _generatedDescription = description;
        //                                   _descController.text =
        //                                       _generatedDescription;
        //                                 });
        //                               }
        //                             },
        //                             child: isLoading
        //                                 ? SizedBox(
        //                                     height: 20,
        //                                     width: 20,
        //                                     child: CircularProgressIndicator(
        //                                       color: Colors.white,
        //                                     ),
        //                                   )
        //                                 : Text('Auto Generate'))),

        //                     10.verticalSpace,

        //                     CustomTextFormField(
        //                       controller: _rateController,
        //                       hintText: '\€ per hour',
        //                       keyboardType: TextInputType.number,
        //                       prefixIcon: ImageIcon(
        //                         AssetImage('assets/icons/price.png'),
        //                         color: AppColors.app_color,
        //                       ),
        //                       isValid: isValidRate,
        //                       onChanged: (value) {
        //                         if (value.isNotEmpty) {
        //                           isValidRate = true;
        //                         } else {
        //                           isValidRate = false;
        //                         }
        //                         setState(() {});
        //                       },
        //                       validator: (value) => value!.isEmpty
        //                           ? "Enter \€ per hour"
        //                           : value!.length > 2
        //                               ? "Enter valid \€ per hour"
        //                               : null,
        //                     ),
        //                     Visibility(
        //                       visible: false,
        //                       child: CustomTextFormField(
        //                         controller: _extraRateController,
        //                         hintText: 'Extra \€ for urgent need',
        //                         keyboardType: TextInputType.number,
        //                         prefixIcon: ImageIcon(
        //                           AssetImage('assets/icons/price.png'),
        //                           color: AppColors.app_color,
        //                         ),
        //                         isValid: isValidExtraRate,
        //                         onChanged: (value) {
        //                           if (value.isNotEmpty) {
        //                             isValidExtraRate = true;
        //                           } else {
        //                             isValidExtraRate = false;
        //                           }

        //                           setState(() {});
        //                         },
        //                         validator: (value) => value!.isEmpty
        //                             ? "Enter extra \€"
        //                             : value!.length > 2
        //                                 ? "Enter valid extra \€"
        //                                 : null,
        //                       ),
        //                     ),

        //                     SizedBox(height: ScreenUtil().setHeight(10)),

        //                     Center(
        //                       child: SwipeableButtonView(
        //                           // isActive: !AlltextFiled(),
        //                           onFinish: () {
        //                             onregisterpressedprovider();
        //                           },
        //                           isFinished: isFinished,
        //                           onWaitingProcess: () {
        //                             //  _controller.dispose();
        //                             onregisterpressedprovider();
        //                           },
        //                           activeColor: AppColors.app_color,
        //                           buttonWidget: Container(
        //                             child: const Icon(
        //                               Icons.arrow_forward_ios_outlined,
        //                               color: Colors.grey,
        //                             ),
        //                           ),
        //                           buttonText: "Continue"),
        //                     ),
        //                     10.verticalSpace,
        //                   ],
        //                 ),
        //               ),
        //             )
        //           ],
        //         ),
        //         if (loading) CustomProgressBar()
        //       ],
        //     ),
        //   ),
        // ),

        );
  }

  void _resetIsFinished() {
    setState(() {
      isFinished = false;
    });
  }

//   onregisterpressedprovider() async {
//     print('anc');
//     // if (_titleController.text.isEmpty ||
//     //     _descController.text.isEmpty ||
//     //     _rateController.text.isEmpty) {
//     //   return;
//     // }

//     print("aa");

//     Map<String, dynamic> bodyprovider1 =
//         (widget.isFromAddGig ?? false || (widget.isFromEditGig ?? false))
//             ? {
//                 'category': selectedcatagory.id,
//                 "description": _descController.text,
//                 "Perhour": _rateController.text,
//                 "Extra_for_urgent_need": 'not provided',
//                 "service_title": _titleController.text
//               }
//             : {
//                 'first_name': widget.bodyprovider['first_name'],
//                 'last_name': widget.bodyprovider['last_name'],
//                 'username': widget.bodyprovider['username'],
//                 'email': widget.bodyprovider['email'],
//                 'category': selectedcatagory.id,
//                 'phone_number': widget.bodyprovider['phone_number'] ?? '',
//                 'password': widget.bodyprovider['password'],
//                 'is_provider': true,
//                 "Age": widget.bodyprovider['Age'],
//                 "nationality": widget.bodyprovider['nationality'] ?? '',
//                 "language": widget.bodyprovider['language'] ?? '',
//                 "service_title": _titleController.text,
//                 'login_src': widget.bodyprovider['login_src'],
//                 'social_login_id': widget.bodyprovider['social_login_id'] ?? '',
//                 "description": _descController.text,
//                 "Perhour": _rateController.text,
//                 'fcm_token': StorageManager().fcmToken,
//                 'os': Platform.isAndroid ? 'android' : 'ios',
//                 "Extra_for_urgent_need":
//                     '${_extraRateController.text} 0.00' ?? ''
//               };

//     print('bb');
//     if (widget.isFromEditGig ?? false) {
//       _resetIsFinished();
//       final result = await Navigator.push(
//           context,
//           MaterialPageRoute(
//               builder: (context) => AddGig(
//                   bodyprovider: bodyprovider1,
//                   isFromEditGig: widget.isFromEditGig,
//                   myGig: widget.myGig ?? null))).then((_) {
//         _resetIsFinished();
//       });
//       if (result == "1" && (widget.isFromEditGig ?? false)) {
//         Navigator.pop(context, "1");
//       }
//     } else {
//       _resetIsFinished();
//       final result = await Navigator.push(
//           context,
//           MaterialPageRoute(
//               builder: (context) => AddGig(
//                   bodyprovider: bodyprovider1,
//                   isFromAddGig: widget.isFromAddGig))).then((_) {
//         _resetIsFinished();
//       });
//       if (result == "1" && (widget.isFromAddGig ?? false)) {
//         Navigator.pop(context, "1");
//       }
//     }
//   }
}
