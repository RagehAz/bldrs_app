import 'package:url_launcher/url_launcher.dart';

void launchURL(link) async {
  if (await canLaunch(link)) {
    await launch(link);
  }else{
    print('wtf');
  }
}

void launchCall(String link) async {
  if (await canLaunch(link)) {
    await launch(link);
  }else{
    print('cant call');
  }
}
