import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:laptrinhungdung/supabase_app/page_fruit_store.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class PageLogin extends StatefulWidget {
  const PageLogin({super.key});

  @override
  State<PageLogin> createState() => _PageLoginState();
}

class _PageLoginState extends State<PageLogin> {
  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _passwordCtrl = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  Future<void> _signIn(BuildContext context) async {
    final email = _emailCtrl.text.trim().toLowerCase();
    final password = _passwordCtrl.text;

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Vui long nhap day du email va mat khau')),
      );
      return;
    }

    try {
      setState(() {
        _isLoading = true;
      });

      final supabase = Supabase.instance.client;
      final response = await supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );

      if (!context.mounted) return;
      if (response.user != null && response.session != null) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => PageFruitStore()),
          (route) => false,
        );
      }
    } on AuthException catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message)),
      );
    } catch (_) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Dang nhap that bai, vui long thu lai')),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _goToSignUp(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const PageSignUp()),
    );
  }

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
        title: const Text('Dang nhap'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailCtrl,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _passwordCtrl,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Mat khau'),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isLoading ? null : () => _signIn(context),
                child: Text(_isLoading ? 'Dang xu ly...' : 'Sign In'),
              ),
            ),
            TextButton(
              onPressed: _isLoading ? null : () => _goToSignUp(context),
              child: const Text('Chua co tai khoan? Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
}

class PageSignUp extends StatefulWidget {
  const PageSignUp({super.key});

  @override
  State<PageSignUp> createState() => _PageSignUpState();
}

class _PageSignUpState extends State<PageSignUp> {
  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _passwordCtrl = TextEditingController();
  final TextEditingController _confirmCtrl = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    _confirmCtrl.dispose();
    super.dispose();
  }

  Future<void> _signUp(BuildContext context) async {
    final email = _emailCtrl.text.trim().toLowerCase();
    final password = _passwordCtrl.text;
    final confirm = _confirmCtrl.text;

    if (email.isEmpty || password.isEmpty || confirm.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Vui long nhap day du thong tin')),
      );
      return;
    }

    if (password != confirm) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Mat khau xac nhan khong khop')),
      );
      return;
    }

    try {
      setState(() {
        _isLoading = true;
      });

      final supabase = Supabase.instance.client;
      final response = await supabase.auth.signUp(
        email: email,
        password: password,
      );

      if (!context.mounted) return;
      if (response.user != null) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => PageVerifyOTP(email: email),
          ),
        );
      }
    } on AuthException catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message)),
      );
    } catch (_) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Dang ky that bai, vui long thu lai')),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

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
        title: const Text('Dang ky'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            TextField(
              controller: _emailCtrl,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _passwordCtrl,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Mat khau'),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _confirmCtrl,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Xac nhan mat khau'),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isLoading ? null : () => _signUp(context),
                child: Text(_isLoading ? 'Dang xu ly...' : 'Sign Up'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PageVerifyOTP extends StatelessWidget {
  const PageVerifyOTP({super.key, required this.email});
  final String email;

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
        title: const Text('Xac thuc ma OTP'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: OtpTextField(
                numberOfFields: 6,
                borderColor: Colors.black,
                showFieldAsBox: true,
                borderWidth: 4.0,
                fieldWidth: 45,
                textStyle: const TextStyle(fontSize: 18),
                clearText: true,
                onCodeChanged: (String code) {},
                onSubmit: (String verificationCode) async {
                  final supabase = Supabase.instance.client;
                  final AuthResponse response = await supabase.auth.verifyOTP(
                    type: OtpType.email,
                    token: verificationCode,
                    email: email,
                  );
                  if (!context.mounted) return;
                  if (response.user != null && response.session != null) {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => PageFruitStore()),
                      (route) => false,
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
