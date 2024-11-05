import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qr/qr.dart';  
import 'package:url_launcher/url_launcher.dart';  // For launching URLs

void main() {
  runApp(QRCodeApp());
}

class QRCodeApp extends StatefulWidget {
  @override
  _QRCodeAppState createState() => _QRCodeAppState();
}

class _QRCodeAppState extends State<QRCodeApp> {
  String qrData = "Initial QR Code";  // Initial QR code data
  String statusMessage = "Press a button to generate a QR code"; 
  TextEditingController _controller = TextEditingController();  // Controller for the TextField

  // Function to launch URL
  void _launchURL() async {
    const url = 'https://gitlab.com/CSUChico/CSUC-CINS467/CINS467-Vlad-Avdeev/CINS467-F24-Vlad-Avdeev'; 
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("QR Code Generator"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // QR Image
              QrImageView(
                data: qrData,
                version: QrVersions.auto,
                size: 200.0,
              ),
              SizedBox(height: 20.0),
              // TextField for entering new QR data
              TextField(
                controller: _controller,  // Controller for capturing the input
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter new QR code data',
                ),
              ),
              SizedBox(height: 10.0),
              
              // Row for two buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Button to update qrData with the input from TextField
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        qrData = _controller.text;  // Update qrData with the input text
                        statusMessage = "QR Code Updated Successfully!";
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purpleAccent,  // Background color
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Update QR Data',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),

                  // Reset Button to reset the qrData to initial state
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        qrData = "Initial QR Code";  // Reset to the initial QR code
                        _controller.clear();  // Clear the text field
                        statusMessage = "QR Code Reset Successfully!";
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,  // Background color for reset button
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Reset',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ],
              ),
              
              SizedBox(height: 10.0),

              // Display status message
              Text(
                statusMessage,
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
        // FloatingActionButton in the bottom right corner
        floatingActionButton: FloatingActionButton(
          onPressed: _launchURL,  // Link to GitHub
          backgroundColor: const Color.fromARGB(255, 1, 81, 99),
          child: Icon(Icons.code),
          tooltip: 'Go to GitHub',
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,  // Bottom-right position
      ),
    );
  }
}

