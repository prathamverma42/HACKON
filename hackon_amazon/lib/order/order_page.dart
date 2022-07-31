import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  final ImagePicker _picker = ImagePicker();
  late String? _pickedImage1 = '';
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.orange,
      ),
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        SizedBox(
          height: height * 0.1,
        ),
        Center(
          child: CircleAvatar(
            radius: height * 0.1,
            backgroundImage: _pickedImage1 != null
                ? FileImage(File(_pickedImage1.toString())) as ImageProvider
                : AssetImage('assets/images/amazon.png'),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        _pickedImage1 == ''
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('You are not verified'),
                  Icon(
                    Icons.warning,
                    size: 30,
                    color: Colors.red,
                  ),
                ],
              )
            : Container(),
        TextButton(
            onPressed: () async {
              final image = await _picker.pickImage(source: ImageSource.camera);
              setState(() {
                _pickedImage1 = image?.path;
              });
            },
            child: Text('Verify your identity')),
        _pickedImage1 != ''
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('You are verified'),
                  Icon(
                    Icons.verified,
                    size: 30,
                    color: Colors.green,
                  ),
                ],
              )
            : Container()
      ]),
      persistentFooterButtons: [
        Center(
          child: MaterialButton(
            onPressed: () {
              if (_pickedImage1 == '') {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Please verify your identity'),
                    actions: [
                      FlatButton(
                        child: Text('Ok'),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      )
                    ],
                  ),
                );
              } else {}
            },
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            minWidth: MediaQuery.of(context).size.width * 0.8,
            color: Colors.orange,
            child: Text(
              'Proceed to Place Order',
              style: TextStyle(color: Colors.white),
            ),
          ),
        )
      ],
    );
  }
}
