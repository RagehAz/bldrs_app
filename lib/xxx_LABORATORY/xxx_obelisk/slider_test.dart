import 'package:bldrs/controllers/drafters/numberers.dart';
import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/drafters/text_generators.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/views/widgets/bubbles/text_field_bubble.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:bldrs/views/widgets/textings/super_text_field.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SliderTestScreen extends StatefulWidget {
  const SliderTestScreen({Key key}) : super(key: key);

  @override
  _SliderTestScreenState createState() => _SliderTestScreenState();
}

class _SliderTestScreenState extends State<SliderTestScreen> {
  double _minValue = 100000;
  double _maxValue = 500000000;
  double _theValue;
  double _onChangeEnd;
  double _onChangeStart;
  double _semanticFormatterCallback;
  TextEditingController _minController = new TextEditingController();
  TextEditingController _maxController = new TextEditingController();
  int _divisions;
  TextEditingController _divisionsController = new TextEditingController();
  RangeValues _rangeValues;
  double _startRangeValue = 100000;
  double _endRangeValue = 500000000;
  RangeLabels _rangeLabels;
  String _stringLabel = 'start';
  String _endLabel = 'end';
  RangeValues _onChangeRangeEnd;
  RangeValues _onChangeRangeStart;
// -----------------------------------------------------------------------------
  @override
  void initState() {
    _theValue = _minValue;
    _rangeValues = RangeValues(_startRangeValue, _endRangeValue);
    _rangeLabels = RangeLabels(_stringLabel, _endLabel);
    super.initState();
  }
// -----------------------------------------------------------------------------
  Widget _button(String verse){
    return
      SuperVerse(
        verse: verse,
        size: 2,
        labelColor: Colorz.White20,
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
      appBarType: AppBarType.Basic,
      pyramids: Iconz.PyramidsGlass,
      pageTitle: 'Slider test',
      tappingRageh: (){

        setState(() {

        });

        print('testing slider');

        },
      layoutWidget: Center(
        child: ListView(
          children: <Widget>[

            Stratosphere(),

            TextFieldBubble(
              title: 'Set Min value',
              keyboardTextInputType: TextInputType.number,
              textController: _minController,
              actionBtIcon: Iconz.Plus,
              actionBtFunction: (){
                print('value is : ${_minController.text}');

                int _value = Numberers.stringToInt(_minController.text);

                setState(() {
                  _minValue = _value.toDouble();
                });

              },
            ),

            TextFieldBubble(
              title: 'Set Max value',
              keyboardTextInputType: TextInputType.number,
              textController: _maxController,
              actionBtIcon: Iconz.Plus,
              actionBtFunction: (){
                print('value is : ${_maxController.text}');

                int _value = Numberers.stringToInt(_maxController.text);

                setState(() {
                  _maxValue = _value.toDouble();
                });

              },
            ),

            TextFieldBubble(
              title: 'Set divisions',
              keyboardTextInputType: TextInputType.number,
              textController: _divisionsController,
              actionBtIcon: Iconz.Plus,
              actionBtFunction: (){
                print('value is : ${_divisionsController.text}');

                int _value = Numberers.stringToInt(_divisionsController.text);

                setState(() {
                  _divisions = _value;
                });

              },
            ),

            _button('Slider value : ${_theValue.toInt()} --- أقل من 50 م²'),

            _button('_onChangeEnd value : $_onChangeEnd'),

            _button('_onChangeStart value : $_onChangeStart'),

            _button('_semanticFormatterCallback value : $_semanticFormatterCallback'),

            Container(
              width: Scale.superScreenWidth(context),
              margin: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[

                  _button('min\n$_minValue'),

                  _button('max\n$_maxValue'),

                ],
              ),
            ),


            SliderTheme(
              data: SliderTheme.of(context).copyWith(
                activeTickMarkColor: Colorz.Black230,
                activeTrackColor: Colorz.Blue225,
                disabledActiveTickMarkColor: Colorz.Green255,
                disabledActiveTrackColor: Colorz.Green125,
                disabledInactiveTickMarkColor: Colorz.White255,
                disabledInactiveTrackColor: Colorz.Black20,
                disabledThumbColor: Colorz.Yellow20,
                inactiveTickMarkColor: Colorz.Red255,
                inactiveTrackColor: Colorz.Facebook,
                minThumbSeparation: 10,
                overlappingShapeStrokeColor: Colorz.White200,
                overlayColor: Colorz.Blue20,
                trackHeight: 15,
                thumbColor: Colorz.Black230,
                showValueIndicator: ShowValueIndicator.always,
                valueIndicatorColor: Colorz.Green125,
                valueIndicatorShape: PaddleSliderValueIndicatorShape(),
                tickMarkShape: RoundSliderTickMarkShape(),
                overlayShape: RoundSliderOverlayShape(overlayRadius: 30),
                thumbShape: RoundSliderThumbShape(enabledThumbRadius: 15),
                trackShape: RoundedRectSliderTrackShape(),
                // valueIndicatorTextStyle: TextStyle(
                //   height: 10,
                //   color: Colorz.BabyBlue,
                //
                // ),

                rangeThumbShape: RoundRangeSliderThumbShape(
                  enabledThumbRadius: 10,
                  disabledThumbRadius: 30,
                  elevation: 10,
                  pressedElevation: 20,
                ),
              ),
              child: Slider(
                value: _theValue,
                activeColor: Colorz.Yellow80,
                autofocus: false,
                divisions: _divisions == 0 ? null : _divisions,
                inactiveColor: Colorz.BloodTest,
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
                onChangeEnd: (value){
                  setState(() {
                  _onChangeEnd = value;
                  });
                },
                onChangeStart: (value){
                  setState(() {
                    _onChangeStart = value;
                  });
                },
                onChanged: (value){
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
            //     print('value is : ${_maxController.text}');
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
            //     print('value is : ${_divisionsController.text}');
            //
            //     int _value = stringToInt(_divisionsController.text);
            //
            //     setState(() {
            //       _divisions = _value;
            //     });
            //
            //   },
            // ),


            _button('_rangeValues : ${_rangeValues?.start?.toInt()} : ${_rangeValues?.end?.toInt()}'),

            _button('_onChangeRangeStart value : ${_onChangeRangeStart?.start?.toInt()} to ${_onChangeRangeStart?.end?.toInt()}'),

            _button('_onChangeRangeEnd value : ${_onChangeRangeEnd?.start?.toInt()} to ${_onChangeRangeEnd?.end?.toInt()}'),

            RangeSlider(
              values: _rangeValues,
              activeColor: Colorz.Yellow255,
              labels: RangeLabels('${_onChangeRangeStart?.start?.toInt()}', '${_onChangeRangeStart?.end?.toInt()}'),
              divisions: _divisions == 0 ? null : _divisions,
              inactiveColor: Colorz.BloodTest,
              max: _maxValue,
              min: _minValue,
              semanticFormatterCallback: (value){

                // if(_isInit == true){
                //   setState(() {
                _semanticFormatterCallback = value;
                //   });
                // }

                return 'the semantic formatter call back value is : $value';
              },
              onChangeEnd: (values){
                setState(() {
                  _onChangeRangeEnd = values;
                });
              },
              onChangeStart: (rangeValue){
                setState(() {
                  _onChangeRangeStart = rangeValue;
                });
              },
              onChanged: (rangeValue){
                setState(() {
                  _rangeValues = rangeValue;
                });
              },
            ),

            PyramidsHorizon(heightFactor: 10,),

          ],
        ),
      ),
    );
  }
}
