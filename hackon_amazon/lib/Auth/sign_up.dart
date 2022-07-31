import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hackon_amazon/home/home.dart';
import 'package:image_picker/image_picker.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final ImagePicker _picker = ImagePicker();
  late String? _pickedImage1 = '';
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Center(
          child: CircleAvatar(
            radius: height * 0.1,
            backgroundImage: _pickedImage1 != null
                ? FileImage(File(_pickedImage1.toString())) as ImageProvider
                : AssetImage('assets/images/amazon.png'),
          ),
        ),
        TextButton(
            onPressed: () async {
              final image = await _picker.pickImage(source: ImageSource.camera);
              setState(() {
                _pickedImage1 = image?.path;
              });
            },
            child: Text('Click Image')),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: TextFormField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.person),
              //  fillColor: Color(0xffFFFFCC).withOpacity(0.2),
              filled: true,
              alignLabelWithHint: false,
              hintText: 'Name',
              border: InputBorder.none,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: TextFormField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.email),
              //  fillColor: Color(0xffFFFFCC).withOpacity(0.2),
              filled: true,
              alignLabelWithHint: false,
              hintText: 'E-Mail',
              border: InputBorder.none,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: TextFormField(
            keyboardType: TextInputType.visiblePassword,
            obscureText: true,
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.lock,
                size: 25,
              ),
              // fillColor: Color(0xffFFFFCC).withOpacity(0.2),
              filled: true,
              border: InputBorder.none,
              hintText: 'Password',
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: MaterialButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: ((context) => Home())),
                  (route) => false);
            },
            minWidth: width * 0.8,
            height: height * 0.055,
            color: Colors.blue,
            child: Text(
              'Sign Up',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ]),
    );
  }
}
