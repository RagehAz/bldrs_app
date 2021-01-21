// import 'package:bldrs/ambassadors/services/auth.dart';
// import 'package:bldrs/view_brains/router/route_names.dart';
// import 'package:bldrs/view_brains/theme/colorz.dart';
// import 'package:bldrs/view_brains/theme/iconz.dart';
// import 'package:bldrs/view_brains/theme/ratioz.dart';
// import 'package:bldrs/views/widgets/pyramids/pyramids.dart';
// import 'package:bldrs/views/widgets/textings/text_field_white.dart';
// import 'package:flutter/material.dart';
// import 'package:websafe_svg/websafe_svg.dart';
// import 'package:modal_progress_hud/modal_progress_hud.dart';
//
// class OwnerSignUpScreen extends StatelessWidget {
//
//   final GlobalKey<FormState> _globalKey=GlobalKey<FormState>();
//   static String id= 'OwnerSignUpScreen';
//   String _email, _password;
//   final _auth = Auth();
//
//   @override
//   Widget build(BuildContext context) {
//
//     double buttonCorner = MediaQuery.of(context).size.height * Ratioz.rrButtonCorner;
// //    double buttonTextSize = MediaQuery.of(context).size.height * Ratioz.fontSize6;
//
//
//     return Scaffold(
//       backgroundColor: Colorz.BabyBlueAir,
//
//       appBar: AppBar(
//         title: Text(
//             'New Owner Aount',
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
// //            'bldrs_assets/dummies/bldrs_night_sky.jpg',
// //            fit: BoxFit.fitWidth ,
// //            width: MediaQuery.of(context).size.width
// //          ),
//
//           ModalProgressHUD(
//             inAsyncCall: false,
//             child: Form(
//               key: _globalKey,
//               child: ListView(
//
//                 children: <Widget>[
//
//                   Column(
//
//                     children: <Widget>[
//
//                       SizedBox(
//                           height: MediaQuery.of(context).size.height * .15,
//                       ),
//
//                       TextFieldWhite(
//                         label: 'E-mail',
//                         onClick: (value){
//                           _email = value;
//                         },
//                       ), // ---------------------------- Signup
//
//                       SizedBox(
//                         height: MediaQuery.of(context).size.height * .015,
//                       ),
//
//                       TextFieldWhite(
//                         label: 'Password',
//                         onClick: (value){
//                           _password = value;
//                         },
//                       ), // ---------------------------- Signup
//
//                       SizedBox(
//                         height: MediaQuery.of(context).size.height * .015,
//                       ),
//
//                       Builder(
//                         builder: (context) => RaisedButton(
//                           onPressed: () async
//                           {
//                             if(_globalKey.currentState.validate())
//                             {
//                               _globalKey.currentState.save();
//
//                               try {
//                                 print(_email);
//                                 print(_password);
//                                 final authResult = await _auth.signUp(_email, _password);
// //                            print(authResult.user.uid);
//                                 Navigator.pushNamed(context, Routez.Home);
//                               }catch(error)
//                               {
// //                            print(error.toString());
//                                 Scaffold.of(context).showSnackBar(SnackBar(
//                                   duration:Duration(seconds: 15),
//                                   elevation: 3,
//                                   backgroundColor: Colorz.BloodRed,
//                                   behavior: SnackBarBehavior.floating,
//                                   action: SnackBarAction(
//                                     onPressed: (){},
//                                     label: 'a77a',
//                                     textColor: Colorz.Yellow,
//                                     disabledTextColor: Colorz.LightGrey
//                                   ),
//                                   content: Text (
//                                       error.message
//                                   ),
//                                 ));
//                               }
//                             }
//                             },
//                           padding: EdgeInsets.all(15),
//                           color: Colorz.WhiteGlass,
//                           elevation: 2,
//                           splashColor: Colorz.Yellow,
//                           shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(buttonCorner)
//                           ),
//                           child: Text(
//                             'Sign up',
//                             style: TextStyle(
//                                 color: Colorz.White,
//                                 fontFamily: 'Verdana Bold',
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: MediaQuery.of(context).size.height * Ratioz.fontSize6,
//                                 letterSpacing: 0.75,
//                                 shadows: [Shadow(
//                                   blurRadius: 2,
//                                   color: Colorz.BlackBlack,
//                                   offset: Offset(3.0,1.0),
//
//                                 )]
//                             ),
//
//                           ),
//                         ),
//                       )
//
//
//                     ],
//                   )
//
//                 ],
//
//               ),
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