import 'dart:math' as math;
// -----------------------------------------------------------------------------
/// remember that dart starts from angle 0 on the right,, rotates clockWise when
/// incrementing the angle degree,, while rotates counter clockwise when decrementing
/// the angle degree.
/// simply, Negative value goes counter ClockWise
double angleByDegree(double degree){
  double radian = degree * ( math.pi / 180 );
  return radian;
}
// -----------------------------------------------------------------------------
