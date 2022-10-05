import 'package:flutter/material.dart';

enum Channel {
  bulletin,
  myReviews,
  savedFlyers,
  newFlyers,
  myBzzFlyers,
  myBzzTeams,
  myBzzFollowers,
  myBzzFlyersEngagement,
  myBzzBulletin,
}

class ChannelModel {
  // -----------------------------------------------------------------------------
  const ChannelModel({
    @required this.id,
    @required this.name,
    @required this.description,
    @required this.group,
  });
  // --------------------
  final String id;
  final String name;
  final String description;
  final String group;
  // -----------------------------------------------------------------------------

  /// CONSTANTS

  // --------------------
  static const String bulletinChannelID = 'com.bldrs.net.urgent'; //'bulletin';
  // --------------------
  static const String myReviewsChannelID = 'myReviews';
  static const String savedFlyersChannelID = 'savedFlyers';
  static const String newFlyersChannelID = 'newFlyers';
  // --------------------
  static const String myBzzFlyersChannelID = 'myBzzFlyers';
  static const String myBzzTeamsChannelID = 'myBzzTeams';
  static const String myBzzFollowersChannelID = 'myBzzFollowers';
  static const String myBzzFlyersEngagementChannelID = 'myBzzFlyersEngagement';
  static const String myBzzBulletinChannelID = 'MyBzzBulletin';
  // -----------------------------------------------------------------------------
  static const String generalGroup = 'General';
  static const String flyersGroup = 'Flyers';
  static const String myBzzGroup = 'My Business';
  // -----------------------------------------------------------------------------
  static const List<ChannelModel> bldrsChannels = <ChannelModel>[
    // ------------------------------------------------
    /// BULLETIN
    ChannelModel(
      id: bulletinChannelID,
      name: 'Bulletin',
      description: 'Major news & general notifications',
      group: generalGroup,
    ),
    // ------------------------------------------------
    /// MY REVIEWS
    ChannelModel(
      id: myReviewsChannelID,
      name: 'My reviews',
      description: 'Interactions over my submitted reviews',
      group: flyersGroup,
    ),
    // --------------------
    /// MY SAVED FLYERS
    ChannelModel(
      id: savedFlyersChannelID,
      name: 'My saved flyers',
      description: 'News about the flyers I saved',
      group: flyersGroup,
    ),
    // --------------------
    /// NEW PUBLISHED FLYERS
    ChannelModel(
      id: newFlyersChannelID,
      name: 'New published flyers',
      description: 'News about flyers published by businesses I follow',
      group: flyersGroup,
    ),
    // ------------------------------------------------
    /// MY BUSINESS BULLETIN
    ChannelModel(
      id: myBzzBulletinChannelID,
      name: 'My Business Bulletin',
      description: 'General news & statistics about my business account',
      group: myBzzGroup,
    ),
    // --------------------
    /// MY BUSINESS ACCOUNT FLYERS
    ChannelModel(
      id: myBzzFlyersChannelID,
      name: 'My Business account flyers',
      description: 'News about flyers published by my business accounts',
      group: myBzzGroup,
    ),
    // --------------------
    /// MY BUSINESS ACCOUNT TEAM
    ChannelModel(
      id: myBzzTeamsChannelID,
      name: 'My Business account team',
      description: 'News about the team members of my business account',
      group: myBzzGroup,
    ),
    // --------------------
    /// MY BUSINESS ACCOUNT FOLLOWERS
    ChannelModel(
      id: myBzzFollowersChannelID,
      name: 'My Business account followers',
      description: 'News about new users following my Business account',
      group: myBzzGroup,
    ),
    // --------------------
    /// MY BUSINESS FLYERS ENGAGEMENT
    ChannelModel(
      id: myBzzFlyersEngagementChannelID,
      name: 'My Business flyers engagements',
      description: 'News about users saving, sharing & revewing my flyers',
      group: myBzzGroup,
    ),
    // ------------------------------------------------

  ];
  // -----------------------------------------------------------------------------

  // -----------------------------------------------------------------------------

  /// GETTERS

  // --------------------
  static String getChannelID(Channel channel){
    switch (channel){
      case Channel.bulletin:                return bulletinChannelID;               break;
      case Channel.myReviews :              return myReviewsChannelID;              break;
      case Channel.savedFlyers :            return savedFlyersChannelID;            break;
      case Channel.newFlyers :              return newFlyersChannelID;              break;
      case Channel.myBzzFlyers :            return myBzzFlyersChannelID;            break;
      case Channel.myBzzTeams :             return myBzzTeamsChannelID;             break;
      case Channel.myBzzFollowers :         return myBzzFollowersChannelID;         break;
      case Channel.myBzzFlyersEngagement :  return myBzzFlyersEngagementChannelID;  break;
      case Channel.myBzzBulletin :          return myBzzBulletinChannelID;          break;
      default: return bulletinChannelID;
    }
  }
  // --------------------
  static ChannelModel getChannelModel(Channel channel){
    final String _channelID = getChannelID(channel);
    final ChannelModel _model = bldrsChannels.singleWhere(
            (model) => model.id == _channelID, orElse: ()=> null
    );

    return _model;
  }
  // --------------------
}
