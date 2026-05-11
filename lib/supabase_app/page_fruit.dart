import 'package:flutter/material.dart';
import 'package:laptrinhungdung/supabase_app/fruit.dart';

class PageFruit extends StatelessWidget {
  const PageFruit({super.key});

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
      ),
      body: SafeArea(
          child: FutureBuilder(
              future: FruitSnapshot.getFruit(),
              builder: (context, snapshot) {
                if(snapshot.hasError){
                  debugPrint("Lỗi đọc dữ liệu ${snapshot.error.toString()}");
                  return Center(
                    child: Text("Lỗi"),
                  );
                }
                if(!snapshot.hasData){
                  return Center(
                    child: Column(
                      mainAxisAlignment: .center,
                      children: [
                        CircularProgressIndicator(),
                        Text("Đang tải......")
                      ],
                    ),
                  );
                }
                var iter = snapshot.data!.values;
                return GridView.extent(
                  maxCrossAxisExtent: 250,
                  childAspectRatio: 0.7,
                  crossAxisSpacing: 5,
                  children: iter.map(
                      (e) {
                        return Column(
                          children: [
                            Image.network(e.anh, fit: .cover,),
                            Text(e.ten),
                            Text("Gia: ${e.gia}"),
                          ],
                        );
                      },
                  ).toList(),
                );
              },
          )
      ),
    );
  }
}

