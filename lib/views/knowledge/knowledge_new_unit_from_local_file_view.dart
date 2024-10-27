import 'dart:io';

import 'package:chatbot_agents/constants/app_colors.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class KnowledgeNewUnitFromLocalFileView extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _KnowledgeNewUnitFromLocalFileViewState();
}

class _KnowledgeNewUnitFromLocalFileViewState extends State<KnowledgeNewUnitFromLocalFileView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
  FilePickerResult? result;
  String? _fileName;
  bool _isLoading = false;
  List<PlatformFile>? _path;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBackground,
      appBar: AppBar(
        backgroundColor: AppColors.primaryBackground,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back,
            color: AppColors.quaternaryText,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Add Unit From Local File',
            style: TextStyle(
                color: AppColors.quaternaryText
            )
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Form(
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.feed_outlined,
                            color: AppColors.quaternaryText,
                          ),
                          const SizedBox(width: 10.0),
                          Text('Local File', 
                            style: TextStyle(
                              color: AppColors.quaternaryText,
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(5.0),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text(
                            '*',
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 8.0),
                          Text('Select a file to upload', 
                            style: TextStyle(
                              color: AppColors.quaternaryText,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                    (_fileName != null) ? Container(
                      decoration: BoxDecoration(
                        color: AppColors.tertiaryBackground,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: EdgeInsets.all(7.0),
                      margin: EdgeInsets.all(10.0),
                      child: Text(_fileName ?? "no file selected",
                          maxLines: 5,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: AppColors.quaternaryText,
                            fontSize: 20,
                          ),
                        ) ,
                    ): Container(),
                    Container(
                      margin: EdgeInsets.all(10.0),
                      child: ElevatedButton(
                        onPressed: () async {
                          await _pickFiles();
                        }, 
                        child: const Text('Choose File',
                          style: TextStyle(
                            color: AppColors.quaternaryText,
                          ),
                        ),
                        style: ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(AppColors.secondaryBackground),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(25.0),
                      child: ElevatedButton(
                        onPressed: () async {
                          Navigator.pop(context);
                          // result = await FilePicker.platform.pickFiles(allowMultiple: false);
                          // if (result == null) {
                          //   print("No file selected");
                          // } else {
                          //   print(result!.files.first.name);
                          //   setState(() {
                          //     _fileName = (result!.files.single.path!);
                          //   });
                          //   //file = File(result!.files.single.path!);
                          // }
                        },
                        child: const Text('Connect',
                          style: TextStyle(
                            color: AppColors.quaternaryText,
                          ),
                        ),
                        style: ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(AppColors.secondaryBackground),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        )
      )
    );
  }

  void _resetState() {
    if (!mounted) {
      return;
    }
    setState(() {
      _isLoading = true;
      _fileName = null;
      _path = null;
      result = null;
    });
  }

  void _logException(String message) {
    print(message);
    _scaffoldMessengerKey.currentState?.hideCurrentSnackBar();
    _scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Future<void> _pickFiles() async {
    _resetState();
    try {
      _path = (await FilePicker.platform.pickFiles(
        compressionQuality: 30,
        allowMultiple: false,
        onFileLoading: (FilePickerStatus status) => print(status),
        
      ))
          ?.files;
    } on PlatformException catch (e) {
      _logException('Unsupported operation' + e.toString());
    } catch (e) {
      _logException(e.toString());
    }
    if (!mounted) return;
    setState(() {
      _isLoading = false;
      _fileName = _path != null ? _path!.single.path : null;
      //_userAborted = _paths == null;
    });
  }
}