import 'package:bldrs/a_models/b_bz/target/target_model.dart';
import 'package:bldrs/a_models/b_bz/target/target_progress.dart';
import 'package:bldrs/a_models/b_bz/target/target_reward.dart';
// -----------------------------------------------------------------------------
const TargetReward startupReward = TargetReward(targetID: 'startup', ankh: 1, slides: 10);
const TargetReward completeAccountReward = TargetReward(targetID: 'completeAccount', ankh: 1, slides: 14);
const TargetReward verifyAccountReward = TargetReward(targetID: 'verifyAccount', ankh: 5, slides: 38);
const TargetReward perfectFlyerReward = TargetReward(targetID: 'perfectFlyer', ankh: 2, slides: 6);
const TargetReward threeFlyersAWeekReward = TargetReward(targetID: 'threeFlyerAWeek', ankh: 5, slides: 75);
const TargetReward aFlyerADayReward = TargetReward(targetID: 'aFlyerADay', ankh: 3, slides: 38);
const TargetReward communityGrowthReward = TargetReward(targetID: 'communityGrowth', ankh: 100, slides: 62);
const TargetReward payItBackReward = TargetReward(targetID: 'payItBack', ankh: 50, slides: 50);
const TargetReward makeARhythmReward = TargetReward(targetID: 'makeARhythm', ankh: 1, slides: 2);
const TargetReward tenPotentialCustomersReward = TargetReward(targetID: 'tenPotentialCustomers', ankh: 2, slides: 10);
const TargetReward richGalleryReward = TargetReward(targetID: 'richGallery', ankh: 75, slides: 100);
const TargetReward callToActionReward = TargetReward(targetID: 'callToAction', ankh: 5, slides: 20);
const TargetReward shareWorthyReward = TargetReward(targetID: 'shareWorthy', ankh: 5, slides: 100);
const TargetReward diversityReward = TargetReward(targetID: 'diversity', ankh: 5, slides: 100);
const TargetReward publisherReward = TargetReward(targetID: 'publisher', ankh: 50, slides: 100);
const TargetReward influencerReward = TargetReward(targetID: 'influencer', ankh: 1, slides: 10);
const TargetReward masterBldrReward = TargetReward(targetID: 'masterBldr', ankh: 10, slides: 50);
// -----------------------------------------------------------------------------
const TargetModel startup = TargetModel(
  id: 'startup',
  name: 'Start-up',
  description: 'Sign up a new business account.',
  reward: startupReward,
);
// -----------------------------------------------------------------------------
const TargetModel completeAccount = TargetModel(
  id: 'completeAccount',
  name: 'Complete Account data',
  description: 'Some fields in your account have been left empty.',
  reward: completeAccountReward,
);
// -----------------------------------------------------------------------------
const TargetModel verifyAccount = TargetModel(
  id: 'verifyAccount',
  name: 'Verify your account',
  description:
      'Upload pictures for the following requirements, the verification request will be processed within several days.',
  instructions: <String>[
    'Utility bill for your place of business',
    'Local business license (issued by your city, county or state)',
    'Tax document for your business',
    'Certificate of formation (for a partnership)',
    'Articles of incorporation (for a corporation)',
  ],
  reward: verifyAccountReward,
);
// -----------------------------------------------------------------------------
const TargetModel perfectFlyer = TargetModel(
  id: 'perfectFlyer',
  name: 'Perfect flyer',
  description: 'Create and publish a flyer that consists of exactly 3 slides',
  reward: perfectFlyerReward,
);
// -----------------------------------------------------------------------------
const TargetModel threeFlyersAWeek = TargetModel(
  id: 'threeFlyersAWeek',
  name: 'Three Flyers a week',
  description: 'Publish three flyers a week for consecutive 4 weeks in a row',
  reward: threeFlyersAWeekReward,
);
// -----------------------------------------------------------------------------
const TargetModel aFlyerADay = TargetModel(
  id: 'aFlyerADay',
  name: 'A Flyer a Day',
  description: 'Publish one flyer each day for seven consecutive days',
  reward: aFlyerADayReward,
);
// -----------------------------------------------------------------------------
const TargetModel communityGrowth = TargetModel(
  id: 'communityGrowth',
  name: 'Community Growth',
  description:
      'Contribute in Bldrs network growth, and take part in deciding in which direction by attentively selecting which of our Bldr contacts on your phone you see suitable to join the community',
  reward: communityGrowthReward,
  instructions: <String>[
    'Verify your business account',
    'Share your BLDR link to people you know who will benefit creating a business account on Bldrs.net',
    'Tell them personally what you really think about Bldrs.net.',
    'Wait until they create a new business account then your business account will get linked.',
    'Wait the linked account to publish 30 slides and link with another business account.',
    "At that point, Both your account and the linked account grow their accounts' credits together",
  ],
);
// -----------------------------------------------------------------------------
const TargetModel payItBack = TargetModel(
  id: 'payItBack',
  name: 'Pay it back',
  description:
      "You have joined Bldrs.net through a link sent to you from another business account, in such case, your account's growth impacts theirs as well",
  reward: payItBackReward,
  instructions: <String>[
    'Verify your business account',
    'Publish 30 slides',
    'Share your BLDR link below to another person who will open a business account on Bldrs.net',
    'Wait until they create a new business account then your business account will get linked.',
    "At that point, Both your account and the one sent you the invitation grow their accounts' credits together",
  ],
);
// -----------------------------------------------------------------------------
const TargetModel makeARhythm = TargetModel(
  id: 'makeARhythm',
  name: 'Make a rhythm',
  description: 'Share at-least one of your own flyers once each day for ',
  instructions: <String>[
    'Share a flyer publicly via any of social media platforms or target a potential customer who is seeking your services',
    'Wait for the flyer views counter to increase 1 view',
  ],
  reward: makeARhythmReward,
);
// -----------------------------------------------------------------------------
const TargetModel tenPotentialCustomers = TargetModel(
  id: 'tenPotentialCustomers',
  name: 'Ten Potential customers',
  description: 'Get total flyer saves to 10 saves',
  reward: tenPotentialCustomersReward,
);
// -----------------------------------------------------------------------------
const TargetModel richGallery = TargetModel(
  id: 'richGallery',
  name: 'Rich Gallery',
  description: 'Publish 30 flyers',
  reward: richGalleryReward,
);
// -----------------------------------------------------------------------------
const TargetModel callToAction = TargetModel(
  id: 'callToAction',
  name: 'Call to Action',
  description: 'Receive 10 phone calls',
  reward: callToActionReward,
);
// -----------------------------------------------------------------------------
const TargetModel shareWorthy = TargetModel(
  id: 'shareWorthy',
  name: 'Share worthy',
  description: 'get total 10 flyers shares',
  reward: shareWorthyReward,
);
// -----------------------------------------------------------------------------
const TargetModel diversity = TargetModel(
  id: 'diversity',
  name: 'Diversity',
  description: 'Use 20 different keywords in your flyers',
  reward: diversityReward,
);
// -----------------------------------------------------------------------------
const TargetModel publisher = TargetModel(
  id: 'publisher',
  name: 'Publisher',
  description: 'Achieve "Three flyers a week" target for 3 consecutive months',
  reward: publisherReward,
);
// -----------------------------------------------------------------------------
const TargetModel influencer = TargetModel(
  id: 'influencer',
  name: 'Influencer',
  description: 'Get 10 Followers',
  reward: influencerReward,
);
// -----------------------------------------------------------------------------
const TargetModel masterBldr = TargetModel(
  id: 'masterBldr',
  name: 'Master Bldr',
  description: 'Use 100 Ankhs to boost your business account',
  reward: masterBldrReward,
);
// -----------------------------------------------------------------------------
List<TargetModel> allTargets() {
  return <TargetModel>[
    startup,
    completeAccount,
    verifyAccount,
    perfectFlyer,
    threeFlyersAWeek,
    aFlyerADay,
    communityGrowth,
    payItBack,
    makeARhythm,
    tenPotentialCustomers,
    richGallery,
    callToAction,
    shareWorthy,
    diversity,
    publisher,
    influencer,
    masterBldr,
  ];
}
// -----------------------------------------------------------------------------
List<TargetProgress> dummyTargetsProgress() {
  return const <TargetProgress>[
    TargetProgress(targetID: 'startup', objective: 1, current: 1),
    TargetProgress(targetID: 'completeAccount', objective: 12, current: 12),
    TargetProgress(targetID: 'verifyAccount', objective: 1, current: 0),
    TargetProgress(targetID: 'perfectFlyer', objective: 1, current: 1),
    TargetProgress(targetID: 'threeFlyersAWeek', objective: 3, current: 3),
    TargetProgress(targetID: 'aFlyerADay', objective: 4, current: 7),
    TargetProgress(targetID: 'communityGrowth', objective: 5, current: 2),
    TargetProgress(targetID: 'payItBack', objective: 5, current: 2),
    TargetProgress(targetID: 'makeARhythm', objective: 0, current: 1),
    TargetProgress(
        targetID: 'tenPotentialCustomers', objective: 10, current: 9),
    TargetProgress(targetID: 'richGallery', objective: 30, current: 24),
    TargetProgress(targetID: 'callToAction', objective: 10, current: 4),
    TargetProgress(targetID: 'shareWorthy', objective: 10, current: 3),
    TargetProgress(targetID: 'diversity', objective: 20, current: 12),
    TargetProgress(targetID: 'publisher', objective: 3, current: 0),
    TargetProgress(targetID: 'influencer', objective: 10, current: 8),
    TargetProgress(targetID: 'masterBldr', objective: 1, current: 0),
  ];
}
// -----------------------------------------------------------------------------
List<TargetModel> insertTargetsProgressIntoTargetsModels({
  List<TargetModel> allTargets,
  List<TargetProgress> targetsProgress,
}) {
  final List<TargetModel> _targets = <TargetModel>[];

  for (final TargetModel target in allTargets) {
    final TargetProgress _progress = targetsProgress.singleWhere(
        (TargetProgress prog) => prog.targetID == target.id,
        orElse: () => null);

    final TargetModel _target = TargetModel(
      id: target.id,
      name: target.name,
      description: target.description,
      instructions: target.instructions,
      reward: target.reward,
      progress: _progress,
    );

    _targets.add(_target);
  }

  return _targets;
}
// -----------------------------------------------------------------------------
