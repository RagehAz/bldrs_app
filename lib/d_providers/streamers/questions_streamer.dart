import 'package:bldrs/b_views/widgets/general/loading/loading.dart';
import 'package:bldrs/e_db/fire/methods/firestore.dart' as Fire;
import 'package:bldrs/e_db/fire/methods/paths.dart';
import 'package:bldrs/f_helpers/drafters/stream_checkers.dart' as StreamChecker;
import 'package:bldrs/xxx_lab/ask/chat/chat_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

typedef ChatModelWidgetBuilder = Widget Function(
  BuildContext context,
  ChatModel chatModel,
);

Widget chatStreamBuilder({
  BuildContext context,
  ChatModelWidgetBuilder builder,
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

  return StreamBuilder<ChatModel>(
    stream: getChatStream(questionID, bzID),
    builder: (BuildContext context, AsyncSnapshot<ChatModel> snapshot) {
      if (StreamChecker.connectionIsLoading(snapshot) == true) {
        return const Loading(
          loading: true,
        );
      } else {
        final ChatModel chatModel = snapshot.data;
        return builder(context, chatModel);
      }
    },
  );
}

// -----------------------------------------------------------------------------
/// get chat doc stream
Stream<ChatModel> getChatStream(String questionID, String bzID) {
  final Stream<DocumentSnapshot<Object>> _bzSnapshot = Fire.streamSubDoc(
    collName: FireColl.questions,
    docName: questionID,
    subCollName: FireSubColl.questions_question_chats,
    subDocName: bzID,
  );

  final Stream<ChatModel> _tinyBzStream =
      _bzSnapshot.map(ChatModel.getChatModelFromSnapshot);
  return _tinyBzStream;
}
// -----------------------------------------------------------------------------