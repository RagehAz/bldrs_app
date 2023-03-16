import 'dart:convert';
import 'dart:typed_data';

import 'package:amazon_image/amazon_image.dart';
import 'package:amazon_image/amazon_image_setting.dart';
import 'package:bldrs/b_views/z_components/app_bar/a_bldrs_app_bar.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bldrs_bubble_header_vm.dart';
import 'package:bldrs/b_views/z_components/layouts/separator_line.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/x_dashboard/zz_widgets/dashboard_layout.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:bubbles/bubbles.dart';
import 'package:filers/filers.dart';
import 'package:flutter/material.dart';
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart';
import 'package:http/http.dart';
import 'package:rest/rest.dart';
import 'package:stringer/stringer.dart';
import 'package:super_image/super_image.dart';
class AffiliateTestScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const AffiliateTestScreen({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  _AffiliateTestScreenState createState() => _AffiliateTestScreenState();
  /// --------------------------------------------------------------------------
}

class _AffiliateTestScreenState extends State<AffiliateTestScreen> {

  static const String _htmlCode = '<a href="https://www.amazon.com/AIOPR-Cordless-Circular-Guide-Blades/dp/B08NDRKJPT?pd_rd_w=JHr3W&content-id=amzn1.sym.1bcf206d-941a-4dd9-9560-bdaa3c824953&pf_rd_p=1bcf206d-941a-4dd9-9560-bdaa3c824953&pf_rd_r=9GJ85SS2M4Z3G4FJRW94&pd_rd_wg=uKesG&pd_rd_r=8fd1cae9-0513-410b-b671-80f1fcccc98a&pd_rd_i=B08NDRKJPT&linkCode=li2&tag=bldrs07-20&linkId=12eaf2d6985b4af023b8e1486ad209d3&language=en_US&ref_=as_li_ss_il" target="_blank"><img border="0" src="//ws-na.amazon-adsystem.com/widgets/q?_encoding=UTF8&ASIN=B08NDRKJPT&Format=_SL160_&ID=AsinImage&MarketPlace=US&ServiceVersion=20070822&WS=1&tag=bldrs07-20&language=en_US" ></a><img src="https://ir-na.amazon-adsystem.com/e/ir?t=bldrs07-20&language=en_US&l=li2&o=1&a=B08NDRKJPT" width="1" height="1" border="0" alt="" style="border:none !important; margin:0px !important;" />';
  // -----------------------------------------------------------------------------
  final TextEditingController controller = TextEditingController();
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
  @override
  void dispose() {
    _loading.dispose();
    super.dispose();
  }
  // -----------------------------------------------------------------------------
  ///
  String getRawLinkFromAmazonLink(String amazonLink){
    final hrefRegex = RegExp(r'href="(.*?)"');
    final match = hrefRegex.firstMatch(amazonLink);
    return match?.group(1);
  }
  // --------------------
  ///
  Future<void> _getImageFromRawLink(String _rawLink) async {

    final Response _res = await Rest.get(
      rawLink: 'https://www.amazon.com/AIOPR-Cordless-Circular-Guide-Blades/dp/B08NDRKJPT?pd_rd_w=Yol1h&content-id=amzn1.sym.a089f039-4dde-401a-9041-8b534ae99e65&pf_rd_p=a089f039-4dde-401a-9041-8b534ae99e65&pf_rd_r=6C4X0NZGP3TAVGY12BHC&pd_rd_wg=qK6eC&pd_rd_r=101e96a1-21d1-4c4c-b1f0-ce93bd96c953&pd_rd_i=B08NDRKJPT&psc=1&linkCode=li2&tag=bldrs07-20&linkId=7afc04f81bf57b98be8797a98ad2b24f&language=en_US&ref_=as_li_ss_il',
      invoker: 'get from amazon',
    );

    Rest.blogResponse(response: _res);

    if (_res.statusCode >= 200) {

      final dom.Document document = parse(_res.body);

      // document.querySelector(selector)
      
      blog('doc blog ====> ');
      blog(document);
      blog('doc blog ENEDED ======<');

      List<int> encodedBytes = utf8.encode(_res.body);

      setState(() {
        _image = _res.bodyBytes;
        _link = _rawLink;
      });
    }

  }

    /// Get amazon's product url.
  String getTheDamnLink() {

    const String trackingId = 'bldrs07-20';
    const String domain = 'amazon.com'; //amazonDomains['US'];
    const String asin = 'B08NDRKJPT';

    // https://www.amazon.co.jp/gp/product/B00N8JJCNQ?tag=flutter_amazon_image-22
    return 'https://www.$domain/gp/product/$asin?tag=$trackingId';
  }

  Future<void> _onPaste() async {

    await TextMod.controllerPaste(controller);

    final String _rawLink = getRawLinkFromAmazonLink(controller.text);

    blog('the rawlink : $_rawLink');

    final String thing = getTheDamnLink();

    final Response _res = await Rest.get(
      rawLink: thing,
      invoker: 'get from amazon',
    );

      final dom.Document doc = parse(_res.body);



    Rest.blogResponse(response: _res);


    // await _getImageFromRawLink(_rawLink);

    // final String _url = await _getImageUrl(controller.text);
    setState(() {
      _link = thing;
      _image = _res?.bodyBytes;
      _html = _res.body;
    });
  }
  // --------------------
  ///
  //   Future<String> _getImageUrl(String html) async {
  //
  //   final dom.Document document = parse(html);
  //   final dom.Element img = document.querySelector('img[id="landingImage"]');
  //
  //   if (img != null) {
  //     return img.attributes['src'] ?? '';
  //   }
  //
  //   else {
  //     throw Exception('Image not found');
  //   }
  //
  // }
  // -----------------------------------------------------------------------------
  String _link;
  Uint8List _image;
  String _imageURL;
  String _html = '<a href="https://www.amazon.com/AIOPR-Cordless-Circular-Guide-Blades/dp/B08NDRKJPT?m=A136BXX9RZN4SF&marketplaceID=ATVPDKIKX0DER&qid=1678560741&s=merchant-items&sr=1-2&linkCode=li2&tag=bldrs07-20&linkId=381dba0414c620137db1be69ec86c5c6&language=en_US&ref_=as_li_ss_il" target="_blank"><img border="0" src="//ws-na.amazon-adsystem.com/widgets/q?_encoding=UTF8&ASIN=B08NDRKJPT&Format=_SL160_&ID=AsinImage&MarketPlace=US&ServiceVersion=20070822&WS=1&tag=bldrs07-20&language=en_US" ></a><img src="https://ir-na.amazon-adsystem.com/e/ir?t=bldrs07-20&language=en_US&l=li2&o=1&a=B08NDRKJPT" width="1" height="1" border="0" alt="" style="border:none !important; margin:0px !important;" />';
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------

    /*
    <a
    href=
    "https://www.amazon.com/AIOPR-Cordless-Circular-Guide-Blades/dp/B08NDRKJPT?pd_rd_w=Yol1h&content-id=amzn1.sym.a089f039-4dde-401a-9041-8b534ae99e65&pf_rd_p=a089f039-4dde-401a-9041-8b534ae99e65&pf_rd_r=6C4X0NZGP3TAVGY12BHC&pd_rd_wg=qK6eC&pd_rd_r=101e96a1-21d1-4c4c-b1f0-ce93bd96c953&pd_rd_i=B08NDRKJPT&psc=1&linkCode=li2&tag=bldrs07-20&linkId=7afc04f81bf57b98be8797a98ad2b24f&language=en_US&ref_=as_li_ss_il"
    target="_blank"><img border="0"
    src="//ws-na.amazon-adsystem.com/widgets/q?_encoding=UTF8&ASIN=B08NDRKJPT&Format=_SL160_&ID=AsinImage&MarketPlace=US&ServiceVersion=20070822&WS=1&tag=bldrs07-20&language=en_US"
    ></a><
    img src="https://ir-na.amazon-adsystem.com/e/ir?t=bldrs07-20&language=en_US&l=li2&o=1&a=B08NDRKJPT"
    width="1" height="1" border="0" alt="" style="border:none !important;
    margin:0px !important;"
     />
     */

    return DashBoardLayout(
      loading: _loading,
      listWidgets: <Widget>[


         Center(
           child: Container(
             width: 200,
             height: 200,
             color: Colorz.bloodTest,
             child: AmazonImage(
              'B078C5S3NC',
              context: context,
              imageSize: ImageSize.Large,
              onTap: (){
                blog('on tap');
              },
              // onDoubleTap: (){
              //   blog('on double tap');
              // },
              boxFit: BoxFit.cover,
              // key: ,
              functionAfterLaunch: (){
                blog('functionBeforeLaunch start');
              },
              functionBeforeLaunch: (BuildContext context) async {
                blog('functionBeforeLaunch start');
                AmazonImageSetting().setTrackingId('bldrs07-20');
                return true;
              },
              // holder: ,
              // isLaunchAfterDoubleTap: ,
              // isLaunchAfterLongTap: ,
              // isLaunchAfterTap: ,
              // linkUrl: ,
              // offset: ,
              // onLongTap: ,
        ),
           ),
         ),

        TextFieldBubble(
          textController: controller,
          bubbleHeaderVM: BldrsBubbleHeaderVM.bake(
            headlineVerse: Verse.plain('Amazon link'),
          ),
          bubbleWidth: BldrsAppBar.width(context),
          pasteFunction: _onPaste,
        ),

        SuperVerse(
            verse: Verse.plain('Link : $_link'),
        ),

        // if (_html != null)
        // Html(
        //   data: _html,
        //   // shrinkWrap: ,
        //   // key: ,
        //   // anchorKey: ,
        //   // customRenders: ,
        //   // onAnchorTap: ,
        //   // onCssParseError: ,
        //   // onImageError: ,
        //   // onImageTap: ,
        //   // onLinkTap: ,
        //   // style: ,
        //   // tagsList: [],
        // ),

        // WideButton(
        //   verse: Verse.plain('GET AMAZON LINK'),
        //   onTap: () async {
        //
        //     final Response _res = await Rest.get(
        //         rawLink: "https://www.amazon.com/AIOPR-Cordless-Circular-Guide-Blades/dp/B08NDRKJPT?pd_rd_w=Yol1h&content-id=amzn1.sym.a089f039-4dde-401a-9041-8b534ae99e65&pf_rd_p=a089f039-4dde-401a-9041-8b534ae99e65&pf_rd_r=6C4X0NZGP3TAVGY12BHC&pd_rd_wg=qK6eC&pd_rd_r=101e96a1-21d1-4c4c-b1f0-ce93bd96c953&pd_rd_i=B08NDRKJPT&psc=1&linkCode=li2&tag=bldrs07-20&linkId=7afc04f81bf57b98be8797a98ad2b24f&language=en_US&ref_=as_li_ss_il",
        //         invoker: 'get from amazon',
        //     );
        //
        //     Rest.blogResponse(response: _res);
        //
        //     if (_res.statusCode >= 200){
        //
        //       setState(() {
        //         _image = _res.bodyBytes;
        //       });
        //
        //     }
        //
        //   },
        // ),

        SuperImage(
          width: 200,
          height: 200,
          pic: _image,
        ),

        const SeparatorLine(),

        SuperImage(
          width: 200,
          height: 200,
          pic: _imageURL,
        ),

        const SeparatorLine(),
        const SeparatorLine(),

      ],
    );
    // --------------------
  }
  // -----------------------------------------------------------------------------
}

enum TaxType {
  /// this goes to IRS : biggest chunk : this is calculated in proportion to how much money
  /// generated from US sourced "US wallets"
  /// => can be exempted from this tax if my country has tax treaty with US
  /// ECI INCOME : ordinary income (10-37%)
  /// FDAP INCOME : passive incomes : rent, dividends & interests (30%)
  federalIncome, // -> only for USA generated money

  /// Wyoming : has no state income, Delaware only taxes if I live in Delaware
  stateIncome, //-> go Wyoming

  /// Annual tax - Annual report fees : Wyoming 50$/year : Delaware 300$/year
  /// DELAWARE  : Business name reservation : 75$
  ///           : File Articles of Formation 90$
  ///           : Annual Franchise tax: 300$
  /// WYOMING   : Business name reservation : 50$
  ///           : File Articles of Formation 100$
  ///           : Annual report fees: 50$
  stateFranchise, //-> go Wyoming

  /// Social security tax + Medicare taxes : paid to IRS if employee or member is US Resident
  /// EMPLOYEE TAXES
  /// the employer pays 7.65% & the employee pays 7.65%
  /// [(6.2% social security + 1.45% medicare ) / US employee wage] * 2 = 15.3%
  /// MEMBER TAXES
  /// (15.3% of NET Income self employment taxes) / US board member
  payroll, //-> do not hire american citizens

  /// a tax on each sale for the state where the customer is located,
  /// after reaching the state minimum requirements :
  /// you establish state tax nexus
  stateSales, //-> only for USA generated money

  /// only for LLC selected to be treated as corporation after filing FORM8832 with IRS
  /// then will pay at c-corp tax rate of (21% of total taxable income)
  /// if remaining money transferred to personal accounts, they are subject to personal income
  /// tax rate,
  /// but only then can pay out salaries
  corporateIncome, //-> do not select to be treated as c-corp : stay default

  /// taxes on sales of (fuel, airline tickets, heavy trucks, tobacco ...etc)
  exise, //-> we will never sell those
}
