import 'package:http/http.dart';
import 'dart:convert';

void main() {
  // print("Olá, mundo!");
  requestDataAsync();
  sendDataAsync();
}
  String url =
  "https://gist.githubusercontent.com/Lucas-397/37296fe80cb4d2043c1cedbc1247f91f/raw/077d0f06aea5eac18c41339e9f7a82492ea46fac/accounts.json";

requestData() {
  Future<Response> futureResponse = get(Uri.parse(url));
  print(futureResponse);
  futureResponse.then(
    (Response response) {
      List<dynamic> accountsList = json.decode(response.body);
      Map<String, dynamic> carlaAccount = accountsList.firstWhere(
        (element) => element["name"] == "Carla"
      );

      print(carlaAccount);
    },
  );

}

Future<List<dynamic>> requestDataAsync() async{
  Response resposta = await get(Uri.parse(url));
  return json.decode(resposta.body);
}

Future  sendDataAsync() async{
  List<dynamic> contas = await requestDataAsync();
  contas.add({
    "id": "Id011",
    "name": "Lucas",
    "lastName": "Machado",
    "balance": 1000.0
  });
  String content = json.encode(contas);

  Response reposta = await post(Uri.parse(url), body: content);
  print(reposta.statusCode);
}