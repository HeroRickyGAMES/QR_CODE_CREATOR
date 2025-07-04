import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_downloader_web/image_downloader_web.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_plus/share_plus.dart';

//Programado por HeroRickyGames

class qrcode extends StatefulWidget {
  String url;
  qrcode(this.url, {super.key});

  @override
  State<qrcode> createState() => _qrcodeState();
}

class _qrcodeState extends State<qrcode> {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 200,
          width: 200,
          child: QrImageView(
            data: widget.url,
            version: QrVersions.auto,
            size: 200.0,
            backgroundColor: Colors.white,
          ),
        ),
        ElevatedButton(onPressed: () async {
          final image = await QrPainter(
            data: widget.url,
            version: QrVersions.auto,
            gapless: false,
            color: Colors.black,
            emptyColor: Colors.white,
          ).toImageData(1080); // Generate QR code image data
          if(kIsWeb){
            var bytes = image!.buffer.asUint8List(); // Get the image bytes

            await WebImageDownloader.downloadImageFromUInt8List(uInt8List: bytes, name: 'qrcode');
          }else{
            if(Platform.isAndroid){
              const filename = 'qr_code.png';
              final tempDir = await getTemporaryDirectory(); // Get temporary directory to store the generated image
              final file = await File('${tempDir.path}/$filename').create(); // Create a file to store the generated image
              var bytes = image!.buffer.asUint8List(); // Get the image bytes
              await file.writeAsBytes(bytes); // Write the image bytes to the file
              final xfile = XFile(file.path);
              await Share.shareXFiles(
                [xfile],
                text: 'QR code for ${widget.url}',
                subject: 'QR Code',
                fileNameOverrides: ['image/png'],
              );
            }
          }

        }, child: const Text( kIsWeb ? "Download" : "Salvar ou Compartilhar")
        )
      ],
    );
  }
}
