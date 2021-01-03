import 'enums/enum_flyer_state.dart';
import 'enums/enum_flyer_type.dart';

// dv - pp (property flyer - property source flyer)
// br - pp (property flyer)
// mn - pd (product flyer - product source flyer)
// sp - pd (product flyer)
// dr - ds (design flyer)
// cn - pj (project flyer)
// ar - cr (craft flyer)

class FlyerModel {
  final String flyerID;
  final String authorID;
  final bool flyerShowsAuthor;
  final FlyerType flyerType;
  final List<String> keyWords;
  final FlyerState flyerState;
  // final DateTime publishTime;
  // flyer x_dummy_database.location

  FlyerModel({
    this.flyerID,
    this.authorID,
    this.flyerShowsAuthor,
    this.flyerType,
    this.keyWords,
    this.flyerState,
  });
}


