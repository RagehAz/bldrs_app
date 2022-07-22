import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/counters/bz_counter_model.dart';
import 'package:bldrs/b_views/z_components/bubble/bubble.dart';
import 'package:bldrs/b_views/z_components/texting/stats_line.dart';
import 'package:bldrs/c_protocols/record_protocols.dart';
import 'package:bldrs/d_providers/bzz_provider.dart';
import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:flutter/material.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:bldrs/f_helpers/drafters/timerz.dart' as Timers;

class BzStatsBubble extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const BzStatsBubble({
    this.bzModel,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final BzModel bzModel;

  @override
  State<BzStatsBubble> createState() => _BzStatsBubbleState();
}

class _BzStatsBubbleState extends State<BzStatsBubble> {

  ValueNotifier<BzCounterModel> _bzCounter;
  BzModel _myActiveBzModel;

// -----------------------------------------------------------------------------
  /// --- LOADING
  final ValueNotifier<bool> _loading = ValueNotifier(false); /// tamam disposed
// -----------
  Future<void> _triggerLoading({bool setTo}) async {
    if (mounted == true){
      if (setTo == null){
        _loading.value = !_loading.value;
      }
      else {
        _loading.value = setTo;
      }
      blogLoading(loading: _loading.value, callerName: 'OldLogoScreen',);
    }
  }
// -----------------------------------------------------------------------------
  @override
  void initState() {

    _myActiveBzModel = widget.bzModel ?? BzzProvider.proGetActiveBzModel(
      context: context,
      listen: false,
    );

    _bzCounter = ValueNotifier<BzCounterModel>(null);
    super.initState();
  }
// -----------------------------------------------------------------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit && mounted) {

      _triggerLoading().then((_) async {

        if (mounted == true){

          _bzCounter.value = await RecordProtocols.readBzCounters(
            context: context,
            bzID: _myActiveBzModel.id,
          );

        }

      });

      _isInit = false;
    }
    super.didChangeDependencies();
  }
// -----------------------------------------------------------------------------
  @override
  void dispose() {

    _loading.dispose();
    _bzCounter.dispose();

    super.dispose(); /// tamam
  }
// -----------------------------------------------------------------------------


  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return ValueListenableBuilder(
        valueListenable: _bzCounter,
        builder: (_, BzCounterModel bzCounter, Widget child){

          final BzCounterModel _counter = bzCounter ?? BzCounterModel.createInitialModel(_myActiveBzModel.id);

          return Bubble(
              title: 'Stats',
              columnChildren: <Widget>[

                /// FOLLOWERS
                StatsLine(
                  verse: '${_counter.follows} ${superPhrase(context, 'phid_followers')}',
                  icon: Iconz.follow,
                ),

                /// CALLS
                StatsLine(
                  verse: '${_counter.calls} ${superPhrase(context, 'phid_callsReceived')}',
                  icon: Iconz.comPhone,
                ),

                /// SLIDES & FLYERS
                StatsLine(
                  verse: '${_counter.allSlides} '
                      '${superPhrase(context, 'phid_slidesPublished')} '
                      '${superPhrase(context, 'phid_inn')} '
                      '${_myActiveBzModel.flyersIDs.length} '
                      '${superPhrase(context, 'phid_flyers')}',
                  icon: Iconz.gallery,
                ),

                /// SAVES
                StatsLine(
                  verse: '${_counter.allSaves} ${superPhrase(context, 'phid_totalSaves')}',
                  icon: Iconz.saveOn,
                ),

                /// VIEWS
                StatsLine(
                  verse: '${_counter.allViews} ${superPhrase(context, 'phid_total_flyer_views')}',
                  icon: Iconz.viewsIcon,
                ),

                /// SHARES
                StatsLine(
                  verse: '${_counter.allShares} ${superPhrase(context, 'phid_totalShares')}',
                  icon: Iconz.share,
                ),

                /// BIRTH
                StatsLine(
                  verse: Timers.generateString_in_bldrs_since_month_yyyy(context, _myActiveBzModel.createdAt),
                  icon: Iconz.calendar,
                ),

              ]
          );

        },
    );


  }
}
