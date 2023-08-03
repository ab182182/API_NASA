import 'package:flutter/material.dart';
import 'package:translator/translator.dart';
import 'model.dart';

class HindiPage extends StatefulWidget {
  final Model? data;

  const HindiPage({Key? key, this.data}) : super(key: key);

  @override
  State<HindiPage> createState() => _HindiPageState();
}

class _HindiPageState extends State<HindiPage> {
  final translator = GoogleTranslator();

  Translation? description;
  Translation? title;

  translate() async {
    var name = await translator.translate("${widget.data!.title}", to: 'hi');
    var desc = await translator.translate("${widget.data!.explanation}", to: 'hi');

    setState(() {
      description = desc;
      title = name;
    });
  }

  @override
  void initState() {
    super.initState();
    translate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Hindi',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.network(
                widget.data!.hdurl.toString(),
                fit: BoxFit.cover,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                widget.data!.date.toString(),
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              title == null
                  ? const SizedBox()
                  : Text(
                      '$title',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
              const SizedBox(
                height: 10,
              ),
              // Text(text.toString()),
              description == null
                  ? const SizedBox()
                  : Text(
                      '$description',
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
