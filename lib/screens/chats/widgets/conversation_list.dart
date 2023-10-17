import 'package:flutter/material.dart';
import 'package:kappu/screens/chats/chat_screen.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';


class ConversationList extends StatefulWidget {
  final int userid;
  final String name;
  final String messageText;
  final String imageUrl;
  final String time;
  final int threadid;
  const ConversationList(
      {Key? key,
      required this.userid,
      required this.name,
      required this.messageText,
      required this.imageUrl,
      required this.time,
      required this.threadid})
      : super(key: key);
  @override
  _ConversationListState createState() => _ConversationListState();
}

class _ConversationListState extends State<ConversationList> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        pushDynamicScreen(context,
            screen: ChattingScreen(
                threadid: widget.threadid,
                otheruserid: widget.userid,
                otherusername: widget.name),
            withNavBar: false);
      },
      child: Container(
        padding:
            const EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                    backgroundColor: Colors.transparent,
                    backgroundImage: NetworkImage(widget.imageUrl),
                    maxRadius: 30,
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: Container(
                      color: Colors.transparent,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            widget.name,
                            style: const TextStyle(fontSize: 16),
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          Text(
                            widget.messageText,
                            style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey.shade600,
                                fontWeight: FontWeight.normal),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Text(
              widget.time,
              style:
                  const TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
            ),
          ],
        ),
      ),
    );
  }
}
