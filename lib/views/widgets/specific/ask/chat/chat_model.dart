import 'package:bldrs/views/widgets/specific/ask/chat/message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
  Map<String, dynamic> toMap(){
    return {
      'bzID' : bzID,
      'messages' : MessageModel.cipherMessages(messages),
      'author1' : authorID1,
      'author2' : authorID2,
      'ownerID' : ownerID,
      'ownerSeen' : ownerSeen,
      'author1Seen' : author1Seen,
      'author2Seen' : author2Seen,
    };
  }
// -----------------------------------------------------------------------------
  static ChatModel decipherChatMap(Map<String, dynamic> map){
    ChatModel _chat;

    if (map != null){
      _chat = ChatModel(
        bzID : map['bzID'],
        messages : MessageModel.decipherMessages(map['messages']),
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
    var _map = doc.data();
    ChatModel _chat = ChatModel.decipherChatMap(_map);
    return _chat;
  }
// -----------------------------------------------------------------------------
}
