import 'package:bldrs/models/target/target_model.dart';
import 'package:bldrs/models/target/target_reward.dart';

abstract class Targetz {
// -----------------------------------------------------------------------------
  static const TargetReward startupReward = const TargetReward(targetID: 'startup', ankh: 1, slides: 10);
  static const TargetReward completeAccountReward = const TargetReward(targetID: 'completeAccount', ankh: 1, slides: 14);
  static const TargetReward verifyAccountReward = const TargetReward(targetID: 'verifyAccount', ankh: 5, slides: 38);
  static const TargetReward perfectFlyerReward = const TargetReward(targetID: 'perfectFlyer', ankh: 2, slides: 6);
  static const TargetReward threeFlyerAWeekReward = const TargetReward(targetID: 'threeFlyerAWeek', ankh: 5, slides: 75);
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
  static const TargetModel threeFlyerAWeek = const TargetModel(
    id: 'threeFlyerAWeek',
    name: 'Three Flyers a week',
    description: 'Publish three flyers a week for consecutive 4 weeks in a row',
    reward: threeFlyerAWeekReward,
  );
// -----------------------------------------------------------------------------
//   static const TargetModel xxxxxxxx = const TargetModel(
//     id: '',
//     name: '',
//     description: '',
//     reward: ,
//   );
// -----------------------------------------------------------------------------
}