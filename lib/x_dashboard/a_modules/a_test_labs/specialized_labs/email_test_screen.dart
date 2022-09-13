import 'package:bldrs/a_models/secondary_models/error_helpers.dart';
import 'package:bldrs/b_views/z_components/dialogs/dialogz/dialogs.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/x_dashboard/b_widgets/layout/dashboard_layout.dart';
import 'package:bldrs/x_dashboard/b_widgets/wide_button.dart';
import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

/// TASK : SENDING EMAILS NOT TESTED
/// TASK : VIEW THIS TUTORIAL : https://www.youtube.com/watch?v=RDwst9icjAY

class EmailTestScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const EmailTestScreen({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  _EmailTestScreenState createState() => _EmailTestScreenState();
/// --------------------------------------------------------------------------
}

class _EmailTestScreenState extends State<EmailTestScreen> {
// -----------------------------------------------------------------------------
  /// --- LOADING
  final ValueNotifier<bool> _loading = ValueNotifier(false);
// -----------
  Future<void> _triggerLoading({bool setTo}) async {
    if (mounted == true){
      if (setTo == null){
        _loading.value = !_loading.value;
      }
      else {
        _loading.value = setTo;
      }
      blogLoading(loading: _loading.value, callerName: 'TestingTemplate',);
    }
  }
// -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
  }
// -----------------------------------------------------------------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit && mounted) {

      _triggerLoading().then((_) async {

        /// FUCK

        await _triggerLoading();
      });

      _isInit = false;
    }
    super.didChangeDependencies();
  }
// -----------------------------------------------------------------------------
  /// XXXX
  @override
  void dispose() {
    _loading.dispose();
    super.dispose();
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return DashBoardLayout(
      loading: _loading,
      listWidgets: <Widget>[

        WideButton(
          verse: Verse.plain('Send Email'),
          onTap: () async {

            const String fromEmail = 'rageh-@hotmail.com';
            final String senderName = 'Rageh El Azzazi ${DateTime.now()}';
            const String subject = 'email test screen subject';
            const String body = 'hey sexy baby lady you sexy boudy';
            const List<String> receiversEmails = <String>[
              'rageh-@hotmail.com',
              'rageh.az@gmail.com',
            ];

            final Message message = Message()
              ..from = Address(fromEmail, senderName)
              ..recipients = receiversEmails
              ..subject = subject
              ..text = body;

            final bool _sent = await tryCatchAndReturnBool(
                context: context,
                functions: () async {

                  const String accessToken = null;
                  final SmtpServer _server = gmailSaslXoauth2(fromEmail, accessToken);

                  await send(message, _server,
                    // timeout: const Duration(minutes: 10),
                  );

                }
            );

            if (_sent == true){

              await Dialogs.showSuccessDialog(
                context: context,
                firstLine: Verse.plain('Emails Sent Successfully to ${receiversEmails.length} emails'),
              );

            }


          },
        ),

      ],
    );

  }

}
