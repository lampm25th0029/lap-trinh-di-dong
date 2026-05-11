# Bao cao bai tap cuoi ky mon Lap trinh thiet bi di dong

## 1) Thong tin chung

- Mon hoc: Lap trinh thiet bi di dong
- De tai: Xay dung ung dung di dong da man hinh voi Flutter
- Sinh vien thuc hien: Phan Minh Lãm
- Ma so sinh vien: 25TH0029
- Hoc ky: (dien theo hoc ky thuc te)
- Giang vien huong dan: Huynh Tuan Anh

## 2) Ly thuyet

### 2.1 Cac nen tang lap trinh di dong

Trong mon hoc, cac nen tang va huong tiep can duoc tim hieu gom:

- Native Android (Java/Kotlin): hieu nang cao, truy cap API he thong day du, nhung phat trien rieng tung nen tang.
- Native iOS (Swift/Objective-C): toi uu cho he sinh thai Apple, nhung can code rieng so voi Android.
- Cross-platform:
	- Flutter: mot codebase cho Android/iOS/Web/Desktop, UI theo kieu declarative, hot reload nhanh.
	- React Native: su dung JavaScript/TypeScript, cau truc component, co kha nang mo rong thong qua native module.

So sanh tong quan:

- Native phu hop bai toan can toi uu sau vao tung he dieu hanh.
- Flutter phu hop bai toan lam ung dung da nen tang nhanh, giao dien dong bo, de mo rong.

### 2.2 Lap trinh di dong voi Flutter

Nhung noi dung cot loi da hoc va ap dung vao bai:

- Cau truc ung dung Flutter:
	- Ham main, runApp.
	- StatelessWidget va StatefulWidget.
- Xay dung giao dien:
	- Widget co ban: Text, Image, Icon, Button, TextField.
	- Layout: Row, Column, Expanded, SizedBox, GridView, ListView.
- Dieu huong:
	- Navigator, MaterialPageRoute.
- Quan ly trang thai:
	- SetState.
	- GetX (GetBuilder, Controller).
- Bat dong bo:
	- async/await, FutureBuilder, xu ly du lieu tu backend.
- Du lieu va backend:
	- Supabase Authentication.
	- CRUD voi bang du lieu Fruit.
	- Upload/Update hinh anh len Supabase Storage.

## 3) Ung dung da cai dat

### 3.1 Tong quan ung dung

Ung dung la bo suu tap cac bai tap thuc hanh theo tung chuong trong mon hoc, gom:

- Trang chu menu tong hop cac bai.
- Nhom bai giao dien co ban.
- Nhom bai state management (GetX).
- Nhom bai backend (Supabase) theo mo hinh cua cua hang trai cay.

### 3.2 Danh sach bai tap/chuc nang da hoan thanh

#### A. Nhom giao dien va dieu huong

- My Profile
	- Hien thi thong tin ca nhan.
	- Chon ngay sinh.
	- Chon gioi tinh.
	- Chon ngon ngu lap trinh yeu thich.
- About
	- Man hinh thong tin.
- My Canon
	- GridView hinh anh.
	- Xem anh lon bang CarouselSlider.

#### B. Nhom state management

- GetX Counter
	- Controller GetX voi increment/decrement.
	- Cap nhat UI theo ID GetBuilder.

#### C. Nhom data/backend (Supabase)

- Fruit Store (xem san pham)
	- Tai danh sach trai cay tu Supabase.
	- Hien thi theo dang luoi.
- Fruit Store (mo rong)
	- Trang chi tiet san pham.
	- Gio hang: them, tang/giam so luong, xoa, tinh tong tien.
- Login + Verify OTP
	- Dang nhap/dang ky email voi Supabase Auth UI.
	- Xac thuc OTP email.
- Fruit Store Admin
	- Them san pham.
	- Sua san pham.
	- Upload/cap nhat anh san pham tren Supabase Storage.

## 4) Ung dung mo rong de dat diem toi da

Nhung noi dung mo rong so voi bai mau co ban:

- Tich hop backend cloud thuc te (Supabase) thay vi du lieu tinh.
- Co luong Authentication + OTP cho nguoi dung.
- Tach nho domain Fruit thanh model, controller, page.
- Co module quan tri (Admin) de thao tac du lieu.
- Gio hang co xu ly nghiep vu co ban (chon san pham, cap nhat so luong, tinh tong).
- Co su dung package thu ba trong he sinh thai Flutter:
	- get
	- supabase_flutter
	- supabase_auth_ui
	- image_picker
	- flutter_slidable
	- flutter_rating_bar
	- carousel_slider
	- badges

## 5) Cong nghe su dung

- Ngon ngu: Dart
- Framework: Flutter
- State management: GetX
- Backend as a Service: Supabase
- IDE: VS Code
- Nen tang da test:
	- Android Emulator (API 35)
	- Windows
	- Chrome

## 6) Cau truc thu muc chinh

- lib/main.dart: diem vao ung dung, khoi tao Supabase
- lib/page_home.dart: menu tong hop bai tap
- lib/page_proflie.dart: bai tap profile
- lib/page_image_gridview.dart: bai tap GridView + Carousel
- lib/getx: bai tap GetX
- lib/supabase_app: bai tap backend (Fruit Store, Login, Admin)

## 7) Huong dan chay du an

### 7.1 Yeu cau moi truong

- Flutter SDK 3.41.x tro len
- Android SDK + Android Emulator
- JDK tu Android Studio (jbr)

### 7.2 Cac buoc chay

1. Cai package:

```bash
flutter pub get
```

2. Kiem tra moi truong:

```bash
flutter doctor -v
```

3. Khoi dong emulator Android.

4. Chay ung dung:

```bash
flutter run -d emulator-5554
```

Hoac chay nhanh tren web/desktop:

```bash
flutter run -d chrome
flutter run -d windows
```

## 8) Minh chung ket qua (khong can push hinh)

Repository nay khong yeu cau kem anh chup man hinh de chay duoc du an.
Neu can nop bao cao co hinh, co the chup va luu anh o may ca nhan hoac dinh kem rieng.

### 8.1 Danh sach man/chuc nang da kiem thu

- Home (menu tong hop)
- My Profile (thong tin ca nhan)
- About
- My Canon (GridView + Carousel)
- GetX Counter
- Fruit Store (danh sach + chi tiet)
- Gio hang (them/xoa/cap nhat so luong)
- Login/Sign up + Verify OTP
- Fruit Admin (them/sua san pham, upload anh len Supabase Storage)

## 9) Danh gia ket qua

- Da ap dung du cac noi dung trong mon:
	- UI co ban
	- Dieu huong
	- State management (GetX)
	- Bat dong bo
	- Data/backend cloud
- Du an da duoc kiem tra analyzer:
	- flutter analyze -> No issues found

## 10) Huong phat trien tiep theo

- Hoan thien giao dien theo chuan responsive va design system.
- Bo sung validate form day du khi them/sua san pham.
- Them phan quyen user/admin ro rang hon.
- Viet test cho mot so luong logic quan trong (controller, service).

## 11) Tai lieu tham khao

- Tai lieu bai giang trong thu muc Bai_Giang:
	- Introduction.pdf
	- Dart.pdf
	- Dart_Async.pdf
	- UI.pdf
	- State_Management.pdf
	- GetX_StateManagement.pdf
	- Data_Backend.pdf
	- Contents_Device.pdf
	- React_Native_From_Flutter.pdf
- Flutter docs: https://docs.flutter.dev
- Dart docs: https://dart.dev
- Supabase docs: https://supabase.com/docs
