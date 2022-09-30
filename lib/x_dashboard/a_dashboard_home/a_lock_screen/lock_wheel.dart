import 'package:bldrs/a_models/secondary_models/map_model.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/f_helpers/drafters/borderers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:flutter/material.dart';
import 'package:wheel_chooser/wheel_chooser.dart';

class LockWheel extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const LockWheel({
    @required this.onChanged,
    this.size = 80,
    this.isIcon = true,
    this.unitColor = Colorz.black255,
    this.startingIndex = 0,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double size;
  final bool isIcon;
  final Color unitColor;
  final ValueChanged<String> onChanged;
  final int startingIndex;
  /// --------------------------------------------------------------------------
  static const List<MapModel> standardLockIcons = <MapModel>[
  /// key is Icon : value is size factor
  MapModel(key: Iconz.cleopatra, value: 0.6),
  MapModel(key: Iconz.pyramidSingleYellow, value: 0.6),
  MapModel(key: Iconz.save, value: 0.6),
  MapModel(key: Iconz.bz, value: 0.6),
  MapModel(key: Iconz.contAfrica, value: 0.6),
  MapModel(key: Iconz.sexyStar, value: 0.6),
  MapModel(key: Iconz.dvRageh, value: 1),
  MapModel(key: Iconz.sphinx, value: 0.6),
  MapModel(key: Iconz.viewsIcon, value: 0.6),
  ];
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double unitWidth = size;
    final double unitHeight = size;

    final double _horizontalPadding = unitWidth * 0.08;

    final double boxHeight = unitWidth * 3.5;
    final double _boxWidth = unitWidth + (_horizontalPadding * 2);

    return Container(
      width: _boxWidth,
      height: boxHeight,
      decoration: BoxDecoration(
        color: Colorz.white10,
        borderRadius: Borderers.cornerAll(context, unitWidth * 0.3)
      ),

      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[

          /// SELECTED UNIT FOOTPRINT
          DreamBox(
            height: _boxWidth - _horizontalPadding,
            width: _boxWidth - _horizontalPadding,
            bubble: false,
            color: Colorz.yellow125,
          ),

          /// UNITS WHEEL
          WheelChooser.custom(
            // ------------------------

            /// PHYSICS

            // ------
            /// WHEN INCREASED SHRINKS SPACING
            squeeze: 0.95,
            /// 0.0005 IS FLAT - 0.01 IS MAXIMUM WHEEL CURVATURE
            // perspective: 0.01, // is best value to avoid top and bottom flickering
            /// FLICKERS THE SCROLLING AND FUCKS EVERYTHING WHEN AT 0.1
            magnification: 0.001,
            // ------------------------

            /// BEHAVIOUR

            // ------
            /// WHEEL STARTING INDEX
            startPosition: startingIndex,
            /// ROTATION DIRECTION
            // horizontal: false,
            /// LOOPS THE WHEEL LIST
            isInfinite: true,
            // ------------------------

            /// SIZING

            // ------
            listHeight: boxHeight,
            itemSize: unitHeight,
            listWidth: unitWidth,
            // ------------------------

            /// SIZING

            // ------
            onValueChanged: (dynamic value){

              final int _index = value;
              final String _selectedIcon = standardLockIcons[_index].key;
              // blog('value changed to : $_selectedIcon');
              onChanged(_selectedIcon);
            },
            children: <Widget>[

              ...List.generate(standardLockIcons.length, (index){

                final MapModel _mapModel = standardLockIcons[index];

                return DreamBox(
                  height: unitHeight,
                  width: unitWidth,
                  icon: _mapModel.key,
                  iconSizeFactor: _mapModel.value.toDouble(),
                  color: unitColor,
                );

              }),

            ],
          ),

        ],
      ),
    );
  }
}
