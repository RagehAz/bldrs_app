import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/chain/d_spec_model.dart';
import 'package:bldrs/b_views/i_chains/z_components/expander_button/c_phid_button.dart';
import 'package:bldrs/b_views/z_components/animators/widget_fader.dart';
import 'package:bldrs/b_views/z_components/bubble/bubble.dart';
import 'package:bldrs/b_views/z_components/bubble/bubble_bullet_points.dart';
import 'package:bldrs/b_views/z_components/bubble/bubble_header.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/info_button/expanded_info_page_parts/info_page_keywords.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:flutter/material.dart';

class ScopeSelectorBubble extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const ScopeSelectorBubble({
    @required this.bzTypes,
    @required this.headlineVerse,
    @required this.selectedSpecs,
    @required this.onAddScope,
    @required this.bulletPoints,
    this.addButtonVerse,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final List<BzType> bzTypes;
  final Verse headlineVerse;
  final List<SpecModel> selectedSpecs;
  final Function onAddScope;
  final List<Verse> bulletPoints;
  final Verse addButtonVerse;
  /// --------------------------------------------------------------------------
  static const double typeButtonSize = 50;
  /// --------------------------------------------------------------------------
  @override
  State<ScopeSelectorBubble> createState() => _ScopeSelectorBubbleState();
  /// --------------------------------------------------------------------------
}

class _ScopeSelectorBubbleState extends State<ScopeSelectorBubble> {
  // -----------------------------------------------------------------------------
  List<String> _phids = <String>[];
  bool _bzTypesExist = false;
  // --------------------
  final ValueNotifier<BzType> _selectedBzType = ValueNotifier(null);
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
      blogLoading(loading: _loading.value, callerName: 'ScopeSelectorBubble',);
    }
  }
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();

    _phids = SpecModel.getSpecsIDs(widget.selectedSpecs);
    _initializeLocalVariables();

  }
  // --------------------
  void _initializeLocalVariables(){
    _bzTypesExist = Mapper.checkCanLoopList(widget.bzTypes) == true;
    _selectedBzType.value = _bzTypesExist == true ? widget.bzTypes[0] : null;
  }
  // --------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit && mounted) {

      _triggerLoading().then((_) async {

        /// FUCK

        await _triggerLoading();
      });

      _isInit = false;
    }
    super.didChangeDependencies();
  }
  // --------------------
  @override
  void didUpdateWidget(covariant ScopeSelectorBubble oldWidget) {
    if (BzModel.checkBzTypesAreIdentical(widget.bzTypes, oldWidget.bzTypes) == false) {
      setState(() {
        _initializeLocalVariables();
      });
    }
    super.didUpdateWidget(oldWidget);
  }
  // --------------------
  @override
  void dispose() {
    _loading.dispose();
    _selectedBzType.dispose();
    super.dispose();
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _phidsZoneWidth = Bubble.clearWidth(context) - ScopeSelectorBubble.typeButtonSize - 10;

    return WidgetFader(
      fadeType: _bzTypesExist == true ? FadeType.stillAtMax : FadeType.stillAtMin,
      min: 0.35,
      absorbPointer: !_bzTypesExist,
      child: Bubble(
        headerViewModel: BubbleHeaderVM(
          headlineVerse: widget.headlineVerse,
        ),
        width: Bubble.bubbleWidth(context),
        columnChildren: <Widget>[

          /// BULLET POINTS
          BulletPoints(
            bulletPoints: widget.bulletPoints,
          ),

          /// SPECS SELECTION BOXES
          SizedBox(
            width: Bubble.clearWidth(context),
            // color: Colorz.bloodTest,
            child: ValueListenableBuilder(
              valueListenable: _selectedBzType,
              builder: (_, BzType selectedBzType, Widget child){

                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[

                    /// TYPE BUTTONS
                    SizedBox(
                      width: ScopeSelectorBubble.typeButtonSize,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[

                          /// FAKE EMPTY BOX IN CASE OF NULL AVAILABLE TYPES
                          if (_bzTypesExist == false)
                            const DreamBox(
                              width: ScopeSelectorBubble.typeButtonSize,
                              height: ScopeSelectorBubble.typeButtonSize,
                              color: Colorz.white20,
                              bubble: false,
                            ),

                          /// BZ TYPES BUTTONS BUILDER
                          if (_bzTypesExist == true)
                            ...List.generate(widget.bzTypes.length, (index){

                              final BzType _bzType = widget.bzTypes[index];
                              final bool _isSelected = selectedBzType == _bzType;

                              return DreamBox(
                                width: ScopeSelectorBubble.typeButtonSize,
                                height: ScopeSelectorBubble.typeButtonSize,
                                icon: _isSelected == true ?  BzModel.getBzTypeIconOn(_bzType)
                                    :
                                BzModel.getBzTypeIconOff(_bzType),
                                iconSizeFactor: 0.9,
                                onTap: (){
                                  _selectedBzType.value = _bzType;
                                },
                              );

                            }),

                        ],
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
                      headerViewModel: BubbleHeaderVM(
                        headlineVerse: Verse(
                          text: BzModel.getBzTypePhid(bzType: selectedBzType),
                          translate: true,
                        ),
                        headlineColor: Colorz.yellow200,
                      ),
                      columnChildren: <Widget>[

                        /// SELECTED PHIDS
                        if (Mapper.checkCanLoopList(_phids) == true)
                          PhidsViewer(
                            pageWidth: _phidsZoneWidth,
                            phids: _phids,
                          ),

                        /// ADD SPECS BUTTON
                        DreamBox(
                          height: PhidButton.getHeight(),
                          // width: Bubble.clearWidth(context),
                          verse: widget.addButtonVerse ?? Verse(
                            text: Mapper.checkCanLoopList(_phids) ?
                            'phid_edit_scope'
                                :
                            'phid_add_scope',
                            translate: true,
                          ),
                          bubble: false,
                          color: Colorz.white20,
                          verseScaleFactor: 1.5,
                          verseWeight: VerseWeight.thin,
                          icon: Iconz.plus,
                          iconSizeFactor: 0.4,
                          iconColor: Colorz.white20,
                          onTap: widget.onAddScope,
                        ),

                      ],
                    ),

                  ],
                );

              },
            ),
          ),

        ],
      ),
    );

  }
}
