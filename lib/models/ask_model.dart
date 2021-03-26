import 'package:bldrs/controllers/drafters/timerz.dart';
import 'package:flutter/foundation.dart';
import 'bz_model.dart';
import 'flyer_model.dart';
import 'sub_models/author_model.dart';
// -----------------------------------------------------------------------------
class AskModel {
  final String askID;
  final String userID;
  final String askBody;
  final FlyerType askType;
  final DateTime askTime;
  final List<String> keyWords;
  final List<dynamic> pics;
  final String title;
  int totalViews;
  int totalChats;
  bool userSeenAll;
  bool askIsActive;
  final bool userDeletedAsk;

  AskModel({
    @required this.askID,
    @required this.userID,
    @required this.askBody,
    @required this.askType,
    @required this.askTime,
    @required this.keyWords,
    @required this.pics,
    @required this.title,
    @required this.totalViews,
    @required this.totalChats,
    @required this.userSeenAll,
    @required this.askIsActive,
    @required this.userDeletedAsk,
});

  Map<String, dynamic> toMap(){
    return {
    'askID' : askID,
    'userID' : userID,
    'askBody' : askBody,
    'askType' : cipherFlyerType(askType),
    'askTime' : cipherDateTimeToString(askTime),
    'keyWords' : keyWords,
    'pics' : pics,
    'title' : title,
    'totalViews' : totalViews,
    'totalChats' : totalChats,
    'userSeenAll' : userSeenAll,
    'askIsActive' : askIsActive,
    'userDeletedAsk' : userDeletedAsk,
    };
  }
}
// -----------------------------------------------------------------------------
AskModel decipherAskMap(Map<String, dynamic> map){
  return AskModel(
      askID: map['askID'],
      userID: map['userID'],
      askBody: map['askBody'],
      askType: decipherFlyerType(map['askType']),
      askTime: map['askTime'],
      keyWords: map['keyWords'],
      pics: map['pics'],
      title: map['title'],
      totalViews: map['totalViews'],
      totalChats: map['totalChats'],
      userSeenAll: map['userSeenAll'],
      askIsActive: map['askIsActive'],
      userDeletedAsk: map['userDeletedAsk']
);
}
// -----------------------------------------------------------------------------
class ChatModel{
  final TinyBz tinyBz;
  List<PostModel> posts;
  final AuthorModel author1;
  final AuthorModel author2;
  final String userID;
  bool userSeen;
  bool author1Seen;
  bool author2Seen;

  ChatModel({
    this.tinyBz,
    this.posts,
    this.author1,
    this.author2,
    this.userID,
    this.userSeen,
    this.author1Seen,
    this.author2Seen,
});

  Map<String, dynamic> toMap(){
    return {
      'tinyBz' : tinyBz.toMap(),
      'posts' : cipherPostsModels(posts),
      'author1' : author1.toMap(),
      'author2' : author2.toMap(),
      'userID' : userID,
      'userSeen' : userSeen,
      'author1Seen' : author1Seen,
      'author2Seen' : author2Seen,
    };
  }

}
// -----------------------------------------------------------------------------
ChatModel decipherChatMap(Map<String, dynamic> map){
  return ChatModel(
    tinyBz : decipherTinyBzMap(map['tinyBz']),
    posts : decipherPostsMaps(map['posts']),
    author1 : decipherBzAuthorMap(map['author1']),
    author2 : decipherBzAuthorMap(map['author2']),
    userID : map['userID'],
    userSeen : map['userSeen'],
    author1Seen : map['author1Seen'],
    author2Seen : map['author2Seen'],
  );
}
// -----------------------------------------------------------------------------
class PostModel{
  final String id;
  final String body;
  final DateTime time;

  PostModel({
    @required this.id,
    @required this.body,
    @required this.time,
});

  Map<String, dynamic> toMap(){
  return {
  'id' : id,
  'body' : body,
  'time' : cipherDateTimeToString(time),
  };
  }

}
// -----------------------------------------------------------------------------
List<dynamic> cipherPostsModels(List<PostModel> postsModel){
  List<Map<String, dynamic>> _postsMaps = new List();
  postsModel.forEach((post) {
    _postsMaps.add(post.toMap());
  });
  return _postsMaps;
}
// -----------------------------------------------------------------------------
PostModel decipherPostMap(Map<String, dynamic> postMap){
  return PostModel(
      id: postMap['id'],
      body: postMap['body'],
      time: decipherDateTimeString(postMap['time']),
  );
}
// -----------------------------------------------------------------------------
List<PostModel> decipherPostsMaps(List<dynamic> postsMaps){
  List<PostModel> _postsModels = new List();

  postsMaps.forEach((postMap) {
    _postsModels.add(decipherPostMap(postMap));
  });

  return _postsModels;
}
// -----------------------------------------------------------------------------
