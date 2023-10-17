import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kappu/components/AppColors.dart';
import 'package:kappu/screens/gig/Gig_tags.dart';

import '../register/widgets/text_field.dart';
import 'Create_first_gig.dart';

class GigTitle extends StatefulWidget {
  final InputData inputData;
  final PageController pageController;
  const GigTitle(
      {Key? key, required this.inputData, required this.pageController})
      : super(key: key);

  @override
  State<GigTitle> createState() => _GigTitleState();
}

class _GigTitleState extends State<GigTitle>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  final TextEditingController _titleController = TextEditingController();

  void _onDataCollected(String data) {
    // widget.inputData.title = data;
    // You can perform other operations with the data if needed
    // ...

    // Move to the next page
    widget.pageController.nextPage(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  void initState() {
    super.initState();
    print('bbbb');
    _titleController.text = widget.inputData.title ?? '';
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

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  bool isValidDesc = true;
  bool isValidTitle = true;
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
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            // Navigator.push(context, route)
            widget.pageController.previousPage(
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
            // Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_new),
          color: Colors.black,
        ),
        elevation: 0,
      ),
      body: Container(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Add a Title for\nYour GiG',
              style: TextStyle(
                  fontFamily: 'Raleway',
                  fontSize: 25,
                  color: Color(0xff374151),
                  fontWeight: FontWeight.w700),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.04,
            ),
            const Text(
              'Give your GiG a catchy name that\nbriefly describes what you offer.\nThis is the first thing clients will\nsee',
              style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Raleway',
                  fontWeight: FontWeight.w500,
                  color: Colors.grey),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            Container(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: const Text(
                'Title :',
                style: TextStyle(
                    fontFamily: 'Raleway',
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Container(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  int endIndex =
                      (_animation.value * hintTexts[currentHintIndex].length)
                          .ceil();
                  return CustomTextFormField(
                    addGigTitle: "yes",
                    controller: _titleController,
                    // hintText: 'Title',
                    hintText:
                        hintTexts[currentHintIndex].substring(0, endIndex),

                    keyboardType: TextInputType.text,
                    // prefixIcon: const ImageIcon(
                    //   AssetImage('assets/icons/price.png'),
                    //   color: AppColors.app_color,
                    // ),
                    isValid: isValidTitle,
                    onChanged: (value) {
                      if (value.isNotEmpty) {
                        isValidTitle = true;
                      } else {
                        isValidTitle = false;
                      }
                      print(value);
                      widget.inputData.setTitle(value);
                      setState(() {});
                    },
                    validator: (value) => value!.isEmpty ? "Enter Title" : null,
                  );
                },
              ),
            ),
            const SizedBox(
              // height: MediaQuery.of(context).size.height * 0.03,
              height: 20,
            ),
            Container(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Row(
                children: [
                  const Text(
                    'Few Examples',
                    style: TextStyle(
                        fontFamily: 'Raleway',
                        fontSize: 20,
                        color: Colors.black),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.04,
                  ),
                  Icon(Icons.arrow_downward_rounded)
                ],
              ),
            ),
            const SizedBox(
              // height: MediaQuery.of(context).size.height * 0.03,
              height: 20,
            ),
            Container(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(10),
                    height: 40,
                    child: const Text(
                      'I will deep clean your kitchen',
                      // textAlign: TextAlign.center,
                      // style: ,
                    ),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 2,
                            offset: Offset(1, 1), // changes the shadow position
                          ),
                        ],
                        border: Border.all(width: 1, color: Colors.white),
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(10),
                    height: 40,
                    child: const Text(
                      'I will install or repair your AC unit',
                      // textAlign: TextAlign.center,
                      // style: ,
                    ),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 2,
                            offset: Offset(1, 1), // changes the shadow position
                          ),
                        ],
                        border: Border.all(width: 1, color: Colors.white),
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(10),
                    height: 40,
                    child: const Text(
                      'I will unclog and fix any drain issue ',
                      // textAlign: TextAlign.center,
                      // style: ,
                    ),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 2,
                            offset: Offset(1, 1), // changes the shadow position
                          ),
                        ],
                        border: Border.all(width: 1, color: Colors.white),
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(10),
                    height: 40,
                    child: const Text(
                      "I will be your electrician for the day",
                      // textAlign: TextAlign.center,
                      // style: ,
                    ),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 2,
                            offset: Offset(1, 1), // changes the shadow position
                          ),
                        ],
                        border: Border.all(width: 1, color: Colors.white),
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ],
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
      ),
    );
  }
}
