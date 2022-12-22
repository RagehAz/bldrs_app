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
import 'package:bldrs/b_views/i_phid_picker/phids_picker_screen.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bubble_header.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bubbles_separator.dart';
import 'package:bldrs/b_views/z_components/bubbles/b_variants/pdf_bubble/pdf_selection_bubble.dart';
import 'package:bldrs/b_views/z_components/bubbles/b_variants/phids_bubble/multiple_choice_bubble.dart';
import 'package:bldrs/b_views/z_components/bubbles/b_variants/text_field_bubble/text_field_bubble.dart';
import 'package:bldrs/b_views/z_components/bubbles/b_variants/zone_bubble/zone_selection_bubble.dart';
import 'package:bldrs/b_views/z_components/buttons/editor_confirm_button.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/night_sky.dart';
import 'package:bldrs/f_helpers/drafters/formers.dart';
import 'package:bldrs/f_helpers/drafters/keyboarders.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/stringers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
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
  final ValueNotifier<DraftFlyer> _draftNotifier = ValueNotifier(null);
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
  }
  // --------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit) {

      _triggerLoading(setTo: true).then((_) async {
        // -------------------------------
        setNotifier(
            notifier: _draftNotifier,
            mounted: mounted,
            value: await DraftFlyer.createDraft(
              context: context,
              oldFlyer: widget.flyerToEdit,
            ),
        );
        // -------------------------------
        await loadFlyerMakerLastSession(
          context: context,
          draft: _draftNotifier,
          mounted: mounted,
        );
        // -----------------------------
          if (widget.validateOnStartup == true){
          _switchOnValidation();
          Formers.validateForm(_draftNotifier.value.formKey);
        }
        // -----------------------------
        if (mounted == true){
          _draftNotifier.addListener(() async {
            _switchOnValidation();
            await saveFlyerMakerSession(
              draft: _draftNotifier,
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
  @override
  void dispose(){

    _loading.dispose();
    _draftNotifier.value.dispose();
    _draftNotifier.dispose();

    super.dispose();
  }
  // -----------------------------------------------------------------------------
  Future<void> _onConfirmTap() async {

    _switchOnValidation();

    await onConfirmPublishFlyerButtonTap(
      context: context,
      oldFlyer: widget.flyerToEdit,
      draft: _draftNotifier,
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
      confirmButtonModel: ConfirmButtonModel(
        // isDeactivated: !_canPublish,
        firstLine: const Verse(
          text: 'phid_publish',
          translate: true,
        ),
        onTap: () => _onConfirmTap(),
      ),
      // onBack: () => onCancelFlyerCreation(context),
      appBarRowWidgets: [

        AppBarButton(
          verse: Verse.plain('Blog'),
          onTap: (){

            _draftNotifier.value.blogDraft(invoker: 'kos ommoko');

          },
        ),

      ],
      layoutWidget: ValueListenableBuilder(
          valueListenable: _draftNotifier,
          builder: (_, DraftFlyer _draft, Widget child){

            // final List<String> _bzTypeTranslation = BzTyper.getBzTypesPhids(
            //     context: context,
            //     bzTypes: _draft?.bzModel?.bzTypes
            // );
            // final List<FlyerType> _allowableTypes = FlyerTyper.concludePossibleFlyerTypesByBzTypes(
            //   bzTypes: _draft?.bzModel?.bzTypes
            // );
            // final List<Verse> _flyerTypesTranslation = Verse.createVerses(
            //   strings: FlyerTyper.translateFlyerTypes(
            //     context: context,
            //     flyerTypes: _allowableTypes,
            //   ),
            //   translate: false,
            // );

            return Form(
              key: _draft?.formKey,
              child: ListView(
                keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.only(top: Ratioz.stratosphere, bottom: Ratioz.horizon),
                children: <Widget>[

                  /// SHELVES
                  SlidesShelfBubble(
                    canValidate: _canValidate,
                    draftNotifier: _draftNotifier,
                    bzModel: _draft?.bzModel,
                    focusNode: null, /// TASK : DO ME
                  ),

                  /// SEPARATOR
                  const DotSeparator(),

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
                      draftNotifier: _draftNotifier,
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
                      draftNotifier: _draftNotifier,
                      text: text,
                      mounted: mounted,
                    ),
                  ),

                  /// SEPARATOR
                  const DotSeparator(),

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
                      draftNotifier: _draftNotifier,
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

                  /// PHIDS
                  PhidsSelectorBubble(
                    bzModel: _draft?.bzModel,
                    draft: _draft,
                    draftNotifier: _draftNotifier,
                    onPhidTap: (String phid){
                      blog('phidSelectorBubble : onPhidTap : phid: $phid');
                    },
                    onPhidLongTap: (String phid){

                      final List<String> _newPhids = Stringer.addOrRemoveStringToStrings(
                        strings: _draft.keywordsIDs,
                        string: phid,
                      );

                      setNotifier(
                        notifier: _draftNotifier,
                        mounted: mounted,
                        value: _draftNotifier.value.copyWith(
                          keywordsIDs: _newPhids,
                        ),
                      );


                    },
                    onAdd: () async {

                      Keyboard.closeKeyboard(context);

                      final List<String> _phids = await Nav.goToNewScreen(
                        context: context,
                        pageTransitionType: Nav.superHorizontalTransition(context),
                        screen: PhidsPickerScreen(
                          multipleSelectionMode: true,
                          selectedPhids: _draftNotifier.value.keywordsIDs,
                          chainsIDs: FlyerTyper.getChainsIDsPerViewingEvent(
                            context: context,
                            flyerType: _draftNotifier.value.flyerType,
                            event: ViewingEvent.flyerEditor,
                          ),
                        ),
                      );

                      if (Mapper.checkCanLoopList(_phids) == true){

                        setNotifier(
                          notifier: _draftNotifier,
                          mounted: mounted,
                          value: _draftNotifier.value.copyWith(
                            keywordsIDs: _phids,
                          ),
                        );

                      }

                    },
                  ),

                  /// SEPARATOR
                  const DotSeparator(),

                  /// PDF SELECTOR
                  PDFSelectionBubble(
                    flyerID: _draft?.id,
                    bzID: _draft?.bzID,
                    appBarType: AppBarType.non,
                    formKey: _draft?.formKey,
                    existingPDF: _draft?.pdfModel,
                    canValidate: _canValidate,
                    onChangePDF: (PDFModel pdf) => onChangeFlyerPDF(
                      draftNotifier: _draftNotifier,
                      pdfModel: pdf,
                      mounted: mounted,
                    ),
                    onDeletePDF: () => onRemoveFlyerPDF(
                      draftNotifier: _draftNotifier,
                      mounted: mounted,
                    ),
                  ),

                  /// SEPARATOR
                  const DotSeparator(),

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
                      draftNotifier: _draftNotifier,
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

                  /// SEPARATOR
                  const DotSeparator(),

                  /// SHOW FLYER AUTHOR
                  ShowAuthorSwitchBubble(
                    draft: _draft,
                    bzModel: _draft?.bzModel,
                    onSwitch: (bool value) => onSwitchFlyerShowsAuthor(
                      value: value,
                      draftNotifier: _draftNotifier,
                      mounted: mounted,
                    ),
                  ),

                  /// SEPARATOR
                  const DotSeparator(),

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
            );

          }),
    );
    // --------------------
  }
  // -----------------------------------------------------------------------------
}
