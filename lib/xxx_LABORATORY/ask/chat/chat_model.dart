import 'package:bldrs/xxx_LABORATORY/ask/chat/message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class ChatModel{
  final String bzID;
  List<MessageModel> messages;
  final String authorID1;
  final String authorID2;
  final String ownerID;
  bool ownerSeen;
  bool author1Seen;
  bool author2Seen;

  ChatModel({
    this.bzID,
    this.messages,
    this.authorID1,
    this.authorID2,
    this.ownerID,
    this.ownerSeen,
    this.author1Seen,
    this.author2Seen,
  });
// -----------------------------------------------------------------------------
  Map<String, dynamic> toMap({@required bool toJSON}){
    return {
      'bzID' : bzID,
      'messages' : MessageModel.cipherMessages(messages: messages, toJSON: toJSON),
      'author1' : authorID1,
      'author2' : authorID2,
      'ownerID' : ownerID,
      'ownerSeen' : ownerSeen,
      'author1Seen' : author1Seen,
      'author2Seen' : author2Seen,
    };
  }
// -----------------------------------------------------------------------------
  static ChatModel decipherChatMap({@required Map<String, dynamic> map, @required bool fromJSON}){
    ChatModel _chat;

    if (map != null){
      _chat = ChatModel(
        bzID : map['bzID'],
        messages : MessageModel.decipherMessages(msgsMaps: map['messages'], fromJSON: fromJSON),
        authorID1 : map['authorID1'],
        authorID2 : map['authorID2'],
        ownerID : map['ownerID'],
        ownerSeen : map['ownerSeen'],
        author1Seen : map['author1Seen'],
        author2Seen : map['author2Seen'],
      );
    }

    return _chat;
// -----------------------------------------------------------------------------
  }
// -----------------------------------------------------------------------------
  static ChatModel getChatModelFromSnapshot(DocumentSnapshot doc){
    final Object _map = doc.data();
    ChatModel _chat = ChatModel.decipherChatMap(map: _map, fromJSON: false);
    return _chat;
  }
// -----------------------------------------------------------------------------
}
