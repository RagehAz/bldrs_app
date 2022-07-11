import 'package:bldrs/a_models/chain/spec_models/spec_model.dart';
import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/a_models/flyer/mutables/draft_flyer_model.dart';
import 'package:bldrs/b_views/x_screens/g_bz/e_flyer_maker/aa_flyer_maker_screen_view.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/unfinished_night_sky.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/c_controllers/g_bz_controllers/e_flyer_maker/a_flyer_maker_controllers.dart';
import 'package:bldrs/c_controllers/g_bz_controllers/e_flyer_maker/aa_draft_shelf_controllers.dart';
import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:flutter/material.dart';

class FlyerMakerScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const FlyerMakerScreen({
    this.flyerToEdit,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final FlyerModel flyerToEdit;
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
  TextEditingController _headlineController; /// tamam disposed
  ValueNotifier<DraftFlyerModel> _draftFlyer; /// tamam disposed
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isEditingFlyer;
// -----------------------------------------------------------------------------
  @override
  void initState() {

    _isEditingFlyer = widget.flyerToEdit != null;

    _headlineController = TextEditingController(text: widget.flyerToEdit?.headline);

    _draftFlyer = initializeDraft(
      context: context,
    );

    super.initState();
  }
// -----------------------------------------------------------------------------
  /// --- LOCAL LOADING BLOCK
  final ValueNotifier<bool> _loading = ValueNotifier(true); /// tamam disposed
// -----------------------------------
  Future<void> _triggerLoading({
    @required bool setTo,
  }) async {
    _loading.value = setTo;
    blogLoading(
      loading: _loading.value,
      callerName: 'EditProfileScreen',
    );
  }
// -----------------------------------------------------------------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit) {

      _triggerLoading(setTo: true).then((_) async {
        // -------------------------------

        blog('FlyerMakerScreen : didChangeDependencies');

          await initializeExistingFlyerDraft(
            flyerToEdit: widget.flyerToEdit,
            draft: _draftFlyer,
          );

          _headlineController = initializeHeadlineController(
            draftFlyer: _draftFlyer,
          );

        // -------------------------------
        await _triggerLoading(setTo: false);

      });

    }
    _isInit = false;
    super.didChangeDependencies();
  }
// -----------------------------------------------------------------------------
  @override
  void dispose(){
    _scrollController.dispose();
    DraftFlyerModel.disposeDraftControllers(
        draft: _draftFlyer.value
    );
    _draftFlyer.dispose();
    _loading.dispose();
    _headlineController.dispose();
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
      loading: _loading,
      sectionButtonIsOn: false,
      zoneButtonIsOn: false,
      appBarRowWidgets: <Widget>[

        const Expander(),

        AppBarButton(
          verse: 'specs',
          onTap: (){
            SpecModel.blogSpecs(_draftFlyer.value.specs);
          },
        ),

        AppBarButton(
          verse: 'flyer',
          onTap: (){
            widget.flyerToEdit?.blogFlyer(methodName: 'XXX');
            _draftFlyer.value.blogDraft();
          },
        ),


      ],
      onBack: () => onCancelFlyerCreation(context),
      layoutWidget: FlyerMakerScreenView(
        formKey: _formKey,
        scrollController: _scrollController,
        headlineController: _headlineController,
        draft: _draftFlyer,
        loading: _loading,
        isEditingFlyer: _isEditingFlyer,
        originalFlyer: widget.flyerToEdit,
      ),
    );

  }
}
