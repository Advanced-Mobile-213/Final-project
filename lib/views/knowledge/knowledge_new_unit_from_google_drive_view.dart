import 'package:chatbot_agents/constants/app_colors.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class KnowledgeNewUnitFromGoogleDriveView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _KnowledgeNewUnitFromGoogleDriveViewState();
}

class _KnowledgeNewUnitFromGoogleDriveViewState extends State<KnowledgeNewUnitFromGoogleDriveView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
  
  TextEditingController _nameInputFieldController = TextEditingController();
  FilePickerResult? result;
  String? _fileName;
  bool _isLoading = false;
  List<PlatformFile>? _path;
  String? _errorMessage = 'No files were uploaded. Please upload a file.';

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

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
        title: const Text('Add Unit From Google Drive',
            style: TextStyle(
                color: AppColors.quaternaryText,
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
                key: _formKey,
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 20),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(FontAwesomeIcons.googleDrive,
                            color: AppColors.quaternaryText,
                          ),
                          const SizedBox(width: 10.0),
                          Text('Google Drive', 
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
                          Text('Name', 
                            style: TextStyle(
                              color: AppColors.quaternaryText,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(10.0),
                      child: TextFormField(
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        enabled: true,
                        controller: _nameInputFieldController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey[200],
                          contentPadding: const EdgeInsets.all(10),
                          hintText: 'Enter name',
                          hintStyle: TextStyle(
                            color: AppColors.greyText,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColors.quaternaryText,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColors.quaternaryText,
                            ),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter name of website';
                          }
                          return null;
                        },
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
                          Text('Google Drive Credentials', 
                            style: TextStyle(
                              color: AppColors.quaternaryText,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.tertiaryBackground,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: EdgeInsets.all(7.0),
                      margin: EdgeInsets.all(10.0),
                      child: (_fileName != null) 
                        ? Text(_fileName ?? "no file selected",
                          maxLines: 5,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: AppColors.quaternaryText,
                            fontSize: 20,
                          ),
                        )
                        : Text('Please Upload file google drive credentials', 
                            style: TextStyle(
                              color: AppColors.quaternaryText,
                              fontSize: 20,
                            ),
                          ),
                    ),
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
                        onPressed: () {
                          if (_fileName == null) {
                            _scaffoldMessengerKey.currentState?.showSnackBar(
                              SnackBar(
                                content: Text(
                                  _errorMessage ?? 'Please upload a file',
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            );
                            return;
                          }
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            Navigator.of(context).pop();
                          }
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
                    )
                    
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
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
      _errorMessage = null;
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
      _errorMessage = null;
      //_userAborted = _paths == null;
    });
  }
}