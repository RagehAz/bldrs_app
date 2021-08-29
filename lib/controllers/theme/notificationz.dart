import 'package:bldrs/models/notification/noti_model.dart';
import 'package:bldrs/models/notification/noti_content.dart';

// -----------------------------------------------------------------------------
/// BLDRS.NET notifications classification
// ------------------------------------------
/// SAMPLE : N - TIMING : REASON : CONDITION : TITLE : HOUR
// ------------------------------------------
/// REASONS : ad - event - reminder
// ------------------------------------------
///
// AUTO NOTIFICATIONS
/// A - AUTOMATIC NOTIFICATIONS
/// ============================
/// * - BLDRS.NET --> to group
///
///     o - to USER
///         N -
///         N -
/// -------------------
///     o - to AUTHOR
///         N -
///         N -
/// -------------------
///     o - to ALL
///         N -
///         N -
///
/// ----------------------------
/// * - BLDRS.NET --> to individual
///
///     o - to USER
///         N - [buildSomething]
///         N -
/// -------------------
///     o - to AUTHOR
///         N -
///         N -
/// -------------------
///     o - to ANY
///         N -
///         N -
///
// ------------------------------
///
// MANUAL NOTIFICATIONS
/// B - MANUAL NOTIFICATIONS
/// ============================
/// * - BLDRS.NET --> to group
///
///     o - to USER
///         N -
///         N -
/// -------------------
///     o - to AUTHOR
///         N -
///         N -
/// -------------------
///     o - to ALL
///         N -
///         N -
///
/// ----------------------------
/// * - BLDRS.NET --> to individual
///
///     o - to USER
///         N -
///         N -
/// -------------------
///     o - to AUTHOR
///         N -
///         N -
/// -------------------
///     o - to ANY
///         N -
///         N -
///
// -----------------------------------------------------------------------------

class Notificationz {

  static String notiSound = 'default';
  static String notiStatus = 'done';

  static dynamic notiDefaultMap = {
    "click_action": "FLUTTER_NOTIFICATION_CLICK",
    "sound": notiSound,
    "status": notiStatus,
    "screen": "",
  };
// -----------------------------------------------------------------------------
  /// 1 - 28 days reminder
  static NotiModel buildSomething(){
    return
      NotiModel(
        reason: NotiReason.reminder,
        timing: 'when user did not sign in for 4 weeks',
        Condition: 'last sign in timeStamp > 28 days',
        dayHour: "asPerDays : 9 pm",
        reciever: NotiReciever.user,
        cityState: CityState.public,
        notiContent: NotiContent(
            title: 'Build Something',
            body: 'Bldrs.net'
        ),
        metaData: notiDefaultMap,
        autoFire: true,
      );
  }
// -----------------------------------------------------------------------------
  /// 2 - 35 days reminder
  static NotiModel createSomethingNew(){
    return
      NotiModel(
        reason: NotiReason.reminder,
        timing: 'when user did not sign in for a 5 weeks',
        Condition: 'last sign in timeStamp > 35 days',
        dayHour: "asPerDays : 10 am",
        reciever: NotiReciever.user,
        cityState: CityState.public,
        notiContent: NotiContent(
            title: 'Create Something new',
            body: 'Bldrs.net'
        ),
        metaData: notiDefaultMap,
        autoFire: true,
      );
  }
// -----------------------------------------------------------------------------
  /// 3 - 42 days reminder
  static NotiModel planYourFuture(){
    return
      NotiModel(
        reason: NotiReason.reminder,
        timing: 'when user did not sign in for  5 weeks',
        Condition: 'last sign in timeStamp > 35 days',
        dayHour: "asPerDays : 10 am",
        reciever: NotiReciever.user,
        cityState: CityState.public,
        notiContent: NotiContent(
            title: 'Plan your future',
            body: 'Collect as many flyers as you can NOW, so when you start, You are ready. 👌',
        ),
        metaData: notiDefaultMap,
        autoFire: true,
      );
  }
// -----------------------------------------------------------------------------
  /// 4 - 7 days reminder for non SIGNED-UP aslan (only downloaded Bldrs.net)
  static NotiModel youDidNotSee(){
    return
      NotiModel(
        reason: NotiReason.reminder,
        timing: 'when user downloaded app but did not sign up aslan for 7 days',
        Condition: 'firebase user.id exists && UserModel does not exist && last signed in timeStamp > 7 days',
        dayHour: "asPerDays : 10 am",
        reciever: NotiReciever.user,
        cityState: CityState.public,
        notiContent: NotiContent(
          title: 'Come and See',
          body: '👁️ You did not see what lies inside Bldrs.net',
        ),
        metaData: notiDefaultMap,
        autoFire: true,
      );
  }
// -----------------------------------------------------------------------------
  /// 5 - 14 days reminder for non SIGNED-UP aslan (only downloaded Bldrs.net)
  static NotiModel rememberYourOptions(){
    return
      NotiModel(
        reason: NotiReason.reminder,
        timing: 'when user downloaded app but did not sign up aslan for 7 days',
        Condition: 'firebase user.id exists && UserModel does not exist && last signed in timeStamp > 7 days',
        dayHour: "asPerDays : 10 am",
        reciever: NotiReciever.user,
        cityState: CityState.public,
        notiContent: NotiContent(
          title: 'Consider your Options',
          body: '🔺 Bldrs.net is your RealEstate, Construction & Supplies search engine.',
        ),
        metaData: notiDefaultMap,
        autoFire: true,
      );
  }
// -----------------------------------------------------------------------------
  /// 6 - city went public
  static NotiModel cityWentPublic(){
    return
      NotiModel(
        reason: NotiReason.event,
        timing: 'when city goes public',
        Condition: 'user.zone.city == this city & cityIsPublic = true after it was false',
        dayHour: "asPerDay : 7:00 pm",
        reciever: NotiReciever.users,
        cityState: CityState.public,
        notiContent: NotiContent(
          title: '{cityName} Builders went public.',
          body: '📢 Bldrs businesses have been posting for some time, and now all their work is LIVE !',
        ),
        metaData: notiDefaultMap,
        autoFire: true,
      );
  }
// -----------------------------------------------------------------------------
  /// 7 - after user feedback
  static NotiModel feedbackAutoReply(){
    return
      NotiModel(
        reason: NotiReason.event,
        timing: 'after user posts opinion feedback with 24 hours',
        Condition: 'feedback.time.sinceThen == 24 hours',
        dayHour: "asPerDay : 10:00 am",
        reciever: NotiReciever.user,
        cityState: CityState.any,
        notiContent: NotiContent(
          title: 'Thank you',
          body: 'Thank you for taking part in building Bldrs.net, Your feedback is currently being reviewed.',
        ),
        metaData: notiDefaultMap,
        autoFire: true,
      );
  }
// -----------------------------------------------------------------------------
  /// 8 - feedback bldrs reply
  static NotiModel bldrsFeedbackReply(){

    String _dayHour = 'manual';
    String _title = '';
    String _body = '';

    return
      NotiModel(
        reason: NotiReason.event,
        timing: 'when bldrs.net replies over customer feedback',
        Condition: 'if bldrs.net admin decides to reply',
        dayHour: _dayHour,
        reciever: NotiReciever.user,
        cityState: CityState.any,
        notiContent: NotiContent(
          title: _title,
          body: _body,
        ),
        metaData: notiDefaultMap,
        autoFire: false,
      );
  }
// -----------------------------------------------------------------------------
  /// 9 - profile status reminder
  static NotiModel chooseYourCustomerStatus(){
    return
      NotiModel(
        reason: NotiReason.reminder,
        timing: 'when user did not assign userStatus for 2 days',
        Condition: 'if userModel.userStatus == null,, or not assigned',
        dayHour: "asPerDay : 2:00 pm",
        reciever: NotiReciever.user,
        cityState: CityState.any,
        notiContent: NotiContent(
          title: 'The Easy way',
          body: 'Builders will assist find your specific needs, just assign your profile status 👌',
        ),
        metaData: notiDefaultMap,
        autoFire: true,
      );
  }
// -----------------------------------------------------------------------------
  /// 10 - monthly statistics
  static NotiModel monthlyStatistics(){
    return
      NotiModel(
        reason: NotiReason.ad,
        timing: 'every month',
        Condition: 'no condition',
        dayHour: "first day in the month : 10:00 am",
        reciever: NotiReciever.users,
        cityState: CityState.public,
        notiContent: NotiContent(
          title: 'The Community is Growing',
          body: '{xx} new businesses had joined and {xx} new flyers were published on Bldrs.net Last month',
        ),
        metaData: notiDefaultMap,
        autoFire: true,
      );
  }
// -----------------------------------------------------------------------------
  /// 11 - new flyer by followed non free bz account (premium - super)
  static NotiModel newFlyerByFollowedPremiumBz(){
    return
      NotiModel(
        reason: NotiReason.event,
        timing: 'when followed premium bz adds new flyers',
        Condition: 'bz.followers.include(userID)',
        dayHour: "asPerDay : asPerHour",
        reciever: NotiReciever.users,
        cityState: CityState.public,
        notiContent: NotiContent(
          title: 'New flyer',
          body: '{bzName} published a new flyer {data about flyer}',
        ),
        metaData: notiDefaultMap,
        autoFire: true,
      );
  }
// -----------------------------------------------------------------------------
  /// 12 - flyer review reply
  static NotiModel flyerReviewReply(){
    return
      NotiModel(
        reason: NotiReason.event,
        timing: 'when author replies on user review',
        Condition: 'if reviewModel.authorReplied turns true',
        dayHour: "asPerDay : asPerTime",
        reciever: NotiReciever.user,
        cityState: CityState.public,
        notiContent: NotiContent(
          title: '{Author name} has replied on your review',
          body: '{review.body}',
        ),
        metaData: notiDefaultMap,
        autoFire: true,
      );
  }
// -----------------------------------------------------------------------------
  /// 13 - flyerReview
  static NotiModel flyerReviewed(){
    return
      NotiModel(
        reason: NotiReason.event,
        timing: 'when user posts flyer review',
        Condition: 'on review doc created && bz.AuthorsIDs.include(userID)',
        dayHour: "asPerDay : asPerTime",
        reciever: NotiReciever.authors,
        cityState: CityState.public,
        notiContent: NotiContent(
          title: '{userName} wrote a review on you flyer',
          body: '{review body}',
        ),
        metaData: notiDefaultMap,
        autoFire: true,
      );
  }
// -----------------------------------------------------------------------------
  /// 14 - flyerSaved
  static NotiModel flyerSaved(){
    return
      NotiModel(
        reason: NotiReason.event,
        timing: 'when a user saves a flyer',
        Condition: 'send to all bz authors',
        dayHour: "asPerDay : asPerTime",
        reciever: NotiReciever.authors,
        cityState: CityState.public,
        notiContent: NotiContent(
          title: '{userName} saved your flyer',
          body: '{flyerTitle} , blah',
        ),
        metaData: notiDefaultMap,
        autoFire: true,
      );
  }
// -----------------------------------------------------------------------------
  /// 14 - flyerSaved
  static NotiModel flyerShared(){
    return
      NotiModel(
        reason: NotiReason.event,
        timing: 'when a user shares a flyer',
        Condition: 'send to all bz authors',
        dayHour: "asPerDay : asPerTime",
        reciever: NotiReciever.authors,
        cityState: CityState.public,
        notiContent: NotiContent(
          title: '{userName} shared your flyer',
          body: '{flyerTitle} , blah',
        ),
        metaData: notiDefaultMap,
        autoFire: true,
      );
  }
// -----------------------------------------------------------------------------
  /// 14 - flyerSaved
  static NotiModel userFollowed(){
    return
      NotiModel(
        reason: NotiReason.event,
        timing: 'when a user follows bz',
        Condition: 'send to all bz authors',
        dayHour: "asPerDay : asPerTime",
        reciever: NotiReciever.authors,
        cityState: CityState.public,
        notiContent: NotiContent(
          title: '{userName} followed your {bzName}',
          body: 'He/She will be updated with you activity',
        ),
        metaData: notiDefaultMap,
        autoFire: true,
      );
  }
// -----------------------------------------------------------------------------
  /// 15 - weekly bz statistics
  static NotiModel weeklyBzStatistics(){
    return
      NotiModel(
        reason: NotiReason.ad,
        timing: 'every week',
        Condition: 'send to all bz authors',
        dayHour: "Monday : 10:00 am",
        reciever: NotiReciever.authors,
        cityState: CityState.any,
        notiContent: NotiContent(
          title: 'Your weekly stats',
          body: '{xx} users viewed your flyers last week, getting {xx} saves, {xx} reviews and {xx} calls',
        ),
        metaData: notiDefaultMap,
        autoFire: true,
      );
  }
// -----------------------------------------------------------------------------
  /// 16 - authorInvitation
  static NotiModel authorInvitation(){
    return
      NotiModel(
        reason: NotiReason.event,
        timing: 'when author sends author invitation to a user',
        Condition: '',
        dayHour: "asPerDate : asPerTime",
        reciever: NotiReciever.user,
        cityState: CityState.any,
        notiContent: NotiContent(
          title: '{authorName} invites you',
          body: 'You are invited to become an author of the Bldr account : {bzName}',
        ),
        metaData: notiDefaultMap,
        autoFire: true,
      );
  }
// -----------------------------------------------------------------------------
  /// 17 - author Invitation reply
  static NotiModel authorInvitationReply(){

    String _reply = 'accepted / rejected';

    return
      NotiModel(
        reason: NotiReason.event,
        timing: 'when user replies on author invitation',
        Condition: ' for all bz authors to know ',
        dayHour: "asPerDate : asPerTime",
        reciever: NotiReciever.authors,
        cityState: CityState.any,
        notiContent: NotiContent(
          title: '{userName} Replied on his invitation',
          body: 'Invitation has been $_reply.',
        ),
        metaData: notiDefaultMap,
        autoFire: true,
      );
  }
// -----------------------------------------------------------------------------
  /// 18 - authorInvitation
  static NotiModel authorInvitationCC(){
    return
      NotiModel(
        reason: NotiReason.event,
        timing: 'when author sends author invitation to a user',
        Condition: 'for all authors in the team except the invitation sender',
        dayHour: "asPerDate : asPerTime",
        reciever: NotiReciever.authors,
        cityState: CityState.any,
        notiContent: NotiContent(
          title: '{authorName} invited {userName}',
          body: 'An invitation has been sent for {userName} to join the team of {bzName}',
        ),
        metaData: notiDefaultMap,
        autoFire: true,
      );
  }
// -----------------------------------------------------------------------------
  /// 19 - country went global
  static NotiModel countryWentGlobal(){
    return
      NotiModel(
        reason: NotiReason.event,
        timing: 'when a county goes global',
        Condition: 'country.isGlobal turns true -- all people in the world receive this',
        dayHour: "Saturday : 9:00 pm",
        reciever: NotiReciever.users,
        cityState: CityState.any,
        notiContent: NotiContent(
          title: '{countryName} Builders are Global',
          body: '{countryFlag} All {countryName} Business and their flyers are now available world wide to reach',
        ),
        metaData: notiDefaultMap,
        autoFire: true,
      );
  }
// -----------------------------------------------------------------------------
  /// 20 - section went live
  static NotiModel sectionWentLive(){
    return
      NotiModel(
        reason: NotiReason.event,
        timing: 'when a section goes live',
        Condition: 'section.isLive turns true',
        dayHour: "Monday : 8 pm",
        reciever: NotiReciever.users,
        cityState: CityState.any,
        notiContent: NotiContent(
          title: 'Section {sectionName} is now available',
          body: 'You can now view the businesses publishing flyers in section {sectionName}',
        ),
        metaData: notiDefaultMap,
        autoFire: true,
      );
  }
// -----------------------------------------------------------------------------
  /// 21 - monthly bz statistics
  static NotiModel monthlyBzStatistics(){
    return
      NotiModel(
        reason: NotiReason.ad,
        timing: 'every week',
        Condition: 'send to all bz authors',
        dayHour: "Monday : 10:00 am",
        reciever: NotiReciever.authors,
        cityState: CityState.any,
        notiContent: NotiContent(
          title: 'Your monthly stats',
          body: ' ?? followers , calls, saves, views, shares, competitors in keywords, a77a',
        ),
        metaData: notiDefaultMap,
        autoFire: true,
      );
  }
// -----------------------------------------------------------------------------
  /// 22 - potential customer to bzz
  static NotiModel potentialCustomerQuestion(){
    return
      NotiModel(
        reason: NotiReason.event,
        timing: 'when user ask a question related to a specific keyword topic',
        Condition: 'bz is subscribed to a keyword topic in questions',
        dayHour: "asPerDay : asPerHour",
        reciever: NotiReciever.authors,
        cityState: CityState.any,
        notiContent: NotiContent(
          title: 'Potential customer',
          body: '{userName} asked a public question about {keyword} in {cityName - districtName}',
        ),
        metaData: notiDefaultMap,
        autoFire: true,
      );
  }
// -----------------------------------------------------------------------------
  /// 23 - question reply
  static NotiModel questionReply(){
    return
      NotiModel(
        reason: NotiReason.event,
        timing: 'when an author answers a question by user',
        Condition: 'use has a question + new reply in question replies sub doc',
        dayHour: "asPerDay : asPerHour",
        reciever: NotiReciever.user,
        cityState: CityState.any,
        notiContent: NotiContent(
          title: 'You received an answer',
          body: '{bzName} replied to your question : {questionReply}',
        ),
        metaData: notiDefaultMap,
        autoFire: true,
      );
  }
// -----------------------------------------------------------------------------
//   /// X -
//   static NotiModel xxx(){
//     return
//       NotiModel(
//         reason: NotiReason.,
//         timing: '',
//         Condition: '',
//         dayHour: "",
//         reciever: NotiReciever.,
//         cityState: CityState.,
//         notiContent: NotiContent(
//           title: '',
//           body: '',
//         ),
//         metaData: notiDefaultMap,
//         autoFire: true,
//       );
//   }
// -----------------------------------------------------------------------------

  static List<NotiModel> allNotifications(){
    return <NotiModel>[
      ///
      // AUTO NOTIFICATIONS
      /// ============================
      ///   o - to USERS
      cityWentPublic(),
      monthlyStatistics(),
      newFlyerByFollowedPremiumBz(),

      ///   o - to AUTHORS
      flyerSaved(),
      flyerReviewed(),
      flyerShared(),
      userFollowed(),
      weeklyBzStatistics(),
      monthlyBzStatistics(),
      authorInvitationCC(),
      potentialCustomerQuestion(),

      ///   o - to USER
      buildSomething(),
      createSomethingNew(),
      planYourFuture(),

      feedbackAutoReply(),

      youDidNotSee(),
      rememberYourOptions(),

      chooseYourCustomerStatus(),
      flyerReviewReply(),
      authorInvitation(),

      countryWentGlobal(),
      sectionWentLive(),

      questionReply(),

      ///   o - to AUTHOR
      authorInvitationReply(),

      // ------------------------------
      ///
      // MANUAL NOTIFICATIONS
      /// ============================
      ///   o - to USERS

      ///   o - to AUTHORS

      ///   o - to ALL

      ///   o - to USER

      ///   o - to AUTHOR

      ///   o - to USER-OR-AUTHOR
      bldrsFeedbackReply(),
      // ------------------------------
      ///
// -----------------------------------------------------------------------------
    ];
  }
}