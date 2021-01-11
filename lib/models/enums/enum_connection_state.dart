enum ConnectionState {
  Approved,
  Rejected,
  Seen,
  UnSeen,
}
// x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x
ConnectionState decipherConnectionState (int x){
  switch (x){
    case 1:   return  ConnectionState.Approved;   break;
    case 2:   return  ConnectionState.Rejected;   break;
    case 3:   return  ConnectionState.Seen;       break;
    case 4:   return  ConnectionState.UnSeen;     break;
    default : return   null;
  }
}
// x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x
int cipherConnectionState (ConnectionState x){
  switch (x){
    case ConnectionState.Approved:    return  1;  break;
    case ConnectionState.Rejected:    return  2;  break;
    case ConnectionState.Seen    :    return  3;  break;
    case ConnectionState.UnSeen  :    return  4;  break;
    default : return null;
  }
}
// x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x
