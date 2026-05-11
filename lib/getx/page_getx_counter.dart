import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'getx_controller.dart';

class PageGetxCounter extends StatelessWidget {
  PageGetxCounter({super.key});
  final controller = Get.put(ControllerGetX());

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
        title: Text("GetX Counter"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "So dem hien tai",
                style: TextStyle(fontSize: 18, color: Colors.black54),
              ),
              SizedBox(height: 8),
              GetBuilder<ControllerGetX>(
                id: "counter",
                init: controller,
                builder: (controller) => Text(
                  "${controller.count}",
                  style: TextStyle(fontSize: 56, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 70,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        controller.decrement();
                      },
                      child: Text("-", style: TextStyle(fontSize: 28)),
                    ),
                  ),
                  SizedBox(width: 16),
                  SizedBox(
                    width: 70,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        controller.increment();
                      },
                      child: Text("+", style: TextStyle(fontSize: 28)),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text(
                "Tong cong don",
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
              SizedBox(height: 6),
              GetBuilder<ControllerGetX>(
                id: "sum",
                init: controller,
                builder: (controller) => Text(
                  "${controller.tong}",
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
