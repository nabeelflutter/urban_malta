import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kappu/components/AppColors.dart';
import 'package:kappu/constants/storage_manager.dart';
import 'package:provider/provider.dart';

import '../../models/serializable_model/allchats.dart';
import '../../net/http_client.dart';
import '../../provider/provider_provider.dart';
import '../chats/widgets/conversation_list.dart';

class AllChatsScreenProvider extends StatefulWidget {
  const AllChatsScreenProvider({Key? key}) : super(key: key);

  @override
  State<AllChatsScreenProvider> createState() => _AllChatsScreenProviderState();
}

class _AllChatsScreenProviderState extends State<AllChatsScreenProvider> {
  TextEditingController searchController = TextEditingController();
  late int cardViewed;
  bool alreadyowned = false;
  int otherpersonid = 0;
  String otherpersoname = '';

  List<AllChats> chatList = [
    AllChats(
        useroneid: 1,
        threadid: 1,
        message: 'message',
        useronename: 'a',
        usertwoid: 1,
        usertwoname: 'usertwoname'),
    AllChats(
        useroneid: 1,
        threadid: 1,
        message: 'message',
        useronename: 'v',
        usertwoid: 1,
        usertwoname: 'usertwoname'),
    AllChats(
        useroneid: 1,
        threadid: 1,
        message: 'message',
        useronename: 'useronename',
        usertwoid: 1,
        usertwoname: 'usertwoname'),
    AllChats(
        useroneid: 1,
        threadid: 1,
        message: 'message',
        useronename: 'useronename',
        usertwoid: 1,
        usertwoname: 'usertwoname'),
    AllChats(
        useroneid: 1,
        threadid: 1,
        message: 'message',
        useronename: 'useronename',
        usertwoid: 1,
        usertwoname: 'usertwoname'),
    AllChats(
        useroneid: 1,
        threadid: 1,
        message: 'message',
        useronename: 'useronename',
        usertwoid: 1,
        usertwoname: 'usertwoname'),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            "Chats",
            style: TextStyle(
                fontSize: 20.sp,
                color: Colors.black,
                fontWeight: FontWeight.bold),
          )),
      body: SingleChildScrollView(
        child: Column(children: [
          SizedBox(height: ScreenUtil().setHeight(17)),
          Padding(
            padding: EdgeInsets.only(left: 10.w, right: 10.w),
            child: Container(
              padding: const EdgeInsets.only(left: 10, bottom: 10, top: 10),
              height: 45.h,
              width: double.infinity,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(30)),
              child: Row(
                children: <Widget>[
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                          hintText: "Search",
                          hintStyle:
                              TextStyle(color: Colors.black54, fontSize: 14.sp),
                          border: InputBorder.none),
                      controller: searchController,
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  GestureDetector(
                    onTap: () {
                      // messeges.add(Chat(
                      //     senderid: loggedinuser.user.id,
                      //     message: messegecontroller.text));
                      // setmessegesstate((() => {}));
                      // Map<String, dynamic> body = {
                      //   "user": loggedinuser.user.id,
                      //   "thread": threadid,
                      //   "receiver": otheruserid,
                      //   "message": messegecontroller.text
                      // };
                      // var jsonString = json.encode(body);
                      // mychannel.sink.add(jsonString);
                      // messegecontroller.clear();
                    },
                    child: CircleAvatar(
                      radius: 25.h,
                      child: const Icon(
                        Icons.search,
                        color: Colors.white,
                        size: 18,
                      ),
                      backgroundColor: AppColors.app_color,
                    ),
                  ),
                ],
              ),
            ),
          ),
          ListView.builder(
            itemCount: chatList.length,
            shrinkWrap: true,
            padding: const EdgeInsets.only(top: 16),
            physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              if (StorageManager().userId == chatList[index].useroneid) {
                otherpersonid = chatList[index].usertwoid;
                otherpersoname = chatList[index].usertwoname;
              } else {
                otherpersonid = chatList[index].useroneid;
                otherpersoname = chatList[index].useronename;
              }
              return Column(
                children: [
                  ConversationList(
                    threadid: chatList[index].threadid,
                    userid: otherpersonid,
                    name: otherpersoname,
                    messageText: chatList[index].message,
                    imageUrl:
                        'https://urbanmalta.com/public/frontend/images/johnwing-app.png',
                    time: '12:21 pm',
                  ),
                  5.verticalSpace,
                  const Divider(thickness: 0.7)
                ],
              );
            },
          ),
        ]),
      ),
    );
  }
}
