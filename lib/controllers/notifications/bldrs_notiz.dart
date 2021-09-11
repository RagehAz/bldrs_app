import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/models/bz/tiny_bz.dart';
import 'package:bldrs/models/flyer/tiny_flyer.dart';
import 'package:bldrs/models/notification/noti_model.dart';
import 'package:bldrs/models/user/tiny_user.dart';
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

class BldrsNotiModelz {

  static String notiSound = 'default';
  static String notiStatus = 'done';

  static dynamic notiDefaultMap = {
    "click_action": "FLUTTER_NOTIFICATION_CLICK",
    "sound": notiSound,
    "status": notiStatus,
    "screen": "",
  };

  static String _bldrsSenderID = 'bldrs';
// -----------------------------------------------------------------------------
  static String _bldrsLogoURL = 'https://firebasestorage.googleapis.com/v0/b/bldrsnet.appspot.com/o/usersPics%2FrBjNU5WybKgJXaiBnlcBnfFaQSq1.jpg?alt=media&token=54a23d82-5642-4086-82b3-b4c1cb885b64';

  static TinyBz _dummyTinyBz = TinyBz.dummyTinyBz('ar1');
  static TinyFlyer _dummyTinyFlyer = TinyFlyer.dummyTinyFlyer('f001');
  static TinyUser _dummyTinyUser = TinyUser.dummyTinyUser();
  static TinyUser _dummyTinyAuthor = TinyUser.dummyTinyAuthor();
  // -----------------------------------------------------------------------------
  /// 1 - 28 days reminder
  static NotiModel buildSomething(){
    return
      NotiModel(
        id: 'n01',
        name: 'buildSomething',
        sudo:
            'subject          :   NotiSubject.reminder'
            'event trigger    :   when user did not sign in for 4 weeks'
            'scheduled timing :   asPerDays : 9 pm'
            'if statement     :   last sign in timeStamp > 28 days'
            'cityState        :   CityState.public'
            'reciever         :   NotiRecieverType.user',

        senderID: _bldrsSenderID,
        pic: _bldrsLogoURL,
        picType: NotiPicType.bldrs,
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
  static NotiModel createSomethingNew(){
    return
      NotiModel(
        id: 'n02',
        name: 'createSomethingNew',
        sudo:
            'subject          :   NotiSubject.reminder'
            'event trigger    :   when user did not sign in for a 5 weeks'
            'scheduled timing :   asPerDays : 10 am'
            'if statement     :   last sign in timeStamp > 35 days'
            'cityState        :   CityState.public'
            'reciever         :   NotiRecieverType.user,',

        senderID: _bldrsSenderID,
        pic: _bldrsLogoURL,
        picType: NotiPicType.bldrs,
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
  static NotiModel planYourFuture(){
    return
      NotiModel(
        id: 'n03',
        name: 'planYourFuture',
        sudo:
            'subject          :   NotiSubject.reminder,'
            'event trigger    :   when user did not sign in for  6 weeks'
            'scheduled timing :   asPerDays : 10 am'
            'if statement     :   last sign in timeStamp > 42 days'
            'cityState        :   CityState.public'
            'reciever         :   NotiRecieverType.user,',

        senderID: _bldrsSenderID,
        pic: _bldrsLogoURL,
        picType: NotiPicType.bldrs,
        title: 'Plan your future',
        timeStamp: DateTime.now(),
        body: 'Collect as many flyers as you can NOW, so when you start, You are ready. 👌',
        attachment: null,
        attachmentType: null,

        dismissed: false,
        sendFCM: true,
        metaData: notiDefaultMap,
      );
  }
// -----------------------------------------------------------------------------
  /// 4 - 7 days reminder for non SIGNED-UP aslan (only downloaded Bldrs.net)
  static NotiModel youDidNotSee(){
    return
      NotiModel(
        id: 'n04',
        name: 'youDidNotSee',
        sudo:
            'subject          :   NotiSubject.reminder,'
            'event trigger    :   when user downloaded app but did not sign up aslan for 7 days'
            'scheduled timing :   asPerDays : 10 am'
            'if statement     :   firebase user.id exists && UserModel does not exist && last signed in timeStamp > 7 days'
            'cityState        :   CityState.public'
            'reciever         :   NotiRecieverType.user',

        senderID: _bldrsSenderID,
        pic: _bldrsLogoURL,
        picType: NotiPicType.bldrs,
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
  static NotiModel rememberYourOptions(){
    return
      NotiModel(
        id: 'n05',
        name: 'rememberYourOptions',
        sudo:
            'subject          :   NotiSubject.reminder,'
            'event trigger    :   when user downloaded app but did not sign up aslan for 14 days'
            'scheduled timing :   asPerDays : 10 am'
            'if statement     :   firebase user.id exists && UserModel does not exist && last signed in timeStamp > 14 days'
            'cityState        :   CityState.public'
            'reciever         :   NotiRecieverType.user',

        senderID: _bldrsSenderID,
        pic: _bldrsLogoURL,
        picType: NotiPicType.bldrs,
        title: 'Consider your Options',
        timeStamp: DateTime.now(),
        body: '🔺 Bldrs.net is your RealEstate, Construction & Supplies search engine.',
        attachment: null,
        attachmentType: null,

        dismissed: false,
        sendFCM: true,
        metaData: notiDefaultMap,
      );
  }
// -----------------------------------------------------------------------------
  /// 6 - city went public
  static NotiModel cityWentPublic({@required String cityName, @required String iso3}){

    return
      NotiModel(
        id: 'n06',
        name: 'cityWentPublic',
        sudo:
            'subject          :   NotiSubject.event,'
            'event trigger    :   when city goes public'
            'scheduled timing :   asPerDay : 7:00 pm'
            'if statement     :   user.zone.city == this city & cityIsPublic = true after it was false'
            'cityState        :   CityState.public'
            'reciever         :   NotiRecieverType.users',

        senderID: _bldrsSenderID,
        pic: iso3,
        picType: NotiPicType.country,
        title: '${cityName} Builders went public.',
        timeStamp: DateTime.now(),
        body: '📢 Bldrs businesses have been posting for some time, and now all their work is LIVE !',
        attachment: null,
        attachmentType: null,

        dismissed: false,
        sendFCM: true,
        metaData: notiDefaultMap,
      );
  }
// -----------------------------------------------------------------------------
  /// 7 - after user feedback
  static NotiModel feedbackAutoReply(){
    return
      NotiModel(
        id: 'n07',
        name: 'feedbackAutoReply',
        sudo:
            'subject          :   NotiSubject.event,'
            'event trigger    :   after user posts opinion feedback with 24 hours'
            'scheduled timing :   asPerDay : 10:00 am'
            'if statement     :   feedback.time.sinceThen == 24 hours'
            'cityState        :   CityState.any'
            'reciever         :   NotiRecieverType.user',

        senderID: _bldrsSenderID,
        pic: _bldrsLogoURL,
        picType: NotiPicType.bldrs,
        title: 'Thank you',
        timeStamp: DateTime.now(),
        body: 'Thank you for taking part in building Bldrs.net, Your feedback is currently being reviewed.',
        attachment: null,
        attachmentType: null,

        dismissed: false,
        sendFCM: true,
        metaData: notiDefaultMap,
      );
  }
// -----------------------------------------------------------------------------
  /// 8 - feedback bldrs reply
  static NotiModel bldrsFeedbackReply({@required String reply}){

    return
      NotiModel(
        id: 'n08',
        name: 'bldrsFeedbackReply',
        sudo:
            'subject          :   NotiSubject.event,'
            'event trigger    :   when bldrs.net replies over customer feedback'
            'scheduled timing :   on time'
            'if statement     :   if bldrs.net admin decides to reply'
            'cityState        :   CityState.any'
            'reciever         :   NotiRecieverType.user,',

        senderID: _bldrsSenderID,
        pic: _bldrsLogoURL,
        picType: NotiPicType.bldrs,
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
  static NotiModel chooseYourCustomerStatus(){
    return
      NotiModel(
        id: 'n09',
        name: 'chooseYourCustomerStatus',
        sudo:
            'subject          :   NotiSubject.reminder,'
            'event trigger    :   when user did not assign userStatus for 2 days'
            'scheduled timing :   asPerDay : 2:00 pm'
            'if statement     :   if userModel.userStatus == null,, or not assigned'
            'cityState        :   CityState.any'
            'reciever         :   NotiRecieverType.user',

        senderID: _bldrsSenderID,
        pic: _bldrsLogoURL,
        picType: NotiPicType.bldrs,
        title: 'The Easy way',
        timeStamp: DateTime.now(),
        body: 'Builders will assist find your specific needs, just assign your profile status 👌',
        attachment: null,
        attachmentType: null,

        dismissed: false,
        sendFCM: true,
        metaData: notiDefaultMap,
      );
  }
// -----------------------------------------------------------------------------
  /// 10 - monthly statistics
  static NotiModel monthlyStatistics({@required int numberOfNewBzz, @required int numberOfNewFlyers}){
    return
      NotiModel(
        id: 'n10',
        name: 'monthlyStatistics',
        sudo:
            'subject          :   NotiSubject.ad,'
            'event trigger    :   every month'
            'scheduled timing :   first day in the month : 10:00 am'
            'if statement     :   no condition'
            'cityState        :   CityState.public'
            'reciever         :   NotiRecieverType.users',

        senderID: _bldrsSenderID,
        pic: _bldrsLogoURL,
        picType: NotiPicType.bldrs,
        title: 'The Community is Growing',
        timeStamp: DateTime.now(),
        body: '$numberOfNewBzz new businesses had joined and $numberOfNewFlyers new flyers were published on Bldrs.net Last month',
        attachment: null,
        attachmentType: null,

        dismissed: false,
        sendFCM: true,
        metaData: notiDefaultMap,
      );
  }
// -----------------------------------------------------------------------------
  /// 11 - new flyer by followed non free bz account (premium - super)
  static NotiModel newPublishedFlyer({@required TinyBz tinyBz, @required TinyFlyer tinyFlyer}){

    // String _flyerType = TextGenerator.flyerTypeSingleStringer(context, flyerType);

    return
      NotiModel(
        id: 'n11',
        name: 'newFlyerByFollowedPremiumBz',
        sudo:
            'subject          :   NotiSubject.event,'
            'event trigger    :   when followed premium bz adds new flyers'
            'scheduled timing :   asPerDay : asPerHour'
            'if statement     :   bz.followers.include(userID)'
            'cityState        :   CityState.public'
            'reciever         :   NotiRecieverType.users',

        senderID: tinyBz.bzID,
        pic: tinyBz.bzLogo,
        picType: NotiPicType.bz,
        title: 'New flyer',
        timeStamp: DateTime.now(),
        body: '${tinyBz.bzName} published a new ${tinyFlyer.flyerType.toString()}flyer', // TASK : fix this flyer type localized in notification
        attachment: tinyFlyer.flyerID,
        attachmentType: NotiAttachmentType.flyers,

        dismissed: false,
        sendFCM: true,
        metaData: notiDefaultMap,
      );
  }
// -----------------------------------------------------------------------------
  /// 12 - flyer review reply
  static NotiModel flyerReviewReply({@required TinyBz tinyBz, @required String reviewBody}){
    return
      NotiModel(
        id: 'n12',
        name: 'flyerReviewReply',
        sudo:
            'subject          :   NotiSubject.event,'
            'event trigger    :   when author replies on user review'
            'scheduled timing :   asPerDay : asPerTime'
            'if statement     :   if reviewModel.authorReplied turns true'
            'cityState        :   CityState.public'
            'reciever         :   NotiRecieverType.user',

        senderID: tinyBz.bzID,
        pic: tinyBz.bzLogo,
        picType: NotiPicType.bz,
        title: '${tinyBz.bzName} has replied on your review',
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
  static NotiModel flyerReviewed({@required TinyUser tinyUser, @required String reviewBody}){
    return
      NotiModel(
        id: 'n13',
        name: 'flyerReviewed',
        sudo:
            'subject          : NotiSubject.event,'
            'event trigger    :   when user posts flyer review'
            'scheduled timing :   asPerDay : asPerTime'
            'if statement     :   on review doc created && bz.AuthorsIDs.include(userID)'
            'cityState        :   CityState.public'
            'reciever         : NotiRecieverType.authors',

        senderID: tinyUser.userID,
        pic: tinyUser.pic,
        picType: NotiPicType.user,
        title: '${tinyUser.name} wrote a review on your flyer',
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
  static NotiModel flyerSaved({@required TinyUser tinyUser, @required String flyerID}){
    return
      NotiModel(
        id: 'n14',
        name: 'flyerSaved',
        sudo:
            'subject          :   NotiSubject.event,'
            'event trigger    :   when a user saves a flyer'
            'scheduled timing :   asPerDay : asPerTime'
            'if statement     :   send to all bz authors'
            'cityState        :   CityState.public'
            'reciever         :   NotiRecieverType.authors',

        senderID: tinyUser.userID,
        pic: tinyUser.pic,
        picType: NotiPicType.user,
        title: '${tinyUser.name} saved your flyer',
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
  static NotiModel flyerShared({@required TinyUser tinyUser, @required String flyerID}){
    return
      NotiModel(
        id: 'n15',
        name: 'flyerShared',
        sudo:
            'subject          :   NotiSubject.event,'
            'event trigger    :   when a user shares a flyer'
            'scheduled timing :   asPerDay : asPerTime'
            'if statement     :   send to all bz authors'
            'cityState        :   CityState.public'
            'reciever         :   NotiRecieverType.authors',

        senderID: tinyUser.userID,
        pic: tinyUser.pic,
        picType: NotiPicType.user,
        title: '${tinyUser.name} shared your flyer',
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
  static NotiModel userFollowed({@required TinyUser tinyUser}){
    return
      NotiModel(
        id: 'n16',
        name: 'userFollowed',
        sudo:
            'subject          :   NotiSubject.event,'
            'event trigger    :   when a user follows bz'
            'scheduled timing :   asPerDay : asPerTime'
            'if statement     :   send to all bz authors'
            'cityState        :   CityState.public'
            'reciever         :   NotiRecieverType.authors',

        senderID: tinyUser.userID,
        pic: tinyUser.pic,
        picType: NotiPicType.user,
        title: '${tinyUser.name} followed your business page',
        timeStamp: DateTime.now(),
        body: '${tinyUser.name} will be updated with you activity',
        attachment: null,
        attachmentType: null,

        dismissed: false,
        sendFCM: true,
        metaData: notiDefaultMap,
      );
  }
// -----------------------------------------------------------------------------
  /// 15 - weekly bz statistics
  static NotiModel weeklyBzStatistics({@required int views, @required int saves, @required int shares, @required int reviews, @required int calls}){
    return
      NotiModel(
        id: 'n17',
        name: 'weeklyBzStatistics',
        sudo:
            'subject          :   NotiSubject.ad,'
            'event trigger    :   every week'
            'scheduled timing :   Monday : 10:00 am'
            'if statement     :   send to all bz authors'
            'cityState        :   CityState.any'
            'reciever         :   NotiRecieverType.authors',

        senderID: _bldrsSenderID,
        pic: _bldrsLogoURL,
        picType: NotiPicType.bldrs,
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
  static NotiModel authorInvitation({@required TinyUser tinyAuthor, @required TinyBz tinyBz}){
    return
      NotiModel(
        id: 'n18',
        name: 'authorInvitation',
        sudo:
            'subject          :   NotiSubject.event,'
            'event trigger    :   when author sends author invitation to a user'
            'scheduled timing :   asPerDate : asPerTime'
            'if statement     :   ... will see ' /// TASK : Develop author invitation thing
            'cityState        :   CityState.any'
            'reciever         :   NotiRecieverType.user',

        senderID: tinyAuthor.userID,
        pic: tinyBz.bzLogo,
        picType: NotiPicType.author,
        timeStamp: DateTime.now(),
        title: '${tinyAuthor.name} invites you',
        body: 'You are invited to become an author of the Bldr account : ${tinyBz.bzName}',
        attachment: tinyBz.bzLogo,
        attachmentType: NotiAttachmentType.bz,

        dismissed: false,
        sendFCM: true,
        metaData: notiDefaultMap,
      );
  }
// -----------------------------------------------------------------------------
  /// 17 - author Invitation reply
  static NotiModel authorInvitationReply({@required TinyUser tinyUser, @required bool invitationAccepted}){

    String _reply = invitationAccepted == true ? 'accepted' : 'rejected';

    return
      NotiModel(
        id: 'n19',
        name: 'authorInvitationReply',
        sudo:
            'subject          :   NotiSubject.event,'
            'event trigger    :   when user replies on author invitation'
            'scheduled timing :   asPerDate : asPerTime'
            'if statement     :   for all bz authors to know ' /// TASK : Develop author invitation thing
            'cityState        :   CityState.any'
            'reciever         :   NotiRecieverType.authors',

        senderID: tinyUser.userID,
        pic: tinyUser.pic,
        picType: NotiPicType.user,
        title: '${tinyUser.name} Replied on his author invitation',
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
  static NotiModel authorInvitationCC({@required TinyUser sender, @required TinyUser reciever, @required TinyBz tinyBz}){
    return
      NotiModel(
        id: 'n20',
        name: 'authorInvitationCC',
        sudo:
            'subject          : NotiSubject.event,'
            'event trigger    :   when author sends author invitation to a user'
            'scheduled timing :   asPerDate : asPerTime'
            'if statement     :   for all authors in the team except the invitation sender'
            'cityState        :   CityState.any'
            'reciever         : NotiRecieverType.authors',

        senderID: sender.userID,
        pic: sender.pic,
        picType: NotiPicType.author,
        title: '${sender.name} invited ${reciever.name}',
        timeStamp: DateTime.now(),
        body: 'An invitation has been sent for ${reciever.name} to join the team of ${tinyBz.bzName}',
        attachment: null,
        attachmentType: null,

        sendFCM: true,
        dismissed: false,
        metaData: notiDefaultMap,
      );
  }
// -----------------------------------------------------------------------------
  /// 19 - country went global
  static NotiModel countryWentGlobal({@required String iso3, @required String countryName}){

    return
      NotiModel(
        id: 'n21',
        name: 'countryWentGlobal',
        sudo:
            'subject          : NotiSubject.event,'
            'event trigger    :   when a county goes global'
            'scheduled timing :   Saturday : 9:00 pm'
            'if statement     :   country.isGlobal turns true -- all people in the world receive this'
            'cityState        :   CityState.any'
            'reciever         : NotiRecieverType.users',

        senderID: _bldrsSenderID,
        picType: NotiPicType.country,
        pic: iso3,
        title: '${countryName} Builders are Global',
        timeStamp: DateTime.now(),
        body: '${countryName} Business and their flyers are now available world wide to reach',
        attachment: null,
        attachmentType: null,

        dismissed: false,
        sendFCM: true,
        metaData: notiDefaultMap,
      );
  }
// -----------------------------------------------------------------------------
  /// 20 - section went live
  static NotiModel sectionWentLive({@required String sectionName}){
    return
      NotiModel(
        id: 'n22',
        name: 'sectionWentLive',
        sudo:
            'subject          :   NotiSubject.event,'
            'event trigger    :   when a section goes live'
            'scheduled timing :   Monday : 8 pm'
            'if statement     :   section.isLive turns true'
            'cityState        :   CityState.any'
            'reciever         :   NotiRecieverType.users',

        senderID: _bldrsSenderID,
        pic: _bldrsLogoURL,
        picType: NotiPicType.bldrs,
        title: 'Section ${sectionName} is now available',
        timeStamp: DateTime.now(),
        body: 'You can now view the businesses publishing flyers in section ${sectionName}',
        attachment: null,
        attachmentType: null,

        dismissed: false,
        sendFCM: true,
        metaData: notiDefaultMap,
      );
  }
// -----------------------------------------------------------------------------
  /// 21 - monthly bz statistics
  static NotiModel monthlyBzStatistics({@required TinyBz tinyBz, @required String monthName, @required int followers, @required int calls, @required int saves, @required int views, @required int shares, @required int competitors,}){
    return
      NotiModel(
        id: 'n23',
        name: 'monthlyBzStatistics',
        sudo:
            'subject          :   NotiSubject.ad,'
            'event trigger    :   every week'
            'scheduled timing :   Monday : 10:00 am'
            'if statement     :   send to all bz authors'
            'cityState        :   CityState.any'
            'reciever         :   NotiRecieverType.authors',

        senderID: _bldrsSenderID,
        pic: _bldrsLogoURL,
        picType: NotiPicType.bldrs,
        title: '${tinyBz.bzName} statistics for $monthName',
        timeStamp: DateTime.now(),
        body: 'on $monthName you have got $followers followers, $calls calls, $saves saves, $views views, $shares shares while $competitors new businesses specialized in ${tinyBz.bzType.toString()} have joined Bldrs.net this month',
        attachment: null,
        attachmentType: null,

        sendFCM: true,
        dismissed: false,
        metaData: notiDefaultMap,
      );
  }
// -----------------------------------------------------------------------------
  /// 22 - potential customer to bzz
  static NotiModel potentialCustomerQuestion({@required TinyUser tinyUser, @required String keyword, @required String cityName, @required String district}){
    return
      NotiModel(
        id: 'n24',
        name: 'potentialCustomerQuestion',
        sudo:
            'subject          :   NotiSubject.event,'
            'event trigger    :   when user ask a question related to a specific keyword topic'
            'scheduled timing :   asPerDay : asPerHour'
            'if statement     :   bz is subscribed to a keyword topic in questions'
            'cityState        :   CityState.any'
            'reciever         :   NotiRecieverType.authors',

        senderID: tinyUser.userID,
        pic: tinyUser.pic,
        picType: NotiPicType.user,
        title: 'Potential customer',
        timeStamp: DateTime.now(),
        body: '${tinyUser.name} asked a public question about ${keyword} in $district, $cityName',
        attachment: null,
        attachmentType: null,

        dismissed: false,
        sendFCM: true,
        metaData: notiDefaultMap,
      );
  }
// -----------------------------------------------------------------------------
  /// 23 - question reply
  static NotiModel questionReply({@required TinyBz tinyBz, @required String reply}){
    return
      NotiModel(
        id: 'n25',
        name: 'questionReply',
        sudo:
            'subject          :   NotiSubject.event,'
            'event trigger    :   when an author answers a question by user'
            'scheduled timing :   asPerDay : asPerHour'
            'if statement     :   user has a question + new reply in question replies sub doc'
            'cityState        :   CityState.any'
            'reciever         :   NotiRecieverType.user',

        senderID: tinyBz.bzID,
        pic: tinyBz.bzID,
        picType: NotiPicType.bz,
        title: 'You received an answer',
        timeStamp: DateTime.now(),
        body: '${tinyBz.bzName} replied to your question :\n$reply',
        attachment: null,
        attachmentType: null,

        dismissed: false,
        sendFCM: true,
        metaData: notiDefaultMap,
      );
  }
// -----------------------------------------------------------------------------
  /// 24 - welcome to bldrs
  static NotiModel welcomeToBldrs(){
    return
      NotiModel(
        id: 'n26',
        name: 'welcomeToBldrs',
        sudo:
            'subject          :   NotiSubject.welcome,'
            'event trigger    :   when new user joins bldrs.net'
            'scheduled timing :   asPerDay : asPerHour'
            'if statement     :   on new firebase user created'
            'cityState        :   CityState.any'
            'reciever         :   NotiRecieverType.user',

        senderID: _bldrsSenderID,
        title: 'Welcome to Bldrs.net',
        pic: _bldrsLogoURL,
        picType: NotiPicType.bldrs,
        timeStamp: DateTime.now(),
        body: 'Find thousands of businesses to help you find and build what you want to build',
        attachment: Iconz.WelcomeToBldrsBanner_22x18,
        attachmentType: NotiAttachmentType.banner,

        dismissed: false,
        sendFCM: true,
        metaData: notiDefaultMap,
      );
  }
// -----------------------------------------------------------------------------
//   /// X -
//   static NotiModel xxx(){
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
  static List<NotiModel> allNotifications(){
    return <NotiModel>[
      ///
      welcomeToBldrs(),
      // AUTO NOTIFICATIONS
      /// ============================
      ///   o - to USERS
      cityWentPublic(
        cityName:'Arizona',
        iso3: 'usa',
      ),
      monthlyStatistics(
        numberOfNewBzz: 15,
        numberOfNewFlyers: 250,
      ),
      newPublishedFlyer(
        tinyBz: _dummyTinyBz,
        tinyFlyer: _dummyTinyFlyer
      ),

      ///   o - to AUTHORS
      flyerSaved(
        flyerID: _dummyTinyFlyer.flyerID,
        tinyUser: _dummyTinyUser,
      ),
      flyerReviewed(
        tinyUser: _dummyTinyUser,
        reviewBody: 'This is a dummy review on the flyer'
      ),
      flyerShared(
        tinyUser: _dummyTinyUser,
        flyerID: _dummyTinyFlyer.flyerID,
      ),
      userFollowed(
        tinyUser: _dummyTinyUser,
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
        tinyBz: _dummyTinyBz,
        competitors: 45,
        monthName: 'November',
      ),
      authorInvitationCC(
        tinyBz: _dummyTinyBz,
        sender: _dummyTinyAuthor,
        reciever: _dummyTinyUser,
      ),
      potentialCustomerQuestion(
        keyword: 'dummyKeyword',
        tinyUser: _dummyTinyUser,
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
        tinyBz: _dummyTinyBz,
      ),
      authorInvitation(
        tinyBz: _dummyTinyBz,
        tinyAuthor: _dummyTinyAuthor,
      ),

      countryWentGlobal(
        countryName: 'United States of Amrika',
        iso3: 'usa',
      ),
      sectionWentLive(
        sectionName: 'Resale properties'
      ),

      questionReply(
        tinyBz: _dummyTinyBz,
        reply: 'This is a dummy bz reply'
      ),

      ///   o - to AUTHOR
      authorInvitationReply(
        tinyUser: _dummyTinyUser,
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
        reply: 'This is bldrs replying over the user\'s feedback',
      ),
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
