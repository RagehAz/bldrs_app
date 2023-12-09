import 'package:basics/bldrs_theme/classes/iconz.dart';
import 'package:basics/helpers/classes/strings/text_check.dart';
import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/b_bz/sub/author_model.dart';
import 'package:bldrs/a_models/e_notes/aa_note_parties_model.dart';
import 'package:bldrs/c_protocols/user_protocols/protocols/a_user_protocols.dart';
import 'package:basics/helpers/classes/maps/mapper.dart';
import 'package:basics/helpers/classes/strings/stringer.dart';

/// => TAMAM
class TopicModel {
  // -----------------------------------------------------------------------------
  const TopicModel({
    required this.id,
    required this.description,
    required this.icon,
  });
  // -----------------------------------------------------------------------------
  final String? id;
  final String? description;
  final String? icon;
  // -----------------------------------------------------------------------------

  /// CONSTANTS

  // --------------------
  /// USER TOPICS IDS
  static const String userGeneralNews = 'userGeneralNews';
  static const String userAuthorshipsInvitations = 'userAuthorshipsInvitations';
  static const String userReviewsReplies = 'userReviewsReplies';
  static const String userReviewsAgrees = 'userReviewsAgrees';
  static const String userSavedFlyersNewReviews = 'userSavedFlyersNewReviews';
  static const String userFollowedBzzNewFlyers= 'userFollowedBzzNewFlyers';
  static const String userSavedFlyersUpdates = 'userSavedFlyersUpdates';
  // --------------------
  /// BZZ TOPICS IDS
  static const String bzGeneralNews = 'bzGeneralNews';
  static const String bzVerifications = 'bzVerifications';
  static const String bzFlyersUpdates = 'bzFlyersUpdates';
  static const String bzAuthorshipsInvitations = 'bzAuthorshipsInvitations';
  static const String bzTeamRolesUpdates = 'bzTeamRolesUpdates';
  static const String bzTeamMembersExit = 'bzTeamMembersExit';
  static const String bzNewFollowers = 'bzNewFollowers';
  static const String bzFlyersNewReviews = 'bzFlyersNewReviews';
  static const String bzFlyersNewSaves = 'bzFlyersNewSaves';
  static const String bzFlyersNewShares = 'bzFlyersNewShares';
  // -----------------------------------------------------------------------------

    /// ALL EVENTS

  // --------------------
  /// TESTED : WORKS PERFECT
  static const Map<String, List<TopicModel>> userTopicMap = {
    // ------------------------------------------------
    'phid_general_notifications' : <TopicModel>[
      // --------------------
      /// GENERAL USER NOTES
      TopicModel(
        id: userGeneralNews,
        description: 'On Major news & general notifications',
        icon: Iconz.notification,
      ),
      // --------------------
      /// USER RECEIVE AUTHORSHIP =====================> SHOULD BE IN GENERAL W 5ALAS
      TopicModel(
        id: userAuthorshipsInvitations,
        description: 'A Business accounts invites me to join their team',
        icon: Iconz.handShake,
      ),
    ],
    // ------------------------------------------------
    'phid_flyers_Reviews_notifications' : <TopicModel>[
      // --------------------
      /// MY REVIEW RECEIVED REPLY
      TopicModel(
        id: userReviewsReplies,
        description: 'A review I wrote on a flyer receives a reply',
        icon: Iconz.balloonSpeaking,
      ),
      // --------------------
      /// MY REVIEW RECEIVED AGREE
      TopicModel(
        id: userReviewsAgrees,
        description: 'A review I wrote on a flyer gets an Agree',
        icon: Iconz.star,
      ),
      // --------------------
      /// A SAVED FLYER RECEIVED A NEW REVIEW
      TopicModel(
        id: userSavedFlyersNewReviews,
        description: 'A flyer I saved get a new review by other users',
        icon: Iconz.balloonSpeaking,
      ),
      // --------------------
    ],
    // ------------------------------------------------
    'phid_new_flyers_notifications' : <TopicModel>[
      // --------------------
      /// A FOLLOWED BZ PUBLISHED FLYER
      TopicModel(
        id: userFollowedBzzNewFlyers,
        description: 'A Business I follow publishes a new flyer',
        icon: Iconz.addFlyer,
      ),
      // --------------------
      /// A SAVED FLYER IS UPDATED
      TopicModel(
        id: userSavedFlyersUpdates,
        description: 'A flyer I saved gets updated',
        icon: Iconz.love,
      ),
      // --------------------
    ],
    // ------------------------------------------------
  };
  // --------------------
  /// TESTED : WORKS PERFECT
  static const Map<String, List<TopicModel>> bzTopicsMap = {
    // ------------------------------------------------
    'phid_general_notifications' : <TopicModel>[
      // --------------------
      /// GENERAL BZ NOTES
      TopicModel(
        id: bzGeneralNews,
        description: 'On General Business related notifications and Major news',
        icon: Iconz.notification,
      ),
      // --------------------
      /*
      /// MY BZ IS DELETED === MANDATORY
      TopicModel(
        id: 'myBzIsDeleted',
        description: 'My business account gets deleted',
      ),
       */
      // --------------------
    ],
    // ------------------------------------------------
    'phid_flyers_notifications' : <TopicModel>[
      // --------------------
      /// MY BZ FLYER IS VERIFIED
      TopicModel(
        id: bzVerifications,
        description: 'A flyer published by my business account gets verified',
        icon: Iconz.verifyFlyer,
      ),
      // --------------------
      /// MY BZ FLYER IS UPDATED
      TopicModel(
        id: bzFlyersUpdates,
        description: 'A flyer published by my business account gets updated by one of my team members',
        icon: Iconz.flyerScale,
      ),
      // --------------------
    ],
    // ------------------------------------------------
    'phid_team_notifications' : <TopicModel>[
      // --------------------
      /// A SENT AUTHORSHIP RECEIVED REPLY
      TopicModel(
        id: bzAuthorshipsInvitations,
        description: 'An invitation to join our team sent to someone receives a reply',
        icon: Iconz.handShake,
      ),
      // --------------------
      /// A TEAM MEMBER ROLE CHANGED
      TopicModel(
        id: bzTeamRolesUpdates,
        description: 'One of my team members gets his role changed',
        icon: Iconz.achievement,
      ),
      // --------------------
      /// A TEAM MEMBER EXITED
      TopicModel(
        id: bzTeamMembersExit,
        description: 'A team member exits this business account',
        icon: Iconz.exit,
      ),
      // --------------------
    ],
    // ------------------------------------------------
    'phid_user_engagement_notifications' : <TopicModel>[
      // --------------------
      /// A USER FOLLOWED MY BZ
      TopicModel(
        id: bzNewFollowers,
        description: 'A user follows my business account',
        icon: Iconz.follow,
      ),
      // --------------------
      /// A USER REVIEWED MY FLYER
      TopicModel(
        id: bzFlyersNewReviews,
        description: 'A user writes a review over one of my flyers',
        icon: Iconz.balloonSpeaking,
      ),
      // --------------------
      /// A USER SAVED MY FLYER
      TopicModel(
        id: bzFlyersNewSaves,
        description: 'A user saves one of my flyers',
        icon: Iconz.love,
      ),
      // --------------------
      /// A USER SHARED MY FLYER
      TopicModel(
        id: bzFlyersNewShares,
        description: 'A user shares one of my flyers',
        icon: Iconz.share,
      ),
      // --------------------
    ],
    // ------------------------------------------------
  };
  // -----------------------------------------------------------------------------

  /// GETTERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static Map<String, dynamic> getTopicsMapByPartyType(PartyType? type){

    if (type == PartyType.user){
      return TopicModel.userTopicMap;
    }
    else if (type == PartyType.bz){
      return TopicModel.bzTopicsMap;
    }
    else {
      return  {};
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<String> _getAllPossibleTopicsIDsByPartyType(PartyType partyType){

    final List<String> _topicsIDs = <String>[];

    if (partyType == PartyType.user || partyType == PartyType.bz){

      final Map<String, dynamic> _topicsMap = getTopicsMapByPartyType(partyType);

      final List<String> keys = _topicsMap.keys.toList();
      for (final String key in keys){
        final List<TopicModel> topicModels = _topicsMap[key];
        for (final TopicModel topicModel in topicModels){
          if (topicModel.id != null){
            _topicsIDs.add(topicModel.id!);
          }
        }
      }

    }


    return _topicsIDs;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<String> getAllPossibleUserTopicsIDs(){
    return _getAllPossibleTopicsIDsByPartyType(PartyType.user);
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<String> getAllPossibleBzTopicsIDs({
    required String? bzID,
  }){
    final List<String> _output = <String>[];

    if (bzID != null){

      final List<String> _allBzTopics = _getAllPossibleTopicsIDsByPartyType(PartyType.bz);

      for (final String rawTopic in _allBzTopics){

        final String _topicID = _generateBzTopicID(
          topicID: rawTopic,
          bzID: bzID,
        );

        _output.add(_topicID);

      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<String> getAllPossibleBzzTopicsIDs({
    required List<String> bzzIDs,
  }){
    final List<String> _output = <String>[];

    if (Mapper.checkCanLoopList(bzzIDs) == true){

      for (final String bzID in bzzIDs){

        final List<String> _bzTopics = getAllPossibleBzTopicsIDs(
          bzID: bzID,
        );

        _output.addAll(_bzTopics);

      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// TOPIC SUBSCRIBERS GETTERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<String>> getTopicSubscribersPics({
    required String? topicID,
    required List<dynamic>? receiversModels,
    required PartyType? receiversType,
  }) async {

    List<String> _output = <String>[];

    /// RECEIVERS BZZ
    if (receiversType == PartyType.bz){
      _output = await _getAuthorsPicsSubscribedToTopic(
        topicID: topicID,
        bzzModels: receiversModels as List<BzModel>,
      );
    }
    /// RECEIVERS USERS
    else {
      _output = await _getUsersPicsSubscribedToTopic(
        topicID: topicID,
        usersModels: receiversModels as List<UserModel>,
      );
    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<String>> _getAuthorsPicsSubscribedToTopic({
    required String? topicID,
    required List<BzModel>? bzzModels,
  }) async {
    final List<String> _output = <String>[];

    if (Mapper.checkCanLoopList(bzzModels) == true){

      for (final BzModel bz in bzzModels!){

        final String? _topicID = bakeTopicID(
            topicID: topicID,
            bzID: bz.id,
            receiverPartyType: PartyType.bz,
        );

        if (Mapper.checkCanLoopList(bz.authors) == true){

          for (final AuthorModel _author in bz.authors!) {
            final bool _isSubscribed = await _checkUserIsSubscribedToTopic(
              topicID: _topicID,
              userID: _author.userID,
            );

            if (_isSubscribed == true) {
              if (_author.picPath != null){
                _output.add(_author.picPath!);
              }
            }
          }

        }

      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<String>> _getUsersPicsSubscribedToTopic({
    required String? topicID,
    required List<UserModel> usersModels,
  }) async {
    final List<String> _output = <String>[];

    if (Mapper.checkCanLoopList(usersModels) == true){

      for (final UserModel user in usersModels){

        final bool _isSubscribed = await _checkUserIsSubscribedToTopic(
          topicID: topicID,
          userID: user.id,
        );

        if (_isSubscribed == true && user.picPath != null){
          _output.add(user.picPath!);
        }

      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> _checkUserIsSubscribedToTopic({
    required String? userID,
    required String? topicID,
  }) async {
  bool _subscribed = false;

  if (userID != null && topicID != null){

    final UserModel? _userModel = await UserProtocols.fetch(
      userID: userID,
    );

    _subscribed = Stringer.checkStringsContainString(
      strings: _userModel?.fcmTopics,
      string: topicID,
    );

  }

  return _subscribed;
  }
  // -----------------------------------------------------------------------------

  /// GENERATORS

  // --------------------
  /// TESTED : WORKS PERFECT
  static String _generateBzTopicID({
    required String? topicID,
    required String? bzID,
  }){

    assert(
    TextCheck.stringContainsSubString(string: topicID, subString: '_') == false,
    'topicID already has an underscore'
    );

    return '${bzID}_$topicID';
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String? bakeTopicID({
    required String? topicID,
    required String? bzID,
    required PartyType? receiverPartyType,
  }){
    String? _topicID = topicID;

    if (receiverPartyType == PartyType.bz){
      _topicID = _generateBzTopicID(
        topicID: topicID,
        bzID: bzID,
      );
    }

    return _topicID;
  }
  // -----------------------------------------------------------------------------

  /// CHECKERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkUserIsSubscribedToThisTopic({
    required PartyType? partyType,
    required String? topicID,
    required UserModel? userModel,
    required String? bzID,
  }){
    bool _isSubscribed = false;

    if (partyType != null && topicID != null && userModel != null){

      final List<String>? _userSubscribedTopics = userModel.fcmTopics;

      if (partyType == PartyType.bz){

        if (bzID != null){

          final String? _customTopicID = bakeTopicID(
            bzID: bzID,
            topicID: topicID,
            receiverPartyType: PartyType.bz,
          );

          _isSubscribed = Stringer.checkStringsContainString(
            strings: _userSubscribedTopics,
            string: _customTopicID,
          );

        }

      }

      if (partyType == PartyType.user){

        _isSubscribed = Stringer.checkStringsContainString(
          strings: _userSubscribedTopics,
          string: topicID,
        );

      }

    }

    return _isSubscribed;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkTopicIDIsBzTopic(String? topicID){
    return TextCheck.stringContainsSubString(string: topicID, subString: '_');
  }
  // -----------------------------------------------------------------------------

  /// GETTERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static List<String> getBzTopicsIDsFromTopics({
    required List<String> topics,
  }){
    final List<String> _output = <String>[];

    if (Mapper.checkCanLoopList(topics) == true){

      for (final String topic in topics){

        if (checkTopicIDIsBzTopic(topic) == true){
          _output.add(topic);
        }

      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<String> getTopicsIncludingBzIDFromTopics({
    required List<String>? topics,
    required String? bzID,
  }){
    final List<String> _output = <String>[];

    if (Mapper.checkCanLoopList(topics) == true && bzID != null){

      for (final String topic in topics!){

        final bool _contains = TextCheck.stringContainsSubString(
            string: topic,
            subString: bzID
        );

        if (_contains == true){
          _output.add(topic);
        }

      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<String> getUserTopicsFromTopics({
    required List<String>? topics,
  }){
    final List<String> _output = <String>[];

    if (Mapper.checkCanLoopList(topics) == true){

      final List<String> _userPossibleTopics = getAllPossibleUserTopicsIDs();

      for (final String topic in topics!){

        final bool _contains = Stringer.checkStringsContainString(
            strings: _userPossibleTopics,
            string: topic,
        );

        if (_contains == true){
          _output.add(topic);
        }

      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------
}
