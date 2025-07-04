import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:instagram_clone/resources/auth_methods.dart';
import 'package:instagram_clone/responsiveness/mobile_screen_layout.dart';
import 'package:instagram_clone/responsiveness/responsive_layout_scree.dart';
import 'package:instagram_clone/responsiveness/web_screen_layout.dart';
import 'package:instagram_clone/screens/sign_up.dart';
import 'package:instagram_clone/utils/Colors.dart';
import 'package:instagram_clone/utils/utils.dart';
import 'package:instagram_clone/widgets/text_field_input.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passController.dispose();
  }

  void loginUser() async {
    setState(() {
      _isLoading = true;
    });

    String res = await AuthMethods().loginUser(
      email: _emailController.text, 
      password: _passController.text,
    );
    
    setState(() {
      _isLoading = false;
    });

    if (res == 'Success'){
      Navigator.of(context).push (
        MaterialPageRoute(
          builder: (context) => const ResponsiveLayoutScree(
            mobileScreenLayout : MobileScreenLayout(),
            webScreenLayout : WebScreenLayout()
          )
        )
      );
    } else {
      showSnackbar(res, context);
    }

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
              Flexible(
                flex: 1,
                child: Container(), 
              ),
              // svg image
              SvgPicture.asset(
                'assets/word_insta_logo.svg',
                color: primaryColor,
                height: 64,
              ),
              const SizedBox(height: 20),

              // username input field 
              TextFieldInput(
                textEditingController: _emailController, 
                hintText: "Enter your email", 
                textInputType: TextInputType.emailAddress
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
                  onPressed: loginUser, 
                  style: ElevatedButton.styleFrom(backgroundColor: blueColor),
                  child: _isLoading ? 
                  const Center(
                    child: CircularProgressIndicator(
                      color: primaryColor,
                    ),
                  ) :
                  Center(child: Text('Log in', style: TextStyle(
                    fontSize: 14,
                  ),)),
                ),
              ),
              
              // transiting to sign up page
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                    ),
                    child: Text("Don't have an account?"),
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => const SignUpScreen()));
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                      ),
                      child: Text("Sign Up", style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                      ),
                    ),
                  ),
                ],
              ),
              Flexible(
                flex: 1,
                child: Container(), 
              ),
            ],
          ),
        )
      ),
    );
  }
}