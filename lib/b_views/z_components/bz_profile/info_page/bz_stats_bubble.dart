import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/counters/bz_counter_model.dart';
import 'package:bldrs/b_views/z_components/bubble/bubble.dart';
import 'package:bldrs/b_views/z_components/texting/stats_line.dart';
import 'package:bldrs/d_providers/bzz_provider.dart';
import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:bldrs/e_db/real/ops/bz_record_real_ops.dart';
import 'package:bldrs/f_helpers/drafters/timers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:flutter/material.dart';

class BzStatsBubble extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const BzStatsBubble({
    this.bzModel,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final BzModel bzModel;
  /// --------------------------------------------------------------------------
  @override
  State<BzStatsBubble> createState() => _BzStatsBubbleState();
/// --------------------------------------------------------------------------
}

class _BzStatsBubbleState extends State<BzStatsBubble> {
// -----------------------------------------------------------------------------
  ValueNotifier<BzCounterModel> _bzCounter;
  BzModel _bzModel;
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
      blogLoading(loading: _loading.value, callerName: 'OldLogoScreen',);
    }
  }
// -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();

    _bzModel = widget.bzModel ?? BzzProvider.proGetActiveBzModel(
      context: context,
      listen: false,
    );

    _bzCounter = ValueNotifier<BzCounterModel>(null);
  }
// -----------------------------------------------------------------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit && mounted) {

      _triggerLoading().then((_) async {

        final BzCounterModel _counters = await BzRecordRealOps.readBzCounters(
          context: context,
          bzID: _bzModel.id,
        );

        if (mounted == true){
          _bzCounter.value = _counters;
        }

      });

      _isInit = false;
    }
    super.didChangeDependencies();
  }
// -----------------------------------------------------------------------------
  /// TAMAM
  @override
  void dispose() {
    _loading.dispose();
    _bzCounter.dispose();
    super.dispose();
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return ValueListenableBuilder(
        valueListenable: _bzCounter,
        builder: (_, BzCounterModel bzCounter, Widget child){

          final BzCounterModel _counter = bzCounter ?? BzCounterModel.createInitialModel(_bzModel.id);

          return Bubble(
              title: 'Stats',
              columnChildren: <Widget>[

                /// FOLLOWERS
                StatsLine(
                  verse: '${_counter.follows} ${xPhrase(context, 'phid_followers')}',
                  icon: Iconz.follow,
                ),

                /// CALLS
                StatsLine(
                  verse: '${_counter.calls} ${xPhrase(context, 'phid_callsReceived')}',
                  icon: Iconz.comPhone,
                ),

                /// SLIDES & FLYERS
                StatsLine(
                  verse: '${_counter.allSlides} '
                      '${xPhrase(context, 'phid_slidesPublished')} '
                      '${xPhrase(context, 'phid_inn')} '
                      '${_bzModel.flyersIDs.length} '
                      '${xPhrase(context, 'phid_flyers')}',
                  icon: Iconz.gallery,
                ),

                /// SAVES
                StatsLine(
                  verse: '${_counter.allSaves} ${xPhrase(context, 'phid_totalSaves')}',
                  icon: Iconz.saveOn,
                ),

                /// VIEWS
                StatsLine(
                  verse: '${_counter.allViews} ${xPhrase(context, 'phid_total_flyer_views')}',
                  icon: Iconz.viewsIcon,
                ),

                /// SHARES
                StatsLine(
                  verse: '${_counter.allShares} ${xPhrase(context, 'phid_totalShares')}',
                  icon: Iconz.share,
                ),

                /// BIRTH
                StatsLine(
                  verse: Timers.generateString_in_bldrs_since_month_yyyy(context, _bzModel.createdAt),
                  icon: Iconz.calendar,
                ),

              ]
          );

        },
    );


  }
}
