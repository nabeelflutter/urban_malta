import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kappu/components/AppColors.dart';
import 'package:provider/provider.dart';
import '../../models/serializable_model/allchats.dart';
import '../../net/http_client.dart';
import '../../provider/userprovider.dart';
import 'widgets/conversation_list.dart';

class AllChatScreen extends ModalRoute<void> {
  @override
  Duration get transitionDuration => const Duration(milliseconds: 500);

  @override
  bool get opaque => false;

  @override
  bool get barrierDismissible => false;

  @override
  Color get barrierColor => Colors.black.withOpacity(0.5);

  @override
  String get barrierLabel => "";

  @override
  bool get maintainState => true;

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    // This makes sure that text and other content follows the material style
    return Material(
      type: MaterialType.transparency,
      child: _buildOverlayContent(context),
    );
  }

  TextEditingController searchController = TextEditingController();
  late int cardViewed;
  bool alreadyowned = false;
  int otherpersonid = 0;
  String otherpersoname = '';
  Widget _buildOverlayContent(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        "Chats",
        style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
      )),
      body: Column(children: [
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
        SizedBox(
          height: 530.h,
          child: Consumer<UserProvider>(
            builder: (context, loggedinuser, child) => FutureBuilder(
                future:
                    HttpClient().getallchats(loggedinuser.user.id.toString()),
                builder: (context, AsyncSnapshot<List<AllChats>> allchats) {
                  if (allchats.connectionState != ConnectionState.done) {
                    return Center(
                        child: Padding(
                      padding: EdgeInsets.only(top: 220.h),
                      child: const CircularProgressIndicator(),
                    ));
                  }
                  return ListView.builder(
                    itemCount: allchats.data!.length,
                    shrinkWrap: true,
                    padding: const EdgeInsets.only(top: 16),
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      if (loggedinuser.user.id ==
                          allchats.data![index].useroneid) {
                        otherpersonid = allchats.data![index].usertwoid;
                        otherpersoname = allchats.data![index].usertwoname;
                      } else {
                        otherpersonid = allchats.data![index].useroneid;
                        otherpersoname = allchats.data![index].useronename;
                      }
                      return ConversationList(
                        threadid: allchats.data![index].threadid,
                        userid: otherpersonid,
                        name: otherpersoname,
                        messageText: allchats.data![index].message,
                        imageUrl:
                            'https://urbanmalta.com/public/frontend/images/johnwing-app.png',
                        time: '12:21 pm',
                      );
                    },
                  );
                }),
          ),
        ),
      ]),
    );
  }
}
