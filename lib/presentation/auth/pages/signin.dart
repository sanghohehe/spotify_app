import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:taxi_app/common/widgets/appbar/app_bar.dart';
import 'package:taxi_app/common/widgets/button/basic_app_button.dart';
import 'package:taxi_app/core/configs/assets/app_vectors.dart';
import 'package:taxi_app/data/model/auth/sigin_user_req.dart';
import 'package:taxi_app/domain/usecases/auth/signin.dart';
import 'package:taxi_app/presentation/auth/pages/signup.dart';
import 'package:taxi_app/presentation/home/pages/home.dart';
import 'package:taxi_app/service_locator.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({super.key});

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  bool _isLoading = false;

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  Future<void> _signin() async {
    if (_email.text.isEmpty || _password.text.isEmpty) {
      _showSnackBar("Please fill all fields");
      return;
    }

    setState(() => _isLoading = true);

    var result = await sl<SigninUsecase>().call(
      params: SigninUserReq(
        email: _email.text.trim(),
        password: _password.text.trim(),
      ),
    );

    result.fold(
      (l) {
        _showSnackBar(l);
      },
      (r) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const HomePage()),
          (route) => false,
        );
      },
    );

    setState(() => _isLoading = false);
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  void _goToSignup() {
    Navigator.push(context, MaterialPageRoute(builder: (_) => SignupPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(
        title: SvgPicture.asset(AppVectors.logo, height: 40, width: 40),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
          child: Column(
            children: [
              const Text(
                'Sign In',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
              const SizedBox(height: 40),

              _emailField(),
              const SizedBox(height: 20),

              _passwordField(),
              const SizedBox(height: 30),

              BasicAppButton(
                onPressed: _isLoading ? () {} : _signin,
                title: _isLoading ? "Loading..." : "Sign In",
                height: 60,
              ),

              const SizedBox(height: 30),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Not a member? "),
                  GestureDetector(
                    onTap: _goToSignup,
                    child: const Text(
                      "Register Now",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _emailField() {
    return TextField(
      controller: _email,
      keyboardType: TextInputType.emailAddress,
      decoration: const InputDecoration(hintText: "Enter Email"),
    );
  }

  Widget _passwordField() {
    return TextField(
      controller: _password,
      obscureText: true,
      decoration: const InputDecoration(hintText: "Enter Password"),
    );
  }
}
