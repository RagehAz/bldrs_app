import 'package:bldrs/controllers/drafters/iconizers.dart';
import 'package:bldrs/controllers/drafters/keyboarders.dart';
import 'package:bldrs/controllers/drafters/mappers.dart';
import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/db/fire/auth_ops.dart';
import 'package:bldrs/providers/streamers/questions_streamer.dart';
import 'package:bldrs/views/widgets/general/bubbles/chat_bubble.dart';
import 'package:bldrs/views/widgets/general/buttons/dream_box/dream_box.dart';
import 'package:bldrs/views/widgets/general/layouts/main_layout.dart';
import 'package:bldrs/xxx_LABORATORY/ask/chat/chat_model.dart';
import 'package:bldrs/xxx_LABORATORY/ask/chat/chat_ops.dart';
import 'package:bldrs/xxx_LABORATORY/ask/chat/message_model.dart';
import 'package:bldrs/xxx_LABORATORY/ask/question/question_model.dart';
import 'package:flutter/material.dart';
import 'package:bldrs/views/widgets/general/textings/super_text_field.dart';

class ChatScreen extends StatefulWidget {
  final QuestionModel question;
  final String bzID;
  final String author1ID;
  final String author2ID;

  const ChatScreen({
    @required this.question,
    @required this.bzID,
    @required this.author1ID,
    @required this.author2ID,
});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final String _currentUserID = superUserID();
  TextEditingController _msgController = new TextEditingController();
  // List<MessageModel> _messages;

  bool _userSeen;
  bool _author1Seen;
  // bool _author2Seen;
// -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();

  }
// -----------------------------------------------------------------------------
  Future<void> _sendMessage({String body, List<MessageModel> existingMsgs}) async {

    if (body != null && body.length != 0){

      Keyboarders.closeKeyboard(context);

      final List<MessageModel> _newMessages = MessageModel.addToMessages(
        body: body,
        existingMsgs: existingMsgs,
      );

      final ChatModel _chatModel = ChatModel(
        bzID: widget.bzID,
        ownerID: widget.question.ownerID,
        messages: _newMessages,
        ownerSeen: _userSeen,
        author1Seen: _author1Seen,
        author2Seen: false,
        authorID1: widget.author1ID,
        authorID2: widget.author2ID,
      );

      await ChatOps.createChatOps(
        context: context,
        chatModel: _chatModel,
        questionID: widget.question.questionID,
      );

      _msgController.clear();

    }

  }
// -----------------------------------------------------------------------------


  @override
  Widget build(BuildContext context) {
    // final Stream<QuerySnapshot> _chatSnapshots = _chatsCollection.orderBy(
    //     'at', descending: false).snapshots();

    final double _screenWidth = Scale.superScreenWidth(context);
    final double _screenHeight = Scale.superScreenHeight(context);

    const double _textFieldBoxHeight = 150;

    final double _convBoxHeight = _screenHeight - _textFieldBoxHeight;

    return MainLayout(
      appBarType: AppBarType.Basic,
      pageTitle: 'Chat Screen',
      pyramids: Iconz.DvBlankSVG,
      sky: Sky.Night,
      appBarRowWidgets: const <Widget>[const BackButton(),],
      layoutWidget: chatStreamBuilder(
          context: context,
          questionID: widget.question.questionID,
          bzID: widget.bzID,
          builder: (xxx, chatModel){
            return

              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[

                  if (Mapper.canLoopList(chatModel.messages))
                  Container(
                    width: _screenWidth,
                    height: _screenHeight - _convBoxHeight,
                    color: Colorz.blue80,
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: chatModel.messages.length,
                      shrinkWrap: false,
                      itemBuilder: (xyz, index){

                        final MessageModel _msg = chatModel.messages[index];
                        final bool _isMyVerse = _currentUserID == _msg.ownerID;

                        return

                          ChatBubble(
                            verse: chatModel.messages[index].body,
                            isMyVerse: _isMyVerse,
                            userID: _currentUserID,
                            // key: ValueKey(conversation[index].documentID), // secret code here
                          );

                      },
                    ),
                  ),

                  /// TEXT FIELD
                  Container(
                    width: _screenWidth,
                    height: _textFieldBoxHeight,
                    color: Colorz.bloodTest,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[

                        SuperTextField(
                          fieldIsFormField: false,
                          height: 40,
                          width: Scale.superScreenWidth(context) - 80,
                          hintText: '...',
                          labelColor: Colorz.white20,
                          counterIsOn: false,
                          keyboardTextInputType: TextInputType.text,
                          keyboardTextInputAction: TextInputAction.send,
                          // onChanged: (value) {
                          //   setState(() {
                          //     _enteredMessage = value;
                          //   });
                          // },
                          margin: const EdgeInsets.all(10),
                          maxLines: 10,
                          textController: _msgController,
                          onSaved: () => _sendMessage(body: _msgController.text.trim(), existingMsgs: chatModel.messages),
                        ),

                        DreamBox(
                          height: 50,
                          icon: Iconizer.superArrowENRight(context),
                          onTap: () => _sendMessage(body: _msgController.text.trim(), existingMsgs: chatModel.messages),
                        ),

                      ],
                    ),
                  ),

                ],
              );
          }
      ),
    );
  }
}