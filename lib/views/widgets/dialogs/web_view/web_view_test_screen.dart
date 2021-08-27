import 'package:bldrs/controllers/drafters/device_checkers.dart';
import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/views/widgets/dialogs/alert_dialog.dart';
import 'package:bldrs/views/widgets/dialogs/bottom_dialog/bottom_dialog.dart';
import 'package:bldrs/views/widgets/layouts/test_layout.dart';
import 'package:bldrs/views/widgets/textings/super_text_field.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/platform_interface.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewTestScreen extends StatefulWidget {

  @override
  _WebViewTestScreenState createState() => _WebViewTestScreenState();
}

class _WebViewTestScreenState extends State<WebViewTestScreen> {

  TextEditingController _textController = new TextEditingController();
  // String _url = 'https://www.cnn.com';

  Widget _webViewWidget(){
    return
      WebView(
        initialUrl: _textController.text,
        gestureNavigationEnabled: true,
        initialMediaPlaybackPolicy: AutoMediaPlaybackPolicy.always_allow,
        onWebViewCreated: (WebViewController controller){

          print('WebViewController : ${controller}');

        },
        onPageFinished: (String string){
          print ('onPageFinished : string : $string');
        },
        onPageStarted: (String string){
          print('onPageStarted : string : $string');
        },
        onWebResourceError: (WebResourceError error){
          print('onWebResourceError : error.errorCode : ${error.errorCode} : error.description : ${error.description}');
        },
        debuggingEnabled: true,
      );
  }

  Future<void> _slideWebViewBottomDialog (BuildContext context) async {

    await tryAndCatch(
        context: context,
        methodName: 'web view bottom dialog',
        functions: () async {

          if (DeviceChecker.deviceIsAndroid() == true) WebView.platform = SurfaceAndroidWebView();

          double _dialogHeight = BottomDialog.dialogHeight(context, ratioOfScreenHeight: 0.8);

          await BottomDialog.slideBottomDialog(
            context: context,
            height: _dialogHeight,
            draggable: false,
            title: _textController.text,
            child: Container(
              width: BottomDialog.dialogClearWidth(context),
              height: BottomDialog.dialogClearHeight(
                context: context,
                title: 'webSite',
                overridingDialogHeight: _dialogHeight,
                draggable: false,
              ),
              // color: Colorz.BloodTest,
              child: _webViewWidget(),
            ),
          );

        }
    );

  }

  @override
  Widget build(BuildContext context) {

    double _screenWidth = Scale.superScreenWidth(context);
    double _screenHeight = Scale.superScreenHeight(context);

    return TestLayout(
        screenTitle: 'web view test screen',
        appbarButtonVerse: 'button',
        appbarButtonOnTap: (){

        },
        listViewWidgets: <Widget>[

          Container(
            width: _screenWidth - 20,
            alignment: Alignment.center,
            child: SuperTextField(
              textController: _textController,
              height: 50,
              width: _screenWidth - 20,
              hintText: 'www.bitch.com',
              keyboardTextInputAction: TextInputAction.send,
              keyboardTextInputType: TextInputType.url,
              onSubmitted: (val) async {
                print('submitted $val');

                await _slideWebViewBottomDialog(context);
              },
            ),
          )


        ],
    );
  }
}
