import 'package:bldrs/b_views/widgets/general/bubbles/chat_bubble.dart';
import 'package:bldrs/b_views/widgets/general/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/widgets/general/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/texting/super_text_field.dart';
import 'package:bldrs/d_providers/streamers/questions_streamer.dart';
import 'package:bldrs/e_db/fire/ops/auth_ops.dart' as FireAuthOps;
import 'package:bldrs/f_helpers/drafters/iconizers.dart' as Iconizer;
import 'package:bldrs/f_helpers/drafters/keyboarders.dart' as Keyboarders;
import 'package:bldrs/f_helpers/drafters/mappers.dart' as Mapper;
import 'package:bldrs/f_helpers/drafters/scalers.dart' as Scale;
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
import 'package:bldrs/xxx_lab/ask/chat/chat_model.dart';
import 'package:bldrs/xxx_lab/ask/chat/chat_ops.dart' as ChatOps;
import 'package:bldrs/xxx_lab/ask/chat/message_model.dart';
import 'package:bldrs/xxx_lab/ask/question/question_model.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const ChatScreen({
    @required this.question,
    @required this.bzID,
    @required this.author1ID,
    @required this.author2ID,
    Key key,
  }) : super(key: key);

  /// --------------------------------------------------------------------------
  final QuestionModel question;
  final String bzID;
  final String author1ID;
  final String author2ID;

  /// --------------------------------------------------------------------------
  @override
  _ChatScreenState createState() => _ChatScreenState();

  /// --------------------------------------------------------------------------
}

class _ChatScreenState extends State<ChatScreen> {
  final String _currentUserID = FireAuthOps.superUserID();
  final TextEditingController _msgController = TextEditingController();
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
  Future<void> _sendMessage(
      {String body, List<MessageModel> existingMsgs}) async {
    if (body != null && body.isNotEmpty) {
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
      appBarType: AppBarType.basic,
      pageTitle: 'Chat Screen',
      pyramids: Iconz.dvBlankSVG,
      appBarRowWidgets: const <Widget>[
        BackButton(),
      ],
      layoutWidget: chatStreamBuilder(
          context: context,
          questionID: widget.question.questionID,
          bzID: widget.bzID,
          builder: (BuildContext xxx, ChatModel chatModel) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                if (Mapper.canLoopList(chatModel.messages))
                  Container(
                    width: _screenWidth,
                    height: _screenHeight - _convBoxHeight,
                    color: Colorz.blue80,
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: chatModel.messages.length,
                      itemBuilder: (BuildContext xyz, int index) {
                        final MessageModel _msg = chatModel.messages[index];
                        final bool _isMyVerse = _currentUserID == _msg.ownerID;

                        return ChatBubble(
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
                    children: <Widget>[
                      SuperTextField(
                        height: 40,
                        width: Scale.superScreenWidth(context) - 80,
                        labelColor: Colorz.white20,
                        counterIsOn: false,
                        keyboardTextInputAction: TextInputAction.send,
                        // onChanged: (value) {
                        //   setState(() {
                        //     _enteredMessage = value;
                        //   });
                        // },
                        margin: const EdgeInsets.all(10),
                        maxLines: 10,
                        textController: _msgController,
                        onSaved: (String val) => _sendMessage(
                            body: _msgController.text.trim(),
                            existingMsgs: chatModel.messages),
                      ),
                      DreamBox(
                        height: 50,
                        icon: Iconizer.superArrowENRight(context),
                        onTap: () => _sendMessage(
                            body: _msgController.text.trim(),
                            existingMsgs: chatModel.messages),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }),
    );
  }
}
