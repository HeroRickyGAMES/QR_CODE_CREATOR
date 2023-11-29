import 'package:admanager_web/admanager_web.dart';
import 'package:fluid_kit/fluid_kit.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_generator/qrgen/qrcode.dart';
import 'package:qr_flutter/qr_flutter.dart';

main(){
  runApp(
    MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark
      ),
      home: const mainTela(),
    )
  );
  AdManagerWeb.init();
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

      return SelectionArea(
        child: Scaffold(
          body: Center(
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
                                        AdRewarded().load(
                                          adUnitId: '/22639388115/rewarded_web_example',
                                          onAdLoaded: (){
                                            print('loaded');
                                          },
                                        );
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
                  Container(
                    padding: const EdgeInsets.all(16),
                    child: const AdBlock(
                      size: [AdBlockSize.mediumRectangle],
                      adUnitId: "ca-pub-1895475762491539",
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
