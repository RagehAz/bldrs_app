import 'package:bldrs/a_models/c_chain/d_spec_model.dart';
import 'package:bldrs/a_models/f_flyer/sub/flyer_typer.dart';
import 'package:bldrs/b_views/i_chains/z_components/expander_button/f_phid_button.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/b_footer/info_button/expanded_info_page_parts/info_page_keywords.dart';
import 'package:bldrs/b_views/z_components/texting/bullet_points/bldrs_bullet_points.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bldrs_bubble_header_vm.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/texting/bldrs_text_field/bldrs_validator.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:filers/filers.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:bubbles/bubbles.dart';
import 'package:flutter/material.dart';
import 'package:mapper/mapper.dart';
import 'package:widget_fader/widget_fader.dart';

class ScopeSelectorBubble extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const ScopeSelectorBubble({
    @required this.flyerTypes,
    @required this.headlineVerse,
    @required this.selectedSpecs,
    @required this.onAddScope,
    @required this.bulletPoints,
    this.addButtonVerse,
    this.validator,
    this.autoValidate = true,
    this.focusNode,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final List<FlyerType> flyerTypes;
  final Verse headlineVerse;
  final List<SpecModel> selectedSpecs;
  final ValueChanged<FlyerType> onAddScope;
  final List<Verse> bulletPoints;
  final Verse addButtonVerse;
  final String Function() validator;
  final bool autoValidate;
  final FocusNode focusNode;
  /// --------------------------------------------------------------------------
  static const double typeButtonSize = 40;
  /// --------------------------------------------------------------------------
  @override
  State<ScopeSelectorBubble> createState() => _ScopeSelectorBubbleState();
  /// --------------------------------------------------------------------------
}

class _ScopeSelectorBubbleState extends State<ScopeSelectorBubble> {
  // -----------------------------------------------------------------------------
  List<String> _phids = <String>[];
  bool _flyerTypesExist = false;
  // -----------------------------------------------------------------------------
  /*
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
   */
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();

    _phids = SpecModel.getSpecsIDs(widget.selectedSpecs);
    _initializeLocalVariables();

  }
  // --------------------
  void _initializeLocalVariables(){
    _flyerTypesExist = Mapper.checkCanLoopList(widget.flyerTypes) == true;
  }
  // --------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit && mounted) {

      // _triggerLoading(setTo: true).then((_) async {
      //
      //
      //   await _triggerLoading(setTo: false);
      // });

      _isInit = false;
    }
    super.didChangeDependencies();
  }
  // --------------------
  @override
  void didUpdateWidget(covariant ScopeSelectorBubble oldWidget) {
    if (
    FlyerTyper.checkFlyerTypesAreIdentical(widget.flyerTypes, oldWidget.flyerTypes) == false
    ||
    SpecModel.checkSpecsListsAreIdentical(widget.selectedSpecs, oldWidget.selectedSpecs) == false
    ) {
      setState(() {
        _phids = SpecModel.getSpecsIDs(widget.selectedSpecs);
        _initializeLocalVariables();
      });
    }
    super.didUpdateWidget(oldWidget);
  }
  // --------------------
  @override
  void dispose() {
    // _loading.dispose();
    super.dispose();
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _phidsZoneWidth = Bubble.clearWidth(context: context) - ScopeSelectorBubble.typeButtonSize - 10;

    return WidgetFader(
      fadeType: _flyerTypesExist == true ? FadeType.stillAtMax : FadeType.stillAtMin,
      min: 0.35,
      ignorePointer: !_flyerTypesExist,
      child: Bubble(
        bubbleHeaderVM: BldrsBubbleHeaderVM.bake(
          context: context,
          headlineVerse: widget.headlineVerse,
        ),
        width: Bubble.bubbleWidth(context: context),
        columnChildren: <Widget>[

          /// BULLET POINTS
          BldrsBulletPoints(
            bulletPoints: widget.bulletPoints,
          ),

          /// SPECS SELECTION BOXES
          SizedBox(
            width: Bubble.clearWidth(context: context),
            // color: Colorz.bloodTest,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[

                /// BZ TYPES BUTTONS BUILDER
                if (_flyerTypesExist == true)
                  ...List.generate(widget.flyerTypes.length, (index){

                    final FlyerType _flyerType = widget.flyerTypes[index];
                    final List<String> _flyerTypePhids = SpecModel.getPhidsFromSpecsFilteredByFlyerType(
                      specs: widget.selectedSpecs,
                      flyerType: _flyerType,
                    );

                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[

                        /// BZ TYPE BUTTON
                        BldrsBox(
                          width: ScopeSelectorBubble.typeButtonSize,
                          height: ScopeSelectorBubble.typeButtonSize,
                          icon: FlyerTyper.flyerTypeIcon(
                            flyerType: _flyerType,
                            isOn: false,
                          ),
                        ),

                        /// SPACER
                        const SizedBox(
                          width: 10,
                          height: 10,
                        ),

                        /// PHIDS
                        Bubble(
                          width: _phidsZoneWidth,
                          bubbleHeaderVM: BldrsBubbleHeaderVM.bake(
                            context: context,
                            headlineVerse: Verse(
                              id: FlyerTyper.getFlyerTypePhid(flyerType: _flyerType),
                              translate: true,
                            ),
                            headlineColor: Colorz.yellow200,
                          ),
                          columnChildren: <Widget>[

                            /// SELECTED PHIDS
                            if (Mapper.checkCanLoopList(_phids) == true)
                              PhidsViewer(
                                pageWidth: _phidsZoneWidth,
                                phids: _flyerTypePhids,
                                onPhidTap: (String phid){
                                  blog('scopeSelectorBubble : onPhidTap : phid: $phid');
                                },
                                onPhidLongTap: (String phid){
                                  blog('scopeSelectorBubble : onPhidLongTap : phid: $phid');
                                },
                              ),

                            /// ADD SPECS BUTTON
                            BldrsBox(
                              height: PhidButton.getHeight(),
                              // width: Bubble.clearWidth(context),
                              verse: widget.addButtonVerse ?? Verse(
                                id: Mapper.checkCanLoopList(_phids) ?
                                'phid_add_bz_scope' // phid_edit_scope
                                    :
                                'phid_add_bz_scope',
                                translate: true,
                              ),
                              bubble: false,
                              color: Colorz.white20,
                              verseScaleFactor: 1.5,
                              verseWeight: VerseWeight.thin,
                              icon: Iconz.plus,
                              iconSizeFactor: 0.4,
                              iconColor: Colorz.white20,
                              onTap: () => widget.onAddScope(_flyerType),
                            ),

                          ],
                        ),

                      ],
                    );

                  }),

                // /// TYPE BUTTONS
                // SizedBox(
                //   width: ScopeSelectorBubble.typeButtonSize,
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: <Widget>[
                //
                //       /// FAKE EMPTY BOX IN CASE OF NULL AVAILABLE TYPES
                //       if (_bzTypesExist == false)
                //         const DreamBox(
                //           width: ScopeSelectorBubble.typeButtonSize,
                //           height: ScopeSelectorBubble.typeButtonSize,
                //           color: Colorz.white20,
                //           bubble: false,
                //         ),
                //
                //       /// BZ TYPES BUTTONS BUILDER
                //       if (_bzTypesExist == true)
                //         ...List.generate(widget.bzTypes.length, (index){
                //
                //           final BzType _bzType = widget.bzTypes[index];
                //           final bool _isSelected = selectedBzType == _bzType;
                //
                //           return DreamBox(
                //             width: ScopeSelectorBubble.typeButtonSize,
                //             height: ScopeSelectorBubble.typeButtonSize,
                //             icon: _isSelected == true ?  BzModel.getBzTypeIconOn(_bzType)
                //                 :
                //             BzModel.getBzTypeIconOff(_bzType),
                //             onTap: (){
                //               _selectedBzType.value  = _bzType;
                //             },
                //           );
                //
                //         }),
                //
                //     ],
                //   ),
                // ),

              ],
            ),
          ),

          /// VALIDATOR
          if (widget.validator != null)
            BldrsValidator(
              width: Bubble.clearWidth(context: context) - 20,
              validator: widget.validator,
              autoValidate: widget.autoValidate,
              focusNode: widget.focusNode,
            ),

        ],
      ),
    );

  }
}
