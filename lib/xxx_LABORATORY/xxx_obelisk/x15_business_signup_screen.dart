// import 'package:bldrs/ambassadors/services/auth.dart';
// import 'package:bldrs/view_brains/theme/colorz.dart';
// import 'package:bldrs/view_brains/theme/iconz.dart';
// import 'package:bldrs/view_brains/theme/ratioz.dart';
// import 'package:bldrs/views/widgets/pyramids/pyramids.dart';
// import 'package:bldrs/views/widgets/textings/text_field_white.dart';
// import 'package:flutter/material.dart';
//
// import 'package:websafe_svg/websafe_svg.dart';
//
//
//
//
// class BusinessSignUpRoute extends StatelessWidget {
//
//   final GlobalKey<FormState> _globalKey=GlobalKey<FormState>();
//   static String id= 'BusinessSignUpScreen';
//   String _email, _password;
//   final _auth = Auth();
//
//   @override
//   Widget build(BuildContext context) {
//
//     double buttonCorner = MediaQuery.of(context).size.height * Ratioz.rrButtonCorner;
//     double buttonTextSize = MediaQuery.of(context).size.height * Ratioz.fontSize6;
//
//
//     return Scaffold(
//       backgroundColor: Colorz.BabyBlueAir,
//
//       appBar: AppBar(
//         title: Text(
//             'New Business Account',
//           style: TextStyle(
//             color: Colorz.White,
//             fontFamily: 'VerdanaBold',
//             fontWeight: FontWeight.bold,
//
//           ),
//
//         ),
//         backgroundColor: Colorz.Nothing,
//         elevation: 0.0,
// //        centerTitle: true,
//         leading: GestureDetector(
//           child: WebsafeSvg.asset(Iconz.Back),
//             onTap: (){
//             Navigator.pop(context);
//             },
//
//
//         ),
//
//
//       ),
//
//       body: Stack(
//         children: <Widget>[
//
// //          Image.asset(
// //            'assets/dummies/bldrs_night_sky.jpg',
// //            fit: BoxFit.fitWidth ,
// //            width: MediaQuery.of(context).size.width
// //          ),
//
//           Form(
//             key: _globalKey,
//             child: ListView(
//
//               children: <Widget>[
//
//                 Column(
//
//                   children: <Widget>[
//
//                     SizedBox(
//                         height: MediaQuery.of(context).size.height * .15,
//                     ),
//
//                     TextFieldWhite(
//                       label: 'E-mail',
//                       onClick: (value){
//                         _email = value;
//                       },
//                     ), // ---------------------------- Signup
//
//                     SizedBox(
//                       height: MediaQuery.of(context).size.height * .015,
//                     ),
//
//                     TextFieldWhite(
//                       label: 'Password',
//                       onClick: (value){
//                         _password = value;
//                       },
//                     ), // ---------------------------- Signup
//
//                     SizedBox(
//                       height: MediaQuery.of(context).size.height * .015,
//                     ),
//
//                     RaisedButton(
//                       onPressed: () async
//                       {
//                         if(_globalKey.currentState.validate())
//                         {
//                           _globalKey.currentState.save();
//                           print(_email);
//                           print(_password);
//                           final authResult = await _auth.signUp(_email, _password);
//                           print(authResult.user.uid);
//                         }
// //                        Navigator.pushNamed(context, StartingScreen.id);
//                         },
//                       padding: EdgeInsets.all(15),
//                       color: Colorz.WhiteGlass,
//                       elevation: 2,
//                       splashColor: Colorz.Yellow,
//                       shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(buttonCorner)
//                       ),
//                       child: Text(
//                         'Sign up',
//                         style: TextStyle(
//                             color: Colorz.White,
//                             fontFamily: 'Kanit',
//                             fontSize: buttonTextSize,
//                             letterSpacing: 0.75,
//                             shadows: [Shadow(
//                               blurRadius: 2,
//                               color: Colorz.BlackBlack,
//                               offset: Offset(3.0,1.0),
//
//                             )]
//                         ),
//
//                       ),
//                     )
//
//
//                   ],
//                 )
//
//               ],
//
//             ),
//           ),
//
//           Pyramids(
//             whichPyramid: Iconz.PyramidsYellow,
//           ),
//
//         ],
//
//       )
//     );
//   }
// }