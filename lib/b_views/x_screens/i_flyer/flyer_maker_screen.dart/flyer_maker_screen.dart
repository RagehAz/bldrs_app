import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/b_views/y_views/i_flyer/flyer_maker/flyer_maker_screen_view.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/unfinished_night_sky.dart';
import 'package:bldrs/c_controllers/i_flyer_maker_controllers/flyer_maker_controller.dart';
import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:flutter/material.dart';

class FlyerPublisherScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const FlyerPublisherScreen({
    @required this.bzModel,
    this.flyerModel,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final BzModel bzModel;
  final FlyerModel flyerModel;
  /// --------------------------------------------------------------------------
  @override
  _FlyerPublisherScreenState createState() => _FlyerPublisherScreenState();
/// --------------------------------------------------------------------------
}

class _FlyerPublisherScreenState extends State<FlyerPublisherScreen> with AutomaticKeepAliveClientMixin{
// -----------------------------------------------------------------------------
  /// to keep out of screen objects alive
  @override
  bool get wantKeepAlive => true;
// -----------------------------------------------------------------------------
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _headlineController = TextEditingController();
// -----------------------------------------------------------------------------
  @override
  void initState() {
    _headlineController.text = widget.flyerModel?.title ?? '';
    super.initState();
  }
// -----------------------------------------------------------------------------
  @override
  void dispose(){
    _scrollController.dispose();
    super.dispose();
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    /// when using with AutomaticKeepAliveClientMixin
    super.build(context);

    return MainLayout(
      key: const ValueKey<String>('FlyerPublisherScreen'),
      pageTitle: superPhrase(context, 'phid_createFlyer'),
      skyType: SkyType.black,
      pyramidsAreOn: true,
      appBarType: AppBarType.basic,
      // loading: _loading,
      sectionButtonIsOn: false,
      zoneButtonIsOn: false,
      appBarRowWidgets: const <Widget>[],
      onBack: () => onCancelFlyerCreation(context),
      layoutWidget: FlyerMakerScreenView(
        bzModel: widget.bzModel,
        scrollController: _scrollController,
        flyerModel: widget.flyerModel,
        headline: _headlineController,
      ),
    );
  }
}
