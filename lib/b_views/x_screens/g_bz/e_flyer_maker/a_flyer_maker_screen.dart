import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/a_models/flyer/mutables/draft_flyer_model.dart';
import 'package:bldrs/a_models/flyer/mutables/mutable_slide.dart';
import 'package:bldrs/b_views/x_screens/g_bz/e_flyer_maker/aa_flyer_maker_screen_view.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/night_sky.dart';
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
  /// --- LOADING
  final ValueNotifier<bool> _loading = ValueNotifier(false); /// tamam disposed
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
          verse: 'test',
          onTap: (){
            // SpecModel.blogSpecs(_draftFlyer.value.specs);

            final MutableSlide _slide1 = _draftFlyer.value.mutableSlides[0].copyWith(

            );
            final MutableSlide _slide2 = _draftFlyer.value.mutableSlides[0].copyWith();

            if (_slide1 == _slide2){
              blog('are identical');
            }
            else {
              blog('fuck are not identical');
            }

            blog('hashCode : ${_slide2.hashCode} : ${_slide1.hashCode}',);

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
