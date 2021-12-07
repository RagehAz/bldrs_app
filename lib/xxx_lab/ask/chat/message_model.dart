import 'package:bldrs/controllers/drafters/timerz.dart' as Timers;
import 'package:bldrs/db/fire/ops/auth_ops.dart' as FireAuthOps;
import 'package:flutter/foundation.dart';

class MessageModel{
  /// --------------------------------------------------------------------------
  const MessageModel({
    @required this.ownerID,
    @required this.body,
    @required this.time,
  });
  /// --------------------------------------------------------------------------
  factory MessageModel.fromMap({@required dynamic map, @required bool fromJSON}) {
    return MessageModel(
      body: map['body'],
      ownerID: map['ownerID'],
      time: Timers.decipherTime(time: map['time'], fromJSON: fromJSON),
    );
  }
  /// --------------------------------------------------------------------------
  final String ownerID;
  final String body;
  final DateTime time;
  /// --------------------------------------------------------------------------
  Map<String, dynamic> toMap({@required bool toJSON}){
    return <String, dynamic>{
      'ownerID' : ownerID,
      'body' : body,
      'time' : Timers.cipherTime(time: time, toJSON: toJSON),
    };
  }
// -----------------------------------------------------------------------------
  static List<dynamic> cipherMessages({@required List<MessageModel> messages, @required bool toJSON}){
    final List<Map<String, dynamic>> _messagesMaps = <Map<String, dynamic>>[];

    for (final MessageModel msg in messages){
      _messagesMaps.add(msg.toMap(toJSON: toJSON));
    }

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
  static List<MessageModel> decipherMessages({@required List<Map<String, dynamic>> msgsMaps, @required bool fromJSON}){
    final List<MessageModel> _postsModels = <MessageModel>[];

    for (final Map<String, dynamic> postMap in msgsMaps){
      _postsModels.add(decipherMessage(msgMap: postMap, fromJSON: fromJSON));
    }

    return _postsModels;
  }
// -----------------------------------------------------------------------------
  static List<MessageModel> addToMessages({String body, List<MessageModel> existingMsgs}){

    final MessageModel _newMessage = MessageModel(
      ownerID: FireAuthOps.superUserID(),
      body: body,
      time: DateTime.now(),
    );

    final List<MessageModel> _newMessages = <MessageModel>[...existingMsgs, _newMessage];

    return _newMessages;
  }
// -----------------------------------------------------------------------------
}
