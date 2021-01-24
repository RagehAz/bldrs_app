import 'package:bldrs/models/old_models_to_delete_when_done/bond_model.dart';
import 'package:bldrs/models/old_models_to_delete_when_done/origin_model.dart';
import 'package:bldrs/models/old_models_to_delete_when_done/slide_model.dart';
import 'package:flutter/foundation.dart';

class CoSlide with ChangeNotifier{
  final SlideModel slide;
  final List<OriginModel> origins;
  final List<BondModel> bonds;
  final int callsCount;
  final int sharesCount;
  final int horuseeCount;
  final int savesCount;

  CoSlide({
    @required this.slide,
    @required this.origins,
    @required this.bonds,
    @required this.callsCount,
    @required this.sharesCount,
    @required this.horuseeCount,
    @required this.savesCount,
  });
}
