import 'dart:io';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:image_picker/image_picker.dart';

class Fruit {
  int id, gia;
  String ten, moTa, anh;

  Fruit({
    required this.id,
    required this.gia,
    required this.ten,
    required this.moTa,
    required this.anh,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'gia': gia,
      'ten': ten,
      'moTa': moTa,
      'anh': anh,
    };
  }

  factory Fruit.fromMap(Map<String, dynamic> map) {
    return Fruit(
      id: map['id'] as int,
      gia: map['gia'] as int,
      ten: map['ten'] as String,
      moTa: map['moTa'] as String,
      anh: map['anh'] as String,
    );
  }
}

class FruitSnapshot {
  static Future<Map<int, Fruit>> getFruit() async {
    try {
      final supabase = Supabase.instance.client;
      final data = await supabase
          .from('Fruit')
          .select();
      var iter = data.map(
        (e) => Fruit.fromMap(e),
      );
      return {for (var element in iter) element.id: element};
    } catch (_) {
      var iter = _mockFruit().map(
        (e) => Fruit.fromMap(e),
      );
      return {for (var element in iter) element.id: element};
    }
  }

  static List<Map<String, dynamic>> _mockFruit() {
    return [
      {
        'id': 1,
        'gia': 15000,
        'ten': 'Tao Do',
        'moTa': 'Trai cay mau cho chup man hinh khi offline',
        'anh': 'https://images.unsplash.com/photo-1560806887-1e4cd0b6cbd6',
      },
      {
        'id': 2,
        'gia': 18000,
        'ten': 'Cam Ngot',
        'moTa': 'Du lieu mau thay the Supabase tam thoi',
        'anh': 'https://images.unsplash.com/photo-1547514701-42782101795e',
      },
      {
        'id': 3,
        'gia': 12000,
        'ten': 'Chuoi Chin',
        'moTa': 'Trang thai offline van hien thi du trang',
        'anh': 'https://images.unsplash.com/photo-1603833665858-e61d17a86224',
      },
    ];
  }
  static Future<void> insert(Fruit fruit) async {
    final supabase = Supabase.instance.client;
    await supabase.from("Fruit").insert(fruit.toMap());
  }
  static Future<void> update(Fruit fruit) async {
    final supabase = Supabase.instance.client;
    await supabase.from("Fruit").update(fruit.toMap()).eq("id", fruit.id);
  }
  static Stream<List<Fruit>> getstream() {
    final supabase = Supabase.instance.client;
    var stream = supabase.from('Fruit').stream(primaryKey: ["id"]);
    return stream.map((event) => event.map((e) => Fruit.fromMap(e)).toList(),);
  }
  static Future<String>uploadImage({required XFile image, required String path})async{
    final supabase = Supabase.instance.client;
    await supabase.storage.from('image').upload(
      path,
      File(image.path),
      fileOptions: const FileOptions(cacheControl: '3600', upsert: false),
    );
    final String publicUrl = supabase
        .storage
        .from('image')
        .getPublicUrl(path);
    return publicUrl;
  }
  static Future<String>updateImage({required XFile image, required String path})async{
    final supabase = Supabase.instance.client;
    await supabase.storage.from('image').update(
      path,
      File(image.path),
      fileOptions: const FileOptions(cacheControl: '3600', upsert: false),
    );
    final String publicUrl = supabase
        .storage
        .from('image')
        .getPublicUrl(path);
    return "$publicUrl?ts=${DateTime.now().millisecond}";
  }
}

