import 'package:bldrs/controllers/router/navigators.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/firestore/auth_ops.dart';
import 'package:bldrs/models/planet/zone_model.dart';
import 'package:bldrs/models/user_model.dart';
import 'package:bldrs/providers/country_provider.dart';
import 'package:bldrs/views/screens/s00_user_checker_widget.dart';
import 'package:bldrs/views/screens/s16_user_editor_screen.dart';
import 'package:bldrs/views/widgets/buttons/main_button.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
import 'package:bldrs/views/widgets/dialogs/alert_dialog.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_size/flutter_keyboard_size.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class GoogleSignInTest extends StatefulWidget {


  @override
  _GoogleSignInTestState createState() => _GoogleSignInTestState();
}

class _GoogleSignInTestState extends State<GoogleSignInTest> {
  /// TASK : should fetch user current location automatically and suggest them here
  final Zone currentZone = Zone(countryID: '', provinceID: '', districtID: '');
  CountryProvider _countryPro;
  bool _isSignedIn = false;
// -----------------------------------------------------------------------------
  /// --- LOADING BLOCK
  bool _loading = false;
  void _triggerLoading(){
    setState(() {_loading = !_loading;});
    _loading == true?
    print('LOADING--------------------------------------') : print('LOADING COMPLETE--------------------------------------');
  }
// -----------------------------------------------------------------------------
  @override
  void initState() {
    /// get user current location
    // TASK : need to trace user current location and pass it here while creating the userModel from firebase User
    _countryPro = Provider.of<CountryProvider>(context, listen: false);
    super.initState();
  }
// -----------------------------------------------------------------------------
  Future<void> _tapGoogleContinue(BuildContext context) async {

    _triggerLoading();

    dynamic _result = await AuthOps().googleSignInOps(context, _countryPro.currentZone);

    if(_result.runtimeType == String){

      _triggerLoading();

      /// pop error dialog
      await authErrorDialog(context: context, result: _result);

    } else {

      /// so sign in succeeded returning a userModel
      UserModel _userModel = _result;
      print('_tapGoogleContinue : _userModel : $_userModel');

      /// check if user model is properly completed
      List<String> _missingFields = UserModel.missingFields(_userModel);
      print('_tapGoogleContinue : _missingFields : $_missingFields');
      if (_missingFields.length == 0){

        print('_missingFields.length == 0 : ${_missingFields.length == 0}');
        _triggerLoading();

        /// so userModel required fields are entered route to userChecker screen
        Nav.goToNewScreen(context, UserChecker());

      } else {

        _triggerLoading();

        /// if userModel is not completed pop Alert
        await superDialog(
          context: context,
          title: 'Ops!',
          body: 'You have to complete your profile info\n ${_missingFields.toString()}',
          boolDialog: false,
        );

        /// and route to complete profile missing data
        Nav.goToNewScreen(context, EditProfileScreen(user: _userModel, firstTimer: false,),);
      }


    }

  }
// -----------------------------------------------------------------------------
  Future<void> _tapGoogleTest({BuildContext context}) async {

    // nlHX0HpQjTcu76XayrRVHBxMZzt2
    // user ID currently testing, delete all data after tests are done

    _triggerLoading();

      FirebaseAuth auth = FirebaseAuth.instance;
      User user;

      /// if used on web
    if (kIsWeb) {

      GoogleAuthProvider authProvider = GoogleAuthProvider();

      try {

        final UserCredential userCredential = await auth.signInWithPopup(authProvider);

        user = userCredential.user;

        if (user != null){
        setState(() {
          _isSignedIn = true;
        });
        }

      } catch (e) {print(e);}

    } else {

      final GoogleSignIn googleSignIn = GoogleSignIn();

      final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();

      if (googleSignInAccount != null) {

        final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        try {

          final UserCredential userCredential =
          await auth.signInWithCredential(credential);

          user = userCredential.user;


          if (user != null){
            setState(() {
              _isSignedIn = true;
            });
          }


        } on FirebaseAuthException catch (e) {

          if (e.code == 'account-exists-with-different-credential') {

            await superDialog(
              context: context,
              title: 'Can\'t continue',
              body: 'Account already signed up by different sign in method',
            );

          } else if (e.code == 'invalid-credential') {

            await superDialog(
              context: context,
              title: 'Can\'t continue',
              body: 'invalid account',
            );

          }

        } catch (e) {

          await superDialog(
            context: context,
            title: 'Can\'t continue',
            body: 'Something is wrong',
          );

        }
      }

      print(user);

    _triggerLoading();

  }}
// -----------------------------------------------------------------------------
  Future<void> _tapGoogleSignOut() async {

      _triggerLoading();

      final GoogleSignIn googleSignIn = GoogleSignIn();
      print('googleSignIn.currentUser was : ${googleSignIn.currentUser}');

      try {

        if (!kIsWeb) {await googleSignIn.signOut();}

        await FirebaseAuth.instance.signOut();

          setState(() {
            _isSignedIn = false;
          });


      } catch (error) {

        await superDialog(
          context: context,
          title: 'Can\'t sign out',
          body: 'Something is wrong : $error',
        );

    }

      _triggerLoading();
      print('googleSignIn.currentUser is : ${googleSignIn.currentUser}');

  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return MainLayout(
      sky: Sky.Black,
      appBarType: AppBarType.Basic,
      // appBarBackButton: true,
      loading: _loading,
      pyramids: Iconz.PyramidzWhite,
      layoutWidget: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[

          DreamBox(
            height: 40,
            // width: 40,
            corners: 20,
            margins: 20,
            verse: _isSignedIn ? 'Signed in' : 'Signed out',
            color: _isSignedIn ? Colorz.Green : Colorz.GreySmoke,
            verseScaleFactor: 0.6,
            verseColor: _isSignedIn ? Colorz.White : Colorz.ModalGrey,
          ),


          SuperVerse(
            verse: 'superFirebaseUser = ${superFirebaseUser()}',
            weight: VerseWeight.thin,
            maxLines: 50,
            size: 2,
            labelColor: _isSignedIn ? Colorz.Green : Colorz.GreySmoke,
            color: _isSignedIn ? Colorz.White : Colorz.ModalGrey,
          ),



          MainButton(
            buttonVerse: "Continue with Google",
            buttonIcon: Iconz.ComGooglePlus,
            buttonColor: Colorz.GoogleRed,
            splashColor: Colorz.Yellow,
            buttonVerseShadow: false,
            function: ()=> _tapGoogleTest(),
            stretched: false,
          ),

          MainButton(
            buttonVerse: "SIGN OUT Google",
            buttonIcon: Iconz.ComGooglePlus,
            buttonColor: Colorz.GoogleRed,
            splashColor: Colorz.Yellow,
            buttonVerseShadow: false,
            function: ()=> _tapGoogleSignOut(),
            stretched: false,
          ),

        ],
      ),
    );
  }
}
