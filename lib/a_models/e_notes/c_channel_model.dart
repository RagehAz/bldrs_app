
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
    id: 'net.bldrs.app.urgent',
    name: "The Builder's Network",
    description: 'News & Notifications',
    group: 'Notifications',
  );
  // --------------------
  static const ChannelModel bldrsDashboardChannel = ChannelModel(
    id: 'net.bldrs.dashboard.urgent',
    name: "The Builder's Network",
    description: 'News & Notifications',
    group: 'Notifications',
  );
  // -----------------------------------------------------------------------------
}
