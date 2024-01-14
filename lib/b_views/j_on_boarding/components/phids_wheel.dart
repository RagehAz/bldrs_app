import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/helpers/classes/checks/tracers.dart';
import 'package:basics/helpers/classes/nums/numeric.dart';
import 'package:basics/helpers/classes/space/scale.dart';
import 'package:bldrs/z_components/buttons/general_buttons/bldrs_box.dart';
import 'package:bldrs/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/chain_protocols/provider/chains_provider.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/f_helpers/localization/localizer.dart';
import 'package:flutter/material.dart';
import 'package:wheel_chooser/wheel_chooser.dart';

class PhidsWheel extends StatelessWidget {
  // --------------------
  const PhidsWheel({
    required this.width,
    required this.phids,
    required this.height,
    required this.autoRotate,
    super.key
  });
  // --------------------
  final double width;
  final double height;
  final List<String> phids;
  final bool autoRotate;
  // --------------------
  @override
  Widget build(BuildContext context) {

    if (autoRotate == true){
      return AutoAnimatedPhidsWheel(
        width: width,
        height: height,
        phids: phids,
        // autoRotate: true,
      );
    }

    else {
      return NonAnimatedPhidsWheel(
        height: height,
        width: width,
        phids: phids,
      );
    }

  }
  // --------------------
}

class NonAnimatedPhidsWheel extends StatelessWidget {
  // --------------------
  const NonAnimatedPhidsWheel({
    required this.width,
    required this.phids,
    required this.height,
    super.key
  });
  // --------------------
  final double width;
  final double height;
  final List<String> phids;
  // --------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _phidWidth = width / 2;
    // --------------------
    return SizedBox(
      width: width,
      height: height,
      // color: Colorz.blue80,
      // alignment: Alignment.center,
      child: WheelChooser.custom(
        /// PHYSICS
        // ------
        /// WHEN INCREASED SHRINKS SPACING
        // squeeze: 1,
        /// 0.0005 IS FLAT - 0.01 IS MAXIMUM WHEEL CURVATURE
        perspective: 0.008, // is best value to avoid top and bottom flickering
        /// FLICKERS THE SCROLLING AND FUCKS EVERYTHING WHEN AT 0.1
        magnification: 0.001,
        // ------------------------
        /// BEHAVIOUR
        // ------
        /// WHEEL STARTING INDEX
        startPosition: Numeric.createRandomIndex(listLength: phids.length),
        /// ROTATION DIRECTION
        horizontal: true,
        /// LOOPS THE WHEEL LIST
        isInfinite: true,
        // ------------------------
        /// SIZING
        // ------
        listHeight: height,
        itemSize: _phidWidth,
        listWidth: width,
        // ------------------------
        /// SIZING
        // ------
        onValueChanged: (dynamic value) async {
          // final int _index = value;
          // final String _selectedIcon = standardLockIcons[_index].key!;
          // // blog('value changed to : $_selectedIcon');
          // onChanged(_selectedIcon);
        },
        children: <Widget>[

          ...List.generate(phids.length, (index){
            final String _phid = phids[index];
            final Verse? _verse = getVerse(_phid);
            final String? _icon = ChainsProvider.proGetPhidIcon(son: _phid);
            return BldrsBox(
              height: height * 0.7,
              width: _phidWidth,
              icon: _icon,
              verse: _verse,
              verseMaxLines: 2,
              verseWeight: VerseWeight.thin,
              verseCentered: _icon == null,
              verseScaleFactor: 0.6,
              color: Colorz.white20,
              bubble: false,
            );
          }),

        ],
      ),
    );
    // --------------------
  }
}

class AutoAnimatedPhidsWheel extends StatefulWidget {
  // --------------------------------------------------------------------------
  const AutoAnimatedPhidsWheel({
    required this.width,
    required this.phids,
    required this.height,
    this.autoRotate = true,
    super.key
  });
  // --------------------
  final double width;
  final double height;
  final List<String> phids;
  final bool autoRotate;
  // --------------------
  @override
  State<AutoAnimatedPhidsWheel> createState() => _AutoAnimatedPhidsWheelState();
  // --------------------------------------------------------------------------
}

class _AutoAnimatedPhidsWheelState extends State<AutoAnimatedPhidsWheel> {
  // -----------------------------------------------------------------------------
  FixedExtentScrollController? _controller;
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
    _controller = FixedExtentScrollController(
      // initialItem: 0,
    );
  }
  // --------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {

    if (_isInit && mounted) {
      _isInit = false; // good

      asyncInSync(() async {

         if (widget.autoRotate == true){
           await _animate();
         }

      });

    }
    super.didChangeDependencies();
  }
  // --------------------
  /*
  @override
  void didUpdateWidget(TheStatefulScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.thing != widget.thing) {
      unawaited(_doStuff());
    }
  }
   */
  // --------------------
  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
  // --------------------
  Future<void> _animate() async {

    const int _unitDuration = 800;

    await Future.delayed(const Duration(milliseconds: 1));

    await _controller?.animateToItem(
      widget.phids.length - 1,
      duration: Duration(milliseconds: widget.phids.length * _unitDuration),
      curve: Curves.easeInOut,
    );
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _phidWidth = widget.width / 2;
    // --------------------
    return SizedBox(
      width: widget.width,
      height: widget.height,
      // color: Colorz.blue80,
      // alignment: Alignment.center,
      child: WheelChooser.custom(
        controller: _controller,
        /// PHYSICS
        // ------
        /// WHEN INCREASED SHRINKS SPACING
        // squeeze: 1,
        /// 0.0005 IS FLAT - 0.01 IS MAXIMUM WHEEL CURVATURE
        // perspective: 0.01, // is best value to avoid top and bottom flickering
        /// FLICKERS THE SCROLLING AND FUCKS EVERYTHING WHEN AT 0.1
        magnification: 0.001,
        // ------------------------
        /// BEHAVIOUR
        // ------
        /// WHEEL STARTING INDEX
        startPosition: null, //Numeric.createRandomIndex(listLength: widget.phids.length),
        /// ROTATION DIRECTION
        horizontal: true,
        /// LOOPS THE WHEEL LIST
        isInfinite: true,
        // ------------------------
        /// SIZING
        // ------
        listHeight: widget.height,
        itemSize: _phidWidth,
        listWidth: widget.width,
        // ------------------------
        /// SIZING
        // ------
        onValueChanged: (dynamic value) async {
          // final int _index = value;
          // final String _selectedIcon = standardLockIcons[_index].key!;
          // // blog('value changed to : $_selectedIcon');
          // onChanged(_selectedIcon);
        },
        children: <Widget>[

          ...List.generate(widget.phids.length, (index){
            final String _phid = widget.phids[index];
            final Verse? _verse = getVerse(_phid);
            final String? _icon = ChainsProvider.proGetPhidIcon(son: _phid);
            return BldrsBox(
              height: widget.height * 0.7,
              width: _phidWidth,
              icon: _icon,
              verse: _verse,
              verseMaxLines: 2,
              verseWeight: VerseWeight.thin,
              verseCentered: _icon == null,
              verseScaleFactor: 0.6,
              color: Colorz.white20,
              bubble: false,
              onTap: () async {

                await _animate();

              },
            );
          }),

        ],
      ),
    );
    // --------------------
  }
}


class PhidsList extends StatelessWidget {
  // --------------------------------------------------------------------------
  const PhidsList({
    required this.width,
    required this.phids,
    required this.height,
    super.key
  });
  // --------------------
  final double width;
  final double height;
  final List<String> phids;
  // --------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    // final double _phidWidth = width / 2;
    // --------------------
    return SizedBox(
      width: width,
      height: height,
      // color: Colorz.blue80,
      // alignment: Alignment.center,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: phids.length,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        itemBuilder: (_, int index){

          final String _phid = phids[index];
          final Verse? _verse = getVerse(_phid);
          final String? _icon = ChainsProvider.proGetPhidIcon(son: _phid);

          return BldrsBox(
            height: height * 0.7,
            // width: _phidWidth,
            icon: _icon,
            verse: _verse,
            verseMaxLines: 2,
            verseWeight: VerseWeight.thin,
            verseCentered: _icon == null,
            verseScaleFactor: 0.6,
            color: Colorz.white20,
            bubble: false,
            margins: Scale.superInsets(
              context: context,
              appIsLTR: UiProvider.checkAppIsLeftToRight(),
              enRight: 5,
            ),
          );

        },

      ),
    );
    // --------------------
  }
  // --------------------------------------------------------------------------
}
