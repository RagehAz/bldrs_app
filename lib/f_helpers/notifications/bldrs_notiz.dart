import 'package:bldrs/a_models/bz/author_model.dart';
import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/a_models/notification/noti_model.dart';
import 'package:bldrs/a_models/notification/noti_sudo.dart';
import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
import 'package:flutter/foundation.dart';

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

const String notiSound = 'default';
const String notiStatus = 'done';

const dynamic notiDefaultMap = <String, dynamic>{
  'click_action': 'FLUTTER_NOTIFICATION_CLICK',
  'sound': notiSound,
  'status': notiStatus,
  'screen': '',
};

const String bldrsSenderID = 'bldrs';
// -----------------------------------------------------------------------------
const String bldrsLogoURL =
    'https://firebasestorage.googleapis.com/v0/b/bldrsnet.appspot.com/o/usersPics%2FrBjNU5WybKgJXaiBnlcBnfFaQSq1.jpg?alt=media&token=54a23d82-5642-4086-82b3-b4c1cb885b64';

final BzModel _dummyBz = BzModel.dummyBz('ar1');
final FlyerModel _dummyFlyer = FlyerModel.dummyFlyers()[0];
final UserModel _dummyUser = UserModel.dummyUsers(numberOfUsers: 1)[0];
final AuthorModel _dummyAuthor = AuthorModel.dummyAuthor();
// -----------------------------------------------------------------------------
/// 1 - 28 days reminder
NotiModel buildSomething() {
  return NotiModel(
    id: 'n01',
    name: 'buildSomething',
    sudo: const NotiSudo(
      subject: NotiSubject.reminder,
      eventTrigger: 'when user did not sign in for 4 weeks',
      scheduledTiming: 'asPerDays : 9 pm',
      ifStatement: 'last sign in timeStamp > 28 days',
      cityState: CityState.public,
      reciever: NotiRecieverType.user,
    ),
    senderID: bldrsSenderID,
    pic: bldrsLogoURL,
    notiPicType: NotiPicType.bldrs,
    title: 'Build Something',
    timeStamp: DateTime.now(),
    body: 'Bldrs.net',
    attachment: null,
    attachmentType: null,
    dismissed: false,
    sendFCM: true,
    metaData: notiDefaultMap,
  );
}

// -----------------------------------------------------------------------------
/// 2 - 35 days reminder
NotiModel createSomethingNew() {
  return NotiModel(
    id: 'n02',
    name: 'createSomethingNew',
    sudo: const NotiSudo(
      subject: NotiSubject.reminder,
      eventTrigger: 'when user did not sign in for a 5 weeks',
      scheduledTiming: 'asPerDays : 10 am',
      ifStatement: 'last sign in timeStamp > 35 days',
      cityState: CityState.public,
      reciever: NotiRecieverType.user,
    ),
    senderID: bldrsSenderID,
    pic: bldrsLogoURL,
    notiPicType: NotiPicType.bldrs,
    title: 'Create Something new',
    timeStamp: DateTime.now(),
    body: 'Bldrs.net',
    attachment: null,
    attachmentType: null,
    dismissed: false,
    sendFCM: true,
    metaData: notiDefaultMap,
  );
}

// -----------------------------------------------------------------------------
/// 3 - 42 days reminder
NotiModel planYourFuture() {
  return NotiModel(
    id: 'n03',
    name: 'planYourFuture',
    sudo: const NotiSudo(
      subject: NotiSubject.reminder,
      eventTrigger: 'when user did not sign in for  6 weeks',
      scheduledTiming: 'asPerDays : 10 am',
      ifStatement: 'last sign in timeStamp > 42 days',
      cityState: CityState.public,
      reciever: NotiRecieverType.user,
    ),
    senderID: bldrsSenderID,
    pic: bldrsLogoURL,
    notiPicType: NotiPicType.bldrs,
    title: 'Plan your future',
    timeStamp: DateTime.now(),
    body:
        'Collect as many flyers as you can NOW, so when you start, You are ready. 👌',
    attachment: null,
    attachmentType: null,
    dismissed: false,
    sendFCM: true,
    metaData: notiDefaultMap,
  );
}

// -----------------------------------------------------------------------------
/// 4 - 7 days reminder for non SIGNED-UP aslan (only downloaded Bldrs.net)
NotiModel youDidNotSee() {
  return NotiModel(
    id: 'n04',
    name: 'youDidNotSee',
    sudo: const NotiSudo(
      subject: NotiSubject.reminder,
      eventTrigger:
          'when user downloaded app but did not sign up aslan for 7 days',
      scheduledTiming: 'asPerDays : 10 am',
      ifStatement:
          'firebase user.id exists && UserModel does not exist && last signed in timeStamp > 7 days',
      cityState: CityState.public,
      reciever: NotiRecieverType.user,
    ),
    senderID: bldrsSenderID,
    pic: bldrsLogoURL,
    notiPicType: NotiPicType.bldrs,
    title: 'Come and See',
    timeStamp: DateTime.now(),
    body: '👁️ You did not see what lies inside Bldrs.net',
    attachment: null,
    attachmentType: null,
    dismissed: false,
    sendFCM: true,
    metaData: notiDefaultMap,
  );
}

// -----------------------------------------------------------------------------
/// 5 - 14 days reminder for non SIGNED-UP aslan (only downloaded Bldrs.net)
NotiModel rememberYourOptions() {
  return NotiModel(
    id: 'n05',
    name: 'rememberYourOptions',
    sudo: const NotiSudo(
      subject: NotiSubject.reminder,
      eventTrigger:
          'when user downloaded app but did not sign up aslan for 14 days',
      scheduledTiming: 'asPerDays : 10 am',
      ifStatement:
          'firebase user.id exists && UserModel does not exist && last signed in timeStamp > 14 days',
      cityState: CityState.public,
      reciever: NotiRecieverType.user,
    ),
    senderID: bldrsSenderID,
    pic: bldrsLogoURL,
    notiPicType: NotiPicType.bldrs,
    title: 'Consider your Options',
    timeStamp: DateTime.now(),
    body:
        '🔺 Bldrs.net is your RealEstate, Construction & Supplies search engine.',
    attachment: null,
    attachmentType: null,
    dismissed: false,
    sendFCM: true,
    metaData: notiDefaultMap,
  );
}

// -----------------------------------------------------------------------------
/// 6 - city went public
NotiModel cityWentPublic({@required String cityName, @required String iso3}) {
  return NotiModel(
    id: 'n06',
    name: 'cityWentPublic',
    sudo: const NotiSudo(
      subject: NotiSubject.event,
      eventTrigger: 'when city goes public',
      scheduledTiming: 'asPerDay : 7:00 pm',
      ifStatement:
          'user.zone.city == this city & cityIsPublic = true after it was false',
      cityState: CityState.public,
      reciever: NotiRecieverType.users,
    ),
    senderID: bldrsSenderID,
    pic: iso3,
    notiPicType: NotiPicType.country,
    title: '$cityName Builders went public.',
    timeStamp: DateTime.now(),
    body:
        '📢 Bldrs businesses have been posting for some time, and now all their work is LIVE !',
    attachment: null,
    attachmentType: null,
    dismissed: false,
    sendFCM: true,
    metaData: notiDefaultMap,
  );
}

// -----------------------------------------------------------------------------
/// 7 - after user feedback
NotiModel feedbackAutoReply() {
  return NotiModel(
    id: 'n07',
    name: 'feedbackAutoReply',
    sudo: const NotiSudo(
      subject: NotiSubject.event,
      eventTrigger: 'after user posts opinion feedback with 24 hours',
      scheduledTiming: 'asPerDay : 10:00 am',
      ifStatement: 'feedback.time.sinceThen == 24 hours',
      cityState: CityState.any,
      reciever: NotiRecieverType.user,
    ),
    senderID: bldrsSenderID,
    pic: bldrsLogoURL,
    notiPicType: NotiPicType.bldrs,
    title: 'Thank you',
    timeStamp: DateTime.now(),
    body:
        'Thank you for taking part in building Bldrs.net, Your feedback is currently being reviewed.',
    attachment: null,
    attachmentType: null,
    dismissed: false,
    sendFCM: true,
    metaData: notiDefaultMap,
  );
}

// -----------------------------------------------------------------------------
/// 8 - feedback bldrs reply
NotiModel bldrsFeedbackReply({@required String reply}) {
  return NotiModel(
    id: 'n08',
    name: 'bldrsFeedbackReply',
    sudo: const NotiSudo(
      subject: NotiSubject.event,
      eventTrigger: 'when bldrs.net replies over customer feedback',
      scheduledTiming: 'on time',
      ifStatement: 'if bldrs.net admin decides to reply',
      cityState: CityState.any,
      reciever: NotiRecieverType.user,
    ),
    senderID: bldrsSenderID,
    pic: bldrsLogoURL,
    notiPicType: NotiPicType.bldrs,
    title: 'Bldrs.net team have replied over your feedback',
    timeStamp: DateTime.now(),
    body: reply,
    attachment: null,
    attachmentType: null,
    dismissed: false,
    sendFCM: true,
    metaData: notiDefaultMap,
  );
}

// -----------------------------------------------------------------------------
/// 9 - profile status reminder
NotiModel chooseYourCustomerStatus() {
  return NotiModel(
    id: 'n09',
    name: 'chooseYourCustomerStatus',
    sudo: const NotiSudo(
      subject: NotiSubject.reminder,
      eventTrigger: 'when user did not assign userStatus for 2 days',
      scheduledTiming: 'asPerDay : 2:00 pm',
      ifStatement: 'if userModel.userStatus == null,, or not assigned',
      cityState: CityState.any,
      reciever: NotiRecieverType.user,
    ),
    senderID: bldrsSenderID,
    pic: bldrsLogoURL,
    notiPicType: NotiPicType.bldrs,
    title: 'The Easy way',
    timeStamp: DateTime.now(),
    body:
        'Builders will assist find your specific needs, just assign your profile status 👌',
    attachment: null,
    attachmentType: null,
    dismissed: false,
    sendFCM: true,
    metaData: notiDefaultMap,
  );
}

// -----------------------------------------------------------------------------
/// 10 - monthly statistics
NotiModel monthlyStatistics(
    {@required int numberOfNewBzz, @required int numberOfNewFlyers}) {
  return NotiModel(
    id: 'n10',
    name: 'monthlyStatistics',
    sudo: const NotiSudo(
      subject: NotiSubject.ad,
      eventTrigger: 'every month',
      scheduledTiming: 'first day in the month : 10:00 am',
      ifStatement: 'no condition',
      cityState: CityState.public,
      reciever: NotiRecieverType.users,
    ),
    senderID: bldrsSenderID,
    pic: bldrsLogoURL,
    notiPicType: NotiPicType.bldrs,
    title: 'The Community is Growing',
    timeStamp: DateTime.now(),
    body:
        '$numberOfNewBzz new businesses had joined and $numberOfNewFlyers new flyers were published on Bldrs.net Last month',
    attachment: null,
    attachmentType: null,
    dismissed: false,
    sendFCM: true,
    metaData: notiDefaultMap,
  );
}

// -----------------------------------------------------------------------------
/// 11 - new flyer by followed non free bz account (premium - super)
NotiModel newPublishedFlyer(
    {@required BzModel bzModel, @required FlyerModel flyer}) {
  // String _flyerType = TextGenerator.flyerTypeSingleStringer(context, flyerType);

  return NotiModel(
    id: 'n11',
    name: 'newFlyerByFollowedPremiumBz',
    sudo: const NotiSudo(
      subject: NotiSubject.event,
      eventTrigger: 'when followed premium bz adds new flyers',
      scheduledTiming: 'asPerDay : asPerHour',
      ifStatement: 'bz.followers.include(userID)',
      cityState: CityState.public,
      reciever: NotiRecieverType.users,
    ),
    senderID: bzModel.id,
    pic: bzModel.logo,
    notiPicType: NotiPicType.bz,
    title: 'New flyer',
    timeStamp: DateTime.now(),
    body:
        '${bzModel.name} published a new ${flyer.flyerType.toString()}flyer', // TASK : fix this flyer type localized in notification
    attachment: flyer.id,
    attachmentType: NotiAttachmentType.flyers,

    dismissed: false,
    sendFCM: true,
    metaData: notiDefaultMap,
  );
}

// -----------------------------------------------------------------------------
/// 12 - flyer review reply
NotiModel flyerReviewReply(
    {@required BzModel bzModel, @required String reviewBody}) {
  return NotiModel(
    id: 'n12',
    name: 'flyerReviewReply',
    sudo: const NotiSudo(
      subject: NotiSubject.event,
      eventTrigger: 'when author replies on user review',
      scheduledTiming: 'asPerDay : asPerTime',
      ifStatement: 'if reviewModel.authorReplied turns true',
      cityState: CityState.public,
      reciever: NotiRecieverType.user,
    ),
    senderID: bzModel.id,
    pic: bzModel.logo,
    notiPicType: NotiPicType.bz,
    title: '${bzModel.name} has replied on your review',
    timeStamp: DateTime.now(),
    body: reviewBody,
    attachment: null,
    attachmentType: null,
    dismissed: false,
    sendFCM: true,
    metaData: notiDefaultMap,
  );
}

// -----------------------------------------------------------------------------
/// 13 - flyerReview
NotiModel flyerReviewed(
    {@required UserModel userModel, @required String reviewBody}) {
  return NotiModel(
    id: 'n13',
    name: 'flyerReviewed',
    sudo: const NotiSudo(
      subject: NotiSubject.event,
      eventTrigger: 'when user posts flyer review',
      scheduledTiming: 'asPerDay : asPerTime',
      ifStatement: 'on review doc created && bz.AuthorsIDs.include(userID)',
      cityState: CityState.public,
      reciever: NotiRecieverType.authors,
    ),
    senderID: userModel.id,
    pic: userModel.pic,
    notiPicType: NotiPicType.user,
    title: '${userModel.name} wrote a review on your flyer',
    timeStamp: DateTime.now(),
    body: reviewBody,
    attachment: null,
    attachmentType: null,
    dismissed: false,
    sendFCM: true,
    metaData: notiDefaultMap,
  );
}

// -----------------------------------------------------------------------------
/// 14 - flyer Saved
NotiModel flyerSaved(
    {@required UserModel userModel, @required String flyerID}) {
  return NotiModel(
    id: 'n14',
    name: 'flyerSaved',
    sudo: const NotiSudo(
      subject: NotiSubject.event,
      eventTrigger: 'when a user saves a flyer',
      scheduledTiming: 'asPerDay : asPerTime',
      ifStatement: 'send to all bz authors',
      cityState: CityState.public,
      reciever: NotiRecieverType.authors,
    ),
    senderID: userModel.id,
    pic: userModel.pic,
    notiPicType: NotiPicType.user,
    title: '${userModel.name} saved your flyer',
    timeStamp: DateTime.now(),
    body: null,
    attachment: flyerID,
    attachmentType: NotiAttachmentType.flyers,
    dismissed: false,
    sendFCM: true,
    metaData: notiDefaultMap,
  );
}

// -----------------------------------------------------------------------------
/// 14 - flyer Shared
NotiModel flyerShared(
    {@required UserModel userModel, @required String flyerID}) {
  return NotiModel(
    id: 'n15',
    name: 'flyerShared',
    sudo: const NotiSudo(
      subject: NotiSubject.event,
      eventTrigger: 'when a user shares a flyer',
      scheduledTiming: 'asPerDay : asPerTime',
      ifStatement: 'send to all bz authors',
      cityState: CityState.public,
      reciever: NotiRecieverType.authors,
    ),
    senderID: userModel.id,
    pic: userModel.pic,
    notiPicType: NotiPicType.user,
    title: '${userModel.name} shared your flyer',
    timeStamp: DateTime.now(),
    body: null,
    attachment: flyerID,
    attachmentType: NotiAttachmentType.flyers,
    dismissed: false,
    sendFCM: true,
    metaData: notiDefaultMap,
  );
}

// -----------------------------------------------------------------------------
/// 14 - user follow
NotiModel userFollowed({@required UserModel userModel}) {
  return NotiModel(
    id: 'n16',
    name: 'userFollowed',
    sudo: const NotiSudo(
      subject: NotiSubject.event,
      eventTrigger: 'when a user follows bz',
      scheduledTiming: 'asPerDay : asPerTime',
      ifStatement: 'send to all bz authors',
      cityState: CityState.public,
      reciever: NotiRecieverType.authors,
    ),
    senderID: userModel.id,
    pic: userModel.pic,
    notiPicType: NotiPicType.user,
    title: '${userModel.name} followed your business page',
    timeStamp: DateTime.now(),
    body: '${userModel.name} will be updated with you activity',
    attachment: null,
    attachmentType: null,
    dismissed: false,
    sendFCM: true,
    metaData: notiDefaultMap,
  );
}

// -----------------------------------------------------------------------------
/// 15 - weekly bz statistics
NotiModel weeklyBzStatistics(
    {@required int views,
    @required int saves,
    @required int shares,
    @required int reviews,
    @required int calls}) {
  return NotiModel(
    id: 'n17',
    name: 'weeklyBzStatistics',
    sudo: const NotiSudo(
      subject: NotiSubject.ad,
      eventTrigger: 'every week',
      scheduledTiming: 'Monday : 10:00 am',
      ifStatement: 'send to all bz authors',
      cityState: CityState.any,
      reciever: NotiRecieverType.authors,
    ),
    senderID: bldrsSenderID,
    pic: bldrsLogoURL,
    notiPicType: NotiPicType.bldrs,
    title: 'Your weekly stats',
    timeStamp: DateTime.now(),
    body: 'This week you got :\n'
        '$views flyer views\n'
        '$saves saves\n'
        '$shares shares\n'
        '$reviews reviews\n'
        '$calls phone calls',
    attachment: null,
    attachmentType: null,
    dismissed: false,
    sendFCM: true,
    metaData: notiDefaultMap,
  );
}

// -----------------------------------------------------------------------------
/// 16 - authorInvitation
NotiModel authorInvitation(
    {@required AuthorModel authorModel, @required BzModel bzModel}) {
  return NotiModel(
    id: 'n18',
    name: 'authorInvitation',
    sudo: const NotiSudo(
      subject: NotiSubject.event,
      eventTrigger: 'when author sends author invitation to a user',
      scheduledTiming: 'asPerDate : asPerTime',
      ifStatement: '... will see ',

      /// TASK : Develop author invitation thing
      cityState: CityState.any,
      reciever: NotiRecieverType.user,
    ),
    senderID: authorModel.userID,
    pic: bzModel.logo,
    notiPicType: NotiPicType.author,
    timeStamp: DateTime.now(),
    title: '${authorModel.name} invites you',
    body:
        'You are invited to become an author of the Bldr account : ${bzModel.name}',
    attachment: null,
    attachmentType: null,
    dismissed: false,
    sendFCM: true,
    metaData: notiDefaultMap,
  );
}

// -----------------------------------------------------------------------------
/// 17 - author Invitation reply
NotiModel authorInvitationReply(
    {@required UserModel userModel, @required bool invitationAccepted}) {
  final String _reply = invitationAccepted == true ? 'accepted' : 'rejected';

  return NotiModel(
    id: 'n19',
    name: 'authorInvitationReply',
    sudo: const NotiSudo(
      subject: NotiSubject.event,
      eventTrigger: 'when user replies on author invitation',
      scheduledTiming: 'asPerDate : asPerTime',
      ifStatement: 'for all bz authors to know ',

      /// TASK : Develop author invitation thing
      cityState: CityState.any,
      reciever: NotiRecieverType.authors,
    ),
    senderID: userModel.id,
    pic: userModel.pic,
    notiPicType: NotiPicType.user,
    title: '${userModel.name} Replied on his author invitation',
    timeStamp: DateTime.now(),
    body: 'Invitation has been $_reply.',
    attachment: null,
    attachmentType: null,
    dismissed: false,
    sendFCM: true,
    metaData: notiDefaultMap,
  );
}

// -----------------------------------------------------------------------------
/// 18 - authorInvitation
NotiModel authorInvitationCC(
    {@required AuthorModel sender,
    @required UserModel reciever,
    @required BzModel tinyBz}) {
  return NotiModel(
    id: 'n20',
    name: 'authorInvitationCC',
    sudo: const NotiSudo(
      subject: NotiSubject.event,
      eventTrigger: 'when author sends author invitation to a user',
      scheduledTiming: 'asPerDate : asPerTime',
      ifStatement: 'for all authors in the team except the invitation sender',
      cityState: CityState.any,
      reciever: NotiRecieverType.authors,
    ),
    senderID: sender.userID,
    pic: sender.pic,
    notiPicType: NotiPicType.author,
    title: '${sender.name} invited ${reciever.name}',
    timeStamp: DateTime.now(),
    body:
        'An invitation has been sent for ${reciever.name} to join the team of ${tinyBz.name}',
    attachment: <String>['Accept', 'Decline'],
    attachmentType: NotiAttachmentType.buttons,
    sendFCM: true,
    dismissed: false,
    metaData: notiDefaultMap,
  );
}

// -----------------------------------------------------------------------------
/// 19 - country went global
NotiModel countryWentGlobal(
    {@required String iso3, @required String countryName}) {
  return NotiModel(
    id: 'n21',
    name: 'countryWentGlobal',
    sudo: const NotiSudo(
      subject: NotiSubject.event,
      eventTrigger: 'when a county goes global',
      scheduledTiming: 'Saturday : 9:00 pm',
      ifStatement:
          'country.isGlobal turns true -- all people in the world receive this',
      cityState: CityState.any,
      reciever: NotiRecieverType.users,
    ),
    senderID: bldrsSenderID,
    notiPicType: NotiPicType.country,
    pic: iso3,
    title: '$countryName Builders are Global',
    timeStamp: DateTime.now(),
    body:
        '$countryName Business and their flyers are now available world wide to reach',
    attachment: null,
    attachmentType: null,
    dismissed: false,
    sendFCM: true,
    metaData: notiDefaultMap,
  );
}

// -----------------------------------------------------------------------------
/// 20 - section went live
NotiModel sectionWentLive({@required String sectionName}) {
  return NotiModel(
    id: 'n22',
    name: 'sectionWentLive',
    sudo: const NotiSudo(
      subject: NotiSubject.event,
      eventTrigger: 'when a section goes live',
      scheduledTiming: 'Monday : 8 pm',
      ifStatement: 'section.isLive turns true',
      cityState: CityState.any,
      reciever: NotiRecieverType.users,
    ),
    senderID: bldrsSenderID,
    pic: bldrsLogoURL,
    notiPicType: NotiPicType.bldrs,
    title: 'Section $sectionName is now available',
    timeStamp: DateTime.now(),
    body:
        'You can now view the businesses publishing flyers in section $sectionName',
    attachment: null,
    attachmentType: null,
    dismissed: false,
    sendFCM: true,
    metaData: notiDefaultMap,
  );
}

// -----------------------------------------------------------------------------
/// 21 - monthly bz statistics
NotiModel monthlyBzStatistics({
  @required BzModel bzModel,
  @required String monthName,
  @required int followers,
  @required int calls,
  @required int saves,
  @required int views,
  @required int shares,
  @required int competitors,
}) {
  return NotiModel(
    id: 'n23',
    name: 'monthlyBzStatistics',
    sudo: const NotiSudo(
      subject: NotiSubject.ad,
      eventTrigger: 'every week',
      scheduledTiming: 'Monday : 10:00 am',
      ifStatement: 'send to all bz authors',
      cityState: CityState.any,
      reciever: NotiRecieverType.authors,
    ),
    senderID: bldrsSenderID,
    pic: bldrsLogoURL,
    notiPicType: NotiPicType.bldrs,
    title: '${bzModel.name} statistics for $monthName',
    timeStamp: DateTime.now(),
    body:
        'on $monthName you have got $followers followers, $calls calls, $saves saves, $views views, $shares shares while $competitors new businesses specialized in ${bzModel.bzTypes.toString()} have joined Bldrs.net this month',
    attachment: null,
    attachmentType: null,
    sendFCM: true,
    dismissed: false,
    metaData: notiDefaultMap,
  );
}

// -----------------------------------------------------------------------------
/// 22 - potential customer to bzz
NotiModel potentialCustomerQuestion(
    {@required UserModel userModel,
    @required String keyword,
    @required String cityName,
    @required String district}) {
  return NotiModel(
    id: 'n24',
    name: 'potentialCustomerQuestion',
    sudo: const NotiSudo(
      subject: NotiSubject.event,
      eventTrigger:
          'when user ask a question related to a specific keyword topic',
      scheduledTiming: 'asPerDay : asPerHour',
      ifStatement: 'bz is subscribed to a keyword topic in questions',
      cityState: CityState.any,
      reciever: NotiRecieverType.authors,
    ),
    senderID: userModel.id,
    pic: userModel.pic,
    notiPicType: NotiPicType.user,
    title: 'Potential customer',
    timeStamp: DateTime.now(),
    body:
        '${userModel.name} asked a public question about $keyword in $district, $cityName',
    attachment: null,
    attachmentType: null,
    dismissed: false,
    sendFCM: true,
    metaData: notiDefaultMap,
  );
}

// -----------------------------------------------------------------------------
/// 23 - question reply
NotiModel questionReply({@required BzModel bzModel, @required String reply}) {
  return NotiModel(
    id: 'n25',
    name: 'questionReply',
    sudo: const NotiSudo(
      subject: NotiSubject.event,
      eventTrigger: 'when an author answers a question by user',
      scheduledTiming: 'asPerDay : asPerHour',
      ifStatement:
          'user has a question + new reply in question replies sub doc',
      cityState: CityState.any,
      reciever: NotiRecieverType.user,
    ),
    senderID: bzModel.id,
    pic: bzModel.logo,
    notiPicType: NotiPicType.bz,
    title: 'You received an answer',
    timeStamp: DateTime.now(),
    body: '${bzModel.name} replied to your question :\n$reply',
    attachment: null,
    attachmentType: null,
    dismissed: false,
    sendFCM: true,
    metaData: notiDefaultMap,
  );
}

// -----------------------------------------------------------------------------
/// 24 - welcome to bldrs
NotiModel welcomeToBldrs() {
  return NotiModel(
    id: 'n01',
    name: 'welcomeToBldrs',
    sudo: const NotiSudo(
      subject: NotiSubject.welcome,
      eventTrigger: 'when new user joins bldrs.net',
      scheduledTiming: 'asPerDay : asPerHour',
      ifStatement: 'on new firebase user created',
      cityState: CityState.any,
      reciever: NotiRecieverType.user,
    ),
    senderID: bldrsSenderID,
    title: 'Welcome to Bldrs.net',
    pic: bldrsLogoURL,
    notiPicType: NotiPicType.bldrs,
    timeStamp: DateTime.now(),
    body:
        'Find thousands of businesses to help you find and build what you want to build',
    attachment: Iconz.welcomeToBldrsBanner_22x18,
    attachmentType: NotiAttachmentType.banner,
    dismissed: false,
    sendFCM: true,
    metaData: notiDefaultMap,
  );
}

// -----------------------------------------------------------------------------
//   /// X -
//   NotiModel xxx(){
//     return
//   NotiModel(
//   reason: NotiReason.,
//   timing: '',
//   Condition: '',
//   reciever: NotiReciever.,
//   cityState: CityState.,
//   title: '',
//   body: '',
//   metaData: notiDefaultMap,
//
//
//   senderPicURL: ,
//   sender: ,
//   id: ,
//   subject: ,
//   );
//   }
// -----------------------------------------------------------------------------
///
// -----------------------------------------------------------------------------
List<NotiModel> allNotifications() {
  return <NotiModel>[
    ///
    welcomeToBldrs(),
    // AUTO NOTIFICATIONS
    /// ============================
    ///   o - to USERS
    cityWentPublic(
      cityName: 'Arizona',
      iso3: 'usa',
    ),
    monthlyStatistics(
      numberOfNewBzz: 15,
      numberOfNewFlyers: 250,
    ),
    newPublishedFlyer(bzModel: _dummyBz, flyer: _dummyFlyer),

    ///   o - to AUTHORS
    flyerSaved(
      flyerID: _dummyFlyer.id,
      userModel: _dummyUser,
    ),
    flyerReviewed(
        userModel: _dummyUser,
        reviewBody: 'This is a dummy review on the flyer'),
    flyerShared(
      userModel: _dummyUser,
      flyerID: _dummyFlyer.id,
    ),
    userFollowed(
      userModel: _dummyUser,
    ),
    weeklyBzStatistics(
      calls: 777,
      reviews: 888,
      saves: 999,
      shares: 1010,
      views: 2222,
    ),
    monthlyBzStatistics(
      views: 11111,
      shares: 22212,
      saves: 1245,
      calls: 1254,
      followers: 6666,
      bzModel: _dummyBz,
      competitors: 45,
      monthName: 'November',
    ),
    authorInvitationCC(
      tinyBz: _dummyBz,
      sender: _dummyAuthor,
      reciever: _dummyUser,
    ),
    potentialCustomerQuestion(
      keyword: 'dummyKeyword',
      userModel: _dummyUser,
      cityName: 'El Suiz',
      district: 'ElMa3moura',
    ),

    ///   o - to USER
    buildSomething(),
    createSomethingNew(),
    planYourFuture(),

    feedbackAutoReply(),

    youDidNotSee(),
    rememberYourOptions(),

    chooseYourCustomerStatus(),
    flyerReviewReply(
      reviewBody: 'This is a dummy review',
      bzModel: _dummyBz,
    ),
    authorInvitation(
      bzModel: _dummyBz,
      authorModel: _dummyAuthor,
    ),

    countryWentGlobal(
      countryName: 'United States of Amrika',
      iso3: 'usa',
    ),
    sectionWentLive(sectionName: 'Resale properties'),

    questionReply(bzModel: _dummyBz, reply: 'This is a dummy bz reply'),

    ///   o - to AUTHOR
    authorInvitationReply(
      userModel: _dummyUser,
      invitationAccepted: true,
    ),

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
    bldrsFeedbackReply(
      reply: "This is bldrs replying over the user's feedback",
    ),
    // ------------------------------
    ///
// -----------------------------------------------------------------------------
  ];
}

// o ( FOLLOWING NOTIFICATIONS )
// --- BZ NEWS : NEW FOLLOWERS : (MIN OF NUMBER = X && MIN OF DURATION = T)


// o ( BZ PUBLISHED FLYER EDITOR'S REPLY )
// --- BZ NEWS : BLDRS EDITORS 'REJECTED, EDITED, HIGHLIGHTED' YOUR FLYER : (INSTANTANEOUS)

// o ( FLYERS SHARING )
// --- ANY USER : RECEIVED A FLYER : (INSTANTANEOUS)
// --- ANY USER : RECEIVED A COLLECTION OF FLYERS : (INSTANTANEOUS)

// o ( STATISTICS )
// --- BZ NEWS : COMPETITION SIGNUPS IN SAME FIELD : (MIN OF NUM = X && MIN OF DURATION = T)
// --- BZ NEWS : ALL BZ SIGNUPS IN ALL FIELDS : (MIN OF NUM = X && MIN OF DURATION = T)
// --- BZ NEWS : DAILY BZ PROFILE STATISTICS 'FOLLOWERS, VIEWS, SAVES, SHARES, CONTACTS, CALLS'
// --- ANY USER : WEEKLY NATIONAL STATISTICS
// --- ANY USER : MONTHLY GLOBAL STATISTICS
