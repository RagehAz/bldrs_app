import 'package:bldrs/controllers/drafters/stream_checkers.dart';
import 'package:bldrs/db/firestore/firestore.dart';
import 'package:bldrs/views/widgets/general/loading/loading.dart';
import 'package:bldrs/xxx_LABORATORY/ask/chat/chat_model.dart';
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
          final ChatModel chatModel = snapshot.data;
          return
            builder(context, chatModel);
        }
      },
    );
}
  // -----------------------------------------------------------------------------
  /// get chat doc stream
  Stream<ChatModel> getChatStream(String questionID, String bzID) {

    final Stream<DocumentSnapshot> _bzSnapshot = Fire.streamSubDoc(
    collName: FireColl.questions,
    docName: questionID,
    subCollName: FireColl.questions_question_chats,
    subDocName: bzID,
  );



    final Stream<ChatModel> _tinyBzStream = _bzSnapshot.map(ChatModel.getChatModelFromSnapshot);
  return _tinyBzStream;
  }
// -----------------------------------------------------------------------------
