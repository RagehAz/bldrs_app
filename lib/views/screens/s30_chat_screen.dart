import 'package:bldrs/ambassadors/services/auth.dart';
import 'package:bldrs/models/user_model.dart';
import 'package:bldrs/providers/users_provider.dart';
import 'package:bldrs/view_brains/controllers/streamerz.dart';
import 'package:bldrs/view_brains/drafters/keyboarders.dart';
import 'package:bldrs/view_brains/drafters/scalers.dart';
import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:bldrs/view_brains/theme/iconz.dart';
import 'package:bldrs/views/widgets/bubbles/chat_bubble.dart';
import 'package:bldrs/views/widgets/buttons/bt_back.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:bldrs/views/widgets/loading/loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:bldrs/views/widgets/textings/super_text_field.dart';

class ChatScreen extends StatefulWidget {

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  String _enteredMessage = '';
  TextEditingController _textBarController = new TextEditingController();
  final CollectionReference _chatsCollection = FirebaseFirestore.instance
      .collection('chats/498KMHxrtsKzUGejl0Bd/messages');


  void _sendMessage(String val) {
    closeKeyboard(context);
    final _userID = superUserID();
    _chatsCollection.add({
      'userID': _userID,
      'text': _enteredMessage,
      'at': Timestamp.now(),
    });
    _textBarController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _chatSnapshots = _chatsCollection.orderBy(
        'at', descending: false).snapshots();
    final _userID = superUserID();

    print('wtf');

    return MainLayout(
      appBarType: AppBarType.Basic,
      pageTitle: 'Chat Screen',
      pyramids: Iconz.PyramidsCrystal,
      sky: Sky.Night,
      appBarRowWidgets: <Widget>[BldrsBackButton(),],
      layoutWidget: Column(
        children: <Widget>[

          StreamBuilder<UserModel>(
              stream: UserProvider(userID: _userID).userData,
              builder: (ctx, snapshot) {
                if (connectionIsWaiting(snapshot)) {
                  return Loading();
                } else {
                  UserModel userModel = snapshot.data;

                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[

                      Stratosphere(),

                      // --- MESSAGES LIST
                      Container(
                        width: superScreenWidth(context),
                        height: 300,
                        child: StreamBuilder(
                          stream: _chatSnapshots,
                          builder: (ctx, streamSnapshot) {
                            List<dynamic> conversation = streamSnapshot?.data?.docs;

                            if (connectionIsWaiting(streamSnapshot)) {
                              return Loading();
                            }
                            return ListView.builder(
                              reverse: false,
                              itemCount: conversation.length,

                              itemBuilder: (ctx, index) {

                                // print(conversation[index].documentID); // which is doc ID of each message sent, cool !

                                 return ChatBubble(
                                   verse: conversation[index]['text'],
                                   myVerse: conversation[index]['userID'] == userModel.userID,
                                   key: ValueKey(conversation[index].documentID), // secret code here
                                   userID: conversation[index]['userID'],
                                  );}
                            );
                          },
                        ),
                      ),

                    ],
                  );
                }
              }
          ),

          // --- TEXT BAR
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[

              SuperTextField(
                fieldIsFormField: false,
                height: 40,
                width: superScreenWidth(context) - 80,
                hintText: '...',
                labelColor: Colorz.WhiteGlass,
                counterIsOn: false,
                keyboardTextInputType: TextInputType.text,
                keyboardTextInputAction: TextInputAction.send,
                onChanged: (value) {
                  setState(() {
                    _enteredMessage = value;
                  });
                },
                margin: EdgeInsets.all(10),
                maxLines: 10,
                textController: _textBarController,
                onSaved: _enteredMessage
                    .trim()
                    .isEmpty ? null :
                    () {
                  print(_enteredMessage);
                  _sendMessage(_enteredMessage);
                },
              ),

              DreamBox(
                height: 50,
                icon: Iconz.DvDonaldDuck,
                boxFunction: _enteredMessage.trim().isEmpty ? null :
                    () {
                  print(_enteredMessage);
                  _sendMessage(_enteredMessage);
                },
              ),

            ],
          ),

        ],
      ),
    );
  }
}