import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:kappu/constants/constants.dart';
import 'package:kappu/constants/storage_manager.dart';
import 'package:kappu/screens/account/slidingopen.dart';
import 'package:http/http.dart' as http;

import '../../components/AppColors.dart';

class ReviewTransfer extends StatefulWidget {
  final String price;
  final List<Map<String, dynamic>> dataList;
  const ReviewTransfer({required this.price, required this.dataList, Key? key})
      : super(key: key);

  @override
  State<ReviewTransfer> createState() => _ReviewTransferState();
}

class _ReviewTransferState extends State<ReviewTransfer> {
  bool isSubmitted = false;
  sendMoney(String firstName, String lastName, String iban, String userId,
      String amount, String bankId, context) async {
    isSubmitted = true;
    setState(() {});
    final String token = StorageManager().accessToken;
    Map<String, String> headers = {
      "Authorization": "Bearer $token",
      "Content-Type": "application/json",
    };

    final url = Uri.parse('${Constants.BASE_URL}/api/wallet/withdrawal');
    final body = {'user_id': userId, 'amount': amount, 'bank_id': bankId};
    try {
      final response =
          await http.post(url, headers: headers, body: json.encode(body));
      print(response);
      Map<String, dynamic> responseData = json.decode(response.body);

      // Access the 'success' property from the parsed data and convert it to a boolean
      print(responseData);
      bool success = responseData['status'] ?? false;
      // var success = response.body./success;
      print(success);
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return SlidingUpPaging(
            firstName: firstName,
            lastName: lastName,
            iban: iban,
            amount: amount,
            success: success);
      })).then((value) {
        isSubmitted = false;
      }).then((value) {
        isSubmitted = false;
        setState(() {});
      });

      return [];
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        title: const Text(
          "Review Transfer",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        leading: IconButton(onPressed: () => Navigator.of(context).pop(), icon: const Icon(Icons.arrow_back_ios_new,color: AppColors.iconColor,))
      ),
      // appBar: AppBar(
      //   elevation: 0,
      //   backgroundColor: Colors.white,
      //   automaticallyImplyLeading: false,
      //   leading: Container(
      //     padding: const EdgeInsets.only(top: 20),
      //     child: IconButton(
      //       onPressed: () {
      //         Navigator.pop(context);
      //       },
      //       icon: const Icon(
      //         Icons.arrow_back_ios,
      //         // size: 24,
      //         color: Color(0xff161D35),
      //       ),
      //     ),
      //   ),
      //   title: Container(
      //     padding: EdgeInsets.only(top: 20),
      //     child: const Text(
      //       "Review Transfer",
      //       style: TextStyle(
      //         fontSize: 26,
      //         fontWeight: FontWeight.w700,
      //         color: Color(0xff161D35),
      //       ),
      //     ),
      //   ),
      // ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 10),
            SizedBox(
              height: 200,
              width: double.infinity,
              child: Container(
                padding: const EdgeInsets.only(
                  right: 20,
                  left: 20,
                ),
                decoration: BoxDecoration(
                    color: Color(0xffF1F7FF),
                    borderRadius: BorderRadius.circular(15)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        'To',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Color(0xff7B7D83)),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        'IBAN',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Color(0xff7B7D83)),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        widget.dataList[0]['iban'] ?? 'XXXXXXXXXXXXXX',
                        style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Color(0xff7B7D83)),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        'BIC / SWIFT',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Color(0xff7B7D83)),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        widget.dataList[0]['bic_swift'] ?? 'XXXXXXXX',
                        style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Color(0xff7B7D83)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            SizedBox(
              height: 90,
              width: double.infinity,
              child: Container(
                padding: const EdgeInsets.only(left: 20, right: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Color(0xffF1F7FF),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        'Reference',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Color(0xff7B7D83)),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        'Sent from UrbanMalta',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Color(0xff161D35)),
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              height: 110,
              child: Container(
                padding: const EdgeInsets.only(left: 20, right: 20),
                decoration: BoxDecoration(
                    color: Color(0xffF1F7FF),
                    borderRadius: BorderRadius.circular(15)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Recipient Gets',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Color(0xff7B7D83)),
                        ),
                        Text(
                          '€${widget.price}',
                          style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Color(0xff161D35)),
                        )
                      ],
                    ),
                     Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Fees ',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Color(0xff7B7D83)),
                        ),
                        Text(
                          '2%',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Color(0xff7B7D83)),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Your Total',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Color(0xff7B7D83)),
                        ),
                        Text(
                          '€${widget.price}',
                          style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Color(0xff161D35)),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            Expanded(child: Container()),
            Container(
              height: 55,
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  disabledBackgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: isSubmitted == false
                    ? () {
                        sendMoney(
                            widget.dataList[0]['first_name'].toString(),
                            widget.dataList[0]['last_name'].toString(),
                            widget.dataList[0]['iban'].toString(),
                            widget.dataList[0]['user_id'].toString(),
                            widget.price,
                            widget.dataList[0]['id'].toString(),
                            context);
                      }
                    : null,
                child: const Text(
                  'Send',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Color(0xffffffff),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
