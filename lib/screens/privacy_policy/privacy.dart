import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../components/AppColors.dart';

class Privacy extends StatefulWidget {
  const Privacy({Key? key}) : super(key: key);

  @override
  State<Privacy> createState() => _PrivacyState();
}

class _PrivacyState extends State<Privacy> {
  String time = "";
  String textDesc = "";
  bool loading = false;

  @override
  void initState() {
    super.initState();

    // getPrivacyPolicy();
  }
  // double screenHeight = MediaQuery.of(context).size.height;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
     
 appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        title: const Text(
          "Privacy Policy",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        leading:IconButton(onPressed: () => Navigator.of(context).pop(), icon: const Icon(Icons.arrow_back_ios_new,color: AppColors.iconColor,))
      ),
        // appBar: AppBar(
        //   backgroundColor: Colors.white,
        //   elevation: 0,
        //   leading: IconButton(
        //       onPressed: () {
        //         Navigator.pop(context);
        //       },
        //       icon: const Icon(
        //         Icons.arrow_back,
        //         color: Colors.black,
        //       )),
        //   title: const Text(
        //     'Privacy Policy',
        //     style: TextStyle(
        //         fontSize: 22, fontWeight: FontWeight.w600, color: Colors.black),
        //   ),
        // ),
        body: Stack(
          children: [
            Column(
              children: [
                Container(
                  color: Colors.white,
                  width: MediaQuery.of(context).size.width,
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Urban Malta Privacy Policy",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 22,
                              // fontFamily: "Montserrat-Bold"
                              ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Last update: 31st July 2023",
                          style: TextStyle(
                              // color: Colors.black,
                              fontSize: 14,
                              // fontFamily: "Montserrat-regular"
                              ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: 1,
                          color: Colors.grey,
                        ),
                        SizedBox(
                          // height: 559,
                          height: MediaQuery.of(context).size.height * 0.7,
                          child: SingleChildScrollView(
                            child: Container(
                              alignment: Alignment.centerLeft,
                              padding:
                                  EdgeInsets.only(left: 20, right: 20, top: 20),
                              child: Column(
                                children: [
                                  // Container(
                                  //   child: Column(
                                  //     children: [
                                  //       Container(
                                  //         alignment: Alignment.centerLeft,
                                  //         child: const Text(
                                  //           'PRIVACY POLICY FOR URBANMALTA',
                                  //           style: TextStyle(
                                  //               fontSize: 25,
                                  //               fontWeight: FontWeight.w500,
                                  //               color: Colors.black),
                                  //         ),
                                  //       )
                                  //     ],
                                  //   ),
                                  // ),
                                  // const SizedBox(
                                  //   height: 15,
                                  // ),
                                  Container(
                                    child: const Text(
                                      'This privacy policy describes how UrbanMalta collects, protects and uses the personally identifiable information  you may provide on the UrbanMalta website and any of its products or services ',
                                      style: TextStyle(fontSize: 17),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Container(
                                      alignment: Alignment.centerLeft,
                                      child: const Text(
                                        'COLLECTION OF PERSONAL INFORMATION',
                                        style: TextStyle(
                                            fontSize: 19,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                      )),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                    child: const Text(
                                      'We receive and store any information you knowingly provide to us when you create an account, publish content, or fill any online forms on the Website. When required, this information may include your email address, name, phone number, address, or other Personal Information.',
                                      style: TextStyle(fontSize: 17),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    child: const Text(
                                      'USE AND PROCESSING OF COLLECTED INFORMATION',
                                      style: TextStyle(
                                          fontSize: 19,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                    child: const Text(
                                      'Any of the information we collect from you may be used to personalize your experience; improve our Website; improve customer service and respond to queries and emails of our customers; process transactions; send notification emails such as password reminders, updates, etc; run and operate our Website and Services.',
                                      style: TextStyle(fontSize: 17),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    child: const Text(
                                      'PAYMENT AND TRANSACTION POLICY',
                                      style: TextStyle(
                                          fontSize: 19,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                    child: const Text(
                                      'When users book services, the payment is made in advance and the money is shown as "Payment on Hold" until the service is provided and approved by the user. In case of cancellation by the user, the money will be credited to the user\'s UrbanMalta wallet, which can be withdrawn to their bank account. Payments will be transferred to service providers\' wallets only after the completion and approval of the service.',
                                      style: TextStyle(fontSize: 17),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    child: const Text(
                                      'COOKIE POLICY',
                                      style: TextStyle(
                                          fontSize: 19,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                    child: const Text(
                                      'The Website uses "cookies" to help personalize your online experience. You have the ability to accept or decline cookies by modifying your web browser; however, if you choose to decline cookies, you may not be able to fully experience the interactive features of the Website',
                                      style: TextStyle(fontSize: 17),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    child: const Text(
                                      'LINKS TO OTHER WEBSITES',
                                      style: TextStyle(
                                          fontSize: 19,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                    child: const Text(
                                      'Our Website contains links to other websites that are not owned or controlled by us. Please be aware that we are not responsible for the privacy practices of such other websites or third parties.',
                                      style: TextStyle(fontSize: 17),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    child: const Text(
                                      'USER CONDUCT AND PROTECTION',
                                      style: TextStyle(
                                          fontSize: 19,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                    child: const Text(
                                      'UrbanMalta reserves the right to remove any content, suspend, or ban any user that seems to violate our policies or engage in unlawful activity. We aim to maintain a safe and secure environment for all our users.',
                                      style: TextStyle(fontSize: 17),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    child: const Text(
                                      'CHANGES TO THIS PRIVACY POLICY',
                                      style: TextStyle(
                                          fontSize: 19,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                    child: const Text(
                                      'UrbanMalta reserves the right to modify this Policy relating to the Website or Services at any time, effective upon posting of an updated version of this Policy on the Website.',
                                      style: TextStyle(fontSize: 17),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    child: const Text(
                                      'CONTACTING US',
                                      style: TextStyle(
                                          fontSize: 19,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  // Container(
                                  //   child: const Text(
                                  //     'If you have any questions about this Policy, please contact us at info@urbanmalta.com.',
                                  //     style: TextStyle(fontSize: 17),
                                  //   ),
                                  // ),
                                  Container(
                                    child: RichText(
                                      text: TextSpan(
                                        text:
                                            'If you have any questions about this Policy, please contact us at ',
                                        style: TextStyle(
                                            fontSize: 17, color: Colors.black),
                                        children: <TextSpan>[
                                          // TextSpan(
                                          //   text: 'info@urbanmalta.com',
                                          //   style: TextStyle(fontSize: 17, color: Colors.blue),
                                          //   // You can add an onTap function to handle the email link click.
                                          //   // For example, launch an email app when the link is tapped.
                                          //   recognizer: new TapGestureRecognizer()
                                          //     ..onTap = () {
                                          //       launch('mailto:info@urbanmalta.com');
                                          //     },
                                          // ),
                                          const TextSpan(
                                            text: '.',
                                            style: TextStyle(
                                                fontSize: 17,
                                                color: Colors.black),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    child: const Text(
                                      'DISCLAIMER',
                                      style: TextStyle(
                                          fontSize: 19,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Container(
                                    child: const Text(
                                      'UrbanMalta is a marketplace that connects local service providers with customers. We are not directly involved in the actual transactions between service providers and customers. As such, we have no control over the quality, safety, morality or legality of any aspect of the services provided, the truth or accuracy of the listings, the ability of service providers to provide services or the ability of customers to pay for services. We are not responsible for the actions, content, information, or data of third parties, and you release us, our directors, officers, employees, and agents from any claims and damages, known and unknown, arising out of or in any way connected with any claim you have against any such third parties.',
                                      style: TextStyle(fontSize: 17),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                   
                      ],
                    ),
                  ),
                ),
              ],
            ),
            // if (loading) CustomProgressBar(),
          ],
        ));
  }
}
