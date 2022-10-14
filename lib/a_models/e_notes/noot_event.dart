import 'package:bldrs/a_models/e_notes/aa_note_parties_model.dart';
import 'package:flutter/material.dart';

class NootEvent {
  // -----------------------------------------------------------------------------
  const NootEvent({
    @required this.id,
    @required this.description,
  });
  // -----------------------------------------------------------------------------
  final String id;
  final String description;
  // -----------------------------------------------------------------------------

    /// ALL EVENTS

  // --------------------
  static const Map<String, List<NootEvent>> userEventsMap = {
    // ------------------------------------------------
    'General' : <NootEvent>[
      // --------------------
      /// GENERAL USER NOTES
      NootEvent(
        id: 'generalUserNotes',
        description: 'General notifications and major news',
      ),
      // --------------------
      /// USER RECEIVE AUTHORSHIP =====================> SHOULD BE IN GENERAL W 5ALAS
      NootEvent(
        id: 'userReceiveAuthorshipRequest',
        description: 'A user received business authorship request',
      ),
    ],
    // ------------------------------------------------
    'Flyers Reviews' : <NootEvent>[
      // --------------------
      /// MY REVIEW RECEIVED REPLY
      NootEvent(
        id: 'myReviewReceivedReply',
        description: 'My review received a reply',
      ),
      // --------------------
      /// MY REVIEW RECEIVED AGREE
      NootEvent(
        id: 'myReviewReceivedAgree',
        description: 'My review received an Agree',
      ),
      // --------------------
      /// A SAVED FLYER RECEIVED A NEW REVIEW
      NootEvent(
        id: 'aSavedFlyerReceivedANewReview',
        description: 'A saved flyer received a new review',
      ),
      // --------------------
    ],
    // ------------------------------------------------
    'New flyers' : <NootEvent>[
      // --------------------
      /// A FOLLOWED BZ PUBLISHED FLYER
      NootEvent(
          id: 'aFollowedBzPublishedFlyer',
          description: 'A Business I follow published a new flyer'
      ),
      // --------------------
      /// A SAVED FLYER IS UPDATED
      NootEvent(
          id: 'aSavedFlyerIsUpdated',
          description: 'A saved flyer is updated'
      ),
      // --------------------
    ],
    // ------------------------------------------------
  };
  // --------------------
  static const Map<String, List<NootEvent>> bzEventsMap = {
    // ------------------------------------------------
    'General' : <NootEvent>[
      // --------------------
      /// GENERAL BZ NOTES
      NootEvent(
        id: 'generalBzNotes',
        description: 'General Business related notifications and major news',
      ),
      // --------------------
      /// MY BZ IS DELETED === MANDATORY
      NootEvent(
        id: 'myBzIsDeleted',
        description: 'My business account is deleted',
      ),
      // --------------------
    ],
    // ------------------------------------------------
    'Flyers' : <NootEvent>[
      // --------------------
      /// MY BZ FLYER IS VERIFIED
      NootEvent(
        id: 'myBzFlyerIsVerified',
        description: 'A flyer published by my business account is verified',
      ),
      // --------------------
      /// MY BZ FLYER IS UPDATED
      NootEvent(
          id: 'myBzFlyerIsUpdated',
          description: 'A flyer published by my business account is updated'
      ),
      // --------------------
    ],
    // ------------------------------------------------
    'Team' : <NootEvent>[
      // --------------------
      /// A SENT AUTHORSHIP RECEIVED REPLY
      NootEvent(
        id: 'aSentAuthorshipReceivedReply',
        description: 'A sent authorship request has received a reply',
      ),
      // --------------------
      /// A TEAM MEMBER ROLE CHANGED
      NootEvent(
        id: 'aTeamMemberRoleChanged',
        description: 'A team member role has changed',
      ),
      // --------------------
      /// A TEAM MEMBER EXITED
      NootEvent(
        id: 'aTeamMemberExited',
        description: 'A team member has exited the business account',
      ),
      // --------------------
    ],
    // ------------------------------------------------
    'Users Engagement' : <NootEvent>[
      // --------------------
      /// A USER FOLLOWED MY BZ
      NootEvent(
        id: 'aUserFollowedMyBz',
        description: 'A user followed my business account',
      ),
      // --------------------
      /// A USER REVIEWED MY FLYER
      NootEvent(
        id: 'aUserReviewedMyFlyer',
        description: 'A user reviewed my flyer',
      ),
      // --------------------
      /// A USER SAVED MY FLYER
      NootEvent(
        id: 'aUserSavedMyFlyer',
        description: 'A user saved my flyer',
      ),
      // --------------------
      /// A USER SHARED MY FLYER
      NootEvent(
        id: 'aUserSharedMyFlyer',
        description: 'A user shared my flyer',
      ),
      // --------------------
    ],
    // ------------------------------------------------
  };
  // -----------------------------------------------------------------------------

  /// GETTERS

  // --------------------
  static Map<String, dynamic> getEventsMapByPartyType(PartyType type){

    if (type == PartyType.user){
      return NootEvent.userEventsMap;
    }
    else if (type == PartyType.bz){
      return NootEvent.bzEventsMap;
    }
    else {
      return  {};
    }

  }



  // -----------------------------------------------------------------------------
}
