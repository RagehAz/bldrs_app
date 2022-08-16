import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';

class BubbleSwitcher extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const BubbleSwitcher({
    @required this.onSwitch,
    this.switchIsOn = false,
    this.width,
    this.height,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double width;
  final double height;
  final bool switchIsOn;
  final ValueChanged<bool> onSwitch;
  /// --------------------------------------------------------------------------
  @override
  _BubbleSwitcherState createState() => _BubbleSwitcherState();
  /// --------------------------------------------------------------------------
  static const double switcherWidth = 50;
  static const double switcherHeight = 35;
/// --------------------------------------------------------------------------
}

class _BubbleSwitcherState extends State<BubbleSwitcher> {
// ----------------------------------------------------
  ValueNotifier<bool> _isOn;
// ----------------------------------------------------
  @override
  void initState() {

    _isOn = ValueNotifier<bool>(widget.switchIsOn);

    super.initState();
  }
// ----------------------------------------------------
  /// TAMAM
  @override
  void dispose() {

    if (widget.switchIsOn == null){
      _isOn.dispose();
    }

    super.dispose();
  }
// ----------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return SizedBox(
      width: widget.width ?? BubbleSwitcher.switcherWidth,
      height: widget.height ?? BubbleSwitcher.switcherHeight,
      child: ValueListenableBuilder(
          valueListenable: _isOn,
          builder: (_, bool isOn, Widget child){

            return Switch(
              activeColor: Colorz.yellow255,
              activeTrackColor: Colorz.yellow80,
              focusColor: Colorz.darkBlue,
              inactiveThumbColor: Colorz.grey255,
              inactiveTrackColor: Colorz.grey80,
              value: isOn,
              onChanged: (bool val){

                _isOn.value = val;

                if (widget.onSwitch != null){
                  widget.onSwitch(val);
                }

              },
            );

          }
      ),
    );

  }
}
