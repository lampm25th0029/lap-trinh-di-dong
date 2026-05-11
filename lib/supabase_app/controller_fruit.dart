import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:laptrinhungdung/supabase_app/fruit.dart';
import 'package:laptrinhungdung/supabase_app/gio_hang.dart';

class ControllerFruitStore extends GetxController{
  Map<int, Fruit> mapFruits ={};
  Map<int, GioHangItem> gioHangs = {};
  int get slmh => gioHangs.length;
  int get slChon => gioHangs.values.where((item) => item.chon).length;

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    FruitSnapshot.getFruit()
        .then(
        (value) {
          mapFruits = value;
          update(["fruit"]);
      },
    ).onError((error, stackTrace) {
      debugPrint("Lỗi đọc bằng Fruit: ${error.toString()}");
    },);
  }

  bool themMHvaoGH(Fruit f){
    if(gioHangs[f.id]!=null){
      gioHangs[f.id]!.soLuong += 1;
      return false;
    }
    gioHangs[f.id] = GioHangItem(id: f.id);
    update(["gioHang"]);
    return true;
  }

  int tongTien(){
    int tong =0;
    for(var item in gioHangs.values){
      if(item.chon==true){
        tong += mapFruits[item.id]!.gia * item.soLuong;
      }
    }
    return tong;
  }

  int tongTienGioHang(){
    int tong = 0;
    for(var item in gioHangs.values){
      tong += mapFruits[item.id]!.gia * item.soLuong;
    }
    return tong;
  }

  void chonMatHangGioHang(GioHangItem item){
    item.chon = (!item.chon);
    update(["chiTietGioHang","title"]);
  }

  void chonTatCa(bool chon){
    for (var item in gioHangs.values) {
      item.chon = chon;
    }
    update(["chiTietGioHang","title"]);
  }
  void tangSL(GioHangItem item){
    item.soLuong += 1;
    update(["chiTietGioHang"]);
  }
  void giamSL(GioHangItem item) {
    if (item.soLuong > 0) {
      item.soLuong -= 1;
      update(["chiTietGioHang"]);
    }
  }
  void xoaMatHangGH(GioHangItem item){
    gioHangs.remove(item.id);
    update(["title"]);
    update(["chiTietGioHang","gioHang"]);
  }
}