import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/a_models/d_zone/a_zoning/zone_stages.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/a_models/f_flyer/sub/flyer_typer.dart';
import 'package:bldrs/b_views/i_phid_picker/floating_flyer_type_selector/floating_flyer_type_selector.dart';
import 'package:bldrs/b_views/i_phid_picker/phids_picker_screen.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bldrs_bubble_header_vm.dart';
import 'package:bldrs/b_views/z_components/bubbles/b_variants/text_field_bubble/text_field_bubble.dart';
import 'package:bldrs/b_views/z_components/buttons/wide_button.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/c_protocols/flyer_protocols/protocols/a_flyer_protocols.dart';
import 'package:bldrs/c_protocols/user_protocols/user/user_provider.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs/x_dashboard/zz_widgets/dashboard_layout.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:bubbles/bubbles.dart';
import 'package:flutter/material.dart';
import 'package:mapper/mapper.dart';
import 'package:page_transition/page_transition.dart';
import 'package:stringer/stringer.dart';

class HashTagManager extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const HashTagManager({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  _HashTagManagerState createState() => _HashTagManagerState();
/// --------------------------------------------------------------------------
}

class _HashTagManagerState extends State<HashTagManager> {
  // -----------------------------------------------------------------------------
  final TextEditingController _textController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List<String> _hashtags = <String>[];
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
  @override
  void dispose() {
    _loading.dispose();
    super.dispose();
  }
  // --------------------
  void scanHashtags(){

    blog('should scan hashtags');

    final List<String> _foundHashtags = Stringer.findHashtags(
      text: _textController.text,
    );

    setState(() {
      _hashtags = _foundHashtags;
    });

  }
  // --------------------

  String _hashtagValidator(String text){

    final bool _hashHashTag = TextCheck.stringContainsSubString(
      string: text,
      subString: '#',
    );

    if (_hashHashTag == true){
      return null;
    }

    else {
      return 'text should include a Hashtag (#)';
    }

  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return DashBoardLayout(
      loading: _loading,
      listWidgets: <Widget>[

        /// TEXT FIELD
        Form(
          key: _formKey,
          child: BldrsTextFieldBubble(
            formKey: _formKey,
            isFormField: true,
            bubbleHeaderVM: BldrsBubbleHeaderVM.bake(
              headlineVerse: Verse.plain('add Hashtag'),
            ),
            appBarType: AppBarType.non,
            textController: _textController,
            bubbleColor: Colorz.blue125,
            // autoValidate: true,
            validator: _hashtagValidator,
            onTextChanged: (String text){
              scanHashtags();
            },
          ),
        ),

        /// TEXT PREVIEW
        ValueListenableBuilder(
          valueListenable: _textController,
          builder: (_, TextEditingValue value, Widget child){

            return SuperVerse(
              verse: Verse.plain(value.text),
              labelColor: Colorz.black255,
              size: 3,
            );

          },
        ),

        Bubble(
          key: const ValueKey<String>('KeywordsBubble'),
          // bubbleColor: bubbleColor,
          // margins: margins,
          // corners: corners,
          bubbleHeaderVM: BldrsBubbleHeaderVM.bake(
            headlineVerse: Verse.plain('Found hashtags'),
          ),
          columnChildren: <Widget>[

            /// STRINGS
            if (Mapper.checkCanLoopList(_hashtags) == true)
              Wrap(
                children: <Widget>[

                  ...List<Widget>.generate(_hashtags?.length, (int index) {

                    final String _phid = _hashtags[index];

                    return SuperVerse(
                      verse: Verse.plain(_phid),
                      labelColor: Colorz.black255,
                      size: 3,
                    );
                  }),

                ],
              ),


          ],
        ),

        /// SELECT MULTIPLE PHIDS
        WideButton(
          verse: Verse.plain('SELECT MULTIPLE PHIDS'),
          onTap: () async {

            final UserModel _userModel = UsersProvider.proGetMyUserModel(context: context, listen: false);

            final FlyerModel _flyerModel = await FlyerProtocols.fetchFlyer(
              context: context,
              flyerID: _userModel.savedFlyers.all.first,
            );

            const List<String> _selectedPhids = <String>[
              'phid_k_pt_factory',
              'phid_k_pt_clinic',
              'phid_s_view_lagoon',
              'phid_s_view_garden',
              'phid_s_view_hill',
              'phid_s_view_back',
              'phid_s_view_sideStreet',
              'phid_s_view_river',
              'phid_s_view_pool',
              'phid_k_pt_hospital',
              'phid_k_pt_sharedRoom',
            ];

            final List<String> _phids = await Nav.goToNewScreen(
                context: context,
                screen: PhidsPickerScreen(
                  flyerModel: _flyerModel,
                  selectedPhids: _selectedPhids,
                  multipleSelectionMode: true,
                  chainsIDs: FlyerTyper.getChainsIDsPerViewingEvent(
                    context: context,
                    flyerType: FlyerType.property,
                    event: ViewingEvent.homeView,
                  ),
                  onlyUseCityChains: false,
                )
            );

            Stringer.blogStrings(
                strings: _phids,
                invoker: 'just got back baby',
            );

          },
        ),

        /// SELECT SINGLE PHID
        WideButton(
          verse: Verse.plain('SELECT SINGLE PHID'),
          onTap: () async {

            final String phid = await Nav.goToNewScreen(
                context: context,
                screen: PhidsPickerScreen(
                  // selectedPhids: _selectedPhids,
                  // multipleSelectionMode: false,
                  chainsIDs: FlyerTyper.getChainsIDsPerViewingEvent(
                    context: context,
                    flyerType: FlyerType.property,
                    event: ViewingEvent.homeView,
                  ),
                  onlyUseCityChains: false,
                )
            );

            blog('just got back baby: $phid');

            // Stringer.blogStrings(
            //   strings: [phid],
            //   invoker: 'just got back baby',
            // );

          },
        ),

        /// SHOW SEXY LIST
        WideButton(
          verse: Verse.plain('SHOW SEXY LIST'),
          onTap: () async {

            final FlyerType flyerType = await Nav.goToNewScreen(
                context: context,
                pageTransitionType: PageTransitionType.leftToRight,
                screen: const FloatingFlyerTypeSelector(),
            );

            if (flyerType != null){

              final String phid = await Nav.goToNewScreen(
                  context: context,
                  pageTransitionType: PageTransitionType.leftToRight,
                  screen: PhidsPickerScreen(
                    // selectedPhids: _selectedPhids,
                    // multipleSelectionMode: false,
                    chainsIDs: FlyerTyper.getChainsIDsPerViewingEvent(
                      context: context,
                      flyerType: FlyerType.property,
                      event: ViewingEvent.homeView,
                    ),
                    onlyUseCityChains: false,
                  )
              );

              Stringer.blogStrings(
                strings: [phid],
                invoker: 'THE SEXY PHID IS : $phid',
              );

            }



          },
        ),

      ],
    );
    // --------------------
  }
// -----------------------------------------------------------------------------
}
