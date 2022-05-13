import 'dart:async';

import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/chain/spec_models/spec_model.dart';
import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/a_models/flyer/mutables/draft_flyer_model.dart';
import 'package:bldrs/b_views/y_views/i_flyer/flyer_maker/flyer_maker_screen_view.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/dialogs/top_dialog/top_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/wait_dialog/wait_dialog.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/unfinished_night_sky.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/c_controllers/i_flyer_maker_controllers/draft_shelf_controller.dart';
import 'package:bldrs/c_controllers/i_flyer_maker_controllers/flyer_maker_controller.dart';
import 'package:bldrs/d_providers/bzz_provider.dart';
import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:bldrs/e_db/fire/ops/auth_ops.dart';
import 'package:bldrs/e_db/fire/ops/flyer_ops.dart' as FlyerOps;
import 'package:bldrs/e_db/ldb/ldb_doc.dart' as LDBDoc;
import 'package:bldrs/e_db/ldb/ldb_ops.dart' as LDBOps;
import 'package:bldrs/f_helpers/router/navigators.dart' as Nav;
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
  final ScrollController _scrollController = ScrollController(); /// tamam disposed
  TextEditingController _headlineController;
  ValueNotifier<DraftFlyerModel> _draftFlyer; /// tamam disposed
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
    super.dispose();
    _scrollController.dispose();
    _draftFlyer.dispose();
    // disposeControllerIfPossible(_headlineController);
    /// task : dispose draft slides text controllers
  }
// -----------------------------------------------------------------------------
  Future<void> _onPublish() async {

    unawaited(
        WaitDialog.showWaitDialog(
          context: context,
          canManuallyGoBack: false,
          loadingPhrase: 'Uploading flyer',
        )
    );

    blog('onPublish flyer : Starting flyer publish ops');

    blog('onPublish flyer : Draft flyer model is : -');
    _draftFlyer.value.blogDraft();

    _formKey.currentState.validate();

    blog('onPublish flyer : fields are valid');

    final FlyerModel _flyerModel = _draftFlyer.value.toFlyerModel();
    _flyerModel.blogFlyer(methodName: '_onPublish');

    blog('onPublish flyer : new flyer created');

    /// upload to firebase
    final FlyerModel _uploadedFlyer = await FlyerOps.createFlyerOps(
        context: context,
        inputFlyerModel: _flyerModel,
        bzModel: widget.bzModel
    );

    blog('onPublish flyer : new flyer uploaded and bzModel updated on firebase');

    /// update ldb
    final List<String> _newBzFlyersIDsList = <String>[... widget.bzModel.flyersIDs, _uploadedFlyer.id];
    final BzModel _newBzModel = widget.bzModel.copyWith(
      flyersIDs: _newBzFlyersIDsList,
    );
    await LDBOps.updateMap(
        objectID: _newBzModel.id,
        docName: LDBDoc.bzz,
        input: _newBzModel.toMap(toJSON: true),
    );
    blog('onPublish flyer : bz model updated on LDB');
    await LDBOps.insertMap(
      primaryKey: 'id',
      docName: LDBDoc.flyers,
      input: _flyerModel.toMap(toJSON: true),
    );
    blog('onPublish flyer : new flyer stored on LDB');

    /// update providers
    final BzzProvider _bzzProvider = Provider.of<BzzProvider>(context, listen: false);
    _bzzProvider.setActiveBzFlyers(
        flyers: <FlyerModel>[..._bzzProvider.myActiveBzFlyers, _uploadedFlyer],
        notify: false,
    );
    blog('onPublish flyer : myActiveBzFlyers on provider updated');
    _bzzProvider.setActiveBz(
        bzModel: _newBzModel,
        bzCountry: _bzzProvider.myActiveBzCountry,
        bzCity: _bzzProvider.myActiveBzCity,
        notify: true,
    );
    blog('onPublish flyer : _newBzModel on provider updated');

    WaitDialog.closeWaitDialog(context);

    await TopDialog.showTopDialog(
      context: context,
      verse: 'Flyer Has been Published',
      color: Colorz.green255,
    );

    Nav.goBack(context);

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
      appBarRowWidgets: <Widget>[

        const Expander(),

        DreamBox(
          height: 40,
          verse: 'blog the specs',
          verseScaleFactor: 0.7,
          onTap: (){
            SpecModel.blogSpecs(_draftFlyer.value.specs);
          },
        ),

      ],
      onBack: () => onCancelFlyerCreation(context),
      layoutWidget: FlyerMakerScreenView(
        formKey: _formKey,
        bzModel: widget.bzModel,
        scrollController: _scrollController,
        headlineController: _headlineController,
        draft: _draftFlyer,
        onPublish: _onPublish,
      ),
    );
  }
}
