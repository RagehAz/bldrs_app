import 'package:bldrs/controllers/drafters/scalers.dart' as Scale;
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/views/widgets/general/layouts/testing_layout.dart';
import 'package:bldrs/views/widgets/general/textings/super_text_field.dart';
import 'package:bldrs/views/widgets/general/textings/super_verse.dart';
import 'package:bldrs/xxx_lab/cleaning_space.dart';
import 'package:flutter/material.dart';

class TrigramTest extends StatefulWidget {
  const TrigramTest({Key key}) : super(key: key);

  @override
  _TrigramTestState createState() => _TrigramTestState();
}

class _TrigramTestState extends State<TrigramTest> {

  final TextEditingController _controller = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  // String _input = 'Rageh mohammed Fawzi Fahim Soliman El Azzazy';
  List<String> _result = <String>['Nothing Yet'];

  // void _createTrigram(String input){
  //
  //   List<String> _trigram = TextMod.createTrigram(
  //     input: input,
  //     maxTrigramLength: 80,
  //   );
  //
  //   setState(() {
  //     _result = _trigram;
  //   });
  // }

  @override
  Widget build(BuildContext context) {

    final double _screenWidth = Scale.superScreenWidth(context);

    return TestingLayout(
        screenTitle: 'Trigram Test',
        appbarButtonVerse: null,
        appbarButtonOnTap: null,
        listViewWidgets: <Widget>[

          /// TEXT FIELD
          Container(
            width: 400,
            height: 70,
            alignment: Alignment.center,
            color: Colorz.blue80,
            child: SuperTextField(
              width: 400,
              height: 70,
              textController: _controller,
              hintText: 'user name ...',
              keyboardTextInputType: TextInputType.multiline,
              maxLength: 20,
              maxLines: 1,
              fieldIsFormField: true,
              keyboardTextInputAction: TextInputAction.search,
              onChanged: (String val){

                // List<String> _trigram = TextGen.createTrigram(
                //   input: val,
                // );

                final List<String> _trigram = generateStringPermutations(val);

                setState(() {
                  _result = _trigram;
                });

              },
            ),
          ),

          /// TRIGRAMS
          Container(
            width: _screenWidth,
            height: 220,
            color: Colorz.bloodTest,
            child: Center(

              child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: _result.length,
                  padding: const EdgeInsets.all(5),
                  itemBuilder: (BuildContext ctx, int index){
                    final String _tri = _result[index];
                    return
                      SuperVerse(
                        verse: '$index : $_tri',
                        color: Colorz.black255,
                        centered: false,
                      );

                  }
              ),
            ),
          ),

          /// NUMBER OF TRIGRAMS
          SuperVerse(
            verse: 'tirgram has : ${_result.length} entries',
            labelColor: Colorz.blue125,
            margin: 10,
          ),

      ],
    );
  }
}
