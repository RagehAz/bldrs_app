import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:flutter/material.dart';

class CheckBoxLesson extends StatefulWidget {
 @override
 _CheckBoxLessonState createState() => _CheckBoxLessonState();
}

class _CheckBoxLessonState extends State<CheckBoxLesson> {
 TextEditingController _fuckform = TextEditingController();
 String textdata;

 var checkbox1 = false;
 var checkbox2 = false;
 var checkbox3 = false;
 var checkbox4 = false;
 var radio1 = 0;

 void radioshack(int val){
   setState(() {
     radio1 = val;
   });
   print(val);
 }

 void checkboxChange(bool val) {
   setState(() {
     checkbox1 = val;
   });
 }

 void checkboxChange2(bool val) {
   setState(() {
     checkbox2 = val;
   });
 }

 void checkboxChange3(bool val) {
   setState(() {
     checkbox3 = val;
   });
 }

 void checkboxChange4(bool val) {
   setState(() {
     checkbox4 = val;
   });
 }


 Widget build(BuildContext context) {
   return  Container(
       padding: const EdgeInsets.all(10),
       child: Column(
         children: <Widget>[

           Stratosphere(),

           Text('$textdata'),
           TextFormField(
             decoration: InputDecoration(
               enabledBorder: OutlineInputBorder(
                 borderSide: BorderSide(
                   color: Color.fromARGB(100, 255, 0, 0),
                   width: 10.0,
                   style: BorderStyle.solid,
                 ),
                 borderRadius: BorderRadius.circular(10),
               ),
               filled: true,
               fillColor: const Color.fromARGB(1000, 153, 204, 255),
               contentPadding: const EdgeInsets.all(20),
               counterText: 'type the fucking shit',
               labelText: 'Yala yabn el metnaka',

               focusedBorder: OutlineInputBorder(
                   borderSide: BorderSide(
                     color: Color.fromARGB(100, 102, 153, 0),
                     width: 10.0,
                     style: BorderStyle.solid,
                   ),
                   borderRadius: BorderRadius.circular(30.0)),

               suffixIcon: Icon(
                 Icons.access_time,
                 color: Colors.red,
                 size: 20,
               ),
               suffixText: 'Enter your fucking name',
               suffixStyle: TextStyle(
                 fontSize: 10,
                 color: Color.fromARGB(1000, 100, 153, 12),
                 fontWeight: FontWeight.bold,
               ),
               prefixIcon: Icon(Icons.accessibility),
//                prefixText: 'Enter here',
               prefixStyle: TextStyle(
                 color: Colors.red,
               ),
               prefix: Image.asset(
                 'assets/icons/bldrs_icon.ico',
                 width: 25,
                 height: 25,
               ),
             ),
             style: TextStyle(),
             onFieldSubmitted: (String val) {
//                print(val);
               setState(() {
                 textdata = _fuckform.text;
               });
             },
//                maxLines: null,
//              controller: _fuckform,
           ),
           Checkbox(
             value: checkbox1,
             onChanged: checkboxChange,
             checkColor: Color.fromARGB(1000, 255, 25, 20),
             activeColor: Color.fromARGB(1000, 102, 255, 51),
           ),
           CheckboxListTile(
             onChanged: checkboxChange2,
             value: checkbox2,
             checkColor: Color.fromARGB(1000, 200, 215, 120),
             activeColor: Color.fromARGB(1000, 200, 20, 70),
             title: Text('fucker'),
             subtitle: Text('motherfucker'),
             dense: false,
             controlAffinity: ListTileControlAffinity.platform,
             isThreeLine: true,
             secondary: Image.asset(
               'assets/icons/bldrs_icon.ico',
               width: 25,
               height: 25,
             ),
           ),
           CheckboxListTile(
             onChanged: checkboxChange3,
             value: checkbox3,
             checkColor: Color.fromARGB(1000, 200, 215, 120),
             activeColor: Color.fromARGB(1000, 200, 20, 70),
             title: Text('Bitch'),
             subtitle: Text('Son of a bitch'),
             dense: false,
             controlAffinity: ListTileControlAffinity.platform,
             isThreeLine: true,
             secondary: Image.asset(
               'assets/icons/bldrs_icon.ico',
               width: 25,
               height: 25,
             ),
           ),
           CheckboxListTile(
             onChanged: checkboxChange4,
             value: checkbox4,
             checkColor: Color.fromARGB(1000, 200, 215, 120),
             activeColor: Color.fromARGB(1000, 200, 20, 70),
             title: Text('Ebn Weskha'),
             subtitle: Text('3ayyel 3ars ebn Weskha'),
             dense: false,
             controlAffinity: ListTileControlAffinity.platform,
             isThreeLine: false,
             secondary: Image.asset(
               'assets/icons/bldrs_icon.ico',
               width: 25,
               height: 25,
             ),
           ),

           Radio(
             value: 0,
             groupValue: radio1,
             onChanged: radioshack
           ),

           Radio(
             value: 1,
             groupValue: radio1,
             onChanged: radioshack
           ),

             Radio(
             value: 2,
             groupValue: radio1,
             onChanged: radioshack,
             activeColor: Color.fromARGB(1000, 255, 0, 0),

           ),

         ],
       ),
     );
 }
}


//                    child: Scaffold( //<----------------------------------TEXT FIELD TEST-
//                      resizeToAvoidBottomPadding: true,
//                      resizeToAvoidBottomInset: true,
//                      body: SingleChildScrollView(
//                        child: Column(
//                          children: <Widget>[
//                            Text('my value is = ${textval}'),
//                            TextField(
//                              autocorrect: false,
//                              textInputAction: TextInputAction.send,
//                              controller: _foo,
//                              textAlign: TextAlign.left,
//                              textDirection: TextDirection.ltr,
//                              autofocus: false,
//                              cursorColor: Color.fromARGB(1000, 0, 0, 0),
//                              maxLines: null,
//                              decoration: InputDecoration(
////                            labelText: "Enter text here",
//                                labelStyle: TextStyle(fontSize: 20),
//                                filled: true,
//                                fillColor: Color.fromARGB(100, 255, 219, 77),
////                            border: OutlineInputBorder
//                              ),
//                              style: TextStyle(
//                                color: Color.fromARGB(200, 255, 26, 26),
//                                wordSpacing: 1.0,
//                                fontSize: 20.0,
//                                decorationStyle: TextDecorationStyle.wavy,
//                                decorationColor:
//                                    Color.fromARGB(1000, 179, 102, 255),
//                              ),
//                              onChanged: onChangeDataOnField,
//                              keyboardType: TextInputType.number,
////                              onEditingComplete: (){print('Done ya 7ayawan');},
////                              onSubmitted: (String val){print(val);},
//                              onTap: () {
//                                print('ready to fuck...');
//                              },
//                            ),
//                            FlatButton(
//                              child: Text('Click Me'),
//                              onPressed: plzclickme,
//                            ),
//                          ],
//                        ),
//                      ),
//                    ), //<----------------------------------TEXT FIELD TEST-


class CheckBoxLessonScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MainLayout(
      layoutWidget: CheckBoxLesson(),
    );
  }
}


