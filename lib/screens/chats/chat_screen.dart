import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kappu/components/AppColors.dart';
import 'package:kappu/provider/provider_provider.dart';
import 'package:provider/provider.dart';
import 'package:web_socket_channel/io.dart';
import '../../models/serializable_model/chat.dart';
import '../../net/http_client.dart';
import '../../provider/userprovider.dart';

class ChattingScreen extends ModalRoute<void> {
  final int otheruserid;
  final String otherusername;
  final int threadid;
  ChattingScreen(
      {required this.otheruserid,
      required this.otherusername,
      required this.threadid});
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
    return Material(
      type: MaterialType.transparency,
      child: _buildOverlayContent(context),
    );
  }

  List<Chat> messeges = [];
  TextEditingController messegecontroller = TextEditingController();

  ScrollController messageListController = ScrollController();
  Future? scrollToBottum() {
    if (messageListController.hasClients) {
      return messageListController.animateTo(
          messageListController.position.maxScrollExtent + 50,
          duration: const Duration(microseconds: 100),
          curve: Curves.fastOutSlowIn);
    }
    return null;
  }

  late int id;
  Widget _buildOverlayContent(BuildContext context) {
    return Scaffold(body: Consumer<UserProvider>(
      builder: (context, loggedinuser, child) {
        return Consumer<ProviderProvider>(
            builder: (context, loggedinprovider, child) {
          loggedinuser.token != ''
              ? id = loggedinuser.user.id
              : id = loggedinprovider.provider.id;
          final mychannel = IOWebSocketChannel.connect(
              Uri.parse('ws://127.0. 0.1:8000/ws/$id/'));
          return SingleChildScrollView(
            child: FutureBuilder(
                future: HttpClient().getchatwithauser(threadid.toString()),
                builder: (context, AsyncSnapshot<List<Chat>> loadmessages) {
                  if (loadmessages.connectionState != ConnectionState.done) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  messeges = loadmessages.data!;
                  return StreamBuilder(
                      stream: mychannel.stream,
                      builder: (context, snapshot) {
                        if (snapshot.hasData &&
                            snapshot.data.toString() != 'connected!' &&
                            id !=
                                jsonDecode(snapshot.data.toString())['user']) {
                          var messegedata =
                              jsonDecode(snapshot.data.toString());
                          messeges.add(Chat(
                              senderid: messegedata['user'],
                              message: messegedata['message']));
                        }
                        return StatefulBuilder(
                            builder: (context, setmessegesstate) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(children: [
                                Container(
                                  height: 90.h,
                                  color: Colors.white,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left: 16.w, right: 16.w, top: 20.h),
                                    child: Row(
                                      children: <Widget>[
                                        CircleAvatar(
                                          backgroundColor: Colors.white,
                                          child: IconButton(
                                            onPressed: () {
                                              mychannel.sink.close();
                                              Navigator.pop(context);
                                            },
                                            icon: const Icon(
                                              Icons.arrow_back_ios,
                                              color: AppColors.app_color,
                                            ),
                                          ),
                                        ),
                                        60.horizontalSpace,
                                        Expanded(
                                          child: Text(
                                            otherusername,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize:
                                                    ScreenUtil().setSp(20)),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                if (messeges.isNotEmpty)
                                  FutureBuilder(
                                      future: scrollToBottum(),
                                      builder: (context, snapshot) {
                                        return SizedBox(
                                          height: 510.h,
                                          child: ListView.builder(
                                            controller: messageListController,
                                            itemCount: messeges.length,
                                            shrinkWrap: true,
                                            padding: const EdgeInsets.only(
                                                top: 10, bottom: 10),
                                            scrollDirection: Axis.vertical,
                                            itemBuilder: (context, index) {
                                              return Container(
                                                padding: const EdgeInsets.only(
                                                    left: 14,
                                                    right: 14,
                                                    top: 10,
                                                    bottom: 10),
                                                child: Align(
                                                  alignment: (messeges[index]
                                                              .senderid !=
                                                          id
                                                      ? Alignment.topLeft
                                                      : Alignment.topRight),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                      color: (messeges[index]
                                                                  .senderid !=
                                                              id
                                                          ? Colors.grey.shade200
                                                          : AppColors.app_color),
                                                    ),
                                                    padding:
                                                        const EdgeInsets.all(
                                                            16),
                                                    child: Text(
                                                      messeges[index].message,
                                                      style: const TextStyle(
                                                          fontSize: 15),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        );
                                      })
                              ]),
                              Padding(
                                padding: EdgeInsets.only(
                                    bottom: 20.h, left: 10.w, right: 10.w),
                                child: Container(
                                  padding: const EdgeInsets.only(
                                      left: 10, bottom: 10, top: 10),
                                  height: 50.h,
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
                                          decoration: const InputDecoration(
                                              hintText: "Write message...",
                                              hintStyle: TextStyle(
                                                  color: Colors.black54),
                                              border: InputBorder.none),
                                          controller: messegecontroller,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 15,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          messeges.add(Chat(
                                              senderid: id,
                                              message: messegecontroller.text));
                                          setmessegesstate((() => {}));
                                          Map<String, dynamic> body = {
                                            "user": id,
                                            "thread": threadid,
                                            "receiver": otheruserid,
                                            "message": messegecontroller.text
                                          };
                                          var jsonString = json.encode(body);
                                          mychannel.sink.add(jsonString);
                                          messegecontroller.clear();
                                          scrollToBottum();
                                        },
                                        child: CircleAvatar(
                                          radius: 25.h,
                                          child: const Icon(
                                            Icons.send,
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
                            ],
                          );
                        });
                      });
                }),
          );
        });
      },
    ));
  }
}
