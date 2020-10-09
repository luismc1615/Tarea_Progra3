import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
//import 'package:font_awesome_flutter/font_awesome_flutter.dart';


void main() {
  runApp(MaterialApp(
    theme: ThemeData(
      primaryColor: Colors.green
    ),
    debugShowCheckedModeBanner: false,
    home: LoginPage(),
  ));
}

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                ]
              )
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.
            center,
            children: [
              SizedBox(height: 20,),
              Image.asset('images/logo.png'),
              SizedBox(height: 15,),
              Text('Trámites municipales',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
              ),
              SizedBox(height: 30,),
              Container(
                height: 400,
                width: 325,
                decoration: BoxDecoration(
                  color: Colors.white, 
                  borderRadius: BorderRadius.circular(10)
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 30,),
                      Text('Hola',
                      style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold
                      ),
                      ),
                      SizedBox(height: 10,),
                      Text('Por favor ingrese sus credenciales',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey
                      )
                      ),
                      SizedBox(height: 20,),
                      Container(
                        width: 250,
                        child: TextField(
                          decoration: InputDecoration(
                            labelText: 'Cédula:',
                            suffixIcon: Icon(FontAwesomeIcons.envelope, 
                            size: 17),
                          ),
                        ),
                      ),
                       Container(
                        width: 250,
                        child: TextField(
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'Contraseña:',
                            suffixIcon: Icon(FontAwesomeIcons.eyeSlash, 
                            size: 17),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(20, 20, 40, 
                        20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text('Da click en Iniciar para ingresar al sistema.',
                            style: TextStyle(
                              color: Colors.orangeAccent[700]
                            ),
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
                              ]
                            )
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Text('Ingresar',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                            ),
                            )
                          ),
                        ),
                      ),
                    ],
                  )
              )
            ],
          )
        ),
      ),
    );
  }
}