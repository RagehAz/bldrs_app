import 'package:bldrs/a_models/e_notes/c_channel_model.dart';

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
// --------------------
const String bulletinChannelID = 'bulletin';
const String myReviewsChannelID = 'myReviews';
const String savedFlyersChannelID = 'savedFlyers';
const String newFlyersChannelID = 'newFlyers';
// --------------------
const String myBzzFlyersChannelID = 'myBzzFlyers';
const String myBzzTeamsChannelID = 'myBzzTeams';
const String myBzzFollowersChannelID = 'myBzzFollowers';
const String myBzzFlyersEngagementChannelID = 'myBzzFlyersEngagement';
const String myBzzBulletinChannelID = 'MyBzzBulletin';
// -----------------------------------------------------------------------------
const String generalGroup = 'General';
const String flyersGroup = 'Flyers';
const String myBzzGroup = 'My Business';
// -----------------------------------------------------------------------------
const List<ChannelModel> bldrsChannels = <ChannelModel>[
  // ------------------------------------------------
  /// BULLETIN
  ChannelModel(
    id: bulletinChannelID,
    name: 'Bulletin',
    description: 'Major news & general notifications',
    group: generalGroup,
    // channel: Channel.bulletin,
  ),
  // ------------------------------------------------
  /// MY REVIEWS
  ChannelModel(
    id: myReviewsChannelID,
    name: 'My reviews',
    description: 'Interactions over my submitted reviews',
    group: flyersGroup,
    // channel: Channel.myReviews,
  ),
  // --------------------
  /// MY SAVED FLYERS
  ChannelModel(
    id: savedFlyersChannelID,
    name: 'My saved flyers',
    description: 'News about the flyers I saved',
    group: flyersGroup,
    // channel: Channel.savedFlyers,
  ),
  // --------------------
  /// NEW PUBLISHED FLYERS
  ChannelModel(
    id: newFlyersChannelID,
    name: 'New published flyers',
    description: 'News about flyers published by businesses I follow',
    group: flyersGroup,
    // channel: Channel.newFlyers,
  ),
  // ------------------------------------------------
  /// MY BUSINESS BULLETIN
  ChannelModel(
    id: myBzzBulletinChannelID,
    name: 'My Business Bulletin',
    description: 'General news & statistics about my business account',
    group: myBzzGroup,
    // channel: Channel.myBzzBulletin,
  ),
  // --------------------
  /// MY BUSINESS ACCOUNT FLYERS
  ChannelModel(
    id: myBzzFlyersChannelID,
    name: 'My Business account flyers',
    description: 'News about flyers published by my business accounts',
    group: myBzzGroup,
    // channel: Channel.myBzzFlyers,
  ),
  // --------------------
  /// MY BUSINESS ACCOUNT TEAM
  ChannelModel(
    id: myBzzTeamsChannelID,
    name: 'My Business account team',
    description: 'News about the team members of my business account',
    group: myBzzGroup,
    // channel: Channel.myBzzTeams,
  ),
  // --------------------
  /// MY BUSINESS ACCOUNT FOLLOWERS
  ChannelModel(
    id: myBzzFollowersChannelID,
    name: 'My Business account followers',
    description: 'News about new users following my Business account',
    group: myBzzGroup,
    // channel: Channel.myBzzFollowers,
  ),
  // --------------------
  /// MY BUSINESS FLYERS ENGAGEMENT
  ChannelModel(
    id: myBzzFlyersEngagementChannelID,
    name: 'My Business flyers engagements',
    description: 'News about users saving, sharing & revewing my flyers',
    group: myBzzGroup,
    // channel: Channel.myBzzFlyersEngagement,
  ),
  // ------------------------------------------------

];
// -----------------------------------------------------------------------------

/*
  /// GETTERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static String getChannelID(Channel channel){
    switch (channel){
      case Channel.bulletin:                return bldrsChannelID;               break;
      case Channel.myReviews :              return myReviewsChannelID;              break;
      case Channel.savedFlyers :            return savedFlyersChannelID;            break;
      case Channel.newFlyers :              return newFlyersChannelID;              break;
      case Channel.myBzzFlyers :            return myBzzFlyersChannelID;            break;
      case Channel.myBzzTeams :             return myBzzTeamsChannelID;             break;
      case Channel.myBzzFollowers :         return myBzzFollowersChannelID;         break;
      case Channel.myBzzFlyersEngagement :  return myBzzFlyersEngagementChannelID;  break;
      case Channel.myBzzBulletin :          return myBzzBulletinChannelID;          break;
      default: return bldrsChannelID;
    }
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static ChannelModel getChannelModel(Channel channel){
    final String _channelID = getChannelID(channel);
    final ChannelModel _model = bldrsChannels.singleWhere(
            (model) => model.id == _channelID, orElse: ()=> null
    );

    return _model;
  }
   */
// -----------------------------------------------------------------------------
