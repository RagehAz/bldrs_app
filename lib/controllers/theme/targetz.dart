import 'package:bldrs/models/bz/target/target_model.dart';
import 'package:bldrs/models/bz/target/target_progress.dart';
import 'package:bldrs/models/bz/target/target_reward.dart';

abstract class Targetz {
// -----------------------------------------------------------------------------
  static const TargetReward startupReward = const TargetReward(targetID: 'startup', ankh: 1, slides: 10);
  static const TargetReward completeAccountReward = const TargetReward(targetID: 'completeAccount', ankh: 1, slides: 14);
  static const TargetReward verifyAccountReward = const TargetReward(targetID: 'verifyAccount', ankh: 5, slides: 38);
  static const TargetReward perfectFlyerReward = const TargetReward(targetID: 'perfectFlyer', ankh: 2, slides: 6);
  static const TargetReward threeFlyersAWeekReward = const TargetReward(targetID: 'threeFlyerAWeek', ankh: 5, slides: 75);
  static const TargetReward aFlyerADayReward = const TargetReward(targetID: 'aFlyerADay', ankh: 3, slides: 38);
  static const TargetReward communityGrowthReward = const TargetReward(targetID: 'communityGrowth', ankh: 100, slides: 62);
  static const TargetReward payItBackReward = const TargetReward(targetID: 'payItBack', ankh: 50, slides: 50);
  static const TargetReward makeARhythmReward = const TargetReward(targetID: 'makeARhythm', ankh: 1, slides: 2);
  static const TargetReward tenPotentialCustomersReward = const TargetReward(targetID: 'tenPotentialCustomers', ankh: 2, slides: 10);
  static const TargetReward richGalleryReward = const TargetReward(targetID: 'richGallery', ankh: 75, slides: 100);
  static const TargetReward callToActionReward = const TargetReward(targetID: 'callToAction', ankh: 5, slides: 20);
  static const TargetReward shareWorthyReward = const TargetReward(targetID: 'shareWorthy', ankh: 5, slides: 100);
  static const TargetReward diversityReward = const TargetReward(targetID: 'diversity', ankh: 5, slides: 100);
  static const TargetReward publisherReward = const TargetReward(targetID: 'publisher', ankh: 50, slides: 100);
  static const TargetReward influencerReward = const TargetReward(targetID: 'influencer', ankh: 1, slides: 10);
  static const TargetReward masterBldrReward = const TargetReward(targetID: 'masterBldr', ankh: 10, slides: 50);

// -----------------------------------------------------------------------------
  static const TargetModel startup = const TargetModel(
    id: 'startup',
    name: 'Start-up',
    description: 'Sign up a new business account.',
    reward: startupReward,
  );
// -----------------------------------------------------------------------------
  static const TargetModel completeAccount = const TargetModel(
    id: 'completeAccount',
    name: 'Complete Account data',
    description: 'Some fields in your account have been left empty.',
    reward: completeAccountReward,
  );
// -----------------------------------------------------------------------------
  static const TargetModel verifyAccount = const TargetModel(
    id: 'verifyAccount',
    name: 'Verify your account',
    description: 'Upload pictures for the following requirements, the verification request will be processed within several days.',
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
  static const TargetModel perfectFlyer = const TargetModel(
    id: 'perfectFlyer',
    name: 'Perfect flyer',
    description: 'Create and publish a flyer that consists of exactly 3 slides',
    reward: perfectFlyerReward,
  );
// -----------------------------------------------------------------------------
  static const TargetModel threeFlyersAWeek = const TargetModel(
    id: 'threeFlyersAWeek',
    name: 'Three Flyers a week',
    description: 'Publish three flyers a week for consecutive 4 weeks in a row',
    reward: threeFlyersAWeekReward,
  );
// -----------------------------------------------------------------------------
  static const TargetModel aFlyerADay = const TargetModel(
    id: 'aFlyerADay',
    name: 'A Flyer a Day',
    description: 'Publish one flyer each day for seven consecutive days',
    reward: aFlyerADayReward,
  );
// -----------------------------------------------------------------------------
  static const TargetModel communityGrowth = const TargetModel(
    id: 'communityGrowth',
    name: 'Community Growth',
    description: 'Contribute in Bldrs network growth, and take part in deciding in which direction by attentively selecting which of our Bldr contacts on your phone you see suitable to join the community',
    reward: communityGrowthReward,
    instructions: <String>[
      'Verify your business account',
      'Share your BLDR link to people you know who will benefit creating a business account on Bldrs.net',
      'Tell them personally what you really think about Bldrs.net.',
      'Wait until they create a new business account then your business account will get linked.',
      'Wait the linked account to publish 30 slides and link with another business account.',
      'At that point, Both your account and the linked account grow their accounts\' credits together',
    ],

  );
// -----------------------------------------------------------------------------
  static const TargetModel payItBack = const TargetModel(
    id: 'payItBack',
    name: 'Pay it back',
    description: 'You have joined Bldrs.net through a link sent to you from another business account, in such case, your account\'s growth impacts theirs as well',
    reward: payItBackReward,
    instructions: <String>[
      'Verify your business account',
      'Publish 30 slides',
      'Share your BLDR link below to another person who will open a business account on Bldrs.net',
      'Wait until they create a new business account then your business account will get linked.',
      'At that point, Both your account and the one sent you the invitation grow their accounts\' credits together',
    ],
  );
// -----------------------------------------------------------------------------
  static const TargetModel makeARhythm = const TargetModel(
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
  static const TargetModel tenPotentialCustomers = const TargetModel(
    id: 'tenPotentialCustomers',
    name: 'Ten Potential customers',
    description: 'Get total flyer saves to 10 saves',
    reward: tenPotentialCustomersReward,
  );
// -----------------------------------------------------------------------------
  static const TargetModel richGallery = const TargetModel(
    id: 'richGallery',
    name: 'Rich Gallery',
    description: 'Publish 30 flyers',
    reward: richGalleryReward,
  );
// -----------------------------------------------------------------------------
  static const TargetModel callToAction = const TargetModel(
    id: 'callToAction',
    name: 'Call to Action',
    description: 'Receive 10 phone calls',
    reward: callToActionReward,
  );
// -----------------------------------------------------------------------------
  static const TargetModel shareWorthy = const TargetModel(
    id: 'shareWorthy',
    name: 'Share worthy',
    description: 'get total 10 flyers shares',
    reward: shareWorthyReward,
  );
// -----------------------------------------------------------------------------
  static const TargetModel diversity = const TargetModel(
    id: 'diversity',
    name: 'Diversity',
    description: 'Use 20 different keywords in your flyers',
    reward: diversityReward,
  );
// -----------------------------------------------------------------------------
  static const TargetModel publisher = const TargetModel(
    id: 'publisher',
    name: 'Publisher',
    description: 'Achieve "Three flyers a week" target for 3 consecutive months',
    reward: publisherReward,
  );
// -----------------------------------------------------------------------------
  static const TargetModel influencer = const TargetModel(
    id: 'influencer',
    name: 'Influencer',
    description: 'Get 10 Followers',
    reward: influencerReward,
  );
// -----------------------------------------------------------------------------
  static const TargetModel masterBldr = const TargetModel(
    id: 'masterBldr',
    name: 'Master Bldr',
    description: 'Use 100 Ankhs to boost your business account',
    reward: masterBldrReward,
  );
// -----------------------------------------------------------------------------
  static List<TargetModel> allTargets(){
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
  static List<TargetProgress> dummyTargetsProgress(){
    return
        const <TargetProgress>[
          const TargetProgress(targetID: 'startup', objective: 1, current: 1),
          const TargetProgress(targetID: 'completeAccount', objective: 12, current: 12),
          const TargetProgress(targetID: 'verifyAccount', objective: 1, current: 0),
          const TargetProgress(targetID: 'perfectFlyer', objective: 1, current: 1),
          const TargetProgress(targetID: 'threeFlyersAWeek', objective: 3, current: 3),
          const TargetProgress(targetID: 'aFlyerADay', objective: 4, current: 7),
          const TargetProgress(targetID: 'communityGrowth', objective: 5, current: 2),
          const TargetProgress(targetID: 'payItBack', objective: 5, current: 2),
          const TargetProgress(targetID: 'makeARhythm', objective: 0, current: 1),
          const TargetProgress(targetID: 'tenPotentialCustomers', objective: 10, current: 9),
          const TargetProgress(targetID: 'richGallery', objective: 30, current: 24),
          const TargetProgress(targetID: 'callToAction', objective: 10, current: 4),
          const TargetProgress(targetID: 'shareWorthy', objective: 10, current: 3),
          const TargetProgress(targetID: 'diversity', objective: 20, current: 12),
          const TargetProgress(targetID: 'publisher', objective: 3, current: 0),
          const TargetProgress(targetID: 'influencer', objective: 10, current: 8),
          const TargetProgress(targetID: 'masterBldr', objective: 1, current: 0),
        ];
  }
// -----------------------------------------------------------------------------
  static List<TargetModel> insertTargetsProgressIntoTargetsModels({List<TargetModel> allTargets, List<TargetProgress> targetsProgress}){
    List<TargetModel> _targets = <TargetModel>[];

    for (TargetModel target in allTargets){

      final TargetProgress _progress = targetsProgress.singleWhere((prog) => prog.targetID == target.id, orElse: () => null);

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
}