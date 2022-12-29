import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/b_views/j_flyer/c_flyer_reviews_screen/a_flyer_reviews_screen.dart';
import 'package:bldrs/b_views/j_flyer/z_components/a_structure/d_flyer_big_view.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs/f_helpers/router/routing.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';

import 'package:flutter/material.dart';

class FlyerPreviewScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const FlyerPreviewScreen({
    @required this.flyerModel,
    @required this.bzModel,
    this.reviewID,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final FlyerModel flyerModel;
  final BzModel bzModel;
  final String reviewID;
  /// --------------------------------------------------------------------------
  static const String routeName = Routing.flyerScreen;

  @override
  State<FlyerPreviewScreen> createState() => _FlyerPreviewScreenState();

}

class _FlyerPreviewScreenState extends State<FlyerPreviewScreen> {
  // -----------------------------------------------------------------------------
  /// --- LOADING
  final ValueNotifier<bool> _loading = ValueNotifier(false);
  // --------------------
  Future<void> _triggerLoading({@required bool setTo}) async {
    setNotifier(
      notifier: _loading,
      mounted: mounted,
      value: setTo,
    );
  }
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
  }
  // --------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit && mounted) {

      _triggerLoading(setTo: true).then((_) async {

        /// GO TO REVIEWS SCREEN IF REVIEW ID IS NOT NULL
        if (widget.reviewID != null) {

          await Nav.goToNewScreen(
            context: context,
            screen: FlyerReviewsScreen(
              flyerModel: widget.flyerModel,
              highlightReviewID: widget.reviewID,
            ),
          );

        }

        await _triggerLoading(setTo: false);
      });

      _isInit = false;
    }
    super.didChangeDependencies();
  }
  // --------------------
  @override
  void dispose() {
    _loading.dispose();
    super.dispose();
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    /// TASK : reviewID is $reviewID and should auto go to reviews screen then scroll to it
    blog('reviewID is ${widget.reviewID} and should auto go to reviews screen then scroll to it');

    // --------------------
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colorz.skyDarkBlue,
        body: FlyerBigView(
          key: PageStorageKey<String>(widget.flyerModel.id),
          flyerBoxWidth: Scale.screenWidth(context),
          flyerModel: widget.flyerModel,
          bzModel: widget.bzModel,
          heroPath: 'FlyerPreviewScreen',
        ),
      ),
    );
    // --------------------
  }
}
