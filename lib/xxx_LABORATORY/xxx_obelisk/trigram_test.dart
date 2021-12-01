import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/drafters/text_generators.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/dashboard/exotic_methods.dart';
import 'package:bldrs/db/fire/methods/firestore.dart';
import 'package:bldrs/db/fire/methods/paths.dart';
import 'package:bldrs/models/bz/bz_model.dart';
import 'package:bldrs/views/widgets/general/buttons/dream_box/dream_box.dart';
import 'package:bldrs/views/widgets/general/layouts/testing_layout.dart';
import 'package:bldrs/views/widgets/general/textings/super_text_field.dart';
import 'package:bldrs/views/widgets/general/textings/super_verse.dart';
import 'package:flutter/material.dart';

class TrigramTest extends StatefulWidget {
  const TrigramTest({Key key}) : super(key: key);

  @override
  _TrigramTestState createState() => _TrigramTestState();
}

class _TrigramTestState extends State<TrigramTest> {

  TextEditingController _controller = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  // String _input = 'Rageh mohammed Fawzi Fahim Soliman El Azzazy';
  List<String> _result = ['Nothing Yet'];

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
        scrollable: false,
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
              inputSize: 2,
              textController: _controller,
              inputColor: Colorz.white255,
              hintText: 'user name ...',
              keyboardTextInputType: TextInputType.multiline,
              maxLength: 20,
              maxLines: 1,
              counterIsOn: true,
              fieldIsFormField: true,
              keyboardTextInputAction: TextInputAction.search,
              onChanged: (String val){

                List<String> _trigram = TextGen.createTrigram(
                  input: val,
                );

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
                    String _tri = _result[index];
                    return
                      SuperVerse(
                        verse: '$index : $_tri',
                        size: 2,
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

          DreamBox(
            height: 40,
            verse: 'fix bbzz',
            color: Colorz.red255,
            verseScaleFactor: 0.7,
            onTap: () async {

              print('wtf');

              List<BzModel> _allBzz = await ExoticMethods.readAllBzzModels(context: context, limit: 200);

              for (var bz in _allBzz){

                List<String> _newTrigram = TextGen.createTrigram(input: bz.name);

                await Fire.updateDocField(
                    context: context,
                    collName: FireColl.bzz,
                    docName: bz.id,
                    field: 'trigram',
                    input: _newTrigram,
                );

              }

              print('DONEEE');

            },
          ),

      ],
    );
  }
}
