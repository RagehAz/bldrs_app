
/// => TAMAM
class ChannelModel {
  // -----------------------------------------------------------------------------
  const ChannelModel({
    required this.id,
    required this.name,
    required this.description,
    required this.group,
  });
  // --------------------
  final String id;
  final String name;
  final String description;
  final String group;
  // -----------------------------------------------------------------------------

  /// CONSTANTS

  // --------------------
  static const ChannelModel bldrsChannel = ChannelModel(
    id: 'net.bldrs.app',
    name: "The Builder's Network",
    description: 'News & Notifications',
    group: 'Notifications',
  );
  // --------------------
  static const ChannelModel bldrsDashboardChannel = ChannelModel(
    id: 'net.bldrs.dashboard',
    name: "The Builder's Network",
    description: 'News & Notifications',
    group: 'Notifications',
  );
  // -----------------------------------------------------------------------------
}
