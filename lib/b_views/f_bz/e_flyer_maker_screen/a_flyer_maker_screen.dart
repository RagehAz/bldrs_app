import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/a_models/flyer/mutables/draft_flyer_model.dart';
import 'package:bldrs/b_views/f_bz/e_flyer_maker_screen/aa_flyer_maker_screen_view.dart';
import 'package:bldrs/b_views/f_bz/e_flyer_maker_screen/x_flyer_maker_controllers.dart';
import 'package:bldrs/b_views/z_components/buttons/editor_confirm_button.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/night_sky.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/f_helpers/drafters/formers.dart';
import 'package:flutter/material.dart';

class FlyerMakerScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const FlyerMakerScreen({
    @required this.validateOnStartup,
    this.flyerToEdit,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final FlyerModel flyerToEdit;
  final bool validateOnStartup;
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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // --------------------
  bool _canValidate = false;
  void _switchOnValidation(){
    if (_canValidate != true){
      setState(() {
        _canValidate = true;
      });
    }
  }
  // --------------------
  final ValueNotifier<bool> _canPickImage = ValueNotifier(true);
  // --------------------
  final ValueNotifier<DraftFlyerModel> _draftFlyer = ValueNotifier(null);
  final ValueNotifier<DraftFlyerModel> _lastDraft = ValueNotifier(null);
  // --------------------
  final ScrollController _scrollController = ScrollController();
  final ValueNotifier<bool> _isEditingFlyer = ValueNotifier(null);
  // -----------------------------------------------------------------------------
  /// --- LOADING
  final ValueNotifier<bool> _loading = ValueNotifier(false);
  // --------------------
  Future<void> _triggerLoading({bool setTo}) async {
    if (mounted == true){
      if (setTo == null){
        _loading.value = !_loading.value;
      }
      else {
        _loading.value = setTo;
      }
      blogLoading(loading: _loading.value, callerName: 'FlyerMakerScreen',);
    }
  }
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();

    _isEditingFlyer.value = widget.flyerToEdit != null;

    initializeFlyerMakerLocalVariables(
      context: context,
      draftFlyer: _draftFlyer,
      oldFlyer: widget.flyerToEdit,
      mounted: mounted,
    );

  }
  bool _isInit = true;
  // --------------------
  @override
  void didChangeDependencies() {
    if (_isInit) {

      _triggerLoading(setTo: true).then((_) async {
        // -------------------------------
        await loadFlyerMakerLastSession(
          context: context,
          oldFlyer: widget.flyerToEdit,
          draft: _draftFlyer,
          isEditingFlyer: _isEditingFlyer,
        );
        // -----------------------------
        if (mounted == true){
          await prepareMutableSlidesForEditing(
            flyerToEdit: widget.flyerToEdit,
            draft: _draftFlyer,
          );
        }
        // -----------------------------
        if (_isEditingFlyer.value == true){
          // if (widget.validateOnStartup == true){
          _switchOnValidation();
          Formers.validateForm(_formKey);
        }
        // -----------------------------
        if (mounted == true){
          _draftFlyer.addListener(() async {
            _switchOnValidation();
            await saveFlyerMakerSession(
              draft: _draftFlyer,
              lastDraft: _lastDraft,
              mounted: mounted,
            );
          });
        }
        // -------------------------------
        await _triggerLoading(setTo: false);
      });

    }
    _isInit = false;
    super.didChangeDependencies();
  }
  // --------------------
  /// TAMAM
  @override
  void dispose(){
    _canPickImage.dispose();

    DraftFlyerModel.disposeDraftNodes(
        draft: _draftFlyer.value
    );
    _draftFlyer.dispose();

    _scrollController.dispose();
    _loading.dispose();
    _isEditingFlyer.dispose();

    super.dispose();
  }
  // -----------------------------------------------------------------------------
  Future<void> _onConfirmTap() async {

    _switchOnValidation();

    await onConfirmPublishFlyerButtonTap(
      context: context,
      formKey: _formKey,
      oldFlyer: widget.flyerToEdit,
      draft: _draftFlyer,
    );

  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    /// when using with AutomaticKeepAliveClientMixin
    super.build(context);
    // --------------------
    return MainLayout(
      key: const ValueKey<String>('FlyerPublisherScreen'),
      pageTitleVerse: Verse(
        text: widget.flyerToEdit == null ? 'phid_createFlyer' : 'phid_edit_flyer',
        translate: true,
      ),
      skyType: SkyType.black,
      pyramidsAreOn: true,
      appBarType: AppBarType.basic,
      loading: _loading,
      sectionButtonIsOn: false,
      confirmButtonModel: ConfirmButtonModel(
        // isDeactivated: !_canPublish,
        firstLine: const Verse(
          text: 'phid_publish',
          translate: true,
        ),
        onTap: () => _onConfirmTap(),
      ),
      appBarRowWidgets: <Widget>[

        const Expander(),

        AppBarButton(
          verse: Verse.plain('Identical'),
          onTap: () async {

            FlyerModel.checkFlyersAreIdentical(
              flyer1: widget.flyerToEdit,
              flyer2: await DraftFlyerModel.bakeDraftToUpload(
                draft: _draftFlyer.value,
                toLDB: false,
              ),
            );

          },
        ),

        AppBarButton(
          verse: Verse.plain('draft'),
          onTap: (){
            // widget.flyerToEdit?.blogFlyer(methodName: 'widget.flyerToEdit');
            _draftFlyer.value.blogDraft();

            Formers.validateForm(_formKey);

          },
        ),


      ],
      // onBack: () => onCancelFlyerCreation(context),
      layoutWidget: FlyerMakerScreenView(
        appBarType: AppBarType.basic,
        formKey: _formKey,
        scrollController: _scrollController,
        draft: _draftFlyer,
        loading: _loading,
        isEditingFlyer: _isEditingFlyer,
        originalFlyer: widget.flyerToEdit,
        canValidate: _canValidate,
      ),
    );
    // --------------------
  }
  // -----------------------------------------------------------------------------
}
