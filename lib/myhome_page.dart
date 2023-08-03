import 'dart:io';
import 'package:api_get_3/gujarati_page.dart';
import 'package:api_get_3/hindi_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'model.dart';

class MyHomePage extends StatefulWidget {
  final String date;

  const MyHomePage({super.key, required this.date});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<Model?> getData() async {
    var url = Uri.parse(
        'https://api.nasa.gov/planetary/apod?api_key=LlYJibdfrFTAxUhp3gWrUCQ4OGKr8xDPteSWpTD8&date=${widget.date}');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      return modelFromJson(response.body.toString());
    } else {
      throw 'Data Not Found';   
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Astronomy Picture of the Day',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        ),
        body: FutureBuilder(
          future: getData(),
          builder: (context, snapShot) {
            if (snapShot.hasData) {
              Model? finalDataList = snapShot.data;
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.network(
                        finalDataList!.hdurl.toString(),
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          OutlinedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HindiPage(
                                    data: finalDataList,
                                  ),
                                ),
                              );
                            },
                            child: const Text(
                              'Hindi',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 0.3),
                            ),
                          ),
                          OutlinedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => GujaratiPage(
                                    data: finalDataList,
                                  ),
                                ),
                              );
                            },
                            child: const Text(
                              'Gujarati',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 0.3),
                            ),
                          ),
                          IconButton(
                            onPressed: () async {
                              final imageUrl = '${finalDataList.hdurl}';
                              final uri = Uri.parse(imageUrl);
                              final response = await http.get(uri);
                              final bytes = response.bodyBytes;
                              final temp = await getTemporaryDirectory();
                              final path = '${temp.path}/image.jpg';
                              File(path).writeAsBytesSync(bytes);
                              await Share.shareXFiles([XFile(path)]);
                            },
                            icon: const Icon(
                              Icons.share,
                              color: Colors.blue,
                              size: 25,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        finalDataList.date.toString(),
                        style: const TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Title: ${finalDataList.title}',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Explanation: ${finalDataList.explanation}',
                        style: const TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
