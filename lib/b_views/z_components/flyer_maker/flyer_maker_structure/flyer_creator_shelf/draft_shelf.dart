import 'dart:async';
import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/a_models/flyer/mutables/draft_flyer_model.dart';
import 'package:bldrs/a_models/flyer/mutables/mutable_slide.dart';
import 'package:bldrs/b_views/x_screens/i_flyer/flyer_maker_screen.dart/slide_editor_screen.dart';
import 'package:bldrs/b_views/z_components/dialogs/bottom_dialog/bottom_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/dialogz/dialogz.dart' as Dialogz;
import 'package:bldrs/b_views/z_components/flyer_maker/flyer_maker_structure/flyer_creator_shelf/shelf_header.dart';
import 'package:bldrs/b_views/z_components/flyer_maker/flyer_maker_structure/flyer_creator_shelf/shelf_slide.dart';
import 'package:bldrs/c_controllers/i_flyer_publisher_controllers/flyer_publisher_controller.dart';
import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:bldrs/f_helpers/drafters/imagers.dart' as Imagers;
import 'package:bldrs/f_helpers/drafters/keyboarders.dart' as Keyboarders;
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart' as Scale;
import 'package:bldrs/f_helpers/drafters/scrollers.dart' as Scrollers;
import 'package:bldrs/f_helpers/drafters/text_checkers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart' as Nav;
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:bldrs/f_helpers/theme/standards.dart' as Standards;
import 'package:flutter/material.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';

class DraftShelf extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const DraftShelf({
    @required this.shelfNumber,
    @required this.onDeleteDraft,
    @required this.bzModel,
    @required this.flyerModel,
    Key key,
}) : super(key: key);
  /// --------------------------------------------------------------------------
  final int shelfNumber;
  final Function onDeleteDraft;
  final BzModel bzModel;
  final FlyerModel flyerModel;
  /// --------------------------------------------------------------------------
  @override
  _DraftShelfState createState() => _DraftShelfState();
  /// --------------------------------------------------------------------------
}

class _DraftShelfState extends State<DraftShelf> with AutomaticKeepAliveClientMixin{
// -----------------------------------------------------------------------------
  @override
  bool get wantKeepAlive => true;
// -----------------------------------------------------------------------------
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
// ----------------------------------------
  final TextEditingController _headlineController = TextEditingController();
  final ValueNotifier<int> _headlineLength = ValueNotifier(0);
// -----------------------------------------------------------------------------
  ValueNotifier<DraftFlyerModel> _draftFlyer;
// -----------------------------------------------------------------------------
  /// --- LOCAL LOADING BLOCK
  final ValueNotifier<bool> _loading = ValueNotifier(false);
// -----------------------------------
  Future<void> _triggerLoading() async {
    _loading.value = !_loading.value;
    blogLoading(loading: _loading.value);
  }
// -----------------------------------------------------------------------------
  ScrollController _scrollController;
  @override
  void initState() {
    _scrollController = ScrollController();
    _draftFlyer = ValueNotifier<DraftFlyerModel>(null);
    // _headlinesControllers = TextChecker.createEmptyTextControllers(1);
    super.initState();
  }
// -----------------------------------------------------------------------------
  @override
  void dispose(){
    disposeControllerIfPossible(_headlineController);
    super.dispose();
  }
// -----------------------------------------------------------------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit) {

      _triggerLoading().then((_) async {

        _draftFlyer.value = await initializeDraftFlyerModel(
          bzModel: widget.bzModel,
          existingFlyer: widget.flyerModel,
        );

        await _triggerLoading();
      });

    }
    _isInit = false;
    super.didChangeDependencies();
  }
// -----------------------------------------------------------------------------
  Future<void> _getMultiGalleryImages() async {

    unawaited(_triggerLoading());

    final List<Asset> _assetsSources = MutableSlide.getAssetsFromMutableSlides(
      mutableSlides: _draftFlyer.value.mutableSlides,
    );

    final int _maxLength = Standards.getMaxSlidesCount(
      bzAccountType: widget.bzModel.accountType,
    );

    /// A - if max images reached
    if(_maxLength <= _assetsSources.length ){

      await Dialogz.maxSlidesReached(context, _maxLength);

    }

    /// A - if can pick more images
    else {

      List<Asset> _outputAssets;

      if(mounted){

        _outputAssets = await Imagers.takeGalleryMultiPictures(
          context: context,
          images: _assetsSources,
          mounted: mounted,
          accountType: widget.bzModel.accountType,
        );

        /// B - if didn't pick more images
        if(_outputAssets.isEmpty){
          // will do nothing
        }

        /// B - if made new picks
        else {

          blog('the thing is : $_outputAssets');

          final List<MutableSlide> _newMutableSlides = await MutableSlide.createNewMutableSlidesByAssets(
            assets: _outputAssets,
            existingMutableSlides: _draftFlyer.value.mutableSlides,
            headlineController: _headlineController,
          );

          final List<MutableSlide> _combinedSlides = <MutableSlide>[... _newMutableSlides];
          final DraftFlyerModel _newDraft = _draftFlyer.value.replaceSlides(_combinedSlides,);

          _draftFlyer.value = _newDraft;
          // setState(() {});

          await Future.delayed(Ratioz.duration150ms,() async {
            await Scrollers.scrollToEnd(
              controller: _scrollController,
            );
          });


          // for (int i = 0; i < _outputAssets.length; i++){
          //   /// for first headline
          //   if(i == 0){
          //     /// keep controller as is
          //   }
          //   /// for the nest pages
          //   else {
          //   }
          // }

        }

      }

    }

    unawaited(_triggerLoading());

  }
// -----------------------------------------------------------------------------
  Future<void> _goToSlideEditorScreen(MutableSlide slide) async {
    Keyboarders.minimizeKeyboardOnTapOutSide(context);

    final MutableSlide _result = await Nav.goToNewScreen(context, SlideEditorScreen(
      slide: slide,
    ));

    blog('received slide aho');

    // _result.blogSlide();

    final int _slideIndex = _result.slideIndex;

    final List<MutableSlide> _updatedSlides = MutableSlide.replaceSlide(
      slides: _draftFlyer.value.mutableSlides,
      slide: _result,
    );

    _draftFlyer.value = _draftFlyer.value.copyWith(
      mutableSlides: _updatedSlides,
    );

    // _draftFlyer.value.blogDraft();

    /*

    /// TASK : bokra isa

    final bool _noChangeOccured = MutableSlide.slidesAreTheSame(slide, _result);

    if (_noChangeOccured == true){
      // do nothing
    }
    else {
      _draftFlyer.value = _draftFlyer.value.replaceSlideWith(_result);
    }


     */
  }
// -----------------------------------------------------------------------------
  void _onImageDelete(int index) {
    onDeleteSlide(
      index: index,
      draftFlyer: _draftFlyer
    );
  }
// -----------------------------------------------------------------------------
  Future<void> _onMoreTap() async {


    await BottomDialog.showButtonsBottomDialog(
        context: context,
        draggable: true,
        buttonHeight: BottomDialog.wideButtonHeight,
        numberOfWidgets: 3,
        builder: (BuildContext ctx, PhraseProvider phraseProvider){

          final List<Widget> _widgets = <Widget>[

            /// DELETE
            BottomDialog.wideButton(
              context: context,
              verse: superPhrase(context, 'phid_delete'),
              verseCentered: true,
              onTap: (){
                Nav.goBack(context);
                widget.onDeleteDraft();
              },
            ),

            /// SAVE DRAFT
            BottomDialog.wideButton(
              context: context,
              verse: 'Save Draft',
              verseCentered: true,
              onTap: (){
                Nav.goBack(context);

              },
            ),

            /// PUBLISH
            BottomDialog.wideButton(
              context: context,
              verse: 'Publish',
              verseCentered: true,
              onTap: (){
                Nav.goBack(context);

              },
            ),

          ];


          return _widgets;

        },
    );

  }
// -----------------------------------------------------------------------------
  void _onFlyerHeadlineChanged(String val){
    _formKey.currentState.validate();
    _headlineLength.value = val.length;

    if (canLoopList(_draftFlyer.value.mutableSlides) == true){
      _draftFlyer.value.updateHeadline(val);
    }

  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    /// when using with AutomaticKeepAliveClientMixin
    super.build(context);

    final double _slideZoneHeight = ShelfSlide.shelfSlideZoneHeight(context);
    const double _headerHeight = ShelfHeader.height;
    final double _overAllHeight = _slideZoneHeight + _headerHeight;

    const BzAccountType _accountType = BzAccountType.premium;

    return Container(
      width: Scale.superScreenWidth(context),
      height: _overAllHeight,
      color: Colorz.white10,
      child:
      _draftFlyer == null ? const SizedBox() :
      ValueListenableBuilder(
        valueListenable: _draftFlyer,
        builder: (_, DraftFlyerModel draft, Widget child){

          if (draft == null){
            return const SizedBox();
          }

          else {


            return ListView(
              physics: const NeverScrollableScrollPhysics(),
              children: <Widget>[

                /// SHELF HEADER
                ShelfHeader(
                  formKey: _formKey,
                  draft: draft,
                  shelfNumber: widget.shelfNumber,
                  titleLength: _headlineLength,
                  onMoreTap: _onMoreTap,
                  loading: _loading,
                  headlineController: _headlineController,
                  onHeadlineChanged: (String val) => _onFlyerHeadlineChanged(val),
                ),

                /// SHELF SLIDES
                SizedBox(
                  width: Scale.superScreenWidth(context),
                  height: _slideZoneHeight,
                  child: ListView.builder(
                    controller: _scrollController,
                    itemCount: draft.mutableSlides.length + 1,
                    scrollDirection: Axis.horizontal,
                    itemExtent: ShelfSlide.flyerBoxWidth,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (ctx, index){

                      final bool _atLastIndex = draft.mutableSlides.length == index;
                      final MutableSlide _mutableSlide = _atLastIndex ? null : draft.mutableSlides[index];
                      final bool _hasSlides = draft.mutableSlides.isNotEmpty;

                      return ShelfSlide(
                          mutableSlide: _mutableSlide,
                          headline: _hasSlides && index == 0 ? _headlineController : null,
                          number: index + 1,
                          onTap: () async {

                            if (_atLastIndex == true){
                              await _getMultiGalleryImages();
                            }
                            else {

                              await _goToSlideEditorScreen(_mutableSlide);

                            }

                          }
                      );

                    },
                  ),

                ),

              ],
            );

          }

        },
      ),
    );
  }
}
