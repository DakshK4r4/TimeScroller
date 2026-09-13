import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/resources/auth_methods.dart';
import 'package:instagram_clone/responsive/mobile_Screen_Layout.dart';
import 'package:instagram_clone/responsive/responsive_layout_screen.dart';
import 'package:instagram_clone/responsive/web_Screen_Layout.dart';
import 'package:instagram_clone/screens/signup_screen.dart';
// import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/utils/utils.dart';
import 'package:instagram_clone/widgets/text_field_input.dart';

class LoginScreen extends StatefulWidget {
  const new({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passcontroller = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailcontroller.dispose();
    _passcontroller.dispose();
  }
  void loginUser() async{
    setState(() {
      _isLoading=true;
    });
    String res =await AuthMethods().loginUser(email: _emailcontroller.text, password: _passcontroller.text);
    if(res=='success'){
      void navigateToSignUp() {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const ResponsiveLayout(
              mobileScreenLayout: MobileScreenLayout(),
              webScreenLayout: WebScreenLayout(),
            ),
          ),
        );
      }
    }
    else{
      showSnackBar(res, context);
    }
    setState(() {
      _isLoading=false;
    });
  }
  void navigateToSignUp(){
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const SignupScreen(),));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 60),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'English(India)',
                    style: TextStyle(fontWeight: FontWeight.w200),
                  ),
                  Icon(Icons.keyboard_arrow_down),
                ],
              ),
              Flexible(flex: 1, child: Container()),
              const SizedBox(height: 10),
              //language
              //svg image
              // SvgPicture.asset(
              //   'assets/ic_instagram.svg',
              //   colorFilter: ColorFilter.mode(primaryColor, BlendMode.srcIn),
              //   height: 64,
              // ),
              Image.asset(
                'assets/Instagram_logo_2016.svg.webp',
                width: 90,
                height: 90,
                ),
              const SizedBox(height: 64),
              //textfiled input for email
              TextFieldInput(
                hintText: 'Username,email address or mobile number',
                textEditingController: _emailcontroller,
                textInputType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 24),
              //textfield input for password
              TextFieldInput(
                hintText: 'Password',
                textEditingController: _passcontroller,
                textInputType: TextInputType.text,
                isPass: true,
              ),
              const SizedBox(height: 30),
              //button for login
              InkWell(
                onTap: loginUser,
                child: Container(
                  width: double.infinity,
                  height: 32,
                  alignment: Alignment.center,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(14)),
                    ),
                    color: blueColor,
                  ),
                  child: _isLoading? const Center( child: CircularProgressIndicator(
                    color: Colors.white ,
                  ),) 
                  :Text(
                    'Log in',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                "Forgotten password?",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 12),
              Flexible(flex: 2, child: Container()),
              //transition to password
              GestureDetector(
                onTap: navigateToSignUp,
                child: Container(
                  width: double.infinity,
                  height: 34,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: blueColor, width: 1.4),
                  ),
                  child: Text(
                    "Create an account",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: blueColor,
                    ),
                  ),
                ),
              ),
              // Image.asset(''),
            ],
          ),
        ),
      ),
    );
  }
}
