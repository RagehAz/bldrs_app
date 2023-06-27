// ignore_for_file: avoid_positional_boolean_parameters
import 'dart:async';

import 'package:basics/helpers/classes/checks/tracers.dart';
import 'package:basics/helpers/classes/strings/text_clip_board.dart';
import 'package:bldrs/a_models/c_chain/d_spec_model.dart';
import 'package:bldrs/a_models/d_zone/a_zoning/zone_model.dart';
import 'package:bldrs/a_models/d_zone/a_zoning/staging_model.dart';
import 'package:bldrs/a_models/f_flyer/draft/draft_flyer_model.dart';
import 'package:bldrs/a_models/f_flyer/sub/flyer_typer.dart';
import 'package:bldrs/a_models/x_utilities/pdf_model.dart';
import 'package:bldrs/b_views/f_bz/e_flyer_maker_screen/flyer_editor_screen/x_flyer_maker_controllers.dart';
import 'package:bldrs/b_views/f_bz/e_flyer_maker_screen/z_components/flyer_poster_creator/flyer_poster_creator_bubble.dart';
import 'package:bldrs/b_views/f_bz/e_flyer_maker_screen/z_components/show_author_switcher/show_author_switch_bubble.dart';
import 'package:bldrs/b_views/f_bz/e_flyer_maker_screen/z_components/slides_shelf/a_slides_shelf_bubble.dart';
import 'package:bldrs/b_views/f_bz/e_flyer_maker_screen/z_components/specs_selector/a_specs_selector_bubble.dart';
import 'package:bldrs/b_views/f_bz/e_flyer_maker_screen/z_components/specs_selector/b_phids_selector_bubble.dart';
import 'package:bldrs/b_views/g_zoning/x_zone_selection_ops.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bldrs_bubble_header_vm.dart';
import 'package:bldrs/b_views/z_components/bubbles/b_variants/pdf_bubble/pdf_selection_bubble.dart';
import 'package:bldrs/b_views/z_components/bubbles/b_variants/phids_bubble/multiple_choice_bubble.dart';
import 'package:bldrs/b_views/z_components/bubbles/b_variants/text_field_bubble/text_field_bubble.dart';
import 'package:bldrs/b_views/z_components/bubbles/b_variants/zone_bubble/zone_selection_bubble.dart';
import 'package:bldrs/b_views/z_components/buttons/editor_confirm_button.dart';
import 'package:bldrs/b_views/z_components/buttons/next_button.dart';
import 'package:bldrs/b_views/z_components/dialogs/dialogz/dialogs.dart';
import 'package:bldrs/b_views/z_components/layouts/custom_layouts/bldrs_floating_list.dart';
import 'package:bldrs/b_views/z_components/layouts/custom_layouts/pages_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/sizing/horizon.dart';
import 'package:bldrs/b_views/z_components/static_progress_bar/progress_bar_model.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/f_helpers/drafters/formers.dart';
import 'package:bldrs/f_helpers/theme/standards.dart';
import 'package:basics/helpers/classes/files/filers.dart';
import 'package:flutter/material.dart';
import 'package:basics/bldrs_theme/night_sky/night_sky.dart';
import 'package:basics/helpers/classes/strings/stringer.dart';

class NewFlyerEditorScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const NewFlyerEditorScreen({
    required this.draftFlyer,
    required this.onConfirm,
    super.key
  });
  /// -----------------------
  final DraftFlyer draftFlyer;
  final Function(DraftFlyer draft) onConfirm;
  /// -----------------------
  @override
  State<NewFlyerEditorScreen> createState() => _NewFlyerEditorScreenState();
  /// --------------------------------------------------------------------------
}

class _NewFlyerEditorScreenState extends State<NewFlyerEditorScreen> with AutomaticKeepAliveClientMixin{
  // -----------------------------------------------------------------------------
  final ValueNotifier<ProgressBarModel> _progressBarModel = ValueNotifier(null);
  final PageController _pageController = PageController();
  ConfirmButtonModel _confirmButtonModel;
  // -----------------------------------------------------------------------------
  /// to keep out of screen objects alive
  @override
  bool get wantKeepAlive => true;
  // -----------------------------------------------------------------------------
  final ValueNotifier<DraftFlyer> draftNotifier = ValueNotifier(null);
  // --------------------
  bool _canValidate = false;
  void _switchOnValidation(){
    blog('switching on validation');
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
  final ValueNotifier<bool> _loading = ValueNotifier(false);
  // --------------------
  Future<void> _triggerLoading({required bool setTo}) async {
    setNotifier(
      notifier: _loading,
      mounted: mounted,
      value: setTo,
    );
  }
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();

    setNotifier(
      notifier: _progressBarModel,
      mounted: mounted,
      value: ProgressBarModel.initialModel(
        numberOfStrips: 6,
      ),
    );

  }
  // --------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit) {

      _triggerLoading(setTo: true).then((_) async {
        // -----------------------------
        if (mounted == true){
          _addSessionListeners();
        }
        // -------------------------------
        setNotifier(
          notifier: draftNotifier,
          mounted: mounted,
          value: widget.draftFlyer,
        );
        // -------------------------------
        await loadFlyerMakerLastSession(
          context: context,
          draft: draftNotifier,
          mounted: mounted,
        );
        // -----------------------------
        if (draftNotifier.value.firstTimer == false){
          _switchOnValidation();
          Formers.validateForm(draftNotifier.value.formKey);
        }
        // -------------------------------
        await _triggerLoading(setTo: false);
      });

    }
    _isInit = false;
    super.didChangeDependencies();
  }
  // --------------------
  @override
  void dispose(){

    _loading.dispose();
    draftNotifier.value.dispose();
    draftNotifier.dispose();
    _progressBarModel.dispose();
    _pageController.dispose();

    super.dispose();
  }
  // -----------------------------------------------------------------------------

  /// SESSION LISTENERS

  // --------------------
  /// TESTED : WORKS PERFECT
  void _addSessionListeners(){

    draftNotifier.addListener(() async {

      _stripsListener();

      _switchOnValidation();

      await saveFlyerMakerSession(
        draft: draftNotifier,
      );

    });

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  void _stripsListener(){

    // -----------------
    /// STRIP 1 : SLIDES - HEADLINE - TYPE

    final bool _slidesAreValid = Formers.slidesValidator(
      draftFlyer: draftNotifier.value,
      canValidate: true,
    ) == null;
    final bool _headlineIsValid = Formers.flyerHeadlineValidator(
      headline: draftNotifier.value?.headline?.text,
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
      draft: draftNotifier.value,
      canValidate: true,
    ) == null;
    final bool _descriptionIsValid = Formers.paragraphValidator(
      text: draftNotifier.value?.description?.text,
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
      phids: draftNotifier.value?.phids,
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
      pdfModel: draftNotifier.value.pdfModel,
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
      zoneModel: draftNotifier.value?.zone,
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

    _updateConfirmButton();

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
  // --------------------
  /// TESTED : WORKS PERFECT
  void _updateConfirmButton(){

    if (_progressBarModel.value.stripsColors.contains(ProgressBarModel.errorStripColor) == true){
      setState(() {
        _confirmButtonModel = null;
      });
    }

    else {
      setState(() {
        _confirmButtonModel = ConfirmButtonModel(
          firstLine: const Verse(id: 'phid_confirm_upload_flyer', translate: true),
          onTap: _onConfirmTap,
          isWide: true,
        );
      });
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _onConfirmTap() async {

    _switchOnValidation();

    widget.onConfirm(draftNotifier.value);

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _onNextTap() async {

    await NextButton.onNextTap(
      context: context,
      mounted: mounted,
      pageController: _pageController,
      progressBarModel: _progressBarModel,
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
      title: Verse(
        id: widget.draftFlyer.firstTimer == true ? 'phid_createFlyer' : 'phid_edit_flyer',
        translate: true,
      ),
      pyramidsAreOn: true,
      appBarType: AppBarType.basic,
      skyType: SkyType.black,
      loading: _loading,
      progressBarModel: _progressBarModel,
      onBack: () => Dialogs.goBackDialog(
        goBackOnConfirm: true,
      ),
      confirmButtonModel: _confirmButtonModel,
      child: ValueListenableBuilder(
        valueListenable: draftNotifier,
        builder: (_, DraftFlyer _draft, Widget? child){

          return Form(
            key: _draft?.formKey,
            child: PagerBuilder(
              progressBarModel: _progressBarModel,
              pageController: _pageController,
              pageBubbles: <Widget>[

                /// SLIDES - HEADLINE
                BldrsFloatingList(
                  columnChildren: <Widget>[

                    /// SHELVES
                    SlidesShelfBubble(
                      canValidate: _canValidate,
                      draftNotifier: draftNotifier,
                      bzModel: _draft?.bzModel,
                      focusNode: null, /// TASK : DO ME
                    ),

                    /// FLYER HEADLINE
                    BldrsTextFieldBubble(
                      key: const ValueKey<String>('flyer_headline_text_field'),
                      bubbleHeaderVM: BldrsBubbleHeaderVM.bake(
                        context: context,
                        headlineVerse: const Verse(
                          id: 'phid_flyer_headline',
                          translate: true,
                        ),
                        redDot: true,
                      ),
                      formKey: _draft?.formKey,
                      focusNode: _draft?.headlineNode,
                      appBarType: AppBarType.non,
                      isFormField: true,
                      counterIsOn: true,
                      maxLength: Standards.flyerHeadlineMaxLength,
                      maxLines: 5,
                      keyboardTextInputType: TextInputType.multiline,
                      onTextChanged: (String text) => onUpdateFlyerHeadline(
                        draftNotifier: draftNotifier,
                        text: text,
                        mounted: mounted,
                      ),
                      textController: _draft?.headline,
                      validator: (String text) => Formers.flyerHeadlineValidator(
                        headline: _draft?.headline?.text,
                        canValidate: _canValidate,
                      ),
                    ),

                    /// NEXT
                    NextButton(
                      onTap: _onNextTap,
                      canGoNext: Formers.slidesValidator(
                        draftFlyer: draftNotifier.value,
                        canValidate: true,
                      ) == null &&
                      Formers.flyerHeadlineValidator(
                        headline: _draft?.headline?.text,
                        canValidate: _canValidate,
                      ) == null,
                    ),

                    const Horizon(heightFactor: 0,),

                  ],
                ),

                /// TYPE - DESCRIPTION
                BldrsFloatingList(
                  columnChildren: <Widget>[

                    /// FLYER TYPE SELECTOR
                    MultipleChoiceBubble(
                      titleVerse: const Verse(
                        id: 'phid_flyer_type',
                        translate: true,
                      ),
                      // bulletPoints: <Verse>[

                      // Verse(
                      //   text: '#!# Business accounts of types '
                      //       '${_bzTypeTranslation.toString()} can publish '
                      //       '${_flyerTypesTranslation.toString()} flyers.',
                      //   translate: true,
                      //   variables: [_bzTypeTranslation.toString(), _flyerTypesTranslation.toString()],
                      // ),
                      //
                      // const Verse(
                      //   text: '#!# Each Flyer Should have one flyer type',
                      //   translate: true,
                      // ),

                      // ],
                      buttonsVerses: Verse.createVerses(
                        strings: FlyerTyper.translateFlyerTypes(
                          context: context,
                          flyerTypes: FlyerTyper.flyerTypesList,
                          pluralTranslation: false,
                        ),
                        translate: false,
                      ),
                      selectedButtonsPhids: FlyerTyper.translateFlyerTypes(
                        context: context,
                        flyerTypes: <FlyerType>[_draft?.flyerType],
                        pluralTranslation: false,
                      ),
                      onButtonTap: (int index) => onSelectFlyerType(
                        context: context,
                        index: index,
                        draftNotifier: draftNotifier,
                        mounted: mounted,
                      ),
                      inactiveButtons: <Verse>[
                        ...Verse.createVerses(
                          strings: FlyerTyper.translateFlyerTypes(
                            context: context,
                            flyerTypes: FlyerTyper.concludeInactiveFlyerTypesByBzModel(
                              bzModel: _draft?.bzModel,
                            ),
                            pluralTranslation: false,
                          ),
                          translate: false,
                        ),
                      ],

                      validator: () => Formers.flyerTypeValidator(
                        draft: _draft,
                        canValidate: _canValidate,
                      ),
                    ),

                    /// FLYER DESCRIPTION
                    BldrsTextFieldBubble(
                      key: const ValueKey<String>('bz_scope_bubble'),
                      // pasteFunction: () async {
                      //   final String _text = await TextMod.paste();
                      //   _draftNotifier.value  = _draft?.copyWith(
                      //     description: _text,
                      //   );
                      //   setState(() {
                      //
                      //   });
                      // },
                      bubbleHeaderVM: BldrsBubbleHeaderVM.bake(
                        context: context,
                        headlineVerse: const Verse(
                          id: 'phid_flyer_description',
                          translate: true,
                        ),
                      ),
                      formKey: _draft?.formKey,
                      focusNode: _draft?.descriptionNode,
                      appBarType: AppBarType.non,
                      isFormField: true,
                      counterIsOn: true,
                      maxLength: 5000,
                      maxLines: 7,
                      keyboardTextInputType: TextInputType.multiline,
                      textController: _draft?.description,
                      validator: (String text) => Formers.paragraphValidator(
                        text: _draft?.description?.text,
                        canValidate: _canValidate,
                      ),
                      pasteFunction: () async {

                        final String _text = await TextClipBoard.paste();

                        blog('pasteFunction _text: $_text');

                        _draft?.description?.text = _text;

                        // onUpdateFlyerDescription(
                        //   draftNotifier: draftNotifier,
                        //   text: _text,
                        //   mounted: mounted,
                        // );
                        //
                        // setState(() {
                        //
                        // });

                      },

                      // onTextChanged: (String text) => onUpdateFlyerDescription(
                      //   draftNotifier: draftNotifier,
                      //   text: text,
                      //   mounted: mounted,
                      // ),
                    ),

                    /// NEXT
                    NextButton(
                      onTap: _onNextTap,
                      canGoNext: Formers.flyerTypeValidator(
                        draft: _draft,
                        canValidate: true,
                      ) == null &&
                      Formers.paragraphValidator(
                        text: _draft?.description?.text,
                        canValidate: _canValidate,
                      ) == null,
                    ),

                    const Horizon(heightFactor: 0,),

                  ],
                ),

                /// KEYWORDS
                BldrsFloatingList(
                  columnChildren: <Widget>[

                    /// PHIDS
                    PhidsSelectorBubble(
                      bzModel: _draft?.bzModel,
                      draft: _draft,
                      draftNotifier: draftNotifier,
                      onPhidTap: (String phid){
                        blog('phidSelectorBubble : onPhidTap : phid: $phid');
                      },
                      onPhidLongTap: (String phid) => onFlyerPhidLongTap(
                        mounted: mounted,
                        phid: phid,
                        draftNotifier: draftNotifier,
                      ),
                      onAdd: () => onFlyerPhidTap(
                        context: context,
                        mounted: mounted,
                        draftNotifier: draftNotifier,
                      ),
                      canValidate: _canValidate,
                    ),

                    /// SPECS
                    SpecsSelectorBubble(
                        draft: _draft,
                        draftNotifier: draftNotifier,
                        bzModel: _draft?.bzModel,
                        onSpecTap: ({SpecModel value, SpecModel unit}){

                          blog('on spec Tap');
                          value.blogSpec();
                          unit.blogSpec();

                        },
                        onDeleteSpec: ({SpecModel value, SpecModel unit}){

                          blog('on Delete spec');
                          value.blogSpec();
                          unit.blogSpec();

                        },
                        onAddSpecsToDraft: () => onAddSpecsToDraftTap(
                          context: context,
                          mounted: mounted,
                          draft: draftNotifier,
                        ),
                    ),

                    /// NEXT
                    NextButton(
                      onTap: _onNextTap,
                      canGoNext:  Formers.flyerPhidsValidator(
                        phids: _draft?.phids,
                        canValidate: true,
                      ) == null,
                    ),

                  ],
                ),

                /// PDF
                BldrsFloatingList(
                  columnChildren: <Widget>[

                    /// PDF SELECTOR
                    PDFSelectionBubble(
                      flyerID: _draft?.id,
                      bzID: _draft?.bzID,
                      appBarType: AppBarType.non,
                      formKey: _draft?.formKey,
                      existingPDF: _draft?.pdfModel,
                      canValidate: _canValidate,
                      onChangePDF: (PDFModel pdf) => onChangeFlyerPDF(
                        draftNotifier: draftNotifier,
                        pdfModel: pdf,
                        mounted: mounted,
                      ),
                      onDeletePDF: () => onRemoveFlyerPDF(
                        draftNotifier: draftNotifier,
                        mounted: mounted,
                      ),
                    ),

                    /// NEXT
                    NextButton(
                      onTap: _onNextTap,
                      canGoNext: Formers.pdfValidator(
                        canValidate: true,
                        pdfModel: _draft?.pdfModel,
                      ) == null,
                    ),

                  ],
                ),

                /// ZONE
                BldrsFloatingList(
                  columnChildren: <Widget>[

                    /// ZONE SELECTOR
                    ZoneSelectionBubble(
                      zoneViewingEvent: ViewingEvent.flyerEditor,
                      depth: ZoneDepth.city,
                      titleVerse: const Verse(
                        id: 'phid_flyer_target_city',
                        translate: true,
                      ),
                      bulletPoints: const <Verse>[
                        Verse(
                          id: 'phid_select_city_you_want_to_target',
                          translate: true,
                        ),
                        Verse(
                          id: 'phid_each_flyer_target_one_city',
                          translate: true,
                        ),
                      ],
                      currentZone: _draft?.zone,
                      viewerCountryID: _draft?.bzModel?.zone?.countryID,
                      onZoneChanged: (ZoneModel zone) => onZoneChanged(
                        context: context,
                        draftNotifier: draftNotifier,
                        zone: zone,
                        mounted: mounted,
                      ),
                      validator: () => Formers.zoneValidator(
                        zoneModel: _draft?.zone,
                        selectCountryIDOnly: false,
                        canValidate: _canValidate,
                      ),
                    ),

                    /// NEXT
                    NextButton(
                      onTap: _onNextTap,
                      canGoNext: Formers.zoneValidator(
                        zoneModel: _draft?.zone,
                        selectCountryIDOnly: false,
                        canValidate: true,
                      ) == null,
                    ),

                  ],
                ),

                /// SHOW AUTHOR - POSTER
                BldrsFloatingList(
                  columnChildren: <Widget>[

                    /// SHOW FLYER AUTHOR
                    ShowAuthorSwitchBubble(
                      draft: _draft,
                      bzModel: _draft?.bzModel,
                      onSwitch: (bool value) => onSwitchFlyerShowsAuthor(
                        value: value,
                        draftNotifier: draftNotifier,
                        mounted: mounted,
                      ),
                    ),

                    /// FLYER POSTER
                    FlyerPosterCreatorBubble(
                      draft: _draft,
                      bzModel: _draft?.bzModel,
                      onSwitch: (bool value){
                        blog('value of poster blah is : $value');
                      },
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
