import 'package:bldrs/models/enums/enum_connection_state.dart';
import 'package:bldrs/models/old_models_to_delete_when_done/connection_model.dart';

final List<ConnectionModel> dbConnections = [

  ConnectionModel(connectionID: 'conn001', requesterID: 'au01', connectionState: ConnectionState.Approved,  responderID: 'au02'),
  ConnectionModel(connectionID: 'conn002', requesterID: 'au01', connectionState: ConnectionState.Seen,      responderID: 'au03'),
  ConnectionModel(connectionID: 'conn003', requesterID: 'au01', connectionState: ConnectionState.Approved,  responderID: 'au04'),
  ConnectionModel(connectionID: 'conn004', requesterID: 'au01', connectionState: ConnectionState.Seen,      responderID: 'au14'),
  ConnectionModel(connectionID: 'conn005', requesterID: 'au02', connectionState: ConnectionState.Rejected,  responderID: 'au04'),
  ConnectionModel(connectionID: 'conn006', requesterID: 'au02', connectionState: ConnectionState.Approved,  responderID: 'au08'),
  ConnectionModel(connectionID: 'conn007', requesterID: 'au05', connectionState: ConnectionState.UnSeen,    responderID: 'au13'),
  ConnectionModel(connectionID: 'conn008', requesterID: 'au06', connectionState: ConnectionState.Approved,  responderID: 'au01'),
  ConnectionModel(connectionID: 'conn009', requesterID: 'au06', connectionState: ConnectionState.Seen,      responderID: 'au02'),
  ConnectionModel(connectionID: 'conn010', requesterID: 'au07', connectionState: ConnectionState.UnSeen,    responderID: 'au06'),

  ConnectionModel(connectionID: 'conn011', requesterID: 'au01', connectionState: ConnectionState.Approved,  responderID: 'au08'),
  ConnectionModel(connectionID: 'conn013', requesterID: 'au01', connectionState: ConnectionState.UnSeen,    responderID: 'au09'),
  ConnectionModel(connectionID: 'conn014', requesterID: 'au01', connectionState: ConnectionState.Approved,  responderID: 'au10'),
  ConnectionModel(connectionID: 'conn015', requesterID: 'au02', connectionState: ConnectionState.Rejected,  responderID: 'au11'),
  ConnectionModel(connectionID: 'conn016', requesterID: 'au02', connectionState: ConnectionState.Seen,      responderID: 'au12'),
  ConnectionModel(connectionID: 'conn017', requesterID: 'au05', connectionState: ConnectionState.Approved,  responderID: 'au11'),
  ConnectionModel(connectionID: 'conn018', requesterID: 'au06', connectionState: ConnectionState.UnSeen,    responderID: 'au11'),
  ConnectionModel(connectionID: 'conn019', requesterID: 'au06', connectionState: ConnectionState.Approved,  responderID: 'au11'),
  ConnectionModel(connectionID: 'conn020', requesterID: 'au07', connectionState: ConnectionState.Approved,  responderID: 'au08'),

  ConnectionModel(connectionID: 'conn011', requesterID: 'au01', connectionState: ConnectionState.Approved,  responderID: 'au21'),
  ConnectionModel(connectionID: 'conn013', requesterID: 'au01', connectionState: ConnectionState.UnSeen,    responderID: 'au21'),
  ConnectionModel(connectionID: 'conn014', requesterID: 'au01', connectionState: ConnectionState.Approved,  responderID: 'au21'),
  ConnectionModel(connectionID: 'conn015', requesterID: 'au02', connectionState: ConnectionState.Rejected,  responderID: 'au21'),
  ConnectionModel(connectionID: 'conn016', requesterID: 'au02', connectionState: ConnectionState.Seen,      responderID: 'au21'),
  ConnectionModel(connectionID: 'conn017', requesterID: 'au05', connectionState: ConnectionState.Approved,  responderID: 'au21'),
  ConnectionModel(connectionID: 'conn018', requesterID: 'au06', connectionState: ConnectionState.UnSeen,    responderID: 'au21'),
  ConnectionModel(connectionID: 'conn019', requesterID: 'au06', connectionState: ConnectionState.Approved,  responderID: 'au21'),
  ConnectionModel(connectionID: 'conn020', requesterID: 'au07', connectionState: ConnectionState.Approved,  responderID: 'au21'),

];
