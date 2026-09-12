import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/resources/auth_methods.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/utils/utils.dart';
import 'package:instagram_clone/widgets/text_field_input.dart';

class SignupScreen extends StatefulWidget {
  const new({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passcontroller = TextEditingController();
  final TextEditingController _biocontroller = TextEditingController();
  final TextEditingController _usernamecontroller = TextEditingController();
  Uint8List? _image;

  @override
  void dispose() {
    super.dispose();
    _emailcontroller.dispose();
    _passcontroller.dispose();
    _biocontroller.dispose();
    _usernamecontroller.dispose();
  }
  void selectImage() async{
    Uint8List? im = await pickImage(ImageSource.gallery);
    setState(() {
      _image=im;
    });
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
              Flexible(flex: 2, child: Container()),
              //svg image
              SvgPicture.asset(
                'assets/ic_instagram.svg',
                colorFilter: ColorFilter.mode(primaryColor, BlendMode.srcIn),
                height: 64,
              ),

              const SizedBox(height: 54),
              //circular idget to accept and show are selected file
              Stack(
                children: [
                  _image!=null?
                  CircleAvatar(
                    radius: 64,
                    backgroundImage:  MemoryImage(_image!),
                  )
                  :CircleAvatar(
                    radius: 64,
                    backgroundImage: NetworkImage("https://i.pinimg.com/736x/13/74/20/137420f5b9c39bc911e472f5d20f053e.jpg"),
                  ), 
                  Positioned(
                    bottom: -10,
                    left: 80,
                    child: IconButton(
                      onPressed: selectImage,
                      icon: const Icon(Icons.add_a_photo),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              //textfield input for username
              TextFieldInput(
                hintText: 'Username',
                textEditingController: _usernamecontroller,
                textInputType: TextInputType.text,
              ),
              const SizedBox(height: 24),
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
              //textfield input for
              TextFieldInput(
                hintText: 'Bio',
                textEditingController: _biocontroller,
                textInputType: TextInputType.text,
              ),
              const SizedBox(height: 24),
              //button for login
              InkWell(
                onTap: () async {
                  {
                    String res = await AuthMethods().signUpUser(
                      email: _emailcontroller.text,
                      password: _passcontroller.text,
                      username: _usernamecontroller.text,
                      bio: _biocontroller.text,
                      file: _image!,
                    );
                  }
                },
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
                  child: Text('Sign Up'),
                ),
              ),
              const SizedBox(height: 12),
              Flexible(flex: 2, child: Container()),
              //transition to password
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Text("Don't have an account?"),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        "Sign up",
                        style: TextStyle(fontWeight: FontWeight.bold),
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
}
