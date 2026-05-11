import 'package:flutter/material.dart';
import 'package:laptrinhungdung/page_home.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async{
  await Supabase.initialize(
    url: 'https://kfjhmejudzyzwmhrymbr.supabase.co',
    anonKey: 'sb_publishable_TQUHR8VRLKrfVbariprklA_d4FNT0yZ',
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: .fromSeed(seedColor: Colors.blue),
        ),
        home: PageHome()
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int count = 0;
  TextEditingController txtName =
      TextEditingController();
  TextEditingController txtPhone =
      TextEditingController();
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
          backgroundColor: Theme.of(context)
              .colorScheme.inversePrimary,
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: .center,
              children: [
                SizedBox(
                  width: 600, height: 300,
                  child: Image.network("https://maubanhkem.com/wp-content/uploads/2025/10/chi-phien-meme-20.jpg"),
                ),
                Row(
                  children: [
                    Icon(Icons.star, color:
                      Colors.orange,),
                    Icon(Icons.star, color:
                      Colors.orange,),
                    Icon(Icons.star, color:
                      Colors.orange,),
                    Icon(Icons.star, color:
                      Colors.orange,),
                    Icon(Icons.star, color:
                      Colors.orange,),
                    SizedBox(width: 20,),
                    Text("5", style: TextStyle
                      (color: Colors.red),)
                  ],
                ),
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        count++;
                      });
                    },
                    child: Text("+", style: TextStyle(fontSize: 30),)
                ),
                Text("$count"),
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        count--;
                      });
                    },
                    child: Text("-",  style: TextStyle(fontSize: 40),)
                ),
                TextField(
                  controller: txtName,
                  decoration: InputDecoration(
                    labelText: "Tên:",
                    hintText: "Nhập tên của bạn vào đây"
                  ),
                ),
                TextField(
                  controller: txtPhone,
                  decoration: InputDecoration(
                     labelText: "Số điện thoại"
                  ),
                  keyboardType: TextInputType.phone,
                ),
              ],
            ),
          ),
        )
    );
  }
}