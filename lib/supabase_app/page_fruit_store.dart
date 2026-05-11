import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:laptrinhungdung/supabase_app/controller_fruit.dart';
import 'package:badges/badges.dart' as badges;
import 'package:laptrinhungdung/supabase_app/fruit.dart';

class PageFruitStore extends StatelessWidget {
  PageFruitStore({super.key});
  final controller = Get.put(ControllerFruitStore());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Navigator.of(context).canPop()
            ? IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: Icon(Icons.arrow_back),
              )
            : null,
        title: Text("Fruit Store"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          GetBuilder(
            id: "gioHang",
            init: controller,
            builder: (controller) {
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => PageGioHang(),)
                  );
                },
                child: badges.Badge(
                  showBadge: controller.slmh > 0,
                  badgeContent: Text('${controller.slmh}', style: TextStyle(color: Colors.white),),
                  child: Icon(Icons.shopping_cart, color: Colors.blue,size: 35,),
                ),
              );
            },
          ),
          SizedBox(width: 20,)
        ],
      ),
      body: SafeArea(
        child: GetBuilder<ControllerFruitStore>(
          init: controller,
          id: "fruit",
          builder: (controller) {
            return GridView.extent(
              maxCrossAxisExtent: 250,
              childAspectRatio: 0.7,
              crossAxisSpacing: 5,
              children: controller.mapFruits.values.map(
                    (e) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => PageChiTiet(fruit: e),
                        )
                      );
                    },
                    child: Column(
                      children: [
                        Expanded(child: Image.network(e.anh, fit: BoxFit.cover,)),
                        Text(e.ten),
                        Text("Gia: ${e.gia}"),
                      ],
                    ),
                  );
                },
              ).toList(),
            );
          },
        ),
      ),
    );
  }
}

class PageChiTiet extends StatelessWidget {
  const PageChiTiet({super.key, required this.fruit});
  final Fruit fruit;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ControllerFruitStore>();
    return Scaffold(
      appBar: AppBar(
        leading: Navigator.of(context).canPop()
            ? IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: Icon(Icons.arrow_back),
              )
            : null,
        title: Text("Fruit Store"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          GetBuilder<ControllerFruitStore>(
            id: "gioHang",
            init: controller,
            builder: (controller) {
              return badges.Badge(
                showBadge: controller.slmh > 0,
                badgeContent: Text('${controller.slmh}', style: TextStyle(color: Colors.white),),
                child: Icon(Icons.shopping_cart, color: Colors.blue, size: 35,),
              );
            },
          ),
          SizedBox(width: 20,)
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: .start,
              children: [
                Image.network(fruit.anh),
                Text(fruit.ten),
                Text(fruit.moTa),
                Row(
                  children: [
                    Text("${fruit.gia}"),
                    SizedBox(width: 20,),
                    Text("${fruit.gia*1.2}", style: TextStyle(
                      decoration: .lineThrough
                    ),)
                  ],
                ),
                Row(
                  children: [
                    RatingBarIndicator(
                      rating: 3.5,
                      itemBuilder: (context, index) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      itemCount: 5,
                      itemSize: 30.0,
                      direction: Axis.horizontal,
                    ),
                    SizedBox(width: 20,),
                    Text("1000 đánh giá")
                  ],
                )
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.themMHvaoGH(fruit);

        },
        child: Icon(Icons.add_shopping_cart),
      ),
    );
  }
}

class PageGioHang extends StatelessWidget {
  PageGioHang({super.key});
  final controller = Get.put(ControllerFruitStore());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Navigator.of(context).canPop()
            ? IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: Icon(Icons.arrow_back),
              )
            : null,
        title: GetBuilder(
          init: controller,
          id: "title",
          builder: (controller) => Text("Giỏ hàng (${controller.slmh})"),
        ),
      ),
      body: SafeArea(
          child: GetBuilder(
            id: "chiTietGioHang",
            init: controller,
            builder: (controller) {
              var items = controller.gioHangs.values.toList();
              return Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  children: [
                    Expanded(
                        child: ListView.separated(
                            itemBuilder: (context, index){
                              var item = items[index];
                              Fruit fruit = controller.mapFruits[item.id]!;
                              return Slidable(
                                endActionPane: ActionPane(
                                  motion: ScrollMotion(),
                                  children: [
                                    SlidableAction(
                                      //flex: 2,
                                      onPressed: (context){
                                        controller.xoaMatHangGH(item);
                                      },
                                      backgroundColor: Color(0xFFFE4A49),
                                      foregroundColor: Colors.white,
                                      icon: Icons.delete,
                                      label: 'Xóa',
                                    ),
                                  ],
                                ),
                                child: Row(
                                  children: [
                                    Checkbox(
                                        value: item.chon,
                                        onChanged: (value){
                                          controller.chonMatHangGioHang(item);
                                
                                        },
                                    ),
                                    SizedBox(width: 80,
                                      child: Image.network(fruit.anh),
                                    ),
                                    SizedBox(width: 8,),
                                    Column(
                                      crossAxisAlignment: .start,
                                      children: [
                                        Text(fruit.ten),
                                        Row(
                                          mainAxisAlignment: .end,
                                          children: [
                                            Text("${fruit.gia * item.soLuong}"),
                                            TextButton(
                                                onPressed: (){
                                                  controller.giamSL(item);
                                
                                                },
                                                child: Text("-")
                                            ),
                                            Text("${item.soLuong}"),
                                            TextButton(
                                                onPressed: (){
                                                  controller.tangSL(item);
                                
                                                },
                                                child: Text("+")
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                            separatorBuilder: (context, index) => Divider(),
                            itemCount: controller.slmh),
                    ),
                    Divider(),
                    Row(
                      children: [
                        Checkbox(
                          value: controller.slmh > 0 && controller.slChon == controller.slmh,
                          onChanged: (value) {
                            controller.chonTatCa(value ?? false);
                          },
                        ),
                        Text("Chọn tất cả"),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: Text("Tổng tiền:",style: TextStyle(fontSize: 20),),
                        ),
                        Text("${controller.tongTien()} VNĐ", style: TextStyle(fontSize: 20, color: Colors.red),),
                      ],
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "Tổng giỏ hàng: ${controller.tongTienGioHang()} VNĐ",
                        style: TextStyle(fontSize: 14, color: Colors.black54),
                      ),
                    ),
                    SizedBox(height: 8),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: controller.slmh == 0
                            ? null
                            : () {
                                final tienThanhToan = controller.slChon > 0
                                    ? controller.tongTien()
                                    : controller.tongTienGioHang();
                                final soMonThanhToan = controller.slChon > 0
                                    ? controller.slChon
                                    : controller.slmh;
                                showDialog(
                                  context: context,
                                  builder: (dialogContext) => AlertDialog(
                                    title: Text("Xác nhận mua hàng"),
                                    content: Text(
                                      "Bạn xác nhận mua $soMonThanhToan mặt hàng với tổng tiền $tienThanhToan VNĐ?",
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.pop(dialogContext),
                                        child: Text("Hủy"),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.pop(dialogContext);
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(
                                              content: Text("Đã xác nhận đơn hàng (demo)."),
                                            ),
                                          );
                                        },
                                        child: Text("Xác nhận"),
                                      ),
                                    ],
                                  ),
                                );
                              },
                        child: Text("Xác nhận mua hàng"),
                      ),
                    )
                  ],
                ),
              );
            },
          )
      ),
    );
  }
}

