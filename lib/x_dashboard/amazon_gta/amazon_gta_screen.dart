import 'package:bldrs/b_views/z_components/buttons/wide_button.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/x_dashboard/zz_widgets/dashboard_layout.dart';
import 'package:filers/filers.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:mapper/mapper.dart';
import 'package:puppeteer/puppeteer.dart' as pup;

class AmazonProduct {

  const AmazonProduct({
    @required this.url,
    @required this.title,
    @required this.images,
    @required this.brand,
    @required this.stars,
    @required this.ratingsCount,
    @required this.price,
    @required this.currency,
    @required this.specifications,
    @required this.aboutThisItem,
    @required this.productDetails,
    @required this.reviews,
    @required this.questions,
    @required this.description,
    @required this.importantInfo,
    @required this.badges,
});

  final String url;
  final String title;
  final List<String> images;
  final String brand;
  final double stars;
  final int ratingsCount;
  final double price;
  final String currency;
  final Map<String, dynamic> specifications;
  final String aboutThisItem;
  final Map<String, dynamic> productDetails;
  final List<ReviewModel> reviews;
  final List<QuestionModel> questions;
  final String description;
  final String importantInfo;
  final Map<String, dynamic> badges;

}

class QuestionModel {

  QuestionModel({
    @required this.question,
    @required this.answer,
    @required this.timeStamp,
  });

  final String question;
  final String answer;
  final DateTime timeStamp;

}

class ReviewModel {

  ReviewModel({
    @required this.name,
    @required this.image,
    @required this.title,
    @required this.review,
    @required this.timeStamp,
    @required this.stars,
  });

  final String name;
  final String image;
  final String title;
  final String review;
  final DateTime timeStamp;
  final double stars;


  /*

  'مش زوايا تصوير . الصور فعلا مصورة نوعين نوع مبطط و نوع مدور\n\nBy The truth on March 17, 2023\n See more answers (1)

   */

}

class AmazonGTAScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const AmazonGTAScreen({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  _AmazonGTAScreenState createState() => _AmazonGTAScreenState();
  /// --------------------------------------------------------------------------
}

class _AmazonGTAScreenState extends State<AmazonGTAScreen> {
  // -----------------------------------------------------------------------------
  final _products = [];
  Uint8List bytes;
  // -----------------------------------------------------------------------------
  static const List<dynamic> cookies = [
{
    'domain': '.amazon.com',
    'hostOnly': false,
    'httpOnly': true,
    'name': '_rails-root_session',
    'path': '/',
    // "sameSite": "unspecified",
    'secure': true,
    'session': true,
    'storeId': '0',
    'value': 'ejBvaG9TdE5Bc0VDbjBYQXZ2SUVwUTNNOW5QMjUrd0xFV2NIUEJKaFJuUXd3R0xGR1cwWVkxOEFNbVV5ZjA1MHg5Y012QnZTU0NNNGRrbnVDcGJzblN3YkdjWnp5Y3VlTEx1VDVadHFZU1F5cUpWeUJTREY4Q0xsdFBNYWtXTW5tcUNjWS95enRPT2VQMGI0aHpFdVZUdFRmVVdDWjNHQzRQdTBXN1Y0a0d1QmJ0eUJxVTIrNkFKd0p1UDBnWXBWLS1ZTDRXcUJwR3BuTmMwdzg1U3JPOU1nPT0%3D--73b0d01c4d005c71a11ae2db26ae1789f2c0d314',
    'id': 1
},
{
    'domain': '.amazon.com',
    'expirationDate': 1711576261.475581,
    'hostOnly': false,
    'httpOnly': true,
    'name': 'at-main',
    'path': '/',
    // "sameSite": "unspecified",
    'secure': true,
    'session': false,
    'storeId': '0',
    'value': 'Atza|IwEBIFnIWZuFTZpT3lq_bsMsooJY5dKwiQ9HPmCOuctsnvBS1M7k2nzOLNvGo2X0-Jmz4LuV-8R6oM0JFjmvI7lZ0fOT4J0MJfBZMRWY9Tpl4nHuAzlShjjod_wmBretZ4hxqerm5naTvwZfshtLY3gwE_EJg3taQAZyTyqB7AZKaSDwC__4igdIOzmqB077fZgDi60_4ZdOw8nms3rw43TaUvLL',
    'id': 2
},
{
    'domain': '.amazon.com',
    'expirationDate': 1711576261.669919,
    'hostOnly': false,
    'httpOnly': false,
    'name': 'i18n-prefs',
    'path': '/',
    // "sameSite": "unspecified",
    'secure': false,
    'session': false,
    'storeId': '0',
    'value': 'USD',
    'id': 3
},
{
    'domain': '.amazon.com',
    'expirationDate': 1711576261.66993,
    'hostOnly': false,
    'httpOnly': false,
    'name': 'lc-main',
    'path': '/',
    // "sameSite": "unspecified",
    'secure': false,
    'session': false,
    'storeId': '0',
    'value': 'en_US',
    'id': 4
},
{
    'domain': '.amazon.com',
    'hostOnly': false,
    'httpOnly': false,
    'name': 's_cc',
    'path': '/',
    // "sameSite": "unspecified",
    'secure': false,
    'session': true,
    'storeId': '0',
    'value': 'true',
    'id': 5
},
{
    'domain': '.amazon.com',
    'expirationDate': 1713106005.366079,
    'hostOnly': false,
    'httpOnly': false,
    'name': 's_fid',
    'path': '/',
    // "sameSite": "unspecified",
    'secure': false,
    'session': false,
    'storeId': '0',
    'value': '5FB56FDD97E784FF-012ACE01DA643399',
    'id': 6
},
{
    'domain': '.amazon.com',
    'hostOnly': false,
    'httpOnly': false,
    'name': 's_sq',
    'path': '/',
    // "sameSite": "unspecified",
    'secure': false,
    'session': true,
    'storeId': '0',
    'value': 'amazdiusprod%3D%2526pid%253Dhttps%25253A%25252F%25252Faffiliate-program.amazon.com%25252Fhome%25252Ftextlink%25252Fsitestripe%25253Fref%25253Dassoc_redirect_from_productlinks%2526oid%253Djavascript%25253Avoid%2525280%252529%2526ot%253DA%26amazditemplate%3D%2526pid%253Dhttps%25253A%25252F%25252Faffiliate-program.amazon.com%25252Fhome%25252Ftextlink%25252Fsitestripe%25253Fref%25253Dassoc_redirect_from_productlinks%2526oid%253Djavascript%25253Avoid%2525280%252529%2526ot%253DA',
    'id': 7
},
{
    'domain': '.amazon.com',
    'expirationDate': 1711576261.475594,
    'hostOnly': false,
    'httpOnly': true,
    'name': 'sess-at-main',
    'path': '/',
    // "sameSite": "unspecified",
    'secure': true,
    'session': false,
    'storeId': '0',
    'value': '"SMzqkt5Tn4m0aco5fDGcCTDUNzJnRNtMZYcX3ySw6o4="',
    'id': 8
},
{
    'domain': '.amazon.com',
    'expirationDate': 1711576275.868359,
    'hostOnly': false,
    'httpOnly': false,
    'name': 'session-id',
    'path': '/',
    // "sameSite": "unspecified",
    'secure': true,
    'session': false,
    'storeId': '0',
    'value': '135-0453659-4300646',
    'id': 9
},
{
    'domain': '.amazon.com',
    'expirationDate': 1711576275.868344,
    'hostOnly': false,
    'httpOnly': false,
    'name': 'session-id-time',
    'path': '/',
    // "sameSite": "unspecified",
    'secure': false,
    'session': false,
    'storeId': '0',
    'value': '2082787201l',
    'id': 10
},
{
    'domain': '.amazon.com',
    'expirationDate': 1714600266.416857,
    'hostOnly': false,
    'httpOnly': true,
    'name': 'session-token',
    'path': '/',
    // "sameSite": "unspecified",
    'secure': true,
    'session': false,
    'storeId': '0',
    'value': '9mmVidp+Pt+iEbPQ3aawAxe1gRlVqQuT/3Bee02Hwkdf3yR5f1tZkFjCNZ6zLsZDvOTKAU/X0uyB0/jTsVP9xXGf97bkM8K1EuUfiCDpeEV7mTng6jInLNHoHiLImPJuKyHp7tM4RjZ3RHUwyo+j26L9DySmLmZNLOb+f7ffKAgHh5uCoeUeeSMqunpZjD3U020k+jLndC4C473fF5XNTNKabYIhh6fiWS/GqlObz+tRytH5trDZc4zs8a4IqRer',
    'id': 11
},
{
    'domain': '.amazon.com',
    'hostOnly': false,
    'httpOnly': false,
    'name': 'skin',
    'path': '/',
    // "sameSite": "unspecified",
    'secure': false,
    'session': true,
    'storeId': '0',
    'value': 'noskin',
    'id': 12
},
{
    'domain': '.amazon.com',
    'expirationDate': 1711518246.484113,
    'hostOnly': false,
    'httpOnly': true,
    'name': 'sp-cdn',
    'path': '/',
    // "sameSite": "unspecified",
    'secure': true,
    'session': false,
    'storeId': '0',
    'value': '"L5Z9:EG"',
    'id': 13
},
{
    'domain': '.amazon.com',
    'expirationDate': 1711576261.475604,
    'hostOnly': false,
    'httpOnly': true,
    'name': 'sst-main',
    'path': '/',
    // "sameSite": "unspecified",
    'secure': true,
    'session': false,
    'storeId': '0',
    'value': 'Sst1|PQFGigqLgdmfFFRLFlWC1VJfCcuPhkmJJPQP5oL0Tk5_C-R30sayW5dqi_qQtZMLk1NlBd3dzkPGlGrKJ4xkq9r3NTmAykg7CL7c6PRt1kopdQFRXHGBFDf23tsF77jOsm8FK-qdfqPEO10jSyMkGyTur62Dy49efgXviwW5oQHZ3E6j4gd17ZJYrIiqAUIpLfOY6dqxqAx9hT4ighhR_TMbb6FzAdCpvhS__YOvyNjoogFQ3RFNlxugGZbKdQr7ZAlHUIDbScDnt35dyE-THSl4isCOg8K3Rv1TpoHaYJ54Dq4',
    'id': 14
},
{
    'domain': '.amazon.com',
    'expirationDate': 1711576275.868293,
    'hostOnly': false,
    'httpOnly': false,
    'name': 'ubid-main',
    'path': '/',
    // "sameSite": "unspecified",
    'secure': true,
    'session': false,
    'storeId': '0',
    'value': '135-0081886-4135368',
    'id': 15
},
{
    'domain': '.amazon.com',
    'expirationDate': 1711576261.669897,
    'hostOnly': false,
    'httpOnly': false,
    'name': 'x-main',
    'path': '/',
    // "sameSite": "unspecified",
    'secure': true,
    'session': false,
    'storeId': '0',
    'value': '"gmhz6Qon3uuq8snHYOmQ@8GAHfPSS8UcdUOzoNy8fgCyVXCJxtEVEUEi4JFHYEl7"',
    'id': 16
},
{
    'domain': 'www.amazon.com',
    'expirationDate': 1710280261,
    'hostOnly': true,
    'httpOnly': false,
    'name': 'csm-hit',
    'path': '/',
    // "sameSite": "unspecified",
    'secure': false,
    'session': false,
    'storeId': '0',
    'value': 'adb:adblk_no&t:1680040261991&tb:s-WX6PWTWQHJER8N38CDWF|1680040261780',
    'id': 17
}
];
  // -----------------------------------------------------------------------------
  /// --- LOADING
  final ValueNotifier<bool> _loading = ValueNotifier(false);
  // --------------------
  Future<void> _triggerLoading({@required bool setTo}) async {
    setNotifier(
      notifier: _loading,
      mounted: mounted,
      value: setTo,
    );
  }
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

      _triggerLoading(setTo: true).then((_) async {

        /// FUCK

        await _triggerLoading(setTo: false);
      });

      _isInit = false;
    }
    super.didChangeDependencies();
  }
  // --------------------
  /*
  @override
  void didUpdateWidget(TheStatefulScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.thing != widget.thing) {
      unawaited(_doStuff());
    }
  }
   */
  // --------------------
  Future<void> launchTheft() async {

    final browser = await pup.puppeteer.launch(
      headless: false,
      // executablePath: 'C:\\Program Files\\Google\\Chrome\\Application\\chrome.exe',
      // userDataDir: 'C:\\Users\\rageh\\AppData\\Local\\Google\\Chrome\\User Data',
    );

    final myPage = await browser.newPage();

    await myPage.setCookies(cookies.map((e) => pup.CookieParam.fromJson(e)).toList());


    const List<String> _urls = <String>[
      'https://www.amazon.com/2021-Apple-10-2-inch-iPad-Wi-Fi/dp/B09G9CJM1Z',
      'https://www.amazon.com/dp/B09G91LXFP',
    ];

    for (final String url in _urls){

      await _stealPage(
        myPage: myPage,
        url: url,
      );

    }

    final theJsons = json.encode(_products);

    final String _thing = '$theJsons\n\n';

    await File('output.json').writeAsString(_thing,
      mode: FileMode.append,
    );


  }
  // --------------------
  Future<void> _stealPage({
    @required dynamic myPage,
    @required String url,
  }) async {


    /// OPENS PAGE
    await myPage.goto(
      url,
      timeout: Duration.zero,
      // wait: Until.networkAlmostIdle,
      // referrer:
    );

    /// TO HOLD UNTIL PAGE INITS
    await Future.delayed(const Duration(seconds: 5));

    // /// TO SCROLL IN PAGE
    // Future<void> autoScroll() async {
    //   await myPage.evaluate(
    //     '''
    //     async ()=>{
    //       await new Promise((resolve)=>{
    //         var totalHeight = 0;
    //         var distance = 100;
    //         var timer = setInterval(()=>{
    //           var scrollHeight = document.body.scrollHeight;
    //           window.scrollBy(0,distance);
    //           totalHeight += distance;
    //           if (totalHeight >= scrollHeight - window.innerHeight){
    //             clearInterval(timer);
    //             resolve();
    //           }
    //         },100);
    //       });
    //     }
    //     ''',
    //   );
    // }

    // myPage.hover(selector)

    final imageSelectors = await myPage.evaluate(
      'document.querySelectorAll("#altImages > ul > li").length + 1',
      // args:,
    );

    blog('thing is : $imageSelectors');

    for (int i = 1; i < imageSelectors; i++){

      await tryAndCatch(
        invoker: '_stealPage',
        functions: () async {

          /// THIS HOVERS
          await myPage.hover('#altImages > ul > li:nth-child($i)');

        },

      );

    }

    blog('before scroll --->');
    // await autoScroll();
    blog('after scroll --->');
    final script = await File('amazon_us.js').readAsString();
    blog('the output is :-');
    // print(script);
    final output = await myPage.evaluate(script);
    blog('--->');

    Mapper.blogMap(output);

    blog('--->');


    _products.add(output);


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
    // --------------------
    return DashBoardLayout(
      pageTitle: 'Amazon GTA',
      loading: _loading,
      listWidgets: <Widget>[

        WideButton(
          verse: Verse.plain('Launch theft'),
          onTap: launchTheft,
        ),

        if (bytes != null)
            Image.memory(bytes,
              height: 200,
              width: 300,
            ),

      ],
    );
    // --------------------
  }
  // -----------------------------------------------------------------------------
}
