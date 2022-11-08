import 'package:bldrs/f_helpers/drafters/error_helpers.dart';
import 'package:bldrs/b_views/z_components/dialogs/dialogz/dialogs.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/x_dashboard/zz_widgets/layout/dashboard_layout.dart';
import 'package:bldrs/x_dashboard/zz_widgets/wide_button.dart';
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
  // --------------------
  /*
  Future<void> _triggerLoading({@required bool setTo}) async {
    setNotifier(
      notifier: _loading,
      mounted: mounted,
      value: setTo,
    );
  }
   */
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
  }
  // --------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit && mounted) {

      // _triggerLoading(setTo: true).then((_) async {
      //
      // -->
      //
      //   await _triggerLoading(setTo: false);
      // });

      _isInit = false;
    }
    super.didChangeDependencies();
  }
  // --------------------
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
  // -----------------------------------------------------------------------------
}
