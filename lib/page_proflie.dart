import 'package:flutter/material.dart';
import 'package:laptrinhungdung/page_about.dart';
import 'package:laptrinhungdung/page_home.dart';

class PageMyProfile extends StatefulWidget {
  const PageMyProfile({super.key});

  @override
  State<PageMyProfile> createState() => _PageMyProfileState();
}

class _PageMyProfileState extends
 State<PageMyProfile> {
  DateTime ngaySinh = DateTime(1997, 1, 1);
  String? gioiTinh = "Nam";
  List<String> nnlts = ["JAVA", "C#", "Python", "TypeScript", "Dart", "C++"];
  String nnlt = "JAVA";
  int index = 0;

  void _goHome() {
    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
      return;
    }
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const PageHome()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          _goHome();
        }
      },
      child: Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: _goHome,
          icon: Icon(Icons.arrow_back),
        ),
        title: Text("My Profile"),
        backgroundColor: Theme.of(context)
            .colorScheme.primary,
      ),
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text("Phan Minh Lãm"),
              accountEmail: Text("MSSV: 25TH0029"),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage
                  ("asset/images/meme.jpg"),
                child: Text("PML", style: TextStyle
                  (color: Colors.white),),
              ),
            ),
          ],
        )
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            crossAxisAlignment: .start,
            children: [
            Center(
              child: SizedBox(
                width: 600, height: 300,
                child: Image.asset
                  ("asset/images/cds.jpg"),
              ),
            ),
            SizedBox(height: 10,),
            Text("Họ tên:",style:
              TextStyle(color: Colors.black,
              fontSize: 18, fontWeight: .bold),),
            Text("Phan Minh Lãm",style:
              TextStyle(color: Colors.blue,
              fontSize: 20, fontWeight: .bold),),
            SizedBox(height: 10,),
            Text("Mã số sinh viên:",style:
              TextStyle(color: Colors.black,
              fontSize: 18, fontWeight: .bold),),
            Text("25TH0029",style:
              TextStyle(color: Colors.blue,
              fontSize: 20, fontWeight: .bold),),
            SizedBox(height: 10,),
            Text("Ngày sinh:",style:
              TextStyle(color: Colors.black,
              fontSize: 18, fontWeight: .bold),),
            Row(
              children: [
                Expanded(
                  child: Text("${ngaySinh.day}/${ngaySinh.month}/${ngaySinh.year}",style: TextStyle(color: Colors.black, fontSize: 20,),),
                ),
                IconButton(
                    onPressed: () async{
                      var ngayChon = await showDatePicker(
                          context: context,
                          firstDate: DateTime(1980),
                          lastDate: DateTime(2090),
                          currentDate: ngaySinh,
                      );
                      if(ngayChon!=null){
                        setState(() {
                          ngaySinh = ngayChon;
                        });
                      }
                    },
                    icon: Icon(Icons
                     .calendar_month)
                ),
                SizedBox(width: 25,)
              ],
            ),
            SizedBox(height: 10,),
            Text("Giới tính:",style:
            TextStyle(color: Colors.black,
                fontSize: 18, fontWeight: .bold),),
            RadioGroup(
                groupValue: gioiTinh,
                onChanged: (value) {
                  setState(() {
                    gioiTinh = value;
                  });
                },
                child: Row(
                  children: [
                    Expanded(
                      child: RadioListTile(
                          value: "Nữ",
                          title: Text("Nữ", style: TextStyle(color: Colors.black, fontSize: 20,),),
                      ),
                    ),
                    Expanded(
                      child: RadioListTile(
                        value: "Nam",
                        title: Text("Nam", style: TextStyle(color: Colors.black, fontSize: 20,),),
                      ),
                    ),
                  ],
                )
            ),
            SizedBox(height: 10,),
            Text("Sở thích"),
            Text("..."),
            SizedBox(height: 10,),
            Text("Ngôn ngữ lập trình yêu thích của bạn"),
              DropdownButton<String>(
                  isExpanded: true,
                  value: nnlt,
                  items: nnlts.map(
                      (e) => DropdownMenuItem<String>(
                        value: e,
                        child: Text(e),
                      ),
                  ).toList(),
                  onChanged: (value) {
                    setState(() {
                      nnlt = value!;
                    });
                  },
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: index,
          onTap: (value){
            setState(() {
              index = value;
            });
            if(index==0){
              _goHome();
            }
            if(index==1){
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => PageAbout(),)
              );
            }
          },
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.home, color: Colors.grey,),
                label: "Trang chủ",
                activeIcon: Icon(Icons.home, color: Colors.blue,),
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.person, color: Colors.grey,),
                label: "Thông tin",
                activeIcon: Icon(Icons.person, color: Colors.orange,),
            ),
          ]
      ),
    ),
    );
  }
}
