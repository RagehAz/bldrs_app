import 'package:bldrs/controllers/drafters/stream_checkers.dart';
import 'package:bldrs/firestore/firestore.dart';
import 'package:bldrs/views/widgets/specific/ask/chat/chat_model.dart';
import 'package:bldrs/views/widgets/general/loading/loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

typedef chatModelWidgetBuilder = Widget Function(
    BuildContext context,
    ChatModel chatModel,
    );

Widget chatStreamBuilder({
  BuildContext context,
  chatModelWidgetBuilder builder,
  String questionID,
  String bzID,
}) {
  // CollectionReference _chatsSubCollectionRef = Fire.getSubCollectionRef(
  //   collName: FireCollection.questions,
  //   docName: questionID,
  //   subCollName: bzID,
  // );

  // final Stream<QuerySnapshot> _chatStream = _chatsSubCollectionRef.orderBy(
  //     'at', descending: false).snapshots();

  return

    StreamBuilder<ChatModel>(
      stream: getChatStream(questionID, bzID),
      builder: (context, snapshot) {
        if (StreamChecker.connectionIsLoading(snapshot) == true) {
          return Loading(loading: true,);
        } else {
          ChatModel chatModel = snapshot.data;
          return
            builder(context, chatModel);
        }
      },
    );
}
  // -----------------------------------------------------------------------------
  /// get chat doc stream
  Stream<ChatModel> getChatStream(String questionID, String bzID) {

  Stream<DocumentSnapshot> _bzSnapshot = Fire.streamSubDoc(
    collName: FireCollection.questions,
    docName: questionID,
    subCollName: FireCollection.questions_question_chats,
    subDocName: bzID,
  );



  Stream<ChatModel> _tinyBzStream = _bzSnapshot.map(ChatModel.getChatModelFromSnapshot);
  return _tinyBzStream;
  }
// -----------------------------------------------------------------------------
