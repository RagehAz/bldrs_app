import 'dart:async';
import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/a_models/flyer/mutables/draft_flyer_model.dart';
import 'package:bldrs/a_models/flyer/mutables/mutable_slide.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/dialogs/dialogz/dialogz.dart' as Dialogz;
import 'package:bldrs/b_views/z_components/flyer_maker/shelf_slide.dart';
import 'package:bldrs/b_views/z_components/texting/unfinished_super_text_field.dart';
import 'package:bldrs/b_views/z_components/texting/unfinished_super_verse.dart';
import 'package:bldrs/c_controllers/i_flyer_publisher_controllers/flyer_publisher_controller.dart';
import 'package:bldrs/f_helpers/drafters/aligners.dart' as Aligners;
import 'package:bldrs/f_helpers/drafters/imagers.dart' as Imagers;
import 'package:bldrs/f_helpers/drafters/keyboarders.dart' as Keyboarders;
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart' as Scale;
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart' as Nav;
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:bldrs/f_helpers/theme/standards.dart' as Standards;
import 'package:bldrs/x_dashboard/bldrs_dashboard.dart';
import 'package:flutter/material.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';

class FlyerDraftShelf extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const FlyerDraftShelf({
    @required this.shelfNumber,
    @required this.onDeleteDraft,
    @required this.shelfHeight,
    @required this.bzModel,
    @required this.flyerModel,
    Key key,
}) : super(key: key);
  /// --------------------------------------------------------------------------
  final int shelfNumber;
  final Function onDeleteDraft;
  final double shelfHeight;
  final BzModel bzModel;
  final FlyerModel flyerModel;
  /// --------------------------------------------------------------------------
  @override
  _FlyerDraftShelfState createState() => _FlyerDraftShelfState();
  /// --------------------------------------------------------------------------
  static const double height = 50;
  /// --------------------------------------------------------------------------
}

class _FlyerDraftShelfState extends State<FlyerDraftShelf> with AutomaticKeepAliveClientMixin{
// -----------------------------------------------------------------------------
  @override
  bool get wantKeepAlive => true;
// -----------------------------------------------------------------------------
  final _formKey = GlobalKey<FormState>();
// ----------------------------------------
  int _textLength = 0;
  final int _flyerTitleMaxLength = Standards.flyerTitleMaxLength;
  Color _counterColor = Colorz.white80;

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
  @override
  void initState() {
    _draftFlyer = ValueNotifier<DraftFlyerModel>(null);
    // _headlinesControllers = TextChecker.createEmptyTextControllers(1);
    super.initState();
  }
// -----------------------------------------------------------------------------
  @override
  void dispose(){
    // TextChecker.disposeAllTextControllers(_headlinesControllers);
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
  Future<void> _getMultiGalleryImages({double flyerBoxWidth}) async {

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

          final List<MutableSlide> _newMutableSlides = await MutableSlide.createNewMutableSlidesByAssets(
            assets: _outputAssets,
            existingAssets: MutableSlide.getAssetsFromMutableSlides(mutableSlides: _draftFlyer.value.mutableSlides),
          );


          for (int i = 0; i < _outputAssets.length; i++){
            /// for first headline
            if(i == 0){
              /// keep controller as is
            }
            /// for the nest pages
            else {
              final List<MutableSlide> _combinedSlides = <MutableSlide>[..._draftFlyer.value.mutableSlides, ... _newMutableSlides];
              _draftFlyer.value.mutableSlides = _combinedSlides;
            }
          }

        }

      }

    }

    unawaited(_triggerLoading());

  }
// -----------------------------------------------------------------------------
  Future <void> _onImageTap(int index) async {

    /// TASK : calculating flyer editor width is redundant and should be in separate method
    // final double _screenWidth = Scale.superScreenWidth(context);
    // const double _buttonSize = 50;
    // const double _panelWidth = _buttonSize + (Ratioz.appBarMargin * 2);
    // double _flyerZoneWidth = _screenWidth - _panelWidth - Ratioz.appBarMargin;

    blog('index is : $index');

    final dynamic _result = await Nav.goToNewScreen(context,
        // FlyerEditorScreen(
        //   draftFlyer : _draftFlyer,
        //   firstTitle : _headlinesControllers.isEmpty ? null : _headlinesControllers[0].text,
        //   headlinesControllers: _headlinesControllers,
        //   index: index,
        //   firstTimer: widget.firstTimer,
        //   bzModel: widget.bzModel,
        //   flyerModel: null,
        //   flyerZoneWidth: _flyerZoneWidth,
        //   onDeleteImage: (i) => _onImageDelete(i),
        // )

      const BldrsDashBoard()
    );

    if (_result == 'published'){
        _draftFlyer.value.flyerState = FlyerState.published;
    }

    else {
      blog('not published');
    }

    /// why
    Keyboarders.minimizeKeyboardOnTapOutSide(context);
  }
// -----------------------------------------------------------------------------
  void _onImageDelete(int index) {
    onDeleteSlide(
      index: index,
      draftFlyer: _draftFlyer
    );
  }
// -----------------------------------------------------------------------------
  String _firstHeadlineValidator(String val){

    if(val.length >= _flyerTitleMaxLength){

      if(_counterColor != Colorz.red255){
        setState(() {
          _counterColor = Colorz.red255;
        });
      }

      return 'Only $_flyerTitleMaxLength characters allowed for the flyer title';
    }

    else {

      if(_counterColor != Colorz.white80){
        setState(() {
          _counterColor = Colorz.white80;
        });
      }

      return null;
    }
  }
// -----------------------------------------------------------------------------
  void _firstHeadlineOnChanged(String val){
    _formKey.currentState.validate();

    setState(() {
      _textLength = val.length;
    });
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    /// when using with AutomaticKeepAliveClientMixin
    super.build(context);

    final double _shelfSlideZoneHeight = ShelfSlide.shelfSlideZoneHeight(context);
    const double _shelfHeaderHeight = FlyerDraftShelf.height;
    final double _overAllHeight = _shelfSlideZoneHeight + _shelfHeaderHeight;

    const BzAccountType _accountType = BzAccountType.premium;
    const double _deleteFlyerButtonSize = _shelfHeaderHeight * 0.9;
    final double _flyerTitleZoneWidth = Scale.superScreenWidth(context) - _deleteFlyerButtonSize - (Ratioz.appBarMargin * 3);

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

            final String _shelfTitle = DraftFlyerModel.generateShelfTitle(
              context: context,
              times: draft.times,
              flyerState: draft.flyerState,
              shelfNumber: widget.shelfNumber,
            );
            final bool _isPublished = draft.flyerState == FlyerState.published;
            final bool _hasSlides = canLoopList(draft.mutableSlides);

            return ListView(
              physics: const NeverScrollableScrollPhysics(),
              children: <Widget>[

                /// SHELF HEADER
                Container(
                  width: Scale.superScreenWidth(context),
                  height: _shelfHeaderHeight,
                  alignment: Aligners.superCenterAlignment(context),
                  color: Colorz.bloodTest,
                  padding: const EdgeInsets.symmetric(horizontal: Ratioz.appBarMargin),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[

                      /// FLYER TITLE TEXT FIELD & COUNTER
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[

                          /// CHAIN NUMBER AND COUNTER
                          SizedBox(
                            width: _flyerTitleZoneWidth,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  right: Ratioz.appBarPadding,
                                  left: Ratioz.appBarPadding,
                                  top: Ratioz.appBarMargin,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[

                                  /// CHAIN NUMBER
                                  SuperVerse(
                                    verse: _shelfTitle,
                                    size: 1,
                                    italic: true,
                                    color: _isPublished ? Colorz.green255: Colorz.white80,
                                    weight: VerseWeight.thin,
                                  ),

                                  /// TEXT FIELD COUNTER
                                  if  (_isPublished == false && _hasSlides)
                                    SuperVerse(
                                      verse: '$_textLength / $_flyerTitleMaxLength',
                                      size: 1,
                                      italic: true,
                                      color: _counterColor,
                                      weight: VerseWeight.thin,
                                    ),

                                ],
                              ),
                            ),
                          ),

                          /// FIRST HEADLINE TEXT FIELD
                          if  (_isPublished == false && _hasSlides)
                            Form(
                              key: _formKey,
                              child: SuperTextField(
                                // onTap: (){},
                                fieldIsFormField: true,
                                height: _shelfHeaderHeight,
                                width: _flyerTitleZoneWidth,
                                maxLines: 1,
                                counterIsOn: false,
                                validator: (val) => _firstHeadlineValidator(val),
                                // margin: EdgeInsets.only(top: Ratioz.appBarPadding),
                                hintText: 'Flyer Headline ...',
                                textController: draft.mutableSlides[0].headline,
                                maxLength: _flyerTitleMaxLength,
                                onChanged: (value) => _firstHeadlineOnChanged(value),

                              ),
                            ),

                          // /// FIRST HEADLINE AS SUPER VERSE
                          // if (_isPublished == true && _hasSlides)
                          //   Container(
                          //     width: _flyerTitleZoneWidth,
                          //     height: _deleteFlyerButtonSize,
                          //     decoration: BoxDecoration(
                          //       color: Colorz.white10,
                          //       borderRadius: Borderers.superBorderAll(context, Ratioz.boxCorner12),
                          //     ),
                          //     alignment: Aligners.superCenterAlignment(context),
                          //     padding: const EdgeInsets.symmetric(horizontal: Ratioz.appBarMargin),
                          //     child: SuperVerse(
                          //       verse: draft.mutableSlides[0].headline.text,
                          //       centered: false,
                          //       size: 3,
                          //     ),
                          //   ),

                        ],
                      ),

                      /// SPACER
                      const SizedBox(
                        width: Ratioz.appBarMargin,
                      ),

                      /// DELETE DRAFT BUTTON
                      Container(
                        width: _deleteFlyerButtonSize,
                        height: _shelfHeaderHeight,
                        alignment: Alignment.center,
                        child: DreamBox(
                            height: _deleteFlyerButtonSize,
                            width: _deleteFlyerButtonSize,
                            color: _isPublished ? Colorz.green255 : null,
                            icon: _isPublished ? Iconz.check : Iconz.xLarge,
                            iconColor: _isPublished ? Colorz.white255 : null,
                            iconSizeFactor: 0.7,
                            onTap: (){

                              DraftFlyerModel.disposeDraftControllers(
                                draft: draft,
                              );

                              widget.onDeleteDraft();
                            }
                        ),

                      ),

                    ],
                  ),
                ),

                /// SHELF SLIDES
                SizedBox(
                  width: Scale.superScreenWidth(context),
                  height: _shelfSlideZoneHeight,
                  child: ListView.builder(
                    itemCount: draft.mutableSlides.length + 1,
                    scrollDirection: Axis.horizontal,
                    itemExtent: ShelfSlide.flyerBoxWidth,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (ctx, index){

                      final bool _atLastIndex = draft.mutableSlides.length == index;
                      final MutableSlide _mutableSlide = _atLastIndex ? null : draft.mutableSlides[index];

                      return ShelfSlide(
                          mutableSlide: _mutableSlide,
                          number: index + 1,
                          onTap: (){

                            if (_atLastIndex == true){
                              blog('add new pics aho');
                            }
                            else {
                              blog('slide is tapped aho');
                              _mutableSlide.blogSlide();
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
