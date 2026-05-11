import 'package:get/get.dart';
class ControllerGetX extends GetxController{
  int count = 0;
  int tong = 0;

  void increment(){
    count++;
    tong = tong + count;
    update(["counter", "sum"]);
  }

  void decrement(){
    if (count > 0) {
      tong = tong - count;
      count--;
    }
    update(["counter", "sum"]);
  }
}