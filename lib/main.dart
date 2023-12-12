import 'dart:io';
import 'package:fluid_kit/fluid_kit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_generator/mobileAds/mobileAds.dart';
import 'package:qr_code_generator/qrgen/qrcode.dart';

//Desenvolvido por HeroRickyGames

main(){
  if(kIsWeb){
    runApp(
        MaterialApp(
          theme: ThemeData(
              useMaterial3: true,
              brightness: Brightness.dark
          ),
          home: const MainTelaWeb(),
        )
    );
  }else if(Platform.isAndroid){
    runApp(
        MaterialApp(
          theme: ThemeData(
              useMaterial3: true,
              brightness: Brightness.dark
          ),
          home: const MainTelaAndroid(),
        )
    );
  }
  //AdManagerWeb.init();
}

class MainTelaWeb extends StatefulWidget {
  const MainTelaWeb({super.key});

  @override
  State<MainTelaWeb> createState() => _MainTelaWebState();
}

class _MainTelaWebState extends State<MainTelaWeb> {
  @override
  Widget build(BuildContext context) {
    return const SelectionArea(
      child: Scaffold(
        body: mainTela(),
      ),
    );
  }
}


class MainTelaAndroid extends StatefulWidget {
  const MainTelaAndroid({super.key});

  @override
  State<MainTelaAndroid> createState() => _MainTelaAndroidState();
}

class _MainTelaAndroidState extends State<MainTelaAndroid> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(top: 25),
          child: const mainTela()
      ),
    );
  }
}


class mainTela extends StatefulWidget {

  const mainTela({super.key});

  @override
  State<mainTela> createState() => _mainTelaState();
}

class _mainTelaState extends State<mainTela> {

  String input = "";
  bool cliked = false;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constrain){
      double heig = constrain.maxHeight - 50;
      double wid = constrain.maxWidth - 50;
      return Center(
        child: Container(
          height: heig,
          width: wid,
          color: Colors.white,
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Fluid(
                    children: [
                      Fluidable(
                        fluid: 1,
                        minWidth: 200,
                        child:  Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                padding: const EdgeInsets.all(16),
                                child: const Text(
                                  'Crie um QR Code totalmente gratis!',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold
                                  ),
                                )
                            ),
                            Container(
                              padding: const EdgeInsets.all(16),
                              child: TextFormField(
                                style: const TextStyle(color: Colors.black),
                                keyboardType: TextInputType.text,
                                onChanged: (valor){
                                  input = valor;
                                  //Mudou mandou para a String
                                },
                                decoration: const InputDecoration(
                                  labelStyle: TextStyle(
                                      color: Colors.black
                                  ),
                                  hintStyle: TextStyle(
                                      color: Colors.black
                                  ),
                                  border: OutlineInputBorder(),
                                  hintText: 'Texto/URL que deseja criar o QR Code',
                                ),
                                onFieldSubmitted: (value){
                                  setState(() {
                                    cliked = true;
                                  });
                                },
                              ),
                            ),
                            Container(
                              child: ElevatedButton(
                                onPressed: (){
                                  setState(() {
                                    cliked = true;
                                  });
                                },
                                child: const Text("Gerar QR Code"),
                              ),
                            )
                          ],
                        ),
                      ),
                      Fluidable(
                        fluid: 1,
                        minWidth: 200,
                        child: Center(
                          child:
                          cliked == true? Container(
                              padding: const EdgeInsets.all(16),
                              child: qrcode(input)
                          ):const Center(
                            child: Text(
                              'Clique em gerar QR Code para gerar um QR Code!',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
             kIsWeb ?
                 Container(

                 ):
             Container(
                padding: const EdgeInsets.all(16),
                child: const mobileAds(),
              ),
            ],
          ),
        ),
      );
    });
  }
}
