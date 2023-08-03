import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'myhome_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  ByteData data =
      await PlatformAssetBundle().load('assets/ca/lets-encrypt-r3.pem');
  SecurityContext.defaultContext
      .setTrustedCertificatesBytes(data.buffer.asUint8List());

  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  TextEditingController date = TextEditingController();

  String? value;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[400],
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Wellcome to Universe',
            style: TextStyle(
              fontSize: 30,
            ),
          ),
        ),
        body: Container(
          alignment: Alignment.bottomRight,
          margin: const EdgeInsets.all(
            5,
          ),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.teal,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(
              10,
            ),
            image: const DecorationImage(
              image: NetworkImage(
                'https://m.media-amazon.com/images/I/91sg6N81vBL.jpg',
              ),
              fit: BoxFit.fill,
            ),
          ),
          child: TextButton(
            onPressed: () {
              myBottomSheet();
            },
            child: const CircleAvatar(
              radius: 35,
              backgroundColor: Colors.teal,
              child: Text(
                'Click',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 25,
                  letterSpacing: 0.7,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  myBottomSheet() {
    showModalBottomSheet(
        isDismissible: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(10),
          ),
        ),
        context: context,
        builder: (context) {
          return Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      10,
                    ),
                  ),
                  hintText: 'YYYY-MM-DD',
                  hintStyle: const TextStyle(
                    fontSize: 20,
                  ),
                  contentPadding: const EdgeInsets.only(
                    left: 10,
                  ),
                ),
                keyboardType: TextInputType.number,
                controller: date,
                onChanged: (val){
                   value = val;
                },
              ),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => MyHomePage(date: value!),
                    ),
                  );
                  date.clear();
                },
                child: const Text(
                  'SUBMIT',
                  style: TextStyle(
                    fontSize: 25,
                  ),
                ),
              ),
            ],
          );
        });
  }
}
