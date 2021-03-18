import 'package:bldrs/models/stenographs/joint_model.dart';

final List<JointModel> dbJoints = [

  JointModel(jointID: 'conn001', requesterID: 'au01', jointState: JointState.Approved,  responderID: 'au02'),
  JointModel(jointID: 'conn002', requesterID: 'au01', jointState: JointState.Seen,      responderID: 'au03'),
  JointModel(jointID: 'conn003', requesterID: 'au01', jointState: JointState.Approved,  responderID: 'au04'),
  JointModel(jointID: 'conn004', requesterID: 'au01', jointState: JointState.Seen,      responderID: 'au14'),
  JointModel(jointID: 'conn005', requesterID: 'au02', jointState: JointState.Rejected,  responderID: 'au04'),
  JointModel(jointID: 'conn006', requesterID: 'au02', jointState: JointState.Approved,  responderID: 'au08'),
  JointModel(jointID: 'conn007', requesterID: 'au05', jointState: JointState.UnSeen,    responderID: 'au13'),
  JointModel(jointID: 'conn008', requesterID: 'au06', jointState: JointState.Approved,  responderID: 'au01'),
  JointModel(jointID: 'conn009', requesterID: 'au06', jointState: JointState.Seen,      responderID: 'au02'),
  JointModel(jointID: 'conn010', requesterID: 'au07', jointState: JointState.UnSeen,    responderID: 'au06'),

  JointModel(jointID: 'conn011', requesterID: 'au01', jointState: JointState.Approved,  responderID: 'au08'),
  JointModel(jointID: 'conn013', requesterID: 'au01', jointState: JointState.UnSeen,    responderID: 'au09'),
  JointModel(jointID: 'conn014', requesterID: 'au01', jointState: JointState.Approved,  responderID: 'au10'),
  JointModel(jointID: 'conn015', requesterID: 'au02', jointState: JointState.Rejected,  responderID: 'au11'),
  JointModel(jointID: 'conn016', requesterID: 'au02', jointState: JointState.Seen,      responderID: 'au12'),
  JointModel(jointID: 'conn017', requesterID: 'au05', jointState: JointState.Approved,  responderID: 'au11'),
  JointModel(jointID: 'conn018', requesterID: 'au06', jointState: JointState.UnSeen,    responderID: 'au11'),
  JointModel(jointID: 'conn019', requesterID: 'au06', jointState: JointState.Approved,  responderID: 'au11'),
  JointModel(jointID: 'conn020', requesterID: 'au07', jointState: JointState.Approved,  responderID: 'au08'),

  JointModel(jointID: 'conn011', requesterID: 'au01', jointState: JointState.Approved,  responderID: 'au21'),
  JointModel(jointID: 'conn013', requesterID: 'au01', jointState: JointState.UnSeen,    responderID: 'au21'),
  JointModel(jointID: 'conn014', requesterID: 'au01', jointState: JointState.Approved,  responderID: 'au21'),
  JointModel(jointID: 'conn015', requesterID: 'au02', jointState: JointState.Rejected,  responderID: 'au21'),
  JointModel(jointID: 'conn016', requesterID: 'au02', jointState: JointState.Seen,      responderID: 'au21'),
  JointModel(jointID: 'conn017', requesterID: 'au05', jointState: JointState.Approved,  responderID: 'au21'),
  JointModel(jointID: 'conn018', requesterID: 'au06', jointState: JointState.UnSeen,    responderID: 'au21'),
  JointModel(jointID: 'conn019', requesterID: 'au06', jointState: JointState.Approved,  responderID: 'au21'),
  JointModel(jointID: 'conn020', requesterID: 'au07', jointState: JointState.Approved,  responderID: 'au21'),

];
