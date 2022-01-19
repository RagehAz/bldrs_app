import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/d_providers/active_flyer_provider.dart';
import 'package:bldrs/d_providers/bzz_provider.dart';
import 'package:bldrs/f_helpers/router/navigators.dart' as Nav;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// -----------------------------------------------------------------------------
void onCloseFullScreenFlyer(BuildContext context){

  final ActiveFlyerProvider _activeFlyerProvider = Provider.of<ActiveFlyerProvider>(context, listen: false);

  /// ACTIVE FLYER BZ COUNTRY AND CITY
  _activeFlyerProvider.setActiveFlyerBzCountryAndCity(
    bzCountry: null,
    bzCity: null,
    notify: false,
  );

  /// FOLLOW IS ON
  _activeFlyerProvider.setFollowIsOn(
      setFollowIsOnTo: false,
      notify: false
  );

  /// CURRENT SLIDE INDEX
  _activeFlyerProvider.setCurrentSlideIndex(
    setIndexTo: 0,
    notify: false,
  );

  /// PROGRESS BAR OPACITY
  _activeFlyerProvider.setProgressBarOpacity(
    setOpacityTo: 0,
    notify: false,
  );

  /// HEADER IS EXPANDED
  _activeFlyerProvider.setHeaderIsExpanded(
    setHeaderIsExpandedTo: false,
    notify: false,
  );

  /// HEADER PAGE OPACITY
  _activeFlyerProvider.setHeaderPageOpacity(
    setOpacityTo: 0,
    notify: true,
  );

  Nav.goBack(context);
}
// -----------------------------------------------------------------------------
Future<BzModel> getFlyerBzModel({
  @required BuildContext context,
  @required FlyerModel flyerModel,
}) async {

  final BzzProvider _bzzProvider = Provider.of<BzzProvider>(context, listen: false);
  final BzModel _bzModel = await _bzzProvider.fetchBzModel(
      context: context,
      bzID: flyerModel.bzID
  );

  return _bzModel;
}
// -----------------------------------------------------------------------------
