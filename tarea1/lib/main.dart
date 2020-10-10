import 'dart:convert';
import 'dart:html';
import 'dart:io';
import 'package:json_table/json_table.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MaterialApp(
    theme: ThemeData(primaryColor: Colors.green),
    debugShowCheckedModeBanner: false,
    home: LoginPage(),
  ));
}

String tokenActual;

class LoginPage extends StatelessWidget {
  String password;
  String usuario;
  BuildContext context;

  TextEditingController inputcontrollerCedula = new TextEditingController();
  TextEditingController inputcontrollerPassword = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                  Color(0xFF8A2387),
                  Color(0xFFE94057),
                  Color(0xFFF27121),
                ])),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 20,
                ),
                Image.asset('images/logo.png'),
                SizedBox(
                  height: 15,
                ),
                Text(
                  'Trámites municipales',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                    height: 400,
                    width: 325,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          'Hola',
                          style: TextStyle(
                              fontSize: 35, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text('Por favor ingrese sus credenciales',
                            style: TextStyle(fontSize: 15, color: Colors.grey)),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: 250,
                          child: TextField(
                            controller: inputcontrollerCedula,
                            decoration: InputDecoration(
                              labelText: 'Cédula:',
                              suffixIcon:
                                  Icon(FontAwesomeIcons.envelope, size: 17),
                            ),
                          ),
                        ),
                        Container(
                          width: 250,
                          child: TextField(
                            obscureText: true,
                            controller: inputcontrollerPassword,
                            decoration: InputDecoration(
                              labelText: 'Contraseña:',
                              suffixIcon:
                                  Icon(FontAwesomeIcons.eyeSlash, size: 17),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(20, 20, 40, 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                'Da click en Iniciar para ingresar al sistema.',
                                style:
                                    TextStyle(color: Colors.orangeAccent[700]),
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                        GestureDetector(
                          child: Container(
                              alignment: Alignment.center,
                              width: 250,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  gradient: LinearGradient(
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                      colors: [
                                        Color(0xFF8A2387),
                                        Color(0xFFE94057),
                                        Color(0xFFF27121),
                                      ])),
                              child: RaisedButton(
                                child: Text("Ingresar"),
                                color: Colors.red,
                                textColor: Colors.white,
                                splashColor: Colors.grey,
                                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                                onPressed: () {
                                  password = inputcontrollerPassword.text;
                                  usuario = inputcontrollerCedula.text;
                                  _loginRequest();
                                },
                              )),
                        ),
                      ],
                    ))
              ],
            )),
      ),
    );
  }
    _makeGetRequest() async {
    String url = 'https://jsonplaceholder.typicode.com/posts';
    http.Response response = await http.get(url);
    int statusCode = response.statusCode;
    Map<String, String> headers = response.headers;
    String contentType = headers['content-type'];
    var jsn = json.decode(response.body);

    print(jsn[1]);
  }
    _loginRequest() async {
    String url = 'http://localhost:8099/authentication/login';
    Map<String, String> headers = {"Content-type": "application/json"};
    String json =
        '{"cedula": "' + usuario + '","password": "' + password + '"}';
    http.Response response = await http.post(url, headers: headers, body: json);

    int statusCode = response.statusCode;
    print(statusCode);
    String body = response.body;
    var jsonResponse = jsonDecode(body);

    if (statusCode == 200) {
      tokenActual = jsonResponse["jwt"];
      Route route = MaterialPageRoute(builder: (bc) => WidgetDestino());
      Navigator.of(context).push(route);
    } else if (statusCode == 500) {
      _showMyDialog();
    }
  }





  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error!'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Los credenciales son inválidos.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Approve'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

class WidgetDestino extends StatelessWidget {
  String jsonSample;
  var json;
  
  final Widget child;
  WidgetDestino({Key key, this.child}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    _makeGetRequest();
        var json = jsonDecode(jsonSample);
    return Scaffold(
      body: Container(
        
        child: JsonTable(
          json
        ),
      ),
    );
  }


  _makeGetRequest() async {
  print(tokenActual);
  String url = 'http://localhost:8099/usuarios';

    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      HttpHeaders.authorizationHeader: 'bearer $tokenActual',
    });
    print(response);

  
}
}