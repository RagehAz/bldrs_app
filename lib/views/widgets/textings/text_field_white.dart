import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:bldrs/view_brains/theme/ratioz.dart';
import 'package:flutter/material.dart';

class TextFieldWhite extends StatelessWidget {
final String label;
final Function onClick;

TextFieldWhite({@required this.onClick, @required this.label});

// (String str) da abl mafty
// String _errorMessage(String str){
//   String message;
//   switch(label) {
//     case 'Company Name' : return 'Your Company\'s name is missing';
//     case 'Author name' : return 'Add your name';
//     case 'Name' : return 'Add your name please';
//     case 'Password' : return 'Forgot your password ? Seriously ?';
//     case 'E-mail' : return 'Add your E-mail';
//   }
// }

  @override
  Widget build(BuildContext context) {

    double textFieldCorner = MediaQuery.of(context).size.height * Ratioz.rrTextFieldCorner;
    double textFieldFontSize = MediaQuery.of(context).size.height * Ratioz.fontSize3;

    return Container(
      width: MediaQuery.of(context).size.width * .8,
//      height: MediaQuery.of(context).size.height * 0.3,
      margin: const EdgeInsets.all(3),
      color: Colorz.BloodTest,
//      alignment: Alignment.centerLeft,

      child:
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: <Widget>[

          Text(
            label,
            style: TextStyle(
              color: Colorz.GreySmoke,
                fontFamily: 'Verdana',
                fontStyle: FontStyle.italic,
                fontSize: textFieldFontSize,
                letterSpacing: 0.5,
            ),
          ),// ----------------------------------------TEXT FIELD LABEL

          SizedBox(
            height: MediaQuery.of(context).size.height * .01,
          ),// -------------------------------------SPACING

          Container(
            height: MediaQuery.of(context).size.height * 0.11,
            color: Colorz.WaterTest,

            child: TextFormField(

              // validator: (value)
              // {
              //   if(value.isEmpty)
              //   {
              //   return _errorMessage(label);
              //   }
              // },

              onSaved: onClick,
              maxLength: 25,
              maxLines: 1,
              autocorrect: false,
              textDirection: TextDirection.ltr,
              enabled: true,
              obscureText: label =='Password' ? true : false,

              style: TextStyle(
                fontFamily: 'Verdana',
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.normal,
                fontSize: MediaQuery.of(context).size.height * Ratioz.fontSize4,
                color: Colorz.White,
                letterSpacing: 0.75
              ),


              cursorColor: Colorz.WhiteAir,
              cursorRadius: Radius.circular(3),
              cursorWidth: 3,

              decoration: InputDecoration(

                hintText: '..',
                hintStyle: TextStyle(
                  color: Colorz.GreySmoke,
                  fontFamily: 'Verdana',
                  fontStyle: FontStyle.normal,
                  fontSize: textFieldFontSize,
                  letterSpacing: 0.5,

                ),

                errorStyle: TextStyle(
                    color: Colorz.BloodRed,
                  fontFamily: 'Verdana',
                  fontStyle: FontStyle.italic,
                  fontSize: MediaQuery.of(context).size.height * Ratioz.fontSize2,
                  letterSpacing: 0.5
                ),

                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(textFieldCorner),
                  borderSide: BorderSide(color: Colorz.BloodRed)
                ),

                focusColor: Colorz.Yellow,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(textFieldCorner),
                  borderSide: BorderSide(color: Colorz.YellowSmoke)
                ),

                filled: true,
                fillColor: Colorz.WhiteAir,

                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(textFieldCorner),
                  borderSide: BorderSide(
                      color: Color.fromARGB(1, 1, 1, 1)
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(textFieldCorner),
                  borderSide: BorderSide(color: Colorz.BloodRed)
                ),

                counterStyle: TextStyle(
//                height: MediaQuery.of(context).size.height,
                  color: Colorz.GreySmoke,
                  letterSpacing: 1.5,
                  fontFamily: 'Verdana',
                  fontSize: MediaQuery.of(context).size.height * Ratioz.fontSize1

                )

              ),

            ),

          ),// --------------------------------------TEXT FIELD

        ],

      ),

    );

  }

}
