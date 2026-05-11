
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class PageImageGridview extends StatelessWidget {
  const PageImageGridview({super.key});

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
        title: Text("My Canon"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: GridView.extent(
        maxCrossAxisExtent: 250,
        crossAxisSpacing: 1,
        childAspectRatio: 1,
        children: List.generate(
            images.length,
            (index) => GestureDetector(
                onTap: (){
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => PageLargeImage(pos: index,),)
                  );
                },
                child: Image.network(images[index], fit: .cover,)),
        )
      ),
    );
  }
}

class PageLargeImage extends StatelessWidget {
  const PageLargeImage({super.key, required this.pos});
  final int pos;

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
        title: Text("Canon"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SafeArea(child: CarouselSlider.builder(
          itemCount: images.length,
          itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) =>
              Column(
                children: [
                  Expanded(
                    child: SizedBox(
                      width: double.infinity,
                      height: double.infinity,
                      child: Image.network(images[itemIndex], fit: .contain,),
                    ),
                  ),
                  Text("${itemIndex+1}"),
                  SizedBox(height: 100,),
                ],
              ),
          options: CarouselOptions(
            autoPlay: false,
            enlargeCenterPage: true,
            initialPage: pos,
            viewportFraction: 1,
            height: MediaQuery.of(context).size.height
            // viewportFraction: 0.9,
            // aspectRatio: 2.0,
            // initialPage: 2,
          ),
        ),
      ),
    );
  }
}

List<String> images =[
  "https://cdn.vjshop.vn/tin-tuc/danh-gia-canon-eos-r8/danh-gia-canon-r8.jpg","https://cdn.vjshop.vn/tin-tuc/danh-gia-canon-eos-r8/danh-gia-canon-eos-r8-1.jpg","https://giangduydat.vn/upload/May-anh-Canon-EOS-R8%20(11).jpeg","https://genk.mediacdn.vn/139269124445442048/2023/8/22/canon-r8-minh-duc-11-16926895087381223469252-1692709900548-16927099006931455884026.jpg","https://assets.newatlas.com/dims4/default/afa8cc6/2147483647/strip/true/crop/7452x4970+0+0/resize/2880x1921!/format/webp/quality/90/?url=https%3A%2F%2Fnewatlas-brightspot.s3.amazonaws.com%2F74%2F8b%2F5c7bac2043bf88c7bd823747e1f5%2Feos-r8-rf-24-50mm-f4.5-6.jpg","https://giangduydat.vn/upload/May-anh-Canon-EOS-R8%20(6).jpg",
];