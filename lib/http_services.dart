
import 'package:api_get_3/model.dart';
import 'package:http/http.dart' as http;

class HttpServices {


  Future<Model?> getData() async {

    var url = Uri.parse(
        'https://api.nasa.gov/planetary/apod?api_key=LlYJibdfrFTAxUhp3gWrUCQ4OGKr8xDPteSWpTD8&date=');
    var response = await http.get(url);

    print(response.statusCode);

    if (response.statusCode == 200) {
     return modelFromJson(response.body.toString());
    } else {
      throw 'Data Not Found';
    }
  }
}
