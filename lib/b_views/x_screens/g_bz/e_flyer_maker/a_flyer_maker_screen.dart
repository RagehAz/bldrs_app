import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/a_models/flyer/mutables/draft_flyer_model.dart';
import 'package:bldrs/b_views/x_screens/g_bz/e_flyer_maker/aa_flyer_maker_screen_view.dart';
import 'package:bldrs/b_views/z_components/buttons/editor_confirm_button.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/night_sky.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/c_controllers/g_bz_controllers/e_flyer_maker/a_flyer_maker_controllers.dart';
import 'package:bldrs/c_controllers/g_bz_controllers/e_flyer_maker/aa_draft_shelf_controllers.dart';
import 'package:bldrs/c_protocols/phrase_protocols/a_phrase_protocols_old.dart';
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
  final ScrollController _scrollController = ScrollController();
  TextEditingController _headlineController;
  ValueNotifier<DraftFlyerModel> _draftFlyer;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isEditingFlyer;
// -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();

    _isEditingFlyer = widget.flyerToEdit != null;

    _headlineController = TextEditingController(text: widget.flyerToEdit?.headline);

    _draftFlyer = initializeDraft(
      context: context,
    );

  }
// -----------------------------------------------------------------------------
  /// --- LOADING
  final ValueNotifier<bool> _loading = ValueNotifier(false);
// -----------
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
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit) {

      _triggerLoading(setTo: true).then((_) async {
        // -------------------------------

        blog('FlyerMakerScreen : didChangeDependencies');

        if (mounted == true){
          await initializeExistingFlyerDraft(
            flyerToEdit: widget.flyerToEdit,
            draft: _draftFlyer,
          );
        }

        if (mounted == true){
          _headlineController = initializeHeadlineController(
            draftFlyer: _draftFlyer,
          );
        }

        // -------------------------------
        await _triggerLoading(setTo: false);

      });

    }
    _isInit = false;
    super.didChangeDependencies();
  }
// -----------------------------------------------------------------------------
  /// TAMAM
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

    // const bool _canPublish =
    // DraftFlyerModel.checkCanPublishDraft(
    //   draft: _draft,
    //   headlineController: _headlineController,
    // )
    // true
    // ;


    return MainLayout(
      key: const ValueKey<String>('FlyerPublisherScreen'),
      pageTitle: widget.flyerToEdit == null ? xPhrase(context, 'phid_createFlyer') : 'Edit Flyer',
      skyType: SkyType.black,
      pyramidsAreOn: true,
      appBarType: AppBarType.basic,
      loading: _loading,
      sectionButtonIsOn: false,
      confirmButtonModel: ConfirmButtonModel(
          // isDeactivated: !_canPublish,
          firstLine: _isEditingFlyer == true ? 'Update Flyer' : xPhrase(context, 'phid_publish'),
          onTap: () async {

            if (_isEditingFlyer == true){
              await onPublishFlyerUpdatesTap(
                context: context,
                draft: _draftFlyer,
                formKey: _formKey,
                originalFlyer: widget.flyerToEdit,
              );
            }

            else {
              await onPublishNewFlyerTap(
                context: context,
                draft: _draftFlyer,
                formKey: _formKey,
              );
            }

          }
      ),
      appBarRowWidgets: <Widget>[

        const Expander(),

        AppBarButton(
          verse: 'Identical',
          onTap: (){

            FlyerModel.checkFlyersAreIdentical(
                flyer1: widget.flyerToEdit,
                flyer2: _draftFlyer.value.toFlyerModel(),
            );


          },
        ),

        AppBarButton(
          verse: 'draft',
          onTap: (){
            widget.flyerToEdit?.blogFlyer(methodName: 'widget.flyerToEdit');
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
