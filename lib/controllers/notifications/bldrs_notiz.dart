import 'package:bldrs/models/notification/noti_model.dart';

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

class BldrsNotiModelz {

  static String notiSound = 'default';
  static String notiStatus = 'done';

  static dynamic notiDefaultMap = {
    "click_action": "FLUTTER_NOTIFICATION_CLICK",
    "sound": notiSound,
    "status": notiStatus,
    "screen": "",
  };
// -----------------------------------------------------------------------------
  static String _bldrsLogoURL = 'https://firebasestorage.googleapis.com/v0/b/bldrsnet.appspot.com/o/usersPics%2FrBjNU5WybKgJXaiBnlcBnfFaQSq1.jpg?alt=media&token=54a23d82-5642-4086-82b3-b4c1cb885b64';
  static String _dummyBzLogoURL = 'https://firebasestorage.googleapis.com/v0/b/bldrsnet.appspot.com/o/bzLogos%2Far1.jpg?alt=media&token=f68673f8-409a-426a-9a80-f1026715c469';
  static String _dummyUserPic = 'https://lh3.googleusercontent.com/a-/AOh14Gj3FAh76iQck0pD8EkRGraEP1OsElK8HysuToZp_A=s96-c';
  // -----------------------------------------------------------------------------
  /// 1 - 28 days reminder
  static NotiModel buildSomething(){
    return
      NotiModel(
        id: 'n01',
        subject: NotiSubject.reminder,
        timing: 'when user did not sign in for 4 weeks - asPerDays : 9 pm',
        Condition: 'last sign in timeStamp > 28 days',
        timeStamp: DateTime.now(),
        reciever: NotiReciever.user,
        cityState: CityState.public,
        title: 'Build Something',
        body: 'Bldrs.net',
        metaData: notiDefaultMap,
        autoFire: true,
        senderPicURL: _bldrsLogoURL,
        sender: NotiSender.bldrs,
      );
  }
// -----------------------------------------------------------------------------
  /// 2 - 35 days reminder
  static NotiModel createSomethingNew(){
    return
      NotiModel(
        id: 'n02',
        subject: NotiSubject.reminder,
        timing: 'when user did not sign in for a 5 weeks - asPerDays : 10 am',
        Condition: 'last sign in timeStamp > 35 days',
        timeStamp: DateTime.now(),
        reciever: NotiReciever.user,
        cityState: CityState.public,
        title: 'Create Something new',
        body: 'Bldrs.net',
        metaData: notiDefaultMap,
        autoFire: true,
        senderPicURL: _bldrsLogoURL,
        sender: NotiSender.bldrs,
      );
  }
// -----------------------------------------------------------------------------
  /// 3 - 42 days reminder
  static NotiModel planYourFuture(){
    return
      NotiModel(
        id: 'n03',
        subject: NotiSubject.reminder,
        timing: 'when user did not sign in for  5 weeks - asPerDays : 10 am',
        Condition: 'last sign in timeStamp > 35 days',
        timeStamp: DateTime.now(),
        reciever: NotiReciever.user,
        cityState: CityState.public,
        title: 'Plan your future',
        body: 'Collect as many flyers as you can NOW, so when you start, You are ready. 👌',
        metaData: notiDefaultMap,
        autoFire: true,
        senderPicURL: _bldrsLogoURL,
        sender: NotiSender.bldrs,
      );
  }
// -----------------------------------------------------------------------------
  /// 4 - 7 days reminder for non SIGNED-UP aslan (only downloaded Bldrs.net)
  static NotiModel youDidNotSee(){
    return
      NotiModel(
        id: 'n04',
        subject: NotiSubject.reminder,
        timing: 'when user downloaded app but did not sign up aslan for 7 days - asPerDays : 10 am',
        Condition: 'firebase user.id exists && UserModel does not exist && last signed in timeStamp > 7 days',
        timeStamp: DateTime.now(),
        reciever: NotiReciever.user,
        cityState: CityState.public,
        title: 'Come and See',
        body: '👁️ You did not see what lies inside Bldrs.net',
        metaData: notiDefaultMap,
        autoFire: true,
        senderPicURL: _bldrsLogoURL,
        sender: NotiSender.bldrs,
      );
  }
// -----------------------------------------------------------------------------
  /// 5 - 14 days reminder for non SIGNED-UP aslan (only downloaded Bldrs.net)
  static NotiModel rememberYourOptions(){
    return
      NotiModel(
        id: 'n05',
        subject: NotiSubject.reminder,
        timing: 'when user downloaded app but did not sign up aslan for 7 days - asPerDays : 10 am',
        Condition: 'firebase user.id exists && UserModel does not exist && last signed in timeStamp > 7 days',
        timeStamp: DateTime.now(),
        reciever: NotiReciever.user,
        cityState: CityState.public,
        title: 'Consider your Options',
        body: '🔺 Bldrs.net is your RealEstate, Construction & Supplies search engine.',
        metaData: notiDefaultMap,
        autoFire: true,
        senderPicURL: _bldrsLogoURL,
        sender: NotiSender.bldrs,
      );
  }
// -----------------------------------------------------------------------------
  /// 6 - city went public
  static NotiModel cityWentPublic(){
    return
      NotiModel(
        id: 'n06',
        subject: NotiSubject.event,
        timing: 'when city goes public - asPerDay : 7:00 pm',
        Condition: 'user.zone.city == this city & cityIsPublic = true after it was false',
        timeStamp: DateTime.now(),
        reciever: NotiReciever.users,
        cityState: CityState.public,
        title: '{cityName} Builders went public.',
        body: '📢 Bldrs businesses have been posting for some time, and now all their work is LIVE !',
        metaData: notiDefaultMap,
        autoFire: true,
        senderPicURL: _bldrsLogoURL,
        sender: NotiSender.bldrs,
      );
  }
// -----------------------------------------------------------------------------
  /// 7 - after user feedback
  static NotiModel feedbackAutoReply(){
    return
      NotiModel(
        id: 'n07',
        subject: NotiSubject.event,
        timing: 'after user posts opinion feedback with 24 hours - asPerDay : 10:00 am',
        Condition: 'feedback.time.sinceThen == 24 hours',
        timeStamp: DateTime.now(),
        reciever: NotiReciever.user,
        cityState: CityState.any,
        title: 'Thank you',
        body: 'Thank you for taking part in building Bldrs.net, Your feedback is currently being reviewed.',
        metaData: notiDefaultMap,
        autoFire: true,
        senderPicURL: _bldrsLogoURL,
        sender: NotiSender.bldrs,
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
        id: 'n08',
        subject: NotiSubject.event,
        timing: 'when bldrs.net replies over customer feedback - $_dayHour',
        Condition: 'if bldrs.net admin decides to reply',
        timeStamp: DateTime.now(),
        reciever: NotiReciever.user,
        cityState: CityState.any,
        title: _title,
        body: _body,
        metaData: notiDefaultMap,
        autoFire: false,
        senderPicURL: _bldrsLogoURL,
        sender: NotiSender.bldrs,
      );
  }
// -----------------------------------------------------------------------------
  /// 9 - profile status reminder
  static NotiModel chooseYourCustomerStatus(){
    return
      NotiModel(
        id: 'n09',
        subject: NotiSubject.reminder,
        timing: 'when user did not assign userStatus for 2 days - asPerDay : 2:00 pm',
        Condition: 'if userModel.userStatus == null,, or not assigned',
        timeStamp: DateTime.now(),
        reciever: NotiReciever.user,
        cityState: CityState.any,
        title: 'The Easy way',
        body: 'Builders will assist find your specific needs, just assign your profile status 👌',
        metaData: notiDefaultMap,
        autoFire: true,
        senderPicURL: _bldrsLogoURL,
        sender: NotiSender.bldrs,
      );
  }
// -----------------------------------------------------------------------------
  /// 10 - monthly statistics
  static NotiModel monthlyStatistics(){
    return
      NotiModel(
        id: 'n10',
        subject: NotiSubject.ad,
        timing: 'every month - first day in the month : 10:00 am',
        Condition: 'no condition',
        timeStamp: DateTime.now(),
        reciever: NotiReciever.users,
        cityState: CityState.public,
        title: 'The Community is Growing',
        body: '{xx} new businesses had joined and {xx} new flyers were published on Bldrs.net Last month',
        metaData: notiDefaultMap,
        autoFire: true,
        senderPicURL: _bldrsLogoURL,
        sender: NotiSender.bldrs,
      );
  }
// -----------------------------------------------------------------------------
  /// 11 - new flyer by followed non free bz account (premium - super)
  static NotiModel newFlyerByFollowedPremiumBz(){
    return
      NotiModel(
        id: 'n11',
        subject: NotiSubject.event,
        timing: 'when followed premium bz adds new flyers - asPerDay : asPerHour',
        Condition: 'bz.followers.include(userID)',
        timeStamp: DateTime.now(),
        reciever: NotiReciever.users,
        cityState: CityState.public,
        title: 'New flyer',
        body: '{bzName} published a new flyer {data about flyer}',
        metaData: notiDefaultMap,
        autoFire: true,
        sender: NotiSender.bz,
        senderPicURL: _dummyBzLogoURL,
      );
  }
// -----------------------------------------------------------------------------
  /// 12 - flyer review reply
  static NotiModel flyerReviewReply(){
    return
      NotiModel(
        id: 'n12',
        subject: NotiSubject.event,
        timing: 'when author replies on user review - asPerDay : asPerTime',
        Condition: 'if reviewModel.authorReplied turns true',
        timeStamp: DateTime.now(),
        reciever: NotiReciever.user,
        cityState: CityState.public,
        title: '{Author name} has replied on your review',
        body: '{review.body}',
        metaData: notiDefaultMap,
        autoFire: true,
        sender: NotiSender.bz,
        senderPicURL: _dummyBzLogoURL,
      );
  }
// -----------------------------------------------------------------------------
  /// 13 - flyerReview
  static NotiModel flyerReviewed(){
    return
      NotiModel(
        id: 'n13',
        subject: NotiSubject.event,
        timing: 'when user posts flyer review - asPerDay : asPerTime',
        Condition: 'on review doc created && bz.AuthorsIDs.include(userID)',
        timeStamp: DateTime.now(),
        reciever: NotiReciever.authors,
        cityState: CityState.public,
        title: '{userName} wrote a review on you flyer',
        body: '{review body}',
        metaData: notiDefaultMap,
        autoFire: true,
        sender: NotiSender.user,
        senderPicURL: _dummyUserPic,
      );
  }
// -----------------------------------------------------------------------------
  /// 14 - flyer Saved
  static NotiModel flyerSaved(){
    return
      NotiModel(
        id: 'n14',
        subject: NotiSubject.event,
        timing: 'when a user saves a flyer - asPerDay : asPerTime',
        Condition: 'send to all bz authors',
        timeStamp: DateTime.now(),
        reciever: NotiReciever.authors,
        cityState: CityState.public,
        title: '{userName} saved your flyer',
        body: '{flyerTitle} , blah',
        metaData: notiDefaultMap,
        autoFire: true,
        sender: NotiSender.user,
        senderPicURL: _dummyUserPic,
      );
  }
// -----------------------------------------------------------------------------
  /// 14 - flyer Shared
  static NotiModel flyerShared(){
    return
      NotiModel(
        id: 'n15',
        subject: NotiSubject.event,
        timing: 'when a user shares a flyer - asPerDay : asPerTime',
        Condition: 'send to all bz authors',
        timeStamp: DateTime.now(),
        reciever: NotiReciever.authors,
        cityState: CityState.public,
        title: '{userName} shared your flyer',
        body: '{flyerTitle} , blah',
        metaData: notiDefaultMap,
        autoFire: true,
        sender: NotiSender.user,
        senderPicURL: _dummyUserPic,
      );
  }
// -----------------------------------------------------------------------------
  /// 14 - user follow
  static NotiModel userFollowed(){
    return
      NotiModel(
        id: 'n16',
        subject: NotiSubject.event,
        timing: 'when a user follows bz - asPerDay : asPerTime',
        Condition: 'send to all bz authors',
        timeStamp: DateTime.now(),
        reciever: NotiReciever.authors,
        cityState: CityState.public,
        title: '{userName} followed your {bzName}',
        body: 'He/She will be updated with you activity',
        metaData: notiDefaultMap,
        autoFire: true,
        sender: NotiSender.user,
        senderPicURL: _dummyUserPic,
      );
  }
// -----------------------------------------------------------------------------
  /// 15 - weekly bz statistics
  static NotiModel weeklyBzStatistics(){
    return
      NotiModel(
        id: 'n17',
        subject: NotiSubject.ad,
        timing: 'every week - Monday : 10:00 am',
        Condition: 'send to all bz authors',
        timeStamp: DateTime.now(),
        reciever: NotiReciever.authors,
        cityState: CityState.any,
        title: 'Your weekly stats',
        body: '{xx} users viewed your flyers last week, getting {xx} saves, {xx} reviews and {xx} calls',
        metaData: notiDefaultMap,
        autoFire: true,
        sender: NotiSender.bldrs,
        senderPicURL: _bldrsLogoURL,
      );
  }
// -----------------------------------------------------------------------------
  /// 16 - authorInvitation
  static NotiModel authorInvitation(){
    return
      NotiModel(
        id: 'n18',
        subject: NotiSubject.event,
        timing: 'when author sends author invitation to a user - asPerDate : asPerTime',
        Condition: '',
        timeStamp: DateTime.now(),
        reciever: NotiReciever.user,
        cityState: CityState.any,
        title: '{authorName} invites you',
        body: 'You are invited to become an author of the Bldr account : {bzName}',
        metaData: notiDefaultMap,
        autoFire: true,
        sender: NotiSender.bz,
        senderPicURL: _dummyBzLogoURL,
      );
  }
// -----------------------------------------------------------------------------
  /// 17 - author Invitation reply
  static NotiModel authorInvitationReply(){

    String _reply = 'accepted / rejected';

    return
      NotiModel(
        id: 'n19',
        subject: NotiSubject.event,
        timing: 'when user replies on author invitation - asPerDate : asPerTime',
        Condition: ' for all bz authors to know ',
        timeStamp: DateTime.now(),
        reciever: NotiReciever.authors,
        cityState: CityState.any,
        title: '{userName} Replied on his invitation',
        body: 'Invitation has been $_reply.',
        metaData: notiDefaultMap,
        autoFire: true,
        sender: NotiSender.user,
        senderPicURL: _dummyUserPic,
      );
  }
// -----------------------------------------------------------------------------
  /// 18 - authorInvitation
  static NotiModel authorInvitationCC(){
    return
      NotiModel(
        id: 'n20',
        subject: NotiSubject.event,
        timing: 'when author sends author invitation to a user - asPerDate : asPerTime',
        Condition: 'for all authors in the team except the invitation sender',
        timeStamp: DateTime.now(),
        reciever: NotiReciever.authors,
        cityState: CityState.any,
        title: '{authorName} invited {userName}',
        body: 'An invitation has been sent for {userName} to join the team of {bzName}',
        metaData: notiDefaultMap,
        autoFire: true,
        sender: NotiSender.bz,
        senderPicURL: _dummyBzLogoURL,
      );
  }
// -----------------------------------------------------------------------------
  /// 19 - country went global
  static NotiModel countryWentGlobal(){
    return
      NotiModel(
        id: 'n21',
        subject: NotiSubject.event,
        timing: 'when a county goes global - Saturday : 9:00 pm',
        Condition: 'country.isGlobal turns true -- all people in the world receive this',
        timeStamp: DateTime.now(),
        reciever: NotiReciever.users,
        cityState: CityState.any,
        title: '{countryName} Builders are Global',
        body: '{countryFlag} All {countryName} Business and their flyers are now available world wide to reach',
        metaData: notiDefaultMap,
        autoFire: true,
        sender: NotiSender.bldrs,
        senderPicURL: _bldrsLogoURL,
      );
  }
// -----------------------------------------------------------------------------
  /// 20 - section went live
  static NotiModel sectionWentLive(){
    return
      NotiModel(
        id: 'n22',
        subject: NotiSubject.event,
        timing: 'when a section goes live - Monday : 8 pm',
        Condition: 'section.isLive turns true',
        timeStamp: DateTime.now(),
        reciever: NotiReciever.users,
        cityState: CityState.any,
        title: 'Section {sectionName} is now available',
        body: 'You can now view the businesses publishing flyers in section {sectionName}',
        metaData: notiDefaultMap,
        autoFire: true,
        sender: NotiSender.bldrs,
        senderPicURL: _bldrsLogoURL,
      );
  }
// -----------------------------------------------------------------------------
  /// 21 - monthly bz statistics
  static NotiModel monthlyBzStatistics(){
    return
      NotiModel(
        id: 'n23',
        subject: NotiSubject.ad,
        timing: 'every week - Monday : 10:00 am',
        Condition: 'send to all bz authors',
        timeStamp: DateTime.now(),
        reciever: NotiReciever.authors,
        cityState: CityState.any,
        title: 'Your monthly stats',
        body: ' ?? followers , calls, saves, views, shares, competitors in keywords, a77a',
        metaData: notiDefaultMap,
        autoFire: true,
        sender: NotiSender.bldrs,
        senderPicURL: _bldrsLogoURL,
      );
  }
// -----------------------------------------------------------------------------
  /// 22 - potential customer to bzz
  static NotiModel potentialCustomerQuestion(){
    return
      NotiModel(
        id: 'n24',
        subject: NotiSubject.event,
        timing: 'when user ask a question related to a specific keyword topic - asPerDay : asPerHour',
        Condition: 'bz is subscribed to a keyword topic in questions',
        timeStamp: DateTime.now(),
        reciever: NotiReciever.authors,
        cityState: CityState.any,
        title: 'Potential customer',
        body: '{userName} asked a public question about {keyword} in {cityName - districtName}',
        metaData: notiDefaultMap,
        autoFire: true,
        sender: NotiSender.bldrs,
        senderPicURL: _bldrsLogoURL,
      );
  }
// -----------------------------------------------------------------------------
  /// 23 - question reply
  static NotiModel questionReply(){
    return
      NotiModel(
        id: 'n25',
        subject: NotiSubject.event,
        timing: 'when an author answers a question by user - asPerDay : asPerHour',
        Condition: 'use has a question + new reply in question replies sub doc',
        timeStamp: DateTime.now(),
        reciever: NotiReciever.user,
        cityState: CityState.any,
        title: 'You received an answer',
        body: '{bzName} replied to your question : {questionReply}',
        metaData: notiDefaultMap,
        autoFire: true,
        sender: NotiSender.bz,
        senderPicURL: _dummyBzLogoURL,
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
  ///
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

// --- ALL NEWS : NEW PUBLISHED FLYER BY BZ WITHOUT AUTHOR : (INSTANTANEOUS)

// --- ALL NEWS : NEW PUBLISHED FLYER BY BZ WITH AUTHOR : (INSTANTANEOUS)

// --- ALL NEWS : NEW PUBLISHED FLYER BY USER OF TYPE : (INSTANTANEOUS)

// o ( FOLLOWING NOTIFICATIONS )
// --- BZ NEWS : NEW FOLLOWERS : (MIN OF NUMBER = X && MIN OF DURATION = T)

// o ( CONNECTION NOTIFICATION )
// --- BZ NEWS : NEW RECEIVED CONNECTION REQUEST : (INSTANTANEOUS)
// --- BZ NEWS : SENT CONNECTION REPLY 'ACCEPTED, REJECTED' : (INSTANTANEOUS)

// o ( BZ AUTHOR REQUEST NOTIFICATION )
// --- BZ NEWS : USER REPLIED TO YOUR SENT AUTHORSHIP REQUEST 'ACCEPTED, REJECTED' : (INSTANTANEOUS)
// --- USER NEWS : BZ SENT YOU AUTHORSHIP REQUEST 'ACCEPT, REJECT' : (INSTANTANEOUS)

// o ( BZ PUBLISHED FLYER EDITOR'S REPLY )
// --- BZ NEWS : BLDRS EDITORS 'REJECTED, EDITED, HIGHLIGHTED' YOUR FLYER : (INSTANTANEOUS)

// o ( FLYERS SHARING )
// --- ANY USER : RECEIVED A FLYER : (INSTANTANEOUS)
// --- ANY USER : RECEIVED A COLLECTION OF FLYERS : (INSTANTANEOUS)

// o ( PAID NEWS )
// --- USER NEWS : BZ PAID NEWS : ( LIMITED AMOUNT PER WEEK AND LIMITED AMOUNT OF NOTIFICATION ALERTS )

// o ( STATISTICS )
// --- BZ NEWS : COMPETITION SIGNUPS IN SAME FIELD : (MIN OF NUM = X && MIN OF DURATION = T)
// --- BZ NEWS : ALL BZ SIGNUPS IN ALL FIELDS : (MIN OF NUM = X && MIN OF DURATION = T)
// --- BZ NEWS : DAILY BZ PROFILE STATISTICS 'FOLLOWERS, VIEWS, SAVES, SHARES, CONTACTS, CALLS'
// --- ANY USER : WEEKLY NATIONAL STATISTICS
// --- ANY USER : MONTHLY GLOBAL STATISTICS
