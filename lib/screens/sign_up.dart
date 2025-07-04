import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/resources/auth_methods.dart';
import 'package:instagram_clone/responsiveness/mobile_screen_layout.dart';
import 'package:instagram_clone/responsiveness/responsive_layout_scree.dart';
import 'package:instagram_clone/responsiveness/web_screen_layout.dart';
import 'package:instagram_clone/screens/login_screen.dart';
import 'package:instagram_clone/utils/Colors.dart';
import 'package:instagram_clone/utils/utils.dart';
import 'package:instagram_clone/widgets/text_field_input.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _usernController = TextEditingController();
  Uint8List? _image;
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passController.dispose();
    _usernController.dispose();
  }

  void selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    print("📸 Image picked: ${im.length} bytes");

    setState(() {
      _image = im;
    });
  }

  void signUpUser() async {
    setState(() {
      _isLoading = true;
    });

    String res = await AuthMethods().signUpUser(
      email: _emailController.text,
      password: _passController.text,
      username: _usernController.text,
      file: _image!,
    );

    if(res != 'Success'){
      showSnackbar(res, context); 
    } else {
      Navigator.of(context).push (
        MaterialPageRoute(
          builder: (context) => const ResponsiveLayoutScree(
            mobileScreenLayout : MobileScreenLayout(),
            webScreenLayout : WebScreenLayout()
          )
        )
      );
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 18),
          width: double.infinity,
          child: Column(
            children: [
              Flexible(flex: 1, child: Container()),
              // svg image
              SvgPicture.asset(
                'assets/word_insta_logo.svg',
                color: primaryColor,
                height: 64,
              ),
              const SizedBox(height: 20),

              // avatar
              Stack(
                children: [
                  _image != null
                      ? CircleAvatar(
                          radius: 64,
                          backgroundImage: MemoryImage(_image!),
                        )
                      : CircleAvatar(
                          radius: 64,
                          backgroundImage: NetworkImage(
                            'https://i.pinimg.com/236x/08/35/0c/08350cafa4fabb8a6a1be2d9f18f2d88.jpg',
                          ),
                        ),

                  Positioned(
                    bottom: -10,
                    left: 80,
                    child: IconButton(
                      onPressed: () {
                        selectImage();
                      },
                      icon: Icon(Icons.add_a_photo),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // username input field
              TextFieldInput(
                textEditingController: _usernController,
                hintText: "Create your username",
                textInputType: TextInputType.text,
              ),
              const SizedBox(height: 20),

              // email input field
              TextFieldInput(
                textEditingController: _emailController,
                hintText: "Enter your email",
                textInputType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 20),

              // password input field
              TextFieldInput(
                textEditingController: _passController,
                hintText: "Enter your password",
                textInputType: TextInputType.emailAddress,
                isPass: true,
              ),
              const SizedBox(height: 20),

              // button login
              Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(vertical: 0),
                alignment: Alignment.centerRight,
                child: FilledButton(
                  onPressed: signUpUser,
                  style: ElevatedButton.styleFrom(backgroundColor: blueColor),
                  child: _isLoading ? 
                  const Center(
                    child: CircularProgressIndicator(
                      color: primaryColor,
                    ),
                  ) :
                  Center(
                    child: Text('Log in', style: TextStyle(fontSize: 14)),
                  ),
                ),
              ),

              // transiting to sign up page
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Text("Already have an account?"),
                  ),

                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => const LoginScreen()));
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        "Login",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
              Flexible(flex: 1, child: Container()),
            ],
          ),
        ),
      ),
    );
  }
}
