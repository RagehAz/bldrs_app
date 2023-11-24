// ignore_for_file: avoid_positional_boolean_parameters
import 'dart:async';

import 'package:basics/animators/helpers/sliders.dart';
import 'package:basics/bldrs_theme/night_sky/night_sky.dart';
import 'package:basics/helpers/classes/checks/tracers.dart';
import 'package:basics/helpers/classes/maps/mapper.dart';
import 'package:basics/mediator/pic_maker/pic_maker.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/c_chain/d_spec_model.dart';
import 'package:bldrs/a_models/d_zoning/world_zoning.dart';
import 'package:bldrs/a_models/f_flyer/draft/draft_flyer_model.dart';
import 'package:bldrs/a_models/f_flyer/draft/draft_slide.dart';
import 'package:bldrs/a_models/f_flyer/sub/price_model.dart';
import 'package:bldrs/a_models/i_pic/pic_model.dart';
import 'package:bldrs/a_models/x_utilities/pdf_model.dart';
import 'package:bldrs/b_views/f_bz/e_flyer_maker_screen/flyer_editor_screen/flyer_editor_pages/a_flyer_editor_page_slides_headline.dart';
import 'package:bldrs/b_views/f_bz/e_flyer_maker_screen/flyer_editor_screen/flyer_editor_pages/b_flyer_editor_page_type_description.dart';
import 'package:bldrs/b_views/f_bz/e_flyer_maker_screen/flyer_editor_screen/flyer_editor_pages/c_flyer_editor_page_keywords_specs.dart';
import 'package:bldrs/b_views/f_bz/e_flyer_maker_screen/flyer_editor_screen/flyer_editor_pages/d_flyer_editor_page_pdf.dart';
import 'package:bldrs/b_views/f_bz/e_flyer_maker_screen/flyer_editor_screen/flyer_editor_pages/e_flyer_editor_page_zone.dart';
import 'package:bldrs/b_views/f_bz/e_flyer_maker_screen/flyer_editor_screen/flyer_editor_pages/f_flyer_editor_page_author_poster.dart';
import 'package:bldrs/b_views/f_bz/e_flyer_maker_screen/flyer_editor_screen/x_flyer_maker_controllers.dart';
import 'package:bldrs/b_views/f_bz/e_flyer_maker_screen/flyer_editor_screen/xx_draft_shelf_controllers.dart';
import 'package:bldrs/b_views/f_bz/e_flyer_maker_screen/flyer_editor_screen/z_components/slides_shelf/e_draft_shelf_slide.dart';
import 'package:bldrs/b_views/z_components/buttons/editors_buttons/editor_confirm_page.dart';
import 'package:bldrs/b_views/z_components/buttons/editors_buttons/editor_swiping_buttons.dart';
import 'package:bldrs/b_views/z_components/dialogs/dialogz/dialogs.dart';
import 'package:bldrs/b_views/z_components/layouts/custom_layouts/pages_builder.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/app_bar/bldrs_app_bar.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/static_progress_bar/progress_bar_model.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/bz_protocols/provider/bzz_provider.dart';
import 'package:bldrs/f_helpers/drafters/formers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewFlyerEditorScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const NewFlyerEditorScreen({
    required this.draftFlyer,
    required this.onConfirm,
    super.key
  });
  /// -----------------------
  final DraftFlyer? draftFlyer;
  final Function(DraftFlyer? draft) onConfirm;
  /// -----------------------
  @override
  State<NewFlyerEditorScreen> createState() => _NewFlyerEditorScreenState();
  /// --------------------------------------------------------------------------
}

class _NewFlyerEditorScreenState extends State<NewFlyerEditorScreen> with AutomaticKeepAliveClientMixin{
  // -----------------------------------------------------------------------------
  final ValueNotifier<ProgressBarModel?> _progressBarModel = ValueNotifier(null);
  final PageController _pageController = PageController();
  final ScrollController _slidesShelfScrollController = ScrollController();
  // -----------------------------------------------------------------------------
  /// to keep out of screen objects alive
  @override
  bool get wantKeepAlive => true;
  // -----------------------------------------------------------------------------
  final ValueNotifier<DraftFlyer?> _draftNotifier = ValueNotifier(null);
  DraftFlyer? _originalFlyer;
  // --------------------
  final ValueNotifier<bool> priceIsGood = ValueNotifier(true);
  // --------------------
  bool _canValidate = true;
  void _switchOnValidation(){
    if (mounted == true){
      if (_canValidate != true){
        setState(() {
          _canValidate = true;
        });
      }
    }
  }
  // -----------------------------------------------------------------------------
  /// --- LOADING
  final ValueNotifier<bool> _loadingPage = ValueNotifier(true);
  final ValueNotifier<bool> _loadingSlides = ValueNotifier(false);
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();

    setNotifier(
      notifier: _progressBarModel,
      mounted: mounted,
      value: ProgressBarModel.initialModel(
        numberOfStrips: 7,
      ),
    );

  }
  // --------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {

    if (_isInit && mounted) {
      _isInit = false; // good

      asyncInSync(() async {
        // -------------------------------
        /// INITIALIZE DRAFT
        await _initializeDraft();
        // -----------------------------
        /// ADD SESSION LISTENERS
        if (mounted == true){
          _addSessionListeners();
        }
        // -------------------------------
        /// LOAD LAST SESSION
        await loadFlyerMakerLastSession(
          context: context,
          draft: _draftNotifier,
          mounted: mounted,
        );
        // -----------------------------
        /// VALIDATION SWITCH
        if (_draftNotifier.value?.firstTimer == false){
          _switchOnValidation();
          Formers.validateForm(_draftNotifier.value?.formKey);
        }
        // -------------------------------
        setNotifier(notifier: _loadingPage, mounted: mounted, value: false);
        setNotifier(notifier: _loadingSlides, mounted: mounted, value: false);
        // -------------------------------
      });

    }

    super.didChangeDependencies();
  }
  // --------------------
  @override
  void dispose(){

    _slidesShelfScrollController.dispose();
    _loadingPage.dispose();
    _loadingSlides.dispose();
    _draftNotifier.value?.dispose();
    _draftNotifier.dispose();
    _progressBarModel.dispose();
    _pageController.dispose();
    priceIsGood.dispose();

    super.dispose();
  }
  // -----------------------------------------------------------------------------

  /// INITIALIZATIONS

  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _initializeDraft() async {

    setNotifier(
      notifier: _draftNotifier,
      mounted: mounted,
      value: widget.draftFlyer,
    );

    _originalFlyer = widget.draftFlyer;

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  void _addSessionListeners(){

    _draftNotifier.addListener(() async {

      _stripsListener();

      _switchOnValidation();

      await saveFlyerMakerSession(
        draft: _draftNotifier,
      );

    });

  }
  // -----------------------------------------------------------------------------

  /// STRIPS

  // --------------------
  /// TESTED : WORKS PERFECT
  void _stripsListener(){

    // -----------------
    /// STRIP 1 : SLIDES - HEADLINE - TYPE

    final bool _slidesAreValid = Formers.slidesValidator(
      draftFlyer: _draftNotifier.value,
      canValidate: true,
    ) == null;
    final bool _headlineIsValid = Formers.flyerHeadlineValidator(
      headline: _draftNotifier.value?.headline?.text,
      canValidate: true,
    ) == null;

    if (_slidesAreValid == false || _headlineIsValid == false){
      setStripIsValid(0, false);
    }
    else {
      setStripIsValid(0, true);
    }

    // -----------------
    /// STRIP 2 : TYPE - DESCRIPTION

    final bool _typeIsValid = Formers.flyerTypeValidator(
      draft: _draftNotifier.value,
      canValidate: true,
    ) == null;
    final bool _descriptionIsValid = Formers.paragraphValidator(
      text: _draftNotifier.value?.description?.text,
      canValidate: true,
    ) == null;

    if (_typeIsValid == false || _descriptionIsValid == false){
      setStripIsValid(1, false);
    }
    else {
      setStripIsValid(1, true);
    }

    // -----------------
    /// STRIP 3 : KEYWORDS

    final bool _phidsAreValid = Formers.flyerPhidsValidator(
      phids: _draftNotifier.value?.phids,
      flyerType: _draftNotifier.value?.flyerType,
      canValidate: true,
    ) == null;

    if (_phidsAreValid == false){
      setStripIsValid(2, false);
    }
    else {
      setStripIsValid(2, true);
    }

    // -----------------
    /// STRIP 4 : PDF

    final bool _pdfIsValid = Formers.pdfValidator(
      pdfModel: _draftNotifier.value?.pdfModel,
      canValidate: true,
    ) == null;

    if (_pdfIsValid == false){
      setStripIsValid(3, false);
    }
    else {
      setStripIsValid(3, true);
    }

    // -----------------
    /// STRIP 5 : ZONE

    final bool _zoneIsValid = Formers.zoneValidator(
      zoneModel: _draftNotifier.value?.zone,
      selectCountryIDOnly: false,
      canValidate: _canValidate,
    ) == null;

    if (_zoneIsValid == false){
      setStripIsValid(4, false);
    }
    else {
      setStripIsValid(4, true);
    }

    // -----------------
    /// STRIP 6 : SHOW AUTHOR - POSTER : NOTHING TO VALIDATE
    // ------->

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  void setStripIsValid(int index, bool isValid){
    ProgressBarModel.setStripColor(
      notifier: _progressBarModel,
      mounted: mounted,
      index: index,
      color: isValid == true ? ProgressBarModel.goodStripColor : ProgressBarModel.errorStripColor,
    );
  }
  // -----------------------------------------------------------------------------

  /// CHECKERS

  // --------------------
  /// TESTED : WORKS PERFECT
  bool _canConfirmEdits(){
    final bool _hasError = Mapper.boolIsTrue(_progressBarModel.value?.stripsColors?.contains(ProgressBarModel.errorStripColor));
    return _hasError == false && _flyerHasChanged() == true;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  bool _flyerHasChanged(){
    return !DraftFlyer.checkDraftsAreIdentical(
      draft1: _originalFlyer,
      draft2: _draftNotifier.value,
    );
  }
  // -----------------------------------------------------------------------------

  /// SWIPING

  // --------------------
  /// TESTED : WORKS PERFECT
  bool _canGoFrom0to1({
    required DraftFlyer? draft,
  }){
    return Formers.slidesValidator(draftFlyer: _draftNotifier.value, canValidate: true,) == null
           &&
           Formers.flyerHeadlineValidator(headline: draft?.headline?.text, canValidate: _canValidate,) == null;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  bool _canGoFrom1To2({
    required DraftFlyer? draft,
  }){
    return Formers.flyerTypeValidator(draft: draft, canValidate: true,) == null
           &&
           Formers.paragraphValidator(text: draft?.description?.text, canValidate: _canValidate,) == null;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  bool _canGoFrom2to3({
    required DraftFlyer? draft,
  }){
    return Formers.flyerPhidsValidator(
      phids: draft?.phids,
      flyerType: draft?.flyerType,
      canValidate: true,
    ) == null
    &&
    // PriceSelectorBubble.validate(
    //   draft: draft,
    //   currentPriceText: draft?.price?.current.toString(),
    //   oldPriceText: draft?.price?.old.toString(),
    // ) == null;
    priceIsGood.value == true;

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  bool _canGoFrom3To4({
    required DraftFlyer? draft,
  }){
    return Formers.pdfValidator(canValidate: true, pdfModel: draft?.pdfModel,) == null;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  bool _canGoFrom4To5({
    required DraftFlyer? draft,
  }){
    return Formers.zoneValidator(zoneModel: draft?.zone, selectCountryIDOnly: false, canValidate: true,) == null;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  bool _canGoFrom5To6({
    required DraftFlyer? draft,
  }){
    return true;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _onNextTap() async {

    await EditorSwipingButtons.onNextTap(
      context: context,
      mounted: mounted,
      pageController: _pageController,
      progressBarModel: _progressBarModel,
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _onPreviousTap() async {

    await EditorSwipingButtons.onPreviousTap(
      context: context,
      mounted: mounted,
      pageController: _pageController,
      progressBarModel: _progressBarModel,
    );

  }
  // -----------------------------------------------------------------------------

  /// CONFIRMATION

  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _onConfirmTap() async {

    _switchOnValidation();

    widget.onConfirm(_draftNotifier.value);

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Verse _createConfirmVerse(){

    return const Verse(id: 'phid_confirm', translate: true);

    // if (Mapper.boolIsTrue(widget.draftFlyer?.firstTimer) == true){
    //   return const Verse(id: 'phid_createFlyer', translate: true);
    // }
    // else {
    //   return const Verse(id: 'phid_edit_flyer', translate: true);
    // }

  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    /// when using with AutomaticKeepAliveClientMixin
    super.build(context);
    // --------------------
    return MainLayout(
      canSwipeBack: false,
      key: const ValueKey<String>('FlyerPublisherScreen'),
      title: const Verse(
        id: 'phid_flyer_editor',
        translate: true,
      ),
      pyramidsAreOn: true,
      appBarType: AppBarType.basic,
      skyType: SkyType.grey,
      loading: _loadingPage,
      progressBarModel: _progressBarModel,
      onBack: () => Dialogs.goBackDialog(
        goBackOnConfirm: true,
        titleVerse: const Verse(id: 'phid_exit_this_editor_page?', translate: true),
        bodyVerse: const Verse(id: 'phid_draft_is_temp_stored', translate: true),
        confirmButtonVerse: const Verse(id: 'phid_exit', translate: true),
      ),
      appBarRowWidgets: <Widget>[

        /// BZ LOGO IN APP BAR
        Selector<BzzProvider, BzModel?>(
          selector: (_, BzzProvider bzzProvider) => bzzProvider.myActiveBz,
          builder: (BuildContext context, BzModel? bzModel, Widget? child){

            return AppBarButton(
              icon: bzModel?.logoPath,
              bigIcon: true,
              bubble: false,
              onTap: () async {

                await Sliders.slideToIndex(
                  pageController: _pageController,
                  toIndex: 0,
                  duration: const Duration(milliseconds: 700),
                  curve: Curves.easeInOutExpo,
                );

                _draftNotifier.value?.blogDraft(invoker: 'current');

                },
            );

            },

        ),

      ],
      child: ValueListenableBuilder(
        valueListenable: _draftNotifier,
        builder: (_, DraftFlyer? draft, Widget? child){

          return Form(
            key: draft?.formKey,
            child: PagerBuilder(
              progressBarModel: _progressBarModel,
              pageController: _pageController,
              pageBubbles: <Widget>[

                /// 0 - SLIDES - HEADLINE
                FlyerEditorPage0SlidesHeadlines(
                  canValidate: _canValidate,
                  draft: draft,
                  shelfScrollController: _slidesShelfScrollController,
                  loadingSlides: _loadingSlides,
                  onNext: _onNextTap,
                  canGoNext: _canGoFrom0to1(draft: draft),
                  onHeadlineTextChanged: (String? text) => onUpdateFlyerHeadline(
                    draftNotifier: _draftNotifier,
                    text: text,
                    mounted: mounted,
                  ),
                  onReorderSlide: (int oldIndex, int newIndex) => onReorderSlide(
                    draftFlyer: _draftNotifier,
                    mounted: mounted,
                    oldIndex: oldIndex,
                    newIndex: newIndex,
                  ),
                  onAddSlides: (PicMakerType imagePickerType) => onAddNewSlides(
                    context: context,
                    isLoading: _loadingSlides,
                    draftFlyer: _draftNotifier,
                    mounted: mounted,
                    scrollController: _slidesShelfScrollController,
                    flyerBoxWidth: DraftShelfSlide.flyerBoxWidth,
                    imagePickerType: imagePickerType,
                  ),
                  onSlideTap: (DraftSlide slide) => onSlideTap(
                    slide: slide,
                    draftFlyer: _draftNotifier,
                    mounted: mounted,
                  ),
                  onDeleteSlide: (DraftSlide slide)=> onDeleteSlide(
                    draftSlide: slide,
                    draftFlyer: _draftNotifier,
                    mounted: mounted,
                  ),
                ),

                /// 1 - TYPE - DESCRIPTION
                FlyerEditorPage1TypeDescription(
                  draft: draft,
                  canValidate: _canValidate,
                  canGoNext: _canGoFrom1To2(draft: draft),
                  onNextTap: _onNextTap,
                  onPreviousTap: _onPreviousTap,
                  onSelectFlyerType: (int index) => onSelectFlyerType(
                    context: context,
                    index: index,
                    draftNotifier: _draftNotifier,
                    mounted: mounted,
                  ),
                ),

                /// 2 - KEYWORDS
                FlyerEditorPage2KeywordsSpecs(
                  draft: draft,
                  onNextTap: _onNextTap,
                  onPreviousTap: _onPreviousTap,
                  canValidate: _canValidate,
                  canGoNext: _canGoFrom2to3(draft: draft),
                  onAddPhidsTap: () => onAddPhidsToFlyerTap(
                        mounted: mounted,
                        draftNotifier: _draftNotifier,
                      ),
                  onPhidLongTap: (String phid) => onFlyerPhidLongTap(
                        mounted: mounted,
                        phid: phid,
                        draftNotifier: _draftNotifier,
                      ),
                  onPhidTap: (String phid){
                    blog('phidSelectorBubble : onPhidTap : phid: $phid');
                    },
                  onAddSpecsToDraft: () => onAddSpecsToDraftTap(
                    mounted: mounted,
                    draft: _draftNotifier,
                  ),
                  onDeleteSpec: ({SpecModel? value, SpecModel? unit}){

                          blog('on Delete spec');
                          value?.blogSpec();
                          unit?.blogSpec();

                        },
                  onSpecTap: ({SpecModel? value, SpecModel? unit}){

                          blog('on spec Tap');
                          value?.blogSpec();
                          unit?.blogSpec();

                        },
                  onCurrentPriceChanged: (double value) => onChangeCurrentPrice(
                    draftNotifier: _draftNotifier,
                    mounted: mounted,
                    value: value,
                  ),
                  onOldPriceChanged: (double value) => onChangeOldPrice(
                    draftNotifier: _draftNotifier,
                    mounted: mounted,
                    value: value,
                  ),
                  onCurrencyChanged: (PriceModel price) => onChangeCurrency(
                    draftNotifier: _draftNotifier,
                    context: context,
                    mounted: mounted,
                    price: price
                  ),
                  priceIsGood: priceIsGood,
                  onSwitchPrice: (bool value) => onSwitchPrice(
                    draftNotifier: _draftNotifier,
                    mounted: mounted,
                    switchValue: value,
                  ),
                ),

                /// 3 - PDF
                FlyerEditorPage3PDF(
                  draft: draft,
                  onNextTap: _onNextTap,
                  onPreviousTap: _onPreviousTap,
                    canValidate: _canValidate,
                  canGoNext: _canGoFrom3To4(draft: draft),
                  onChangePDF: (PDFModel? pdf) => onChangeFlyerPDF(
                    draftNotifier: _draftNotifier,
                    pdfModel: pdf,
                    mounted: mounted,
                  ),
                  onDeletePDF: () => onRemoveFlyerPDF(
                    draftNotifier: _draftNotifier,
                    mounted: mounted,
                  ),
                ),

                /// 4 - ZONE
                FlyerEditorPage4Zone(
                  draft: draft,
                  canValidate: _canValidate,
                  onPreviousTap: _onPreviousTap,
                  onNextTap: _onNextTap,
                  canGoNext: _canGoFrom4To5(draft: draft),
                  onZoneChanged: (ZoneModel? zone) => onZoneChanged(
                    context: context,
                    draftNotifier: _draftNotifier,
                    zone: zone,
                    mounted: mounted,
                  ),
                ),

                /// 5 - SHOW AUTHOR - POSTER
                FlyerEditorPage5AuthorPoster(
                  draft: draft,
                  onSwitchFlyerShowsAuthor: (bool value) => onSwitchFlyerShowsAuthor(
                    value: value,
                    draftNotifier: _draftNotifier,
                    mounted: mounted,
                  ),
                  canValidate: _canValidate,
                  onNextTap: _onNextTap,
                  onPreviousTap: _onPreviousTap,
                  canGoNext: _canGoFrom5To6(draft: draft),
                  onPosterCreated: (PicModel? pic) => onPosterChanged(
                    poster: pic,
                    mounted: mounted,
                    draftNotifier: _draftNotifier,
                  ),
                ),

                /// 6 - CONFIRM
                EditorConfirmPage(
                  verse: _createConfirmVerse(),
                  onConfirmTap: _onConfirmTap,
                  canConfirm: _canConfirmEdits(),
                  modelHasChanged: _flyerHasChanged(),
                  onPreviousTap: _onPreviousTap,
                  previewWidget: Container(),
                  bulletPoints: const <Verse>[
                    Verse(
                      id: 'phid_publishing_flyer_makes_it_public',
                      translate: true,
                    ),
                  ],
                ),

              ],
            ),
          );

        },
      ),
    );
    // --------------------
  }
  // -----------------------------------------------------------------------------
}
