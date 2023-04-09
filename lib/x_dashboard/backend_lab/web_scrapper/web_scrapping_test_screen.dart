import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:bldrs/a_models/x_utilities/dimensions_model.dart';
import 'package:bldrs/b_views/j_flyer/b_slide_full_screen/a_slide_full_screen.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bldrs_bubble_header_vm.dart';
import 'package:bldrs/b_views/z_components/bubbles/b_variants/text_field_bubble/text_field_bubble.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/f_helpers/drafters/formers.dart';
import 'package:layouts/layouts.dart';
import 'package:bldrs/x_dashboard/zz_widgets/dashboard_layout.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:filers/filers.dart';
import 'package:flutter/material.dart';
import 'package:html/parser.dart' as html;
import 'package:mapper/mapper.dart';
import 'package:scale/scale.dart';
import 'package:stringer/stringer.dart';
import 'package:super_image/super_image.dart';

class WebScrappingTestScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const WebScrappingTestScreen({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  _WebScrappingTestScreenState createState() => _WebScrappingTestScreenState();
  /// --------------------------------------------------------------------------
}

class _WebScrappingTestScreenState extends State<WebScrappingTestScreen> {
  // -----------------------------------------------------------------------------
  Website _website;
  final TextEditingController _controller  = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
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
    _controller.dispose();
    super.dispose();
  }
  // -----------------------------------------------------------------------------
  /*
  Future<Map<String, dynamic>> getWebsiteDataOld(String url) async {

  final client = HttpClient();
  final request = await client.getUrl(Uri.parse(url));
  final response = await request.close();
  final contents = await response.transform(utf8.decoder).join();

  final document = html.parse(contents);
  final title = document.head.querySelector('title').text;
  final descriptionX = document.head.querySelector('meta[name="description"]');
  final description = descriptionX == null ? '' : descriptionX.attributes['content'];
  final content = document.body.text;
  final imageUrls = document.body.querySelectorAll('img').map((img) => img.attributes['src']).toList();
  final textParagraphs = document.body.querySelectorAll('p').map((p) => p.text).toList();

  return {
    'url': url,
    'title': title,
    'description': description,
    'content': content,
    'imageUrls': Website.cleanURLS(imageUrls),
    'textParagraphs': textParagraphs,
  };

}

   */
  // -----------------------------------------------------------------------------
Future<Map<String, dynamic>> getWebsiteData(String url) async {
  final client = HttpClient();
  final request = await client.getUrl(Uri.parse(url));
  final response = await request.close();
  final contents = await response.transform(utf8.decoder).join();

  final document = html.parse(contents);
  blog('### --- ### >');
  blog(contents);
  blog('### --- ### >');
  final title = document.head.querySelector('title').text;
  final descriptionX = document.head.querySelector('meta[name="description"]');
  final description = descriptionX == null ? '' : descriptionX.attributes['content'];
  final content = document.body.text;
  final imageUrls = <String>[];
  document.body.querySelectorAll('img').forEach((img) {
    final src = img.attributes['src'];
    if (src != null) {
      imageUrls.add(src);
    }
  });
  document.body.querySelectorAll('style').forEach((style) {
    final matches = RegExp(r'url\(([^)]+)\)').allMatches(style.text);
    for (final match in matches) {
      final src = match.group(1);
      imageUrls.add(src);
    }
  });
  final textParagraphs = document.body.querySelectorAll('p').map((p) => p.text).toList();

  return {
    'url': url,
    'title': title,
    'description': description,
    'content': content,
    'imageUrls': Website.cleanURLS(imageUrls),
    'textParagraphs': textParagraphs,
  };
}  // --------------------
  ///
  Future<void> scrapURL(String url) async {

    final bool _canGo = Formers.validateForm(_formKey);

    blog('canGO : $_canGo');

    if (_canGo == true) {
      final Map<String, dynamic> data = await getWebsiteData(url);

      setState(() {
        _website = Website.decipher(data);
      });
    }
  }
  // --------------------
  ///
  Future<void> _onPaste() async {
    final String _text = await TextClipBoard.paste();
    _controller.text = _text;
  }
  // --------------------
  ///
  List<String> getUrlsFromSite(String url) {
  final urls = <String>[];

  HttpClient().getUrl(Uri.parse(url))
    .then((HttpClientRequest request) => request.close())
    .then((HttpClientResponse response) {
      response.transform(utf8.decoder).join().then((body) {
        final document = html.parse(body);
        final elements = document.querySelectorAll('a[href]');
        for (final element in elements) {
          urls.add(element.attributes['href']);
        }
      });
    });

  return urls;
}
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return DashBoardLayout(
      loading: _loading,
      listWidgets: <Widget>[

        Form(
          key: _formKey,
          child: BldrsTextFieldBubble(
            formKey: _formKey,
            bubbleHeaderVM: BldrsBubbleHeaderVM.bake(
              headlineVerse: Verse.plain('Website URL'),
            ),
            appBarType: AppBarType.non,
            textController: _controller,
            pasteFunction: _onPaste,
            keyboardTextInputType: TextInputType.url,
            keyboardTextInputAction: TextInputAction.go,
            // autoValidate: true,
            isFormField: true,
            validator: (String text) => Formers.webSiteValidator(
                context: context,
                website: text,
            ),
            onSubmitted: scrapURL,
            columnChildren: <Widget>[

              BldrsBox(
                height: 50,
                icon: Iconz.search,
                iconSizeFactor: 0.7,
                verse: Verse.plain('Search'),
                onTap: () => scrapURL(_controller.text),
              ),

            ],
          ),
        ),

        if (_website != null)
          BldrsBox(
            height: 50,
            verse: Verse.plain('get lnks'),
            onTap: () async {

              final List<String> _urls = getUrlsFromSite(_website.url);
              Stringer.blogStrings(strings: _urls, invoker: 'urls from website');

            },
          ),

        /// TITLE
        if (_website != null)
          BldrsText(
              verse: Verse.plain(_website.title),
            maxLines: 1000,
          ),

        if (Mapper.checkCanLoopList(_website?.imageUrls) == true)
        URLImagesGrid(
          urls: _website?.imageUrls,
        ),

        if (Mapper.checkCanLoopList(_website?.textParagraphs) == true)
        ...List.generate(_website.textParagraphs.length, (index){

          final String _paragraph = _website.textParagraphs[index];

          return BldrsText(
            verse: Verse.plain(_paragraph),
            labelColor: Colorz.black125,
            maxLines: 10,
            centered: false,
          );

        }),

      ],
    );
    // --------------------
  }
  // -----------------------------------------------------------------------------
}

@immutable
class Website {
  // -----------------------------------------------------------------------------
  const Website({
    @required this.url,
    @required this.title,
    @required this.description,
    @required this.content,
    @required this.imageUrls,
    @required this.textParagraphs,
  });
  // -----------------------------------------------------------------------------
  final String url;
  final String title;
  final String description;
  final String content;
  final List<String> imageUrls;
  final List<String> textParagraphs;
  // -----------------------------------------------------------------------------

  /// CIPHERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static Website decipher(Map<String, dynamic> data) {

    if (data == null) {
      return null;
    }

    else {
      return Website(
        url: data['url'],
        title: data['title'],
        description: data['description'],
        content: data['content'],
        imageUrls: data['imageUrls'],
        textParagraphs: data['textParagraphs'],
      );
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<String> cleanURLS(List<String> urls){
    final List<String> _output = <String>[];

    if (Mapper.checkCanLoopList(urls) == true){

      for (final String url in urls){

        final bool _isURL = ObjectCheck.isAbsoluteURL(url);

        if (_isURL == true){
          _output.add(url.trim());
        }

      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// EQUALITY

  // --------------------
  /// TESTED : WORKS PERFECT
  static bool websitesAreIdentical({
    @required Website website1,
    @required Website website2,
  }){
    bool _identical = false;

    if (website1 == null && website2 == null){
      _identical = true;
    }

    else if (website1 != null && website2 != null){

      if (
          website1.url == website2.url &&
          website1.title == website2.title &&
          website1.description == website2.description &&
          website1.content == website2.content &&
          Mapper.checkListsAreIdentical(list1: website1.imageUrls, list2: website2.imageUrls) == true &&
          Mapper.checkListsAreIdentical(list1: website1.textParagraphs, list2: website2.textParagraphs) == true
      ){
        _identical = true;
      }

    }

    return _identical;
  }
  // -----------------------------------------------------------------------------

  /// OVERRIDES

  // --------------------
  /*
   @override
   String toString() => 'MapModel(key: $key, value: ${value.toString()})';
   */
  // --------------------
  @override
  bool operator == (Object other){

    if (identical(this, other)) {
      return true;
    }

    bool _areIdentical = false;
    if (other is Website){
      _areIdentical = websitesAreIdentical(
        website1: this,
        website2: other,
      );
    }

    return _areIdentical;
  }
  // --------------------
  @override
  int get hashCode =>
      url.hashCode^
      title.hashCode^
      description.hashCode^
      content.hashCode^
      imageUrls.hashCode^
      textParagraphs.hashCode;
  // -----------------------------------------------------------------------------
}

class URLImagesGrid extends StatelessWidget {
  // -----------------------------------------------------------------------------
  const URLImagesGrid({
    @required this.urls,
    Key key
  }) : super(key: key);
  // -----------------------------------------------------------------------------
  final List<String> urls;
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: urls.length,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        padding: const EdgeInsets.all(10),
        itemBuilder: (BuildContext context, int index) {

          final String url = urls[index];

          return FutureBuilder(
            future: Dimensions.superDimensions(url),
            builder: (BuildContext context, AsyncSnapshot<Dimensions> snapshot) {

              final double _height = Scale.getUniformRowItemWidth(
                context: context,
                numberOfItems: 3,
                boxWidth: Scale.screenWidth(context),
                // spacing: 10,
              );

              final Dimensions _dims = snapshot.data ?? Dimensions(width: _height, height: _height);

              final double _width = Dimensions.concludeWidthByDimensions(
                height: _height,
                graphicWidth: _dims.width,
                graphicHeight: _dims.height,
              );

              return GestureDetector(
                onTap: () => Nav.goToNewScreen(
                  context: context,
                  screen: SlideFullScreen(
                    image: url.trim(),
                    imageSize: _dims,
                    filter: null,
                    title: Verse.plain('Image'),
                  ),
                ),
                child: SuperImage(
                  width: _width,
                  height: _height,
                  pic: url.trim(),
                  corners: Borderers.constantCornersAll10,
                  backgroundColor: Colorz.white20,
                  // package: Iconz.bldrsTheme,
                ),
              );
            },
          );

        });

  }
  // -----------------------------------------------------------------------------
}
