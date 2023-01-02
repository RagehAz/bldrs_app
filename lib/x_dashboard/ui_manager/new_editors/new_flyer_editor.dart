// ignore_for_file: avoid_positional_boolean_parameters
import 'dart:async';

import 'package:bldrs/a_models/d_zone/a_zoning/zone_model.dart';
import 'package:bldrs/a_models/d_zone/a_zoning/zone_stages.dart';
import 'package:bldrs/a_models/f_flyer/draft/draft_flyer_model.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/a_models/f_flyer/sub/flyer_typer.dart';
import 'package:bldrs/a_models/x_utilities/pdf_model.dart';
import 'package:bldrs/b_views/f_bz/e_flyer_maker_screen/flyer_editor_screen/x_flyer_maker_controllers.dart';
import 'package:bldrs/b_views/f_bz/e_flyer_maker_screen/z_components/flyer_poster_creator/flyer_poster_creator_bubble.dart';
import 'package:bldrs/b_views/f_bz/e_flyer_maker_screen/z_components/show_author_switcher/show_author_switch_bubble.dart';
import 'package:bldrs/b_views/f_bz/e_flyer_maker_screen/z_components/slides_shelf/a_slides_shelf_bubble.dart';
import 'package:bldrs/b_views/f_bz/e_flyer_maker_screen/z_components/specs_selector/b_phids_selector_bubble.dart';
import 'package:bldrs/b_views/g_zoning/x_zone_selection_ops.dart';
import 'package:bldrs/b_views/z_components/app_bar/progress_bar_swiper_model.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bubble_header.dart';
import 'package:bldrs/b_views/z_components/bubbles/b_variants/pdf_bubble/pdf_selection_bubble.dart';
import 'package:bldrs/b_views/z_components/bubbles/b_variants/phids_bubble/multiple_choice_bubble.dart';
import 'package:bldrs/b_views/z_components/bubbles/b_variants/text_field_bubble/text_field_bubble.dart';
import 'package:bldrs/b_views/z_components/bubbles/b_variants/zone_bubble/zone_selection_bubble.dart';
import 'package:bldrs/b_views/z_components/buttons/editor_confirm_button.dart';
import 'package:bldrs/b_views/z_components/dialogs/dialogz/dialogs.dart';
import 'package:bldrs/b_views/z_components/layouts/custom_layouts/floating_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/custom_layouts/pages_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/night_sky.dart';
import 'package:bldrs/b_views/z_components/sizing/horizon.dart';
import 'package:bldrs/f_helpers/drafters/formers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:flutter/material.dart';

class NewFlyerEditor extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const NewFlyerEditor({
    @required this.validateOnStartup,
    this.flyerToEdit,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final FlyerModel flyerToEdit;
  final bool validateOnStartup;
  /// --------------------------------------------------------------------------
  @override
  _NewFlyerEditorState createState() => _NewFlyerEditorState();
/// --------------------------------------------------------------------------
}

class _NewFlyerEditorState extends State<NewFlyerEditor> with AutomaticKeepAliveClientMixin{
  // -----------------------------------------------------------------------------
  final ValueNotifier<ProgressBarModel> _progressBarModel = ValueNotifier(null);
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
  Future<void> _triggerLoading({@required bool setTo}) async {
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
        // -------------------------------
        setNotifier(
          notifier: draftNotifier,
          mounted: mounted,
          value: await DraftFlyer.createDraft(
            context: context,
            oldFlyer: widget.flyerToEdit,
          ),
        );
        // -------------------------------
        await loadFlyerMakerLastSession(
          context: context,
          draft: draftNotifier,
          mounted: mounted,
        );
        // -----------------------------
        if (widget.validateOnStartup == true){
          _switchOnValidation();
          Formers.validateForm(draftNotifier.value.formKey);
        }
        // -----------------------------
        if (mounted == true){
          _addSessionListeners();
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

    super.dispose();
  }
  // -----------------------------------------------------------------------------
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
  Future<void> _onConfirmTap() async {

    _switchOnValidation();

    await onConfirmPublishFlyerButtonTap(
      context: context,
      oldFlyer: widget.flyerToEdit,
      draft: draftNotifier,
    );

  }
  // -----------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  void _stripsListener(){

    // -----------------
    /// STRIP 1 : SLIDES - HEADLINE - TYPE

    final bool _slidesAreValid = Formers.slidesValidator(
      context: context,
      draftFlyer: draftNotifier.value,
      canValidate: true,
    ) == null;
    final bool _headlineIsValid = Formers.flyerHeadlineValidator(
      context: context,
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
      context: context,
      draft: draftNotifier.value,
      canValidate: true,
    ) == null;
    final bool _descriptionIsValid = Formers.paragraphValidator(
      context: context,
      text: draftNotifier.value?.description,
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
      phids: draftNotifier.value?.keywordsIDs,
      context: context,
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
      context: context,
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
      context: context,
      zoneModel: draftNotifier.value?.zone,
      selectCountryAndCityOnly: true,
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

    _controlConfirmButton();

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
  void _controlConfirmButton(){

    if (_progressBarModel.value.stripsColors.contains(ProgressBarModel.errorStripColor) == true){
      setState(() {
        _confirmButtonModel = null;
      });
    }

    else {
      setState(() {
        _confirmButtonModel = ConfirmButtonModel(
          firstLine: const Verse(text: 'phid_confirm_upload_flyer', translate: true),
          onTap: _onConfirmTap,
          isWide: true,
        );
      });
    }

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
        text: widget.flyerToEdit == null ? 'phid_createFlyer' : 'phid_edit_flyer',
        translate: true,
      ),
      pyramidsAreOn: true,
      appBarType: AppBarType.basic,
      skyType: SkyType.black,
      loading: _loading,
      progressBarModel: _progressBarModel,
      onBack: () => Dialogs.goBackDialog(
        context: context,
        goBackOnConfirm: true,
      ),
      confirmButtonModel: _confirmButtonModel,
      child: ValueListenableBuilder(
        valueListenable: draftNotifier,
        builder: (_, DraftFlyer _draft, Widget child){

          return Form(
            key: _draft?.formKey,
            child: PagerBuilder(
              progressBarModel: _progressBarModel,
              pageBubbles: <Widget>[

                /// SLIDES - HEADLINE
                FloatingList(
                  columnChildren: <Widget>[

                    /// SHELVES
                    SlidesShelfBubble(
                      canValidate: _canValidate,
                      draftNotifier: draftNotifier,
                      bzModel: _draft?.bzModel,
                      focusNode: null, /// TASK : DO ME
                    ),

                    /// FLYER HEADLINE
                    TextFieldBubble(
                      key: const ValueKey<String>('flyer_headline_text_field'),
                      bubbleHeaderVM: const BubbleHeaderVM(
                        headlineVerse: Verse(
                          text: 'phid_flyer_headline',
                          translate: true,
                        ),
                        redDot: true,
                      ),
                      formKey: _draft?.formKey,
                      focusNode: _draft?.headlineNode,
                      appBarType: AppBarType.non,
                      isFormField: true,
                      counterIsOn: true,
                      maxLength: 50,
                      maxLines: 3,
                      keyboardTextInputType: TextInputType.multiline,
                      onTextChanged: (String text) => onUpdateFlyerHeadline(
                        draftNotifier: draftNotifier,
                        text: text,
                        mounted: mounted,
                      ),
                      textController: _draft?.headline,
                      validator: (String text) => Formers.flyerHeadlineValidator(
                        context: context,
                        headline: _draft?.headline?.text,
                        canValidate: _canValidate,
                      ),
                    ),

                    const Horizon(heightFactor: 0,),

                  ],
                ),

                /// TYPE - DESCRIPTION
                FloatingList(
                  columnChildren: <Widget>[

                    /// FLYER TYPE SELECTOR
                    MultipleChoiceBubble(
                      titleVerse: const Verse(
                        text: 'phid_flyer_type',
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
                        context: context,
                        draft: _draft,
                        canValidate: _canValidate,
                      ),
                    ),

                    /// FLYER DESCRIPTION
                    TextFieldBubble(
                      key: const ValueKey<String>('bz_scope_bubble'),
                      // pasteFunction: () async {
                      //   final String _text = await TextMod.paste();
                      //   _draftNotifier.value  = _draft.copyWith(
                      //     description: _text,
                      //   );
                      //   setState(() {
                      //
                      //   });
                      // },
                      bubbleHeaderVM: const BubbleHeaderVM(
                        headlineVerse: Verse(
                          text: 'phid_flyer_description',
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
                      initialText: _draft?.description,
                      validator: (String text) => Formers.paragraphValidator(
                        context: context,
                        text: _draft?.description,
                        canValidate: _canValidate,
                      ),
                      onTextChanged: (String text) => onUpdateFlyerDescription(
                        draftNotifier: draftNotifier,
                        text: text,
                        mounted: mounted,
                      ),
                    ),

                    const Horizon(heightFactor: 0,),

                  ],
                ),

                /// KEYWORDS
                FloatingList(
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

                  ],
                ),

                /// PDF
                FloatingList(
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

                  ],
                ),

                /// ZONE
                FloatingList(
                  columnChildren: <Widget>[

                    /// ZONE SELECTOR
                    ZoneSelectionBubble(
                      zoneViewingEvent: ViewingEvent.flyerEditor,
                      depth: ZoneDepth.city,
                      titleVerse: const Verse(
                        text: 'phid_flyer_target_city',
                        translate: true,
                      ),
                      bulletPoints: const <Verse>[
                        Verse(
                          pseudo: 'Select The city you would like this flyer to target',
                          text: 'phid_select_city_you_want_to_target',
                          translate: true,
                        ),
                        Verse(
                          pseudo: 'Each flyer can target only one city',
                          text: 'phid_each_flyer_target_one_city',
                          translate: true,
                        ),
                        Verse(
                          pseudo: 'Selecting district increases the probability of this flyer to gain more views in that district',
                          text: 'phid_selecting_district_focuses_search',
                          translate: true,
                        ),
                      ],
                      currentZone: _draft?.zone,
                      onZoneChanged: (ZoneModel zone) => onZoneChanged(
                        context: context,
                        draftNotifier: draftNotifier,
                        zone: zone,
                        mounted: mounted,
                      ),
                      validator: () => Formers.zoneValidator(
                        context: context,
                        zoneModel: _draft?.zone,
                        selectCountryAndCityOnly: true,
                        selectCountryIDOnly: false,
                        canValidate: _canValidate,
                      ),
                    ),

                  ],
                ),

                /// SHOW AUTHOR - POSTER
                FloatingList(
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

                    /// SHOW FLYER AUTHOR
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
