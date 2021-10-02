import 'package:bldrs/firestore/firestore.dart';
import 'package:bldrs/views/widgets/specific/ask/chat/chat_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

/// db/questions/questionID/chats/chatID/messages/messageID
class ChatOps{
// -----------------------------------------------------------------------------
  /// chats sub collection reference
  CollectionReference chatsSubCollectionRef(){
    return Fire.getCollectionRef(FireCollection.questions_question_chats);
  }
// -----------------------------------------------------------------------------
  /// chat doc ref
  DocumentReference chatSubDocRef(String questionID, String chatID){
    return
        Fire.getSubDocRef(
          collName: FireCollection.questions,
          docName: questionID,
          subCollName: FireCollection.questions_question_chats,
          subDocName: chatID
        );
  }
// -----------------------------------------------------------------------------
  /// create
  static Future<void> createChatOps({BuildContext context, ChatModel chatModel, String questionID}) async {

    await Fire.createSubDoc(
      context: context,
      collName: FireCollection.questions,
      docName: questionID,
      subCollName: chatModel.bzID,
      input: chatModel.toMap(),
    );

  }
// -----------------------------------------------------------------------------
  /// read
  static Future<ChatModel> readChatOps({BuildContext context, String bzID, String questionID}) async {

    final dynamic _chatMap = await Fire.readSubDoc(
      context: context,
      collName: FireCollection.questions,
      docName: questionID,
      subCollName: FireCollection.questions_question_chats,
      subDocName: bzID,
    );

    final ChatModel _chat = ChatModel.decipherChatMap(_chatMap);

    return _chat;
  }
// -----------------------------------------------------------------------------
  /// edit
  static Future<void> updateChatOps({BuildContext context, ChatModel updatedChat, String questionID}) async {

    await Fire.updateSubDoc(
      context: context,
      collName: FireCollection.questions,
      docName: questionID,
      subCollName: FireCollection.questions_question_chats,
      subDocName: updatedChat.bzID,
      input: updatedChat.toMap(),
    );

  }
// -----------------------------------------------------------------------------
  /// delete
  static Future<void> deleteChatOps({BuildContext context, String bzID, String questionID}) async {

    await Fire.deleteSubDoc(
      context: context,
      collName: FireCollection.questions,
      docName: questionID,
      subCollName: FireCollection.questions_question_chats,
      subDocName: bzID,
    );

  }
// -----------------------------------------------------------------------------
}