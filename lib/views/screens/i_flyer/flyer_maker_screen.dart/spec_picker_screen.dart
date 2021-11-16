import 'package:bldrs/controllers/drafters/borderers.dart';
import 'package:bldrs/controllers/drafters/object_checkers.dart';
import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/router/navigators.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/models/kw/kw.dart';
import 'package:bldrs/models/kw/specs/data_creator.dart';
import 'package:bldrs/models/kw/specs/spec%20_list_model.dart';
import 'package:bldrs/models/kw/specs/spec_model.dart';
import 'package:bldrs/models/secondary_models/name_model.dart';
import 'package:bldrs/views/widgets/general/appbar/bldrs_app_bar.dart';
import 'package:bldrs/views/widgets/general/buttons/dream_box/dream_box.dart';
import 'package:bldrs/views/widgets/general/layouts/main_layout.dart';
import 'package:bldrs/views/widgets/general/textings/super_text_field.dart';
import 'package:bldrs/views/widgets/general/textings/super_verse.dart';
import 'package:bldrs/views/widgets/specific/specs/specs_selector_bubble.dart';
import 'package:bldrs/views/widgets/specific/specs/specs_text_field.dart';
import 'package:flutter/material.dart';

class SpecPickerScreen extends StatefulWidget {
  final SpecList specList;
  final List<Spec> allSelectedSpecs;

  const SpecPickerScreen({
    @required this.specList,
    @required this.allSelectedSpecs,
});

  static const double instructionBoxHeight = 50;

  @override
  State<SpecPickerScreen> createState() => _SpecPickerScreenState();
}

class _SpecPickerScreenState extends State<SpecPickerScreen> {

  List<Spec> _selectedSpecs = [];

  // -----------------------------------------------------------------------------
  @override
  void initState() {

    _selectedSpecs = widget.allSelectedSpecs;
    // Spec.getSpecsByListID(specsList: widget.allSelectedSpecs, specsListID: widget.specList.id)

    super.initState();
  }
// -----------------------------------------------------------------------------
  Future<void> _onSpecTap(BuildContext context, KW kw) async {

    // spec.printSpec();

    final Spec _spec = Spec.getSpecFromKW(
      specsListID: widget.specList.id,
      kw: kw,
    );

    final bool _alreadySelected = Spec.specsContainThisSpec(specs: _selectedSpecs, spec: _spec);
    final int _specIndex = _selectedSpecs.indexWhere((sp) => sp.value == _spec.value);

    // ----------------------------------------------------------
    /// A - ALREADY SELECTED SPEC
    if (_alreadySelected == true){

      /// A1 - CAN PICK MANY
      if (widget.specList.canPickMany == true){
        setState(() {
          _selectedSpecs.removeAt(_specIndex);
        });
      }

      /// A2 - CAN NOT PICK MANY
      else {
        setState(() {
          _selectedSpecs.removeAt(_specIndex);
        });
      }

    }
    // ----------------------------------------------------------
    /// B - NEW SELECTED SPEC
    else {

      /// B1 - WHEN CAN PICK MANY
      if (widget.specList.canPickMany == true){
        setState(() {
          _selectedSpecs.add(_spec);
        });
      }

      /// B2 - WHEN CAN NOT PICK MANY
      else {

          final int _specIndex = _selectedSpecs.indexWhere((spec) => spec.specsListID == widget.specList.id);

            /// C1 - WHEN NO SPEC OF THIS KIND IS SELECTED
            if (_specIndex == -1){
              setState(() {
                _selectedSpecs.add(_spec);
              });
            }

            /// C2 - WHEN A SPEC OF THIS KIND ALREADY EXISTS TO BE REPLACED
            else {
              setState(() {
                _selectedSpecs.removeAt(_specIndex);
                _selectedSpecs.add(_spec);
              });
            }

      }

    }
    // ----------------------------------------------------------

  }
// -----------------------------------------------------------------------------
  Future<void> _onBack() async {
    await Nav.goBack(context, argument: _selectedSpecs);
  }
// -----------------------------------------------------------------------------
  String _getInstructions(){
    String _instructions;

    if (widget.specList.specChain.sons.runtimeType == DataCreator){

      _instructions = 'Specify this';

    }

    else {

      _instructions = widget.specList.canPickMany == true ? 'You may pick multiple specifications from this list' : 'You can pick only one specification from this list';

    }

    return _instructions;
  }

  @override
  Widget build(BuildContext context) {

    final double _screenWidth = Scale.superScreenWidth(context);
    final double _screenHeight = Scale.superScreenHeightWithoutSafeArea(context);

    final double _listZoneHeight = _screenHeight - Ratioz.stratosphere - SpecPickerScreen.instructionBoxHeight;

    final String _instructions = _getInstructions();

    return MainLayout(
      appBarType: AppBarType.Basic,
      // appBarBackButton: true,
      sky: Sky.Black,
      pageTitle: Name.getNameByCurrentLingoFromNames(context, widget.specList.names),
      pyramids: Iconz.PyramidzYellow,
      onBack: _onBack,
      layoutWidget: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[

          const Stratosphere(),

          /// INSTRUCTIONS BOX HEIGHT
          Container(
            width: _screenWidth,
            height: SpecPickerScreen.instructionBoxHeight,
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: Ratioz.appBarMargin),
            child: SuperVerse(
              verse: _instructions,
              maxLines: 3,
              weight: VerseWeight.thin,
              italic: true,
              color: Colorz.white125,
            ),
            // color: Colorz.white10,
          ),

          /// SPEC SELECTOR
          if (widget.specList.specChain.sons.runtimeType != DataCreator)
            SpecSelectorBubble(
              bubbleHeight: _listZoneHeight,
              specList: widget.specList,
              selectedSpecs: _selectedSpecs,
              onSpecTap: (KW kw) => _onSpecTap(context, kw),
            ),

          ///
          if (widget.specList.specChain.sons.runtimeType == DataCreator)
            SpecsTextField(
            ),

        ],

      ),
    );
  }
}

/*



 */