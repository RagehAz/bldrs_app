import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/a_models/flyer/mutables/draft_flyer_model.dart';
import 'package:bldrs/a_models/flyer/mutables/mutable_slide.dart';
import 'package:bldrs/e_db/fire/ops/auth_ops.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:flutter/cupertino.dart';
// -----------------------------------------------------------------------------
Future<DraftFlyerModel> initializeDraftFlyerModel({
  @required FlyerModel existingFlyer,
  @required BzModel bzModel,
}) async {
  DraftFlyerModel _draft;

  if (existingFlyer == null){

    _draft = DraftFlyerModel.createNewDraft(
      bzModel: bzModel,
      authorID: superUserID(),
    );

  }

  else {

    _draft = await DraftFlyerModel.createDraftFromFlyer(existingFlyer);

  }

  return _draft;
}
// -----------------------------------------------------------------------------
void onDeleteSlide({
  @required ValueNotifier<DraftFlyerModel> draftFlyer,
  @required int index,
}){

  final List<MutableSlide> _slides = draftFlyer.value.mutableSlides;

  if (canLoopList(_slides) == true){

    _slides.removeAt(index);

    draftFlyer.value.mutableSlides = _slides;
  }

}
// -----------------------------------------------------------------------------
