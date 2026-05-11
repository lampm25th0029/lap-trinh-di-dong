import 'package:flutter/material.dart';
import 'package:laptrinhungdung/page_about.dart';
import 'package:laptrinhungdung/page_fruit_admin.dart';
import 'package:laptrinhungdung/page_image_gridview.dart';
import 'package:laptrinhungdung/page_proflie.dart';
import 'package:laptrinhungdung/supabase_app/login.dart';
import 'package:laptrinhungdung/supabase_app/page_fruit_store.dart';
import 'getx/page_getx_counter.dart';

class PageHome extends StatelessWidget {
  const PageHome({super.key});

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
        title: Text("My App"),
      ),
      body: Center(
        child: Column(
          children: [
            _buidButton(context, title: "My Profile", destination: PageMyProfile()),
            _buidButton(context, title: "About", destination: PageAbout()),
            _buidButton(context, title: "GetX_Counter", destination: PageGetxCounter()),
            _buidButton(context, title: "My Canon", destination: PageImageGridview()),
            _buidButton(context, title: "Fruit Store", destination: PageFruitStore()),
            _buidButton(context, title: "Login", destination: PageLogin()),
            _buidButton(context, title: "Fruit Store Admin", destination: PageFruitAdmin()),
          ],
        ),
      ),
    );
  }

  Widget _buidButton(BuildContext context, {required String title, required Widget destination}){
    return SizedBox(
      width: 250,
      child: ElevatedButton(
          onPressed: (){
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) =>
                    destination,)
            );
          },
          child: Text(
              title
          )
      ),
    );
  }
}
