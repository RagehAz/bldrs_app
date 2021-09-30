import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/drafters/text_manipulators.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/views/widgets/general/layouts/testing_layout.dart';
import 'package:bldrs/views/widgets/general/textings/super_text_field.dart';
import 'package:bldrs/views/widgets/general/textings/super_verse.dart';
import 'package:flutter/material.dart';

class TrigramTest extends StatefulWidget {

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

    double _screenWidth = Scale.superScreenWidth(context);

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
            child: SuperTextField(
              width: 400,
              height: 70,
              inputSize: 2,
              textController: _controller,
              inputColor: Colorz.White255,
              hintText: 'user name ...',
              keyboardTextInputType: TextInputType.multiline,
              maxLength: 20,
              maxLines: 1,
              counterIsOn: true,
              fieldIsFormField: true,
              keyboardTextInputAction: TextInputAction.search,
              onChanged: (String val){

                List<String> _trigram = TextMod.createTrigram(
                  input: val,
                  maxTrigramLength: 10,
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
            color: Colorz.BloodTest,
            child: Center(

              child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: _result.length,
                  padding: const EdgeInsets.all(5),
                  itemBuilder: (ctx, index){
                    String _tri = _result[index];
                    return
                      SuperVerse(
                        verse: '$index : $_tri',
                        size: 2,
                        color: Colorz.Black255,
                        centered: false,
                      );

                  }
              ),
            ),
          ),

          /// NUMBER OF TRIGRAMS
          SuperVerse(
            verse: 'tirgram has : ${_result.length} entries',
            labelColor: Colorz.Blue125,
            margin: 10,
          ),

          // /// ADD TO FIREBASE
          // DashboardWideButton(
          //   title: 'add trigrams to db',
          //   icon: null,
          //   onTap: () async {
          //
          //     List<UserModel> _allUsers = await SuperBldrsMethod.readAllUserModels();
          //
          //     for (var user in _allUsers){
          //
          //       List<String> _trigram = TextMod.createTrigram(
          //         input: user.name,
          //         maxTrigramLength: 10,
          //       );
          //
          //       await Fire.updateDocField(
          //         context: context,
          //         collName: FireCollection.users,
          //         docName: user.userID,
          //         input: _trigram,
          //         field: 'nameTrigram',
          //       );
          //
          //       setState(() {
          //         _result = _trigram;
          //       });
          //
          //     }
          //
          //
          //     },
          // )

      ],
    );
  }
}
