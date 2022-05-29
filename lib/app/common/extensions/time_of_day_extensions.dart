import 'package:clinic_v2/app/base/responsive/responsive.dart';

extension TimeOfDayUtils on TimeOfDay {
  bool isAfter(TimeOfDay other) {
    return (other.hour == hour) ? minute > other.minute : hour > other.hour;
  }

  bool isBefore(TimeOfDay other) {
    return (other.hour == hour) ? minute < other.minute : hour < other.hour;
  }
  // List<TimeOfDay> splitIntoTow(){
  //   late TimeOfDay firstTime;
  //   late TimeOfDay secondTime;
  //   if(hour % 2 == 0){
  //     firstTime=TimeOfDay(hour: hour ~/2,minute: )
  //   }
  // }
}
