import 'package:ecommerce_app/Screens/sign_up.dart';
import 'package:ecommerce_app/vendors-dashboard/vendor_dashboard.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  // const LoginPage({super.key});
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isNewPasswordVisible = false;
  bool _isLoading = false;
  String _message = '';
  // const LoginPage({super.key});

  Future<void> _attemptLogin() async {
    setState(() {
      _isLoading = true;
      _message = ''; // Clear previous messages
    });

    // Simulate network delay
    await Future.delayed(Duration(seconds: 2));

    // Dummy logic for success or failure

    // setState(() {
    //   _isLoading = false;
    //   if (isSuccess) {
    //     _message = 'Login Successful';

    //     // Navigate to the Dashboard page
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => PersistentBottomNavBar()),
        );
    //   } else {
    //     _message = 'Login Failed. Try again.';
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          margin: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _header(context),
              _inputField(context),
              // _forgotPassword(context),
              _signup(context),
            ],
          ),
        ),
      ),
    );
  }

  _header(context) {
    return const Column(
      children: [
        Text(
          "Welcome",
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
        ),
        Text("Login to access your Vendor account."),
      ],
    );
  }

  _inputField(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          decoration: InputDecoration(
              hintText: "Email",
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide.none),
              fillColor: Colors.purple.withOpacity(0.1),
              filled: true,
              prefixIcon: const Icon(Icons.email)),
          cursorColor: Colors.purple,
        ),
        const SizedBox(height: 10),
        TextFormField(
          obscureText: !_isNewPasswordVisible,
          cursorColor: Colors.purple,
          decoration: InputDecoration(
            hintText: 'Password',
            filled: true,
            fillColor: Colors.purple.withOpacity(0.1),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide.none),
            prefixIcon: Icon(Icons.password),
            suffixIcon: IconButton(
              icon: Icon(
                _isNewPasswordVisible ? Icons.visibility : Icons.visibility_off,
                color: Colors.purple,
              ),
              onPressed: () {
                setState(() {
                  _isNewPasswordVisible = !_isNewPasswordVisible;
                });
              },
            ),
          ),
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: ElevatedButton(
            onPressed: () async {
              await _attemptLogin();
            },
            child: _isLoading
                ? CircularProgressIndicator(color: Colors.white)
                : Text(
                    'Login',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
            style: ElevatedButton.styleFrom(
              shape: const StadiumBorder(),
              padding: const EdgeInsets.symmetric(vertical: 16),
              backgroundColor: Colors.purple,
            ),
          ),
        ),
        SizedBox(height: 20),
        if (_message.isNotEmpty)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              _message,
              style: TextStyle(
                fontSize: 20,
                color:
                    _message == 'Login Successful' ? Colors.green : Colors.red,
                fontWeight: FontWeight.bold,
                fontFamily: 'poppins',
              ),
            ),
          ),
      ],
    );
  }

  // _forgotPassword(context) {
  //   return TextButton(
  //     onPressed: () {},
  //     child: const Text("Forgot password?",
  //       style: TextStyle(color: Colors.purple),
  //     ),
  //   );
  // }

  _signup(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Dont have an account? "),
        TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SignupPage(),
                ),
              );
            },
            child: const Text(
              "Register here",
              style: TextStyle(color: Colors.purple),
            ))
      ],
    );
  }
}
