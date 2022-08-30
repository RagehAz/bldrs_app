import 'package:bldrs/b_views/z_components/texting/text_field_bubble.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
import 'package:bldrs/b_views/z_components/sizing/horizon.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/f_helpers/drafters/numeric.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:flutter/material.dart';

class SliderTestScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const SliderTestScreen({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  _SliderTestScreenState createState() => _SliderTestScreenState();
/// --------------------------------------------------------------------------
}

class _SliderTestScreenState extends State<SliderTestScreen> {
  double _minValue = 100000;
  double _maxValue = 500000000;
  double _theValue;
  double _onChangeEnd;
  double _onChangeStart;
  double _semanticFormatterCallback;
  final TextEditingController _minController = TextEditingController(); /// tamam disposed
  final TextEditingController _maxController = TextEditingController(); /// tamam disposed
  int _divisions;
  final TextEditingController _divisionsController = TextEditingController(); /// tamam disposed
  RangeValues _rangeValues;
  final double _startRangeValue = 100000;
  final double _endRangeValue = 500000000;
  // RangeLabels _rangeLabels;
  // String _stringLabel = 'start';
  // String _endLabel = 'end';
  RangeValues _onChangeRangeEnd;
  RangeValues _onChangeRangeStart;
// -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
    _theValue = _minValue;
    _rangeValues = RangeValues(_startRangeValue, _endRangeValue);
    // _rangeLabels = RangeLabels(_stringLabel, _endLabel);
  }
// -----------------------------------------------------------------------------
  @override
  void dispose(){
    _divisionsController.dispose();
    _minController.dispose();
    _maxController.dispose();
    super.dispose();
  }
// -----------------------------------------------------------------------------
  Widget _button(String verse) {
    return SuperVerse(
      verse: verse,
      labelColor: Colorz.white20,
      weight: VerseWeight.thin,
      italic: true,
      maxLines: 3,
    );
  }

// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return MainLayout(
      // appBarBackButton: true,
      appBarType: AppBarType.basic,
      pyramidsAreOn: true,
      pageTitleVerse:  'Slider test',
      layoutWidget: Center(
        child: ListView(
          children: <Widget>[

            const Stratosphere(),

            TextFieldBubble(
              appBarType: AppBarType.basic,
              titleVerse:  'Set Min value',
              keyboardTextInputType: TextInputType.number,
              textController: _minController,
              actionBtIcon: Iconz.plus,
              actionBtFunction: () {
                blog('value is : ${_minController.text}');

                final int _value = Numeric.transformStringToInt(_minController.text);

                setState(() {
                  _minValue = _value.toDouble();
                });
              },
            ),

            TextFieldBubble(
              appBarType: AppBarType.basic,
              titleVerse:  'Set Max value',
              keyboardTextInputType: TextInputType.number,
              textController: _maxController,
              actionBtIcon: Iconz.plus,
              actionBtFunction: () {
                blog('value is : ${_maxController.text}');

                final int _value = Numeric.transformStringToInt(_maxController.text);

                setState(() {
                  _maxValue = _value.toDouble();
                });
              },
            ),

            TextFieldBubble(
              appBarType: AppBarType.basic,
              titleVerse:  'Set divisions',
              keyboardTextInputType: TextInputType.number,
              textController: _divisionsController,
              actionBtIcon: Iconz.plus,
              actionBtFunction: () {
                blog('value is : ${_divisionsController.text}');

                final int _value =
                    Numeric.transformStringToInt(_divisionsController.text);

                setState(() {
                  _divisions = _value;
                });
              },
            ),

            _button('Slider value : ${_theValue.toInt()} --- أقل من 50 م²'),

            _button('_onChangeEnd value : $_onChangeEnd'),

            _button('_onChangeStart value : $_onChangeStart'),

            _button(
                '_semanticFormatterCallback value : $_semanticFormatterCallback'),

            Container(
              width: Scale.superScreenWidth(context),
              margin: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  _button('min\n$_minValue'),
                  _button('max\n$_maxValue'),
                ],
              ),
            ),

            SliderTheme(
              data: SliderTheme.of(context).copyWith(
                activeTickMarkColor: Colorz.black230,
                activeTrackColor: Colorz.blue255,
                disabledActiveTickMarkColor: Colorz.green255,
                disabledActiveTrackColor: Colorz.green125,
                disabledInactiveTickMarkColor: Colorz.white255,
                disabledInactiveTrackColor: Colorz.black20,
                disabledThumbColor: Colorz.yellow20,
                inactiveTickMarkColor: Colorz.red255,
                inactiveTrackColor: Colorz.facebook,
                minThumbSeparation: 10,
                overlappingShapeStrokeColor: Colorz.white200,
                overlayColor: Colorz.blue20,
                trackHeight: 15,
                thumbColor: Colorz.black230,
                showValueIndicator: ShowValueIndicator.always,
                valueIndicatorColor: Colorz.green125,
                valueIndicatorShape: const PaddleSliderValueIndicatorShape(),
                tickMarkShape: const RoundSliderTickMarkShape(),
                overlayShape: const RoundSliderOverlayShape(overlayRadius: 30),
                thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 15),
                trackShape: const RoundedRectSliderTrackShape(),
                // valueIndicatorTextStyle: TextStyle(
                //   height: 10,
                //   color: Colorz.BabyBlue,
                //
                // ),

                rangeThumbShape: const RoundRangeSliderThumbShape(
                  disabledThumbRadius: 30,
                  elevation: 10,
                  pressedElevation: 20,
                ),
              ),
              child: Slider(
                value: _theValue,
                activeColor: Colorz.yellow80,
                divisions: _divisions == 0 ? null : _divisions,
                inactiveColor: Colorz.bloodTest,
                label: '${_theValue.toInt()}',
                max: _maxValue,
                min: _minValue,
                // semanticFormatterCallback: (value){
                //
                //   // if(_isInit == true){
                //   //   setState(() {
                //       _semanticFormatterCallback = value;
                //   //   });
                //   // }
                //
                //   return 'the semantic formatter call back value is : $value';
                // },
                onChangeEnd: (double value) {
                  setState(() {
                    _onChangeEnd = value;
                  });
                },
                onChangeStart: (double value) {
                  setState(() {
                    _onChangeStart = value;
                  });
                },
                onChanged: (double value) {
                  setState(() {
                    _theValue = value;
                  });
                },
              ),
            ),

            // TextFieldBubble(
            //   title: 'Set _rangeValues.start value',
            //   keyboardTextInputType: TextInputType.number,
            //   textController: _maxController,
            //   actionBtIcon: Iconz.Plus,
            //   actionBtFunction: (){
            //     blog('value is : ${_maxController.text}');
            //
            //     int _value = stringToInt(_maxController.text);
            //
            //     setState(() {
            //       _rangeValues.start = _value.toDouble();
            //     });
            //
            //   },
            // ),
            //
            // TextFieldBubble(
            //   title: 'Set divisions',
            //   keyboardTextInputType: TextInputType.number,
            //   textController: _divisionsController,
            //   actionBtIcon: Iconz.Plus,
            //   actionBtFunction: (){
            //     blog('value is : ${_divisionsController.text}');
            //
            //     int _value = stringToInt(_divisionsController.text);
            //
            //     setState(() {
            //       _divisions = _value;
            //     });
            //
            //   },
            // ),

            _button(
                '_rangeValues : ${_rangeValues?.start?.toInt()} : ${_rangeValues?.end?.toInt()}'),

            _button(
                '_onChangeRangeStart value : ${_onChangeRangeStart?.start?.toInt()} to ${_onChangeRangeStart?.end?.toInt()}'),

            _button(
                '_onChangeRangeEnd value : ${_onChangeRangeEnd?.start?.toInt()} to ${_onChangeRangeEnd?.end?.toInt()}'),

            RangeSlider(
              values: _rangeValues,
              activeColor: Colorz.yellow255,
              labels: RangeLabels('${_onChangeRangeStart?.start?.toInt()}',
                  '${_onChangeRangeStart?.end?.toInt()}'),
              divisions: _divisions == 0 ? null : _divisions,
              inactiveColor: Colorz.bloodTest,
              max: _maxValue,
              min: _minValue,
              semanticFormatterCallback: (double value) {
                // if(_isInit == true){
                //   setState(() {
                _semanticFormatterCallback = value;
                //   });
                // }

                return 'the semantic formatter call back value is : $value';
              },
              onChangeEnd: (RangeValues values) {
                setState(() {
                  _onChangeRangeEnd = values;
                });
              },
              onChangeStart: (RangeValues rangeValue) {
                setState(() {
                  _onChangeRangeStart = rangeValue;
                });
              },
              onChanged: (RangeValues rangeValue) {
                setState(() {
                  _rangeValues = rangeValue;
                });
              },
            ),

            const Horizon(),
          ],
        ),
      ),
    );
  }
}
