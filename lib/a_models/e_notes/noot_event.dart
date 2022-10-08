import 'package:bldrs/a_models/e_notes/c_channel_model.dart';
import 'package:flutter/material.dart';

class NootEvent {

  const NootEvent({
    @required this.id,
    @required this.channelID,
    @required this.description,
  });

  final String id;
  final String channelID;
  final String description;

  static const List<NootEvent> allEvent = <NootEvent>[
    // ------------------------------------------------
    /// GENERAL
    NootEvent(
      id: 'generalNotification',
      channelID: ChannelModel.bulletinChannelID,
      description: 'General notifications, news & bulletins',
    ),
    // ------------------------------------------------
    /// USER RECEIVE AUTHORSHIP
    NootEvent(
      id: 'userReceiveAuthorshipRequest',
      channelID: ChannelModel.bulletinChannelID,
      description: 'A user receives business authorship request',
    ),
    // ------------------------------------------------
    /// MY REVIEW RECEIVED REPLY
    NootEvent(
      id: 'myReviewReceivedReply',
      channelID: ChannelModel.myReviewsChannelID,
      description: 'My review received a reply',
    ),
    // --------------------
    /// MY REVIEW RECEIVED AGREE
    NootEvent(
      id: 'myReviewReceivedAgree',
      channelID: ChannelModel.myReviewsChannelID,
      description: 'My review received an Agree',
    ),
    // ------------------------------------------------
    /// A SAVED FLYER RECEIVED A NEW REVIEW
    NootEvent(
      id: 'aSavedFlyerReceivedANewReview',
      channelID: ChannelModel.savedFlyersChannelID,
      description: 'A saved flyer received a new review',
    ),
    // --------------------
    /// A SAVED FLYER IS UPDATED
    NootEvent(
      id: 'aSavedFlyerIsUpdated',
      channelID: ChannelModel.savedFlyersChannelID,
      description: 'A saved flyer is updated'
    ),
    // ------------------------------------------------
    /// A FOLLOWED BZ PUBLISHED FLYER
    NootEvent(
      id: 'aFollowedBzPublishedFlyer',
      channelID: ChannelModel.newFlyersChannelID,
      description: 'A Business I follow published a new flyer'
    ),
    // ------------------------------------------------
    /// MY BZ FLYER IS VERIFIED
    NootEvent(
      id: 'myBzFlyerIsVerified',
      channelID: ChannelModel.myBzzFlyersChannelID,
      description: 'A flyer published by my business account is verified',
    ),
    // --------------------
    /// MY BZ FLYER IS UPDATED
    NootEvent(
      id: 'myBzFlyerIsUpdated',
      channelID: ChannelModel.myBzzFlyersChannelID,
      description: 'A flyer published by my business account is updated'
    ),
    // ------------------------------------------------
    /// A SENT AUTHORSHIP RECEIVED REPLY
    NootEvent(
      id: 'aSentAuthorshipReceivedReply',
      channelID: ChannelModel.myBzzTeamsChannelID,
      description: 'A sent authorship request has received a reply',
    ),
    // --------------------
    /// A TEAM MEMBER ROLE CHANGED
    NootEvent(
      id: 'aTeamMemberRoleChanged',
      channelID: ChannelModel.myBzzTeamsChannelID,
      description: 'A team member role has changed',
    ),
    // --------------------
    /// A TEAM MEMBER EXITED
    NootEvent(
      id: 'aTeamMemberExited',
      channelID: ChannelModel.myBzzTeamsChannelID,
      description: 'A team member has exited the business account',
    ),
    // ------------------------------------------------
    /// A USER FOLLOWED MY BZ
    NootEvent(
      id: 'aUserFollowedMyBz',
      channelID: ChannelModel.myBzzFollowersChannelID,
      description: 'A user followed my business account',
    ),
    // ------------------------------------------------
    /// A USER REVIEWED MY FLYER
    NootEvent(
      id: 'aUserReviewedMyFlyer',
      channelID: ChannelModel.myBzzFlyersEngagementChannelID,
      description: 'A user reviewed my flyer',
    ),
    /// A USER SAVED MY FLYER
    NootEvent(
      id: 'aUserSavedMyFlyer',
      channelID: ChannelModel.myBzzFlyersEngagementChannelID,
      description: 'A user saved my flyer',
    ),
    /// A USER SHARED MY FLYER
    NootEvent(
      id: 'aUserSharedMyFlyer',
      channelID: ChannelModel.myBzzFlyersEngagementChannelID,
      description: 'A user shared my flyer',
    ),
    // ------------------------------------------------
    /// MY BZ IS DELETED
    NootEvent(
      id: 'myBzIsDeleted',
      channelID: ChannelModel.bulletinChannelID,
      description: 'My business account is deleted',
    ),
    // ------------------------------------------------
  ];

}
