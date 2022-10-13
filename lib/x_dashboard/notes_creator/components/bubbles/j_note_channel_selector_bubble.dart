import 'package:bldrs/a_models/e_notes/a_note_model.dart';
import 'package:bldrs/a_models/e_notes/c_channel_model.dart';
import 'package:bldrs/b_views/z_components/animators/widget_fader.dart';
import 'package:flutter/material.dart';

class NoteChannelSelectorBubble extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const NoteChannelSelectorBubble({
    @required this.note,
    // @required this.channel,
    @required this.onSelectChannel,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final NoteModel note;
  // final Channel channel;
  final ValueChanged<ChannelModel> onSelectChannel;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    // final double _bubbleWidth = Bubble.bubbleWidth(context);
    // --------------------
    return WidgetFader(
      fadeType: note.sendFCM == true ? FadeType.stillAtMax : FadeType.stillAtMin,
      min: 0.2,
      absorbPointer: !note.sendFCM,
      // child: ExpandingTile(
      //   width: _bubbleWidth,
      //   isDisabled: !note.sendFCM,
      //   firstHeadline: Verse.plain('Channel'),
      //   secondHeadline: Verse.plain(channel.name),
      //   icon: Iconz.advertise,
      //   iconSizeFactor: 0.4,
      //   margin: const EdgeInsets.only(bottom: 10),
      //   // child: Column(
      //   //   crossAxisAlignment: CrossAxisAlignment.start,
      //     // children: const <Widget>[
      //
      //       // ...List<Widget>.generate(ChannelModel.bldrsChannels.length, (int index) {
      //       //
      //       //   final ChannelModel _channelModel = ChannelModel.bldrsChannels[index];
      //       //   final bool _isSelected = _channelModel.channel == channel;
      //       //
      //       //   return DreamBox(
      //       //     height: 40,
      //       //     margins: const EdgeInsets.only(bottom: 3, left: 10),
      //       //     verse: Verse.plain(_channelModel.name),
      //       //     secondLine: Verse.plain(_channelModel.description),
      //       //     verseScaleFactor: 0.6,
      //       //     verseCentered: false,
      //       //     bubble: false,
      //       //     color: _isSelected == true ? Colorz.yellow255 : Colorz.white20,
      //       //     verseColor: _isSelected == true ? Colorz.black255 : Colorz.white255,
      //       //     secondLineColor: _isSelected == true ? Colorz.black255 : Colorz.white255,
      //       //     onTap: () => onSelectChannel(_channelModel),
      //       //   );
      //       //
      //       // }),
      //
      //     // ],
      //   // ),
      // ),
    );

  }
  /// --------------------------------------------------------------------------
}
