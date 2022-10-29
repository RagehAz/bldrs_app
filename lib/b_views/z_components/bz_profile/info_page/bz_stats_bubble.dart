import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/g_counters/bz_counter_model.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bubble.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bubble_header.dart';
import 'package:bldrs/b_views/z_components/texting/customs/stats_line.dart';
import 'package:bldrs/d_providers/bzz_provider.dart';
import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:bldrs/e_back_end/x_ops/real_ops/bz_record_real_ops.dart';
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
  final ValueNotifier<BzCounterModel> _bzCounter = ValueNotifier<BzCounterModel>(null);
  BzModel _bzModel;
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

    _bzModel = widget.bzModel ?? BzzProvider.proGetActiveBzModel(
      context: context,
      listen: false,
    );

  }
  // --------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit && mounted) {

      _triggerLoading(setTo: true).then((_) async {

        final BzCounterModel _counters = await BzRecordRealOps.readBzCounters(
          bzID: _bzModel.id,
        );

        setNotifier(
            notifier: _bzCounter,
            mounted: mounted,
            value: _counters,
        );

        await _triggerLoading(setTo: false);
      });

      _isInit = false;
    }
    super.didChangeDependencies();
  }
  // --------------------
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

          final BzCounterModel _counter = bzCounter ?? BzCounterModel.createInitialModel(_bzModel?.id);

          return Bubble(
            headerViewModel: const BubbleHeaderVM(
              headlineVerse: Verse(
                text: 'phid_stats',
                translate: true,
              ),
            ),
              columnChildren: <Widget>[

                /// FOLLOWERS
                StatsLine(
                  verse: Verse(
                    text: '${_counter.follows} ${xPhrase( context, 'phid_followers')}',
                    translate: false,
                  ),
                  icon: Iconz.follow,
                ),

                /// CALLS
                StatsLine(
                  verse: Verse(
                    text: '${_counter.calls} ${xPhrase( context, 'phid_callsReceived')}',
                    translate: false,
                  ),
                  icon: Iconz.comPhone,
                ),

                /// SLIDES & FLYERS
                StatsLine(
                  verse: Verse(
                    text: '${_counter.allSlides} '
                        '${xPhrase( context, 'phid_slidesPublished')} '
                        '${xPhrase( context, 'phid_inn')} '
                        '${_bzModel?.flyersIDs?.length} '
                        '${xPhrase( context, 'phid_flyers')}',
                    translate: false,
                    variables: [_counter.allSlides, _bzModel?.flyersIDs?.length]
                  ),
                  icon: Iconz.gallery,
                ),

                /// SAVES
                StatsLine(
                  verse: Verse(
                    text:  '${_counter.allSaves} ${xPhrase( context, 'phid_totalSaves')}',
                    translate: false,
                  ),
                  icon: Iconz.saveOn,
                ),

                /// VIEWS
                StatsLine(
                  verse: Verse(
                    text: '${_counter.allViews} ${xPhrase( context, 'phid_total_flyer_views')}',
                    translate: false,
                  ),
                  icon: Iconz.viewsIcon,
                ),

                /// SHARES
                StatsLine(
                  verse: Verse(
                    text: '${_counter.allShares} ${xPhrase( context, 'phid_totalShares')}',
                    translate: false,
                  ),
                  icon: Iconz.share,
                ),

                /// BIRTH
                StatsLine(
                  verse: Verse(
                    text: Timers.generateString_in_bldrs_since_month_yyyy(context, _bzModel?.createdAt),
                    translate: false,
                  ),
                  icon: Iconz.calendar,
                ),

              ]
          );

        },
    );


  }
  // -----------------------------------------------------------------------------
}
