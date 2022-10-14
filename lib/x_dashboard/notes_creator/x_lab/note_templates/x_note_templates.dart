import 'package:bldrs/a_models/e_notes/a_note_model.dart';
import 'package:bldrs/a_models/e_notes/aa_note_parties_model.dart';
import 'package:bldrs/a_models/e_notes/aa_poll_model.dart';

const List<NoteModel> noteTemplates = <NoteModel>[

  /// 28 days reminder
  NoteModel(
    parties: NoteParties(
      senderID: NoteParties.bldrsSenderID,
      senderImageURL: NoteParties.bldrsLogoStaticURL,
      senderType: PartyType.bldrs,
      receiverID: null,
      receiverType: PartyType.user,
    ),
    sentTime: null,
    /// variables
    id: 'buildSomething',
    title: 'Build Something',
    body: 'Bldrs.net',
    /// pseudo
    //   subject: NotiSubject.reminder,
    //   eventTrigger: 'when user did not sign in for 4 weeks',
    //   scheduledTiming: 'asPerDays : 9 pm',
    //   ifStatement: 'last sign in timeStamp > 28 days',
    //   cityState: CityState.public,
    //   reciever: NotiRecieverType.user,
  ),

  /// 35 days reminder
  NoteModel(
    parties: NoteParties(
      senderID: NoteParties.bldrsSenderID,
      senderImageURL: NoteParties.bldrsLogoStaticURL,
      senderType: PartyType.bldrs,
      receiverID: null,
      receiverType: PartyType.user,
    ),
    sentTime: null,
    /// variables
    id: 'createSomethingNew',
    title: 'Create Something new',
    body: 'Bldrs.net',
    /// pseudo
    //   subject: NotiSubject.reminder,
    //   eventTrigger: 'when user did not sign in for a 5 weeks',
    //   scheduledTiming: 'asPerDays : 10 am',
    //   ifStatement: 'last sign in timeStamp > 35 days',
    //   cityState: CityState.public,
    //   reciever: NotiRecieverType.user,
  ),

  /// 42 days reminder
  NoteModel(
    parties: NoteParties(
      senderID: NoteParties.bldrsSenderID,
      senderImageURL: NoteParties.bldrsLogoStaticURL,
      senderType: PartyType.bldrs,
      receiverID: null,
      receiverType: PartyType.user,
    ),
    sentTime: null,
    /// variables
    id: 'planYourFuture',
    title: 'Plan your future',
    body: 'Collect as many flyers as you can NOW, so when you start, You are ready. 👌',
    /// pseudo
    //   subject: NotiSubject.reminder,
    //   eventTrigger: 'when user did not sign in for  6 weeks',
    //   scheduledTiming: 'asPerDays : 10 am',
    //   ifStatement: 'last sign in timeStamp > 42 days',
    //   cityState: CityState.public,
    //   reciever: NotiRecieverType.user,
  ),

  /// 7 days reminder for non SIGNED-UP aslan (only downloaded Bldrs.net)
  NoteModel(
    parties: NoteParties(
      senderID: NoteParties.bldrsSenderID,
      senderImageURL: NoteParties.bldrsLogoStaticURL,
      senderType: PartyType.bldrs,
      receiverID: null,
      receiverType: PartyType.user,
    ),
    sentTime: null,
    /// variables
    id: 'youDidNotSee',
    title: 'Come and See',
    body: '👁️ You did not see what lies inside Bldrs.net',
    /// pseudo
    //   subject: NotiSubject.reminder,
    //   eventTrigger: 'when user downloaded app but did not sign up aslan for 7 days',
    //   scheduledTiming: 'asPerDays : 10 am',
    //   ifStatement: 'firebase user.id exists && UserModel does not exist && last signed in timeStamp > 7 days',
    //   cityState: CityState.public,
    //   reciever: NotiRecieverType.user,
  ),

  /// 14 days reminder for non SIGNED-UP aslan (only downloaded Bldrs.net)
  NoteModel(
    parties: NoteParties(
      senderID: NoteParties.bldrsSenderID,
      senderImageURL: NoteParties.bldrsLogoStaticURL,
      senderType: PartyType.bldrs,
      receiverID: null,
      receiverType: PartyType.user,
    ),
    sentTime: null,
    /// variables
    id: 'rememberYourOptions',
    title: 'Consider your Options',
    body: '🔺 Bldrs.net is your RealEstate, Construction & Supplies search engine.',
    /// pseudo
    //   subject: NotiSubject.reminder,
    //   eventTrigger: 'when user downloaded app but did not sign up aslan for 14 days',
    //   scheduledTiming: 'asPerDays : 10 am',
    //   ifStatement: 'firebase user.id exists && UserModel does not exist && last signed in timeStamp > 14 days',
    //   cityState: CityState.public,
    //   reciever: NotiRecieverType.user,
  ),

  /// city went public
  NoteModel(
    parties: NoteParties(
      senderID: null,
      senderImageURL: null,
      senderType: PartyType.country,
      receiverID: null,
      receiverType: PartyType.user,
    ),
    sentTime: null,
    /// variables
    id: 'cityWentPublic',
    title: '#CityName Builders went public.',
    body: '📢 Bldrs businesses have been posting for some time, and now all their work is LIVE !',
    /// pseudo
    //   subject: NotiSubject.event,
    //   eventTrigger: 'when city goes public',
    //   scheduledTiming: 'asPerDay : 7:00 pm',
    //   ifStatement:'user.zone.city == this city & cityIsPublic = true after it was false',
    //   cityState: CityState.public,
    //   reciever: NotiRecieverType.users,
  ),

  /// after user feedback
  NoteModel(
    parties: NoteParties(
      senderID: NoteParties.bldrsSenderID,
      senderImageURL: NoteParties.bldrsLogoStaticURL,
      senderType: PartyType.bldrs,
      receiverID: null,
      receiverType: PartyType.user,
    ),
    sentTime: null,
    /// variables
    id: 'feedbackAutoReply',
    title: 'Thank you',
    body: 'Thank you for taking part in building Bldrs.net, Your feedback is currently being reviewed.',
    /// pseudo
    //   subject: NotiSubject.event,
    //   eventTrigger: 'after user posts opinion feedback with 24 hours',
    //   scheduledTiming: 'asPerDay : 10:00 am',
    //   ifStatement: 'feedback.time.sinceThen == 24 hours',
    //   cityState: CityState.any,
    //   reciever: NotiRecieverType.user,
  ),

  /// feedback bldrs reply
  NoteModel(
    parties: NoteParties(
      senderID: NoteParties.bldrsSenderID,
      senderImageURL: NoteParties.bldrsLogoStaticURL,
      senderType: PartyType.bldrs,
      receiverID: null,
      receiverType: PartyType.user,
    ),
    sentTime: null,
    /// variables
    id: 'bldrsFeedbackReply',
    title: 'Bldrs.net team have replied over your feedback',
    body: null,
    /// pseudo
    //   subject: NotiSubject.event,
    //   eventTrigger: 'when bldrs.net replies over customer feedback',
    //   scheduledTiming: 'on time',
    //   ifStatement: 'if bldrs.net admin decides to reply',
    //   cityState: CityState.any,
    //   reciever: NotiRecieverType.user,
  ),

  /// profile status reminder
  NoteModel(
    parties: NoteParties(
      senderID: NoteParties.bldrsSenderID,
      senderImageURL: NoteParties.bldrsLogoStaticURL,
      senderType: PartyType.bldrs,
      receiverID: null,
      receiverType: PartyType.user,
    ),
    sentTime: null,
    /// variables
    id: 'chooseYourCustomerStatus',
    title: 'The Easy way',
    body: 'Builders will assist find your specific needs, just assign your profile status 👌',
    /// pseudo
    //   subject: NotiSubject.event,
    //   eventTrigger: 'when bldrs.net replies over customer feedback',
    //   scheduledTiming: 'on time',
    //   ifStatement: 'if bldrs.net admin decides to reply',
    //   cityState: CityState.any,
    //   reciever: NotiRecieverType.user,
  ),

  /// monthly statistics
  NoteModel(
    parties: NoteParties(
      senderID: NoteParties.bldrsSenderID,
      senderImageURL: NoteParties.bldrsLogoStaticURL,
      senderType: PartyType.bldrs,
      receiverID: null,
      receiverType: PartyType.bz,
    ),
    sentTime: null,
    /// variables
    id: 'monthlyStatistics',
    title: 'The Community is Growing',
    body: '#numberOfNewBzz new businesses had joined and #numberOfNewFlyers new flyers were published on Bldrs.net Last month',
    /// pseudo
    //   subject: NotiSubject.ad,
    //   eventTrigger: 'every month',
    //   scheduledTiming: 'first day in the month : 10:00 am',
    //   ifStatement: 'no condition',
    //   cityState: CityState.public,
    //   reciever: NotiRecieverType.users,
  ),

  /// new flyer by followed non free bz account (premium - super)
  NoteModel(
    parties: NoteParties(
      senderID: null,
      senderImageURL: null,
      senderType: PartyType.bz,
      receiverID: null,
      receiverType: PartyType.user,
    ),
    sentTime: null,
    /// variables
    id: 'newFlyerByFollowedPremiumBz',
    title: 'New flyer',
    body: '#{bzModel.name} published a new #{flyer.flyerType.toString()}flyer',
    /// pseudo
    //   subject: NotiSubject.event,
    //   eventTrigger: 'when followed premium bz adds new flyers',
    //   scheduledTiming: 'asPerDay : asPerHour',
    //   ifStatement: 'bz.followers.include(userID)',
    //   cityState: CityState.public,
    //   reciever: NotiRecieverType.users,
  ),

  /// flyer review reply
  NoteModel(
    parties: NoteParties(
      senderID: null,
      senderImageURL: null,
      senderType: PartyType.bz,
      receiverID: null,
      receiverType: PartyType.user,
    ),
    sentTime: null,
    /// variables
    id: 'flyerReviewReply',
    title: '#{bzModel.name} has replied on your review',
    body: null,
    /// pseudo
    //   subject: NotiSubject.event,
    //   eventTrigger: 'when author replies on user review',
    //   scheduledTiming: 'asPerDay : asPerTime',
    //   ifStatement: 'if reviewModel.authorReplied turns true',
    //   cityState: CityState.public,
    //   reciever: NotiRecieverType.user,
  ),

  /// flyerReview
  NoteModel(
    parties: NoteParties(
      senderID: null,
      senderImageURL: null,
      senderType: PartyType.user,
      receiverID: null,
      receiverType: PartyType.bz,
    ),
    sentTime: null,
    /// variables
    id: 'flyerReviewed',
    title: '#{userModel.name} wrote a review on your flyer',
    body: null,
    /// pseudo
    //   subject: NotiSubject.event,
    //   eventTrigger: 'when user posts flyer review',
    //   scheduledTiming: 'asPerDay : asPerTime',
    //   ifStatement: 'on review doc created && bz.AuthorsIDs.include(userID)',
    //   cityState: CityState.public,
    //   reciever: NotiRecieverType.authors,
  ),

  /// flyerReview
  NoteModel(
    parties: NoteParties(
      senderID: null,
      senderImageURL: null,
      senderType: PartyType.user,
      receiverID: null,
      receiverType: PartyType.bz,
    ),
    sentTime: null,
    /// variables
    id: 'flyerSaved',
    title: '#{userModel.name} saved your flyer',
    body: null,
    /// pseudo
    //   subject: NotiSubject.event,
    //   eventTrigger: 'when a user saves a flyer',
    //   scheduledTiming: 'asPerDay : asPerTime',
    //   ifStatement: 'send to all bz authors',
    //   cityState: CityState.public,
    //   reciever: NotiRecieverType.authors,
  ),

  /// flyer Shared
  NoteModel(
    parties: NoteParties(
      senderID: null,
      senderImageURL: null,
      senderType: PartyType.user,
      receiverID: null,
      receiverType: PartyType.bz,
    ),
    sentTime: null,
    /// variables
    id: 'flyerShared',
    title: '#{userModel.name} shared your flyer',
    body: null,
    /// pseudo
    //   subject: NotiSubject.event,
    //   eventTrigger: 'when a user shares a flyer',
    //   scheduledTiming: 'asPerDay : asPerTime',
    //   ifStatement: 'send to all bz authors',
    //   cityState: CityState.public,
    //   reciever: NotiRecieverType.authors,
  ),

  /// user follow
  NoteModel(
    parties: NoteParties(
      senderID: null,
      senderImageURL: null,
      senderType: PartyType.user,
      receiverID: null,
      receiverType: PartyType.bz,
    ),
    sentTime: null,
    /// variables
    id: 'userFollowed',
    title: '#{userModel.name} followed your business page',
    body: '#{userModel.name} will be updated with you activity',
    /// pseudo
    //   subject: NotiSubject.event,
    //   eventTrigger: 'when a user follows bz',
    //   scheduledTiming: 'asPerDay : asPerTime',
    //   ifStatement: 'send to all bz authors',
    //   cityState: CityState.public,
    //   reciever: NotiRecieverType.authors,
  ),

  ///  weekly bz statistics
  NoteModel(
    parties: NoteParties(
      senderID: NoteParties.bldrsSenderID,
      senderImageURL: NoteParties.bldrsLogoStaticURL,
      senderType: PartyType.bldrs,
      receiverID: null,
      receiverType: PartyType.bz,
    ),
    sentTime: null,
    /// variables
    id: 'weeklyBzStatistics',
    title: 'Your weekly stats',
    body: 'This week you got :\n'
        '#views flyer views\n'
        '#saves saves\n'
        '#shares shares\n'
        '#reviews reviews\n'
        '#calls phone calls',
    /// pseudo
    //   subject: NotiSubject.ad,
    //   eventTrigger: 'every week',
    //   scheduledTiming: 'Monday : 10:00 am',
    //   ifStatement: 'send to all bz authors',
    //   cityState: CityState.any,
    //   reciever: NotiRecieverType.authors,
  ),

  /// authorInvitation
  NoteModel(
    parties: NoteParties(
      senderID: null,
      senderImageURL: null,
      senderType: PartyType.bz,
      receiverID: null,
      receiverType: PartyType.user,
    ),
    sentTime: null,
    poll: PollModel(
      buttons: PollModel.acceptDeclineButtons,
      reply: null,
      replyTime: null,
    ),
    /// variables
    id: 'authorInvitation',
    title: '#{authorModel.name} invites you',
    body: 'You are invited to become an author of the Bldr account : #{bzModel.name}',
    /// pseudo
    //   subject: NotiSubject.event,
    //   eventTrigger: 'when author sends author invitation to a user',
    //   scheduledTiming: 'asPerDate : asPerTime',
    //   ifStatement: '... will see ',
    //   cityState: CityState.any,
    //   reciever: NotiRecieverType.user,
  ),

  /// author Invitation reply
  NoteModel(
    parties: NoteParties(
      senderID: null,
      senderImageURL: null,
      senderType: PartyType.user,
      receiverID: null,
      receiverType: PartyType.bz,
    ),
    sentTime: null,
    /// variables
    id: 'authorInvitationReply',
    title: '#{userModel.name} Replied on his author invitation',
    body: 'Invitation has been #_reply.',
    /// pseudo
    //   subject: NotiSubject.event,
    //   eventTrigger: 'when user replies on author invitation',
    //   scheduledTiming: 'asPerDate : asPerTime',
    //   ifStatement: 'for all bz authors to know ',
    //   cityState: CityState.any,
    //   reciever: NotiRecieverType.authors,
  ),

  /// author Invitation CC
  NoteModel(
    parties: NoteParties(
      senderID: null,
      senderImageURL: null,
      senderType: PartyType.bz,
      receiverID: null,
      receiverType: PartyType.bz,
    ),
    sentTime: null,
    /// variables
    id: 'authorInvitationCC',
    title: '#{sender.name} invited #{reciever.name}',
    body: 'An invitation has been sent for #{reciever.name} to join the team of #{bzModel.name}',
    /// pseudo
    //   subject: NotiSubject.event,
    //   eventTrigger: 'when author sends author invitation to a user',
    //   scheduledTiming: 'asPerDate : asPerTime',
    //   ifStatement: 'for all authors in the team except the invitation sender',
    //   cityState: CityState.any,
    //   reciever: NotiRecieverType.authors,
  ),

  /// country went global
  NoteModel(
    parties: NoteParties(
      senderID: null,
      senderImageURL: null,
      senderType: PartyType.country,
      receiverID: null,
      receiverType: PartyType.user,
    ),
    sentTime: null,
    /// variables
    id: 'countryWentGlobal',
    title: '#countryName Builders are Global',
    body:'#countryName Business and their flyers are now available world wide to reach',
    /// pseudo
    //   subject: NotiSubject.event,
    //   eventTrigger: 'when a county goes global',
    //   scheduledTiming: 'Saturday : 9:00 pm',
    //   ifStatement: 'country.isGlobal turns true -- all people in the world receive this',
    //   cityState: CityState.any,
    //   reciever: NotiRecieverType.users,
  ),

  /// section went live
  NoteModel(
    parties: NoteParties(
      senderID: NoteParties.bldrsSenderID,
      senderImageURL: NoteParties.bldrsLogoStaticURL,
      senderType: PartyType.bldrs,
      receiverID: null,
      receiverType: PartyType.user,
    ),
    sentTime: null,
    /// variables
    id: 'sectionWentLive',
    title: 'Section #sectionName is now available',
    body: 'You can now view the businesses publishing flyers in section #sectionName',
    /// pseudo
    //   subject: NotiSubject.event,
    //   eventTrigger: 'when a section goes live',
    //   scheduledTiming: 'Monday : 8 pm',
    //   ifStatement: 'section.isLive turns true',
    //   cityState: CityState.any,
    //   reciever: NotiRecieverType.users,
  ),

  /// monthly bz statistics
  NoteModel(
    parties: NoteParties(
      senderID: NoteParties.bldrsSenderID,
      senderImageURL: NoteParties.bldrsLogoStaticURL,
      senderType: PartyType.bldrs,
      receiverID: null,
      receiverType: PartyType.bz,
    ),
    sentTime: null,
    /// variables
    id: 'monthlyBzStatistics',
    title: '#{bzModel.name} statistics for #monthName',
    body: 'on #monthName you have got #followers followers, #calls calls, #saves saves, '
        '#views views, #shares shares while #competitors new businesses specialized in '
        '#{bzModel.bzTypes.toString()} have joined Bldrs.net this month',
    /// pseudo
    //   subject: NotiSubject.ad,
    //   eventTrigger: 'every week',
    //   scheduledTiming: 'Monday : 10:00 am',
    //   ifStatement: 'send to all bz authors',
    //   cityState: CityState.any,
    //   reciever: NotiRecieverType.authors,
  ),

  /// potential customer to bzz
  NoteModel(
    parties: NoteParties(
      senderID: null,
      senderImageURL: null,
      senderType: PartyType.user,
      receiverID: null,
      receiverType: PartyType.bz,
    ),
    sentTime: null,
    /// variables
    id: 'potentialCustomerQuestion',
    title: 'Potential customer',
    body: '#{userModel.name} asked a public question about #keyword in #district, #cityName',
    /// pseudo
    //   subject: NotiSubject.event,
    //   eventTrigger: 'when user ask a question related to a specific keyword topic',
    //   scheduledTiming: 'asPerDay : asPerHour',
    //   ifStatement: 'bz is subscribed to a keyword topic in questions',
    //   cityState: CityState.any,
    //   reciever: NotiRecieverType.authors,
  ),

  /// question reply
  NoteModel(
    parties: NoteParties(
      senderID: null,
      senderImageURL: null,
      senderType: PartyType.bz,
      receiverID: null,
      receiverType: PartyType.user,
    ),
    sentTime: null,
    /// variables
    id: 'questionReply',
    title: 'You received an answer',
    body: '#{bzModel.name} replied to your question :\n#reply',
    /// pseudo
    //   subject: NotiSubject.event,
    //   eventTrigger: 'when an author answers a question by user',
    //   scheduledTiming: 'asPerDay : asPerHour',
    //   ifStatement: 'user has a question + new reply in question replies sub doc',
    //   cityState: CityState.any,
    //   reciever: NotiRecieverType.user,
  ),

  /// welcome to bldrs
  NoteModel(
    parties: NoteParties(
      senderID: NoteParties.bldrsSenderID,
      senderImageURL: NoteParties.bldrsLogoStaticURL,
      senderType: PartyType.bldrs,
      receiverID: null,
      receiverType: PartyType.user,
    ),
    sentTime: null,
    /// variables
    id: 'welcomeToBldrs',
    title: 'Welcome to Bldrs.net',
    body: 'Find thousands of businesses to help you find and build what you want to build',
    /// pseudo
    //   subject: NotiSubject.welcome,
    //   eventTrigger: 'when new user joins bldrs.net',
    //   scheduledTiming: 'asPerDay : asPerHour',
    //   ifStatement: 'on new firebase user created',
    //   cityState: CityState.any,
    //   reciever: NotiRecieverType.user,
  ),

];

/*
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
 */