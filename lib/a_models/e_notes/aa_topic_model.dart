import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/a_models/b_bz/sub/author_model.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/e_notes/aa_note_parties_model.dart';
import 'package:bldrs/c_protocols/user_protocols/a_user_protocols.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/stringers.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:flutter/material.dart';

class TopicModel {
  // -----------------------------------------------------------------------------
  const TopicModel({
    @required this.id,
    @required this.description,
    @required this.icon,
  });
  // -----------------------------------------------------------------------------
  final String id;
  final String description;
  final String icon;
  // -----------------------------------------------------------------------------

  /// CONSTANTS

  // --------------------
  /// USER TOPICS IDS
  static const String generalUserNotes = 'generalUserNotes';
  static const String bzInvitations = 'bzInvitations';
  static const String myReviewReceivedReply = 'myReviewReceivedReply';
  static const String myReviewReceivedAgree = 'myReviewReceivedAgree';
  static const String aSavedFlyerReceivedANewReview = 'aSavedFlyerReceivedANewReview';
  static const String aFollowedBzPublishedFlyer= 'aFollowedBzPublishedFlyer';
  static const String aSavedFlyerIsUpdated = 'aSavedFlyerIsUpdated';
  // --------------------
  /// BZZ TOPICS IDS
  static const String generalBzNotes = 'generalBzNotes';
  static const String myBzFlyerIsVerified = 'myBzFlyerIsVerified';
  static const String myBzFlyerIsUpdated = 'myBzFlyerIsUpdated';
  static const String aSentAuthorshipReceivedReply = 'aSentAuthorshipReceivedReply';
  static const String aTeamMemberRoleChanged = 'aTeamMemberRoleChanged';
  static const String aTeamMemberExited = 'aTeamMemberExited';
  static const String aUserFollowedMyBz = 'aUserFollowedMyBz';
  static const String aUserReviewedMyFlyer = 'aUserReviewedMyFlyer';
  static const String aUserSavedMyFlyer = 'aUserSavedMyFlyer';
  static const String aUserSharedMyFlyer = 'aUserSharedMyFlyer';
  // -----------------------------------------------------------------------------

    /// ALL EVENTS

  // --------------------
  static const Map<String, List<TopicModel>> userTopicMap = {
    // ------------------------------------------------
    'General' : <TopicModel>[
      // --------------------
      /// GENERAL USER NOTES
      TopicModel(
        id: generalUserNotes,
        description: 'On Major news & general notifications',
        icon: Iconz.notification,
      ),
      // --------------------
      /// USER RECEIVE AUTHORSHIP =====================> SHOULD BE IN GENERAL W 5ALAS
      TopicModel(
        id: bzInvitations,
        description: 'A Business accounts invites me to join their team',
        icon: Iconz.handShake,
      ),
    ],
    // ------------------------------------------------
    'Flyers Reviews' : <TopicModel>[
      // --------------------
      /// MY REVIEW RECEIVED REPLY
      TopicModel(
        id: myReviewReceivedReply,
        description: 'A review I wrote on a flyer receives a reply',
        icon: Iconz.balloonSpeaking,
      ),
      // --------------------
      /// MY REVIEW RECEIVED AGREE
      TopicModel(
        id: myReviewReceivedAgree,
        description: 'A review I wrote on a flyer gets an Agree',
        icon: Iconz.star,
      ),
      // --------------------
      /// A SAVED FLYER RECEIVED A NEW REVIEW
      TopicModel(
        id: aSavedFlyerReceivedANewReview,
        description: 'A flyer I saved get a new review by other users',
        icon: Iconz.balloonSpeaking,
      ),
      // --------------------
    ],
    // ------------------------------------------------
    'New flyers' : <TopicModel>[
      // --------------------
      /// A FOLLOWED BZ PUBLISHED FLYER
      TopicModel(
        id: aFollowedBzPublishedFlyer,
        description: 'A Business I follow publishes a new flyer',
        icon: Iconz.addFlyer,
      ),
      // --------------------
      /// A SAVED FLYER IS UPDATED
      TopicModel(
        id: aSavedFlyerIsUpdated,
        description: 'A flyer I saved gets updated',
        icon: Iconz.savedFlyers,
      ),
      // --------------------
    ],
    // ------------------------------------------------
  };
  // --------------------
  static const Map<String, List<TopicModel>> bzTopicsMap = {
    // ------------------------------------------------
    'General' : <TopicModel>[
      // --------------------
      /// GENERAL BZ NOTES
      TopicModel(
        id: generalBzNotes,
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
    'Flyers' : <TopicModel>[
      // --------------------
      /// MY BZ FLYER IS VERIFIED
      TopicModel(
        id: myBzFlyerIsVerified,
        description: 'A flyer published by my business account gets verified',
        icon: Iconz.verifyFlyer,
      ),
      // --------------------
      /// MY BZ FLYER IS UPDATED
      TopicModel(
        id: myBzFlyerIsUpdated,
        description: 'A flyer published by my business account gets updated by one of my team members',
        icon: Iconz.flyerScale,
      ),
      // --------------------
    ],
    // ------------------------------------------------
    'Team' : <TopicModel>[
      // --------------------
      /// A SENT AUTHORSHIP RECEIVED REPLY
      TopicModel(
        id: aSentAuthorshipReceivedReply,
        description: 'An invitation to join our team sent to someone receives a reply',
        icon: Iconz.handShake,
      ),
      // --------------------
      /// A TEAM MEMBER ROLE CHANGED
      TopicModel(
        id: aTeamMemberRoleChanged,
        description: 'One of my team members gets his role changed',
        icon: Iconz.achievement,
      ),
      // --------------------
      /// A TEAM MEMBER EXITED
      TopicModel(
        id: aTeamMemberExited,
        description: 'A team member exits this business account',
        icon: Iconz.exit,
      ),
      // --------------------
    ],
    // ------------------------------------------------
    'Users Engagement' : <TopicModel>[
      // --------------------
      /// A USER FOLLOWED MY BZ
      TopicModel(
        id: aUserFollowedMyBz,
        description: 'A user follows my business account',
        icon: Iconz.follow,
      ),
      // --------------------
      /// A USER REVIEWED MY FLYER
      TopicModel(
        id: aUserReviewedMyFlyer,
        description: 'A user writes a review over one of my flyers',
        icon: Iconz.balloonSpeaking,
      ),
      // --------------------
      /// A USER SAVED MY FLYER
      TopicModel(
        id: aUserSavedMyFlyer,
        description: 'A user saves one of my flyers',
        icon: Iconz.save,
      ),
      // --------------------
      /// A USER SHARED MY FLYER
      TopicModel(
        id: aUserSharedMyFlyer,
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
  static Map<String, dynamic> getTopicsMapByPartyType(PartyType type){

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
  ///
  static List<String> _getAllTopicsIDsByPartyType(PartyType partyType){

    final List<String> _topicsIDs = <String>[];

    if (partyType == PartyType.user || partyType == PartyType.bz){

      final Map<String, dynamic> _topicsMap = getTopicsMapByPartyType(partyType);

      final List<String> keys = _topicsMap.keys.toList();
      for (final String key in keys){
        final List<TopicModel> topicModels = _topicsMap[key];
        for (final TopicModel topicModel in topicModels){
          _topicsIDs.add(topicModel.id);
        }
      }

    }


    return _topicsIDs;
  }
  // --------------------
  ///
  static List<String> getAllUserTopics(){
    return _getAllTopicsIDsByPartyType(PartyType.user);
  }
  // --------------------
  ///
  static List<String> getAllBzTopics({
    @required String bzID,
  }){
    final List<String> _output = <String>[];

    if (bzID != null){

      final List<String> _allBzTopics = _getAllTopicsIDsByPartyType(PartyType.bz);

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
  ///
  static List<String> getAllBzzTopics({
    @required List<String> bzzIDs,
  }){
    final List<String> _output = <String>[];

    if (Mapper.checkCanLoopList(bzzIDs) == true){

      for (final String bzID in bzzIDs){

        final List<String> _bzTopics = getAllBzTopics(
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
    @required BuildContext context,
    @required String topicID,
    @required List<dynamic> receiversModels,
    @required PartyType receiversType,
  }) async {

    List<String> _output = <String>[];

    /// RECEIVERS BZZ
    if (receiversType == PartyType.bz){
      _output = await _getAuthorsPicsSubscribedToTopic(
        context: context,
        topicID: topicID,
        bzzModels: receiversModels,
      );
    }
    /// RECEIVERS USERS
    else {
      _output = await _getUsersPicsSubscribedToTopic(
        context: context,
        topicID: topicID,
        usersModels: receiversModels,
      );
    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<String>> _getAuthorsPicsSubscribedToTopic({
    @required BuildContext context,
    @required String topicID,
    @required List<BzModel> bzzModels,
  }) async {
    final List<String> _output = <String>[];

    if (Mapper.checkCanLoopList(bzzModels) == true){

      for (final BzModel bz in bzzModels){

        final String _topicID = bakeTopicID(
            topicID: topicID,
            bzID: bz.id,
            partyType: PartyType.bz,
        );

        for (final AuthorModel _author in bz.authors){

          final bool _isSubscribed = await _checkUserIsSubscribedToTopic(
            context: context,
            topicID: _topicID,
            userID: _author.userID,
          );

          if (_isSubscribed == true){
            _output.add(_author.pic);
          }


        }


      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<String>> _getUsersPicsSubscribedToTopic({
    @required BuildContext context,
    @required String topicID,
    @required List<UserModel> usersModels,
  }) async {
    final List<String> _output = <String>[];

    if (Mapper.checkCanLoopList(usersModels) == true){

      for (final UserModel user in usersModels){

        final bool _isSubscribed = await _checkUserIsSubscribedToTopic(
          context: context,
          topicID: topicID,
          userID: user.id,
        );

        if (_isSubscribed == true){
          _output.add(user.pic);
        }

      }

    }

    return _output;
  }
  // --------------------
  ///
  static Future<bool> _checkUserIsSubscribedToTopic({
    @required BuildContext context,
    @required String userID,
    @required String topicID,
  }) async {
  bool _subscribed = false;

  if (userID != null && topicID != null){

    final UserModel _userModel = await UserProtocols.fetchUser(
      context: context,
      userID: userID,
    );

    final bool _isBlocked = Stringer.checkStringsContainString(
      strings: _userModel?.blockedTopics,
      string: topicID,
    );

    _subscribed = !_isBlocked;

  }

  return _subscribed;
  }
  // -----------------------------------------------------------------------------

  /// GENERATORS

  // --------------------
  /// TESTED : WORKS PERFECT
  static String _generateBzTopicID({
    @required String topicID,
    @required String bzID,
  }){
    return '${bzID}_$topicID';
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String bakeTopicID({
    @required String topicID,
    @required String bzID,
    @required PartyType partyType,
  }){
    String _topicID = topicID;

    if (partyType == PartyType.bz){
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
  ///
  static bool checkUserIsSubscribedToThisTopic({
    @required PartyType partyType,
    @required BuildContext context,
    @required String topicID,
    @required UserModel userModel,
    @required String bzID,
  }){
    bool _isSubscribed = false;

    if (partyType != null && topicID != null && userModel != null){

      final List<String> _userBlockedTopics = userModel.blockedTopics;

      if (partyType == PartyType.bz){

        if (bzID != null){

          final String _customTopicID = bakeTopicID(
            bzID: bzID,
            topicID: topicID,
            partyType: PartyType.bz,
          );

          final bool _isBlocked = Stringer.checkStringsContainString(
            strings: _userBlockedTopics,
            string: _customTopicID,
          );

          _isSubscribed = !_isBlocked;
        }

      }

      if (partyType == PartyType.user){

        final bool _isBlocked = Stringer.checkStringsContainString(
          strings: _userBlockedTopics,
          string: topicID,
        );

        _isSubscribed = !_isBlocked;

      }

    }

    return _isSubscribed;
  }
  // -----------------------------------------------------------------------------
}

/*
  // -----------------------------------------------------------------------------

  /// TOPICS

  // --------------------
  /// TESTED : WORKS PERFECT
  static String generateTopic({
    @required TopicType topicType,
    @required String id,
  }){
    return '${topicType}_$id';
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<TopicType> getAllBzzTopics(){
    return <TopicType>[
      TopicType.flyerVerification, // 'flyerVerification/bzID/'
      TopicType.flyerUpdate, // 'flyerUpdate/bzID/'
      TopicType.authorshipReply, // 'authorshipAcceptance/bzID/'
      TopicType.authorRoleChanged, // 'authorRoleChanged/bzID/'
      TopicType.authorDeletion, // 'authorDeletion/bzID/'
      TopicType.generalBzNotes, // 'generalBzNotes/bzID/'
    ];
  }
 */
