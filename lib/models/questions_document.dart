

import 'package:bldrs/models/enums/enum_flyer_type.dart';

/// as chats are private and only fetched between 2 users, and we don't wanna fetch
/// the entire chats when fetching a user,, and only fetch the chat when entering
/// the chat screen with help of pagination as well but I guess that wouldn't be possible
/// .. I've split the QuestionDocument from ChatDocument
class QuestionDocument {
  final String questionID;
  final String userID;
  final String questionBody;
  final FlyerType questionType;
  final DateTime questionTime;
  /// maybe we add this in future,, but for now all chats are private
  final bool chatsArePrivate;
  /// this map will look like this [attachmentsMaps]
  final List<Map<String,Object>> questionAttachments;

  QuestionDocument({
    this.questionID,
    this.userID,
    this.questionBody,
    this.questionType,
    this.questionTime,
    this.chatsArePrivate,
    this.questionAttachments,
});
}


/// with this way,, note that we can not split the chat and fetch parts of it,,
/// so if the conversation is long and has many attachments,,, both users keep
/// fetching the entire chat each time they open it,, this needs some thinking,,
/// split replies into separate collection ba2a walla eh ?
class ChatDocument{
  /// here we need userName, userPic, userJobTitle, userContacts
  final String askerID;
  /// here we don't just need the author ID but we specifically need
  /// the data of [MiniHeader();]
  /// authorName, authorPic, authorJobTitle, bzLogo, bzName, bzLocale, numberOfFollowers,
  /// numberOfFlyers, bzContacts or the authorContacts or both.
  /// so do we just fetch by ID of we put all of those duplicates here ?
  /// i don't like these duplicates
  final String answererID;

  /// this should look like this [chatMaps]
  List<Map<String,Object>> chat;

  ChatDocument({
    this.askerID,
    this.answererID,
    this.chat,
});
}

/// see you can add countless amounts of attachments or keep the list empty,
/// a user can add a flyer from his saved flyers into the question while creating
/// the question
List<Map<String, Object>> attachmentsMaps = [
  {'type': 'image', 'attachment': 'link or reference to uploaded image from client device'},
  {'type': 'flyer', 'attachment': 'flyerID'}
];

/// if we do this right,, we can remove [bzWhatsAppIsOn]
///
/// the userID to know who from both asker & answerer added this entry to the chat Map
///
/// shayef elly 7asal fel attachments ezzay gowa el body fel chat ?,, i'm not sure about this
List<Map<String,Object>> chatMaps = [
  {'userID' : '', 'body' : 'how are you sir ?', 'timeStamp' : ''},
  {'userID' : '', 'body' : {'type': 'flyer', 'attachment': 'flyerID'}, 'timeStamp' : ''},
  {'userID' : '', 'body' : {'type': 'image', 'attachment': 'link or reference to uploaded image from client device'}, 'timeStamp' : ''},
  {'userID' : '', 'body' : 'tamam enta 3aml eh ?', 'timeStamp' : ''},
];