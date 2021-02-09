import 'package:url_launcher/url_launcher.dart';

void launchURL(link) async {
  // should make a condition
  // if it starts with http:// or not
  // then do whats necessary, as the link should include http://
  if (await canLaunch(link)) {
    await launch(link);
  }else{
    print('Can Not launch link');
  }
}

void launchCall(String link) async {
  if (await canLaunch(link)) {
    await launch(link);
  }else{
    print('cant call');
  }
}
