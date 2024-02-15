import 'dart:async';
import 'package:basics/helpers/checks/tracers.dart';
import 'package:basics/helpers/strings/text_check.dart';
import 'package:basics/helpers/strings/text_mod.dart';
import 'package:bldrs/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:cloud_functions/cloud_functions.dart';

/// => TAMAM
class CloudFunction {
  // --------------------
  /// http trigger -> ( callable function - end point request )
  // --------------------
  /// private constructor to create instances of this class only in itself
  CloudFunction.singleton();
  // --------------------
  /// Singleton instance
  static final CloudFunction _singleton = CloudFunction.singleton();
  // --------------------
  /// Singleton accessor
  static CloudFunction get instance => _singleton;
  // -----------------------------------------------------------------------------

  /// FirebaseFunctions SINGLETON

  // --------------------
  /// FirebaseFunctions SINGLETON
  FirebaseFunctions? _fireFunctions;
  FirebaseFunctions get fireFunctions => _fireFunctions ??= FirebaseFunctions.instanceFor(
      region: bldrsCloudFunctionsRegion,
  );
  static FirebaseFunctions getFireFunctionsInstance() => CloudFunction.instance.fireFunctions;
  // -----------------------------------------------------------------------------

  /// CLOUD FUNCTIONS REGION

  // --------------------
  static const String bldrsCloudFunctionsRegion = 'us-central1';
  // -----------------------------------------------------------------------------

  /// CALLABLE FUNCTIONS NAMES

  // --------------------
  /// returns true on success - false on failure
  static const String callSendFCMToDevice = 'callSendFCMToDevice';     // v1 : one note => one user
  static const String callSendFCMToDevices = 'callSendFCMToDevices';   // v1 : one note => multiple users
  static const String callSendFCMToTopic = 'callSendFCMToTopic';       // v1 : one note => one bz
  static const String callSendFCMsToDevices = 'callSendFCMsToDevices'; // v2 : multiple notes => multiple devices ( due to different topics )
  // --------------------
  static const String callDeleteStorageDirectory = 'callDeleteStorageDirectory';

  static const String callGetAuthUsers = 'callGetAuthUsers';
  // -----------------------------------------------------------------------------

  /// INSTANCE

  // --------------------
  /// TESTED : WORKS PERFECT
  static HttpsCallable _createHttpsCallableFunction({
    required String funcName,
    Duration timeout = const Duration(seconds: 60),
  }) {
    return getFireFunctionsInstance().httpsCallable(
      funcName,
      options: HttpsCallableOptions(
        timeout: timeout,
      ),
    );
  }
  // -----------------------------------------------------------------------------

  /// CALLING

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<dynamic> call({
    required String functionName,
    Map<String, dynamic>? mapToPass,
    Function(dynamic)? onFinish,
  }) async {

    dynamic _output;

    String? _showNotSentDialog;

    try {
      blog('Cloud Function call : start');

      final HttpsCallable _function = _createHttpsCallableFunction(
        funcName: functionName,
      );

      blog('Cloud Function call : _function : $_function');

      final Map<String, dynamic> _map = mapToPass ?? <String, dynamic>{};

      blog('Cloud Function call : _map : $_map');

      final HttpsCallableResult _result = await _function.call(_map);

      blog('Cloud Function call : _map : $_map');

      blog('call : _result : $_result');
      _output = _result.data;
      blog('call : _output : $_output');
    }

    on FirebaseFunctionsException catch (exception) {
      blog('callFunction : exception.message    : ${exception.message}');
      blog('callFunction : exception.details    : ${exception.details}');
      blog('callFunction : exception.code       : ${exception.code}');
      blog('callFunction : exception.plugin     : ${exception.plugin}');
      blog('callFunction : exception.stackTrace : ${exception.stackTrace}');
      _showNotSentDialog = exception.message;
    }

    on Exception catch (error){
      blog('callFunction : error.message    : ${error.runtimeType}');
      blog('callFunction : error.toString() : $error');

      final bool _unauthenticated = TextCheck.stringContainsSubString(
        string: error.toString(),
        subString: '/unauthenticated]',
      );

      blog('callFunction : unauthenticated IS $_unauthenticated');

      if (_unauthenticated == true) {
        await BldrsCenterDialog.showCenterDialog(
          titleVerse: const Verse(
            pseudo: 'You Are not Signed in',
            id: 'phid_your_not_signed_in',
            translate: true,
          ),
          bodyVerse: const Verse(
            id: 'phid_please_sign_in_first',
            translate: true,
          ),
        );
      }

      else {
        _showNotSentDialog = error.toString();
      }

    }

    if (_showNotSentDialog != null){

      await BldrsCenterDialog.showCenterDialog(
        titleVerse: const Verse(
          id: 'phid_error',
          translate: true,
        ),
        bodyVerse: Verse(
          id: _showNotSentDialog,
          translate: false,
        ),
      );

    }

    if (onFinish != null){
      onFinish(_output);
    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// CLOUD FUNCTIONS NOUR METHOD

  // --------------------
  /// DEPRECATED
  /*
  /// TESTED : WORKS PERFECT
  static const String _realIncrementationLink = 'https://www.bldrs.net/counters?operation=';
  // -----------------------------------------------------------------------------
  static Future<String?> incrementDocFieldNourMethod({
    required String docID,
    required String fieldName,
    required String collName,
    required bool increment,
  }) async {

    /// TASK : SHOULD RETURN THE ENTIRE MAP

    String? _docID;

    await tryAndCatch(
        functions: () async {

          final String _action = increment == true ? 'increment' : 'decrement';

          /// post map to realtime database
          final http.Response _response = await http.post(
            Uri.parse('$_realIncrementationLink$_action'),
            body: {
              'collName' : collName,
              'id' : docID,
              'field' : fieldName,
            },
            // json.encode({
            //   'field' : fieldName,
            //   'id' : flyerID,
            // }),
            headers: {
              'Content-Type': 'application/x-www-form-urlencoded',
            },
            // encoding:
          );

          blog('response is : ${_response.body}');

          /// --- get doc ID;
          _docID = json.decode(_response.body)['name'];

          blog('_docID is : $_docID');

        },
        onError: (String error) async {

          await Dialogs.errorDialog(
              bodyVerse: Verse.plain(error)
          );

        }

    );

    return _docID;
  }

   */
  // -----------------------------------------------------------------------------
}

/// => TAMAM
class BldrsCloudFunctions{
  // -----------------------------------------------------------------------------

  const BldrsCloudFunctions();

  // -----------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  static Future<void> deleteStorageDirectory({
    required String? path,
    Function(dynamic)? onFinish,
  }) async {

    if (TextCheck.isEmpty(path) == false){

      String? _path = path;

      final String? _storage = TextMod.removeTextAfterFirstSpecialCharacter(
          text: path,
          specialCharacter: '/',
      );

      if (_storage !=null && _storage == 'storage'){
        _path = TextMod.removeTextBeforeFirstSpecialCharacter(
            text: path,
            specialCharacter: '/',
        );
      }

      await CloudFunction.call(
        functionName: CloudFunction.callDeleteStorageDirectory,
        mapToPass: {
          'path' : _path,
        },
        onFinish: onFinish,
      );

    }

  }
  // -----------------------------------------------------------------------------
}
