import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:laptrinhungdung/supabase_app/fruit.dart';

class PageFruitAdmin extends StatefulWidget {
  const PageFruitAdmin({super.key});

  @override
  State<PageFruitAdmin> createState() => _PageFruitAdminState();
}

class _PageFruitAdminState extends State<PageFruitAdmin> {
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
        title: Text("Fruit Store Admin"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => PageAddFruit(),)
              );
            },
            icon: Icon(Icons.add_circle_outline, size: 40,),
          )
        ],
      ),
      body: SafeArea(
          child: RefreshIndicator(
            onRefresh: () async{
              setState(() {

              });
            },
            child: FutureBuilder<Map<int, Fruit>>(
                future: FruitSnapshot.getFruit(),
                builder: (context, snapshot) {
                  if(snapshot.hasError){
                    debugPrint("Lỗi: ${snapshot.error.toString()}");
                    return Center(child: Text("Lỗi"),);
                  }
                  if (!snapshot.hasData){
                    return Center(
                      child: Column(
                        mainAxisAlignment: .center,
                        children: [
                          CircularProgressIndicator(),
                            Text("Đang tải.....")
                        ],
                      ),
                    );
                  }
                  List<Fruit> list = snapshot.data!.values.toList();
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.separated(
                        itemBuilder: (context, index) {
                          Fruit fruit = list[index];
                          return Slidable(
                            endActionPane: ActionPane(
                              motion: ScrollMotion(),
                              children: [
                                SlidableAction(
                                  flex: 1,
                                  onPressed: (context) {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(builder: (context) => PageUpdateFruit(fruit: fruit),)
                                    );
                                  },
                                  backgroundColor: Color(0xFF0033FF),
                                  foregroundColor: Colors.white,
                                  icon: Icons.edit,
                                  label: 'Update',
                                ),
                                SlidableAction(
                                  onPressed: (context) {

                                  },
                                  backgroundColor: Color(0xFFCF0303),
                                  foregroundColor: Colors.white,
                                  icon: Icons.delete,
                                  label: 'Delete',
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 100, height: 100,
                                  child: Image.network(fruit.anh),
                                ),
                                SizedBox(width: 10,),
                                Column(
                                  crossAxisAlignment: .start,
                                  children: [
                                    Text(fruit.ten),
                                    Text("${fruit.gia} VNĐ"),
                                    Text(fruit.moTa),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                        separatorBuilder: (context, index) => Divider(),
                        itemCount: list.length
                    ),
                  );
                },
            ),
          ),
      ),
    );
  }
}

class PageAddFruit extends StatefulWidget {
  const PageAddFruit({super.key});

  @override
  State<PageAddFruit> createState() => _PageAddFruitState();
}

class _PageAddFruitState extends State<PageAddFruit> {
  XFile? _xFile;
  TextEditingController txtID = TextEditingController();
  TextEditingController txtTen = TextEditingController();
  TextEditingController txtGia = TextEditingController();
  TextEditingController txtMoTa = TextEditingController();
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
        title: Text("Add Fruit"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SafeArea(
          child: SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  crossAxisAlignment: .start,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width*0.9,
                      height: MediaQuery.of(context).size.width*0.9,
                      child: _xFile==null ? Icon(Icons.image, size: 100,) : Image.file(File(_xFile!.path)),
                    ),
                    Row(
                      mainAxisAlignment: .end,
                      children: [
                        ElevatedButton(
                            onPressed: () async{
                              var imagePicker = await ImagePicker().pickImage(source: .gallery);
                              if(imagePicker!=null) {
                                setState(() {
                                  _xFile = imagePicker;
                                });
                              }
                            },
                            child: Text("..."),
                        ),
                      ]
                    ),
                    TextField(
                      controller: txtID,
                      keyboardType: .number,
                      decoration: InputDecoration(
                          labelText: "ID"
                      ),
                    ),
                    TextField(
                      controller: txtTen,
                      decoration: InputDecoration(
                          labelText: "Tên SP"
                      ),
                    ),
                    TextField(
                      controller: txtGia,
                      keyboardType: .number,
                      decoration: InputDecoration(
                       labelText: "Giá"
                      ),
                    ),
                    TextField(
                      controller: txtMoTa,
                      decoration: InputDecoration(
                          labelText: "Mô tả"
                      ),
                    ),
                    Row(
                      mainAxisAlignment: .end,
                      children: [
                        ElevatedButton(
                            onPressed: (){
                              Navigator.of(context).pop();
                            },
                            child: Text("Close"),
                        ),
                        ElevatedButton(
                          onPressed: () async{
                            if(_xFile!=null){
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("Đang lưu ${txtTen.text}..."),
                                      duration: Duration(seconds: 10),
                                  )
                              );
                              String imageURL = await FruitSnapshot.uploadImage(
                                  image: _xFile!,
                                  path: "${txtID.text}.jpg"
                              );
                              Fruit fruit = Fruit(
                                  id: int.parse(txtID.text),
                                  gia: int.parse(txtGia.text),
                                  ten: txtTen.text,
                                  moTa: txtMoTa.text,
                                  anh: imageURL
                              );
                              await FruitSnapshot.insert(fruit);
                              if (!context.mounted) return;
                              ScaffoldMessenger.of(context).clearSnackBars();
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text("Đã thêm ${txtTen.text}"),
                                  )
                              );
                            }
                          },
                          child: Text("Save"),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          )
      ),
    );
  }
}

class PageUpdateFruit extends StatefulWidget {
  const PageUpdateFruit({super.key, required this.fruit});
  final Fruit fruit;
  @override
  State<PageUpdateFruit> createState() => _PageUpdateFruitState();
}

class _PageUpdateFruitState extends State<PageUpdateFruit> {
  XFile? _xFile;
  late Fruit fruit;
  TextEditingController txtID = TextEditingController();
  TextEditingController txtTen = TextEditingController();
  TextEditingController txtGia = TextEditingController();
  TextEditingController txtMoTa = TextEditingController();
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
        title: Text("Update Fruit"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SafeArea(
          child: SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  crossAxisAlignment: .start,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width*0.9,
                      height: MediaQuery.of(context).size.width*0.9,
                      child: _xFile==null ? Image.network(fruit.anh) : Image.file(File(_xFile!.path)),
                    ),
                    Row(
                        mainAxisAlignment: .end,
                        children: [
                          ElevatedButton(
                            onPressed: () async{
                              var imagePicker = await ImagePicker().pickImage(source: .gallery);
                              if(imagePicker!=null) {
                                setState(() {
                                  _xFile = imagePicker;
                                });
                              }
                            },
                            child: Text("..."),
                          ),
                        ]
                    ),
                    TextField(
                      controller: txtID,
                      readOnly: true,
                      keyboardType: .number,
                      decoration: InputDecoration(
                          labelText: "ID"
                      ),
                    ),
                    TextField(
                      controller: txtTen,
                      decoration: InputDecoration(
                          labelText: "Tên SP"
                      ),
                    ),
                    TextField(
                      controller: txtGia,
                      keyboardType: .number,
                      decoration: InputDecoration(
                          labelText: "Giá"
                      ),
                    ),
                    TextField(
                      controller: txtMoTa,
                      decoration: InputDecoration(
                          labelText: "Mô tả"
                      ),
                    ),
                    Row(
                      mainAxisAlignment: .end,
                      children: [
                        ElevatedButton(
                          onPressed: (){
                            Navigator.of(context).pop();
                          },
                          child: Text("Close"),
                        ),
                        ElevatedButton(
                          onPressed: () async{
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Đang cập nhật ${fruit.ten}..."),
                              duration: Duration(seconds: 10),)
                            );
                            if(_xFile!=null){
                              fruit.anh = await FruitSnapshot.updateImage(
                                  image: _xFile!,
                                  path: "${txtID.text}.jpg"
                              );
                            }
                            fruit.ten = txtTen.text;
                            fruit.gia = int.parse(txtGia.text);
                            fruit.moTa = txtMoTa.text;
                            await FruitSnapshot.update(fruit);
                            if (!context.mounted) return;
                            ScaffoldMessenger.of(context).clearSnackBars();
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Đã cập nhật ${fruit.ten}"),)
                            );
                          },
                          child: Text("Cập nhật"),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          )
      ),
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fruit = widget.fruit;
    txtTen.text = fruit.ten;
    txtGia.text = "${fruit.gia}";
    txtMoTa.text = fruit.moTa;
    txtID.text = "${fruit.id}";
  }
}


