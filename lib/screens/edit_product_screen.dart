import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EditProductScreen extends StatefulWidget {
  static final String route = '/editProductScreen';

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _imageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your products'),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Form(
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(
                      labelText: 'Title', hintText: 'Input title here'),
                  textInputAction: TextInputAction.next,
                ),
                Row(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      child: _imageController.text.isEmpty
                          ? Text('Enter url')
                          : FittedBox(
                              child: Image.network(_imageController.text),
                              fit: BoxFit.cover,
                            ),
                    ),
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(
                            labelText: 'url', hintText: 'input url here'),
                        controller: _imageController,
                        keyboardType: TextInputType.url,
                        textInputAction: TextInputAction.done,
                        onEditingComplete: () {
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
