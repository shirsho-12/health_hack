import 'dart:developer' as devtools show log;
import 'package:flutter/material.dart';

import '../../../app_ui.dart';

//TODO: IsEnabled has to be improved, is not responsive enough -> needs BLoC

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isEnabled = false;
  bool _isUserNameIconVisible = false;
  bool _isPasswordIconVisible = false;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'HealthHack.',
          style: HHackTextStyle.headline2,
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: IconButton(
              icon: const Icon(Icons.arrow_back, size: 40),
              onPressed: () {
                FocusManager.instance.primaryFocus?.unfocus();
                Navigator.pop(context);
              },
            ),
          ),
          Center(
            child: SizedBox(
              width: width * 0.8,
              height: height * 0.8,
              child: Flex(
                direction: Axis.vertical,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: 'Welcome back!\n',
                      style: HHackTextStyle.headline1.copyWith(
                        color: HHackColors.black,
                        fontSize: 36,
                        fontWeight: FontWeight.w300,
                      ),
                      children: [
                        TextSpan(
                          text: 'Sign in to begin generating',
                          style: HHackTextStyle.overline,
                        ),
                      ],
                    ),
                  ),
                  Text('Login', style: HHackTextStyle.headline1),
                  const SizedBox(height: 20),
                  // const Align(
                  //     alignment: Alignment.centerLeft, child: Text("USERNAME")),
                  Container(
                    decoration: const BoxDecoration(
                      border: Border(bottom: BorderSide()),
                    ),
                    child: TextField(
                      onChanged: ((value) {
                        setState(() {
                          if (_emailController.text.isNotEmpty &&
                              _passwordController.text.isNotEmpty) {
                            _isEnabled = true;
                          } else {
                            _isEnabled = false;
                          }
                          if (_emailController.text.isNotEmpty) {
                            _isUserNameIconVisible = true;
                          } else {
                            _isUserNameIconVisible = false;
                          }
                        });
                      }),
                      controller: _emailController,
                      decoration: InputDecoration(
                        // border: OutlineInputBorder(),
                        border: InputBorder.none,
                        labelText: 'USERNAME',
                        labelStyle: const TextStyle(color: Colors.black),
                        suffixIcon:
                            _isUserNameIconVisible
                                ? IconButton(
                                  icon: const Icon(Icons.close),
                                  color: Colors.black,
                                  onPressed: _emailController.clear,
                                )
                                : null,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // const Align(
                  //     alignment: Alignment.bottomLeft, child: Text("PASSWORD")),
                  Container(
                    decoration: const BoxDecoration(
                      border: Border(bottom: BorderSide()),
                    ),
                    child: TextField(
                      onChanged: ((value) {
                        setState(() {
                          if (_emailController.text.isNotEmpty &&
                              _passwordController.text.isNotEmpty) {
                            _isEnabled = true;
                          } else {
                            _isEnabled = false;
                          }
                          if (_passwordController.text.isNotEmpty) {
                            _isPasswordIconVisible = true;
                          } else {
                            _isPasswordIconVisible = false;
                          }
                        });
                      }),
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        labelText: 'PASSWORD',
                        labelStyle: const TextStyle(color: Colors.black),
                        suffixIcon:
                            _isPasswordIconVisible
                                ? IconButton(
                                  icon: const Icon(Icons.close),
                                  color: Colors.black,
                                  onPressed: _passwordController.clear,
                                )
                                : null,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      if (_isEnabled) {
                        FocusManager.instance.primaryFocus?.unfocus();
                        devtools.log('Login button pressed');
                        // Navigator.of(
                        //   context,
                        // ).pushNamedAndRemoveUntil('/home', (route) => false);
                      }
                    },
                    // style:
                    //     _isEnabled
                    //         ? HHackButtonStyle.enabled
                    //         : HHackButtonStyle.disabled,
                    child: const Text('Login'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
