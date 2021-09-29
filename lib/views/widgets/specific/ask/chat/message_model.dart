import 'package:bldrs/controllers/drafters/timerz.dart';
import 'package:bldrs/firestore/auth_ops.dart';
import 'package:flutter/foundation.dart';

class MessageModel{
  final String ownerID;
  final String body;
  final DateTime time;

  MessageModel({
    @required this.ownerID,
    @required this.body,
    @required this.time,
  });
// -----------------------------------------------------------------------------
  Map<String, dynamic> toMap(){
    return {
      'ownerID' : ownerID,
      'body' : body,
      'time' : Timers.cipherDateTimeToString(time),
    };
  }
// -----------------------------------------------------------------------------
  factory MessageModel.fromMap(map) {
    return MessageModel(
      body: map['body'],
      ownerID: map['ownerID'],
      time: Timers.decipherDateTimeString(map['time']),
    );
  }
// -----------------------------------------------------------------------------
  static List<dynamic> cipherMessages(List<MessageModel> messages){
    List<Map<String, dynamic>> _messagesMaps = [];
    messages.forEach((msg) {
      _messagesMaps.add(msg.toMap());
    });
    return _messagesMaps;
  }
// -----------------------------------------------------------------------------
  static MessageModel decipherMessage(Map<String, dynamic> msgMap){
    return MessageModel(
      ownerID: msgMap['ownerID'],
      body: msgMap['body'],
      time: Timers.decipherDateTimeString(msgMap['time']),
    );
  }
// -----------------------------------------------------------------------------
  static List<MessageModel> decipherMessages(List<dynamic> msgsMaps){
    List<MessageModel> _postsModels = [];

    msgsMaps.forEach((postMap) {
      _postsModels.add(decipherMessage(postMap));
    });

    return _postsModels;
  }
// -----------------------------------------------------------------------------
  static List<MessageModel> addToMessages({String body, List<MessageModel> existingMsgs}){

    MessageModel _newMessage = MessageModel(
      ownerID: superUserID(),
      body: body,
      time: DateTime.now(),
    );

    List<MessageModel> _newMessages = <MessageModel>[...existingMsgs, _newMessage];

    return _newMessages;
  }

}
