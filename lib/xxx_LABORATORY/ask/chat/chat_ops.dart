import 'package:bldrs/db/firestore/firestore.dart';
import 'package:bldrs/xxx_LABORATORY/ask/chat/chat_model.dart';
import 'package:flutter/material.dart';

/// db/questions/questionID/chats/chatID/messages/messageID
class ChatOps{
// -----------------------------------------------------------------------------
//   /// chats sub collection reference
//   CollectionReference _chatsSubCollectionRef(){
//     return Fire.getCollectionRef(FireCollection.questions_question_chats);
//   }
// // -----------------------------------------------------------------------------
//   /// chat doc ref
//   DocumentReference _chatSubDocRef(String questionID, String chatID){
//     return
//         Fire.getSubDocRef(
//           collName: FireCollection.questions,
//           docName: questionID,
//           subCollName: FireCollection.questions_question_chats,
//           subDocName: chatID
//         );
//   }
// -----------------------------------------------------------------------------
  /// create
  static Future<void> createChatOps({@required BuildContext context, @required ChatModel chatModel, @required String questionID}) async {

    await Fire.createSubDoc(
      context: context,
      collName: FireColl.questions,
      docName: questionID,
      subCollName: chatModel.bzID,
      input: chatModel.toMap(toJSON: false),
    );

  }
// -----------------------------------------------------------------------------
  /// read
  static Future<ChatModel> readChatOps({@required BuildContext context, @required String bzID, @required String questionID}) async {

    final dynamic _chatMap = await Fire.readSubDoc(
      context: context,
      collName: FireColl.questions,
      docName: questionID,
      subCollName: FireColl.questions_question_chats,
      subDocName: bzID,
    );

    final ChatModel _chat = ChatModel.decipherChatMap(map: _chatMap, fromJSON: false);

    return _chat;
  }
// -----------------------------------------------------------------------------
  /// edit
  static Future<void> updateChatOps({@required BuildContext context, @required ChatModel updatedChat, @required String questionID}) async {

    await Fire.updateSubDoc(
      context: context,
      collName: FireColl.questions,
      docName: questionID,
      subCollName: FireColl.questions_question_chats,
      subDocName: updatedChat.bzID,
      input: updatedChat.toMap(toJSON: false),
    );

  }
// -----------------------------------------------------------------------------
  /// delete
  static Future<void> deleteChatOps({BuildContext context, String bzID, String questionID}) async {

    await Fire.deleteSubDoc(
      context: context,
      collName: FireColl.questions,
      docName: questionID,
      subCollName: FireColl.questions_question_chats,
      subDocName: bzID,
    );

  }
// -----------------------------------------------------------------------------
}