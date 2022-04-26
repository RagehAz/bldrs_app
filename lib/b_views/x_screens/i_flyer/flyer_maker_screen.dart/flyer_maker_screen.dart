import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/flyer/mutables/draft_flyer_model.dart';
import 'package:bldrs/b_views/y_views/i_flyer/flyer_maker/flyer_maker_screen_view.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/unfinished_night_sky.dart';
import 'package:bldrs/c_controllers/i_flyer_maker_controllers/draft_shelf_controller.dart';
import 'package:bldrs/c_controllers/i_flyer_maker_controllers/flyer_maker_controller.dart';
import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:bldrs/e_db/fire/ops/auth_ops.dart';
import 'package:flutter/material.dart';

class FlyerMakerScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const FlyerMakerScreen({
    @required this.bzModel,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final BzModel bzModel;
  /// --------------------------------------------------------------------------
  @override
  _FlyerMakerScreenState createState() => _FlyerMakerScreenState();
/// --------------------------------------------------------------------------
}

class _FlyerMakerScreenState extends State<FlyerMakerScreen> with AutomaticKeepAliveClientMixin{
// -----------------------------------------------------------------------------
  /// to keep out of screen objects alive
  @override
  bool get wantKeepAlive => true;
// -----------------------------------------------------------------------------
  final ScrollController _scrollController = ScrollController();
  TextEditingController _headlineController;
  ValueNotifier<DraftFlyerModel> _draftFlyer;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
// -----------------------------------------------------------------------------
  @override
  void initState() {

    final DraftFlyerModel _draft = DraftFlyerModel.createNewDraft(
      bzModel: widget.bzModel,
      authorID: superUserID(),
    );
    _draftFlyer = ValueNotifier(_draft);

    _headlineController = initializeHeadlineController(
      draftFlyer: _draftFlyer,
    );

    super.initState();
  }
// -----------------------------------------------------------------------------

  @override
  void dispose(){
    _scrollController.dispose();
    // disposeControllerIfPossible(_headlineController);
    /// task : dispose draft slides text controllers
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
        headlineController: _headlineController,
        draft: _draftFlyer,
      ),
    );
  }
}
