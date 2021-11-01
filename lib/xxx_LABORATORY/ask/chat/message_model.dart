import 'package:bldrs/controllers/drafters/timerz.dart';
import 'package:bldrs/db/fire/auth_ops.dart';
import 'package:flutter/foundation.dart';

class MessageModel{
  final String ownerID;
  final String body;
  final DateTime time;

  const MessageModel({
    @required this.ownerID,
    @required this.body,
    @required this.time,
  });
// -----------------------------------------------------------------------------
  Map<String, dynamic> toMap({@required bool toJSON}){
    return {
      'ownerID' : ownerID,
      'body' : body,
      'time' : Timers.cipherTime(time: time, toJSON: toJSON),
    };
  }
// -----------------------------------------------------------------------------
  factory MessageModel.fromMap({@required dynamic map, @required bool fromJSON}) {
    return MessageModel(
      body: map['body'],
      ownerID: map['ownerID'],
      time: Timers.decipherTime(time: map['time'], fromJSON: fromJSON),
    );
  }
// -----------------------------------------------------------------------------
  static List<dynamic> cipherMessages({@required List<MessageModel> messages, @required bool toJSON}){
    final List<Map<String, dynamic>> _messagesMaps = <Map<String, dynamic>>[];
    messages.forEach((msg) {
      _messagesMaps.add(msg.toMap(toJSON: toJSON));
    });
    return _messagesMaps;
  }
// -----------------------------------------------------------------------------
  static MessageModel decipherMessage({@required Map<String, dynamic> msgMap, @required bool fromJSON}){
    return MessageModel(
      ownerID: msgMap['ownerID'],
      body: msgMap['body'],
      time: Timers.decipherTime(time: msgMap['time'], fromJSON: fromJSON),
    );
  }
// -----------------------------------------------------------------------------
  static List<MessageModel> decipherMessages({@required List<dynamic> msgsMaps, @required bool fromJSON}){
    final List<MessageModel> _postsModels = <MessageModel>[];

    msgsMaps.forEach((postMap) {
      _postsModels.add(decipherMessage(msgMap: postMap, fromJSON: fromJSON));
    });

    return _postsModels;
  }
// -----------------------------------------------------------------------------
  static List<MessageModel> addToMessages({String body, List<MessageModel> existingMsgs}){

    final MessageModel _newMessage = MessageModel(
      ownerID: superUserID(),
      body: body,
      time: DateTime.now(),
    );

    final List<MessageModel> _newMessages = <MessageModel>[...existingMsgs, _newMessage];

    return _newMessages;
  }
// -----------------------------------------------------------------------------
}