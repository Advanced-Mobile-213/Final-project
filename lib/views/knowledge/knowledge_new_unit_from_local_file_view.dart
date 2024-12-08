import 'dart:io';

import 'package:chatbot_agents/constants/app_colors.dart';
import 'package:chatbot_agents/models/knowledge/knowledge.dart';
import 'package:chatbot_agents/utils/snack_bar_util.dart';
import 'package:chatbot_agents/view_models/knowledge_unit_view_model.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class KnowledgeNewUnitFromLocalFileView extends StatefulWidget {
  final Knowledge knowledge;
  const KnowledgeNewUnitFromLocalFileView({super.key, required this.knowledge});

  @override
  State<StatefulWidget> createState() =>
      _KnowledgeNewUnitFromLocalFileViewState();
}

class _KnowledgeNewUnitFromLocalFileViewState
    extends State<KnowledgeNewUnitFromLocalFileView> {
  final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();
  FilePickerResult? _result;
  String? _filePath;
  String? _fileName;
  bool _isLoading = false;
  late final SnackBarUtil snackBarUtil;
  late final KnowledgeUnitViewModel readKnowledgeUnitViewModel;

  @override
  void initState() {
    super.initState();
    readKnowledgeUnitViewModel = context.read<KnowledgeUnitViewModel>();
    snackBarUtil = SnackBarUtil(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldMessengerKey,
      backgroundColor: AppColors.primaryBackground,
      appBar: AppBar(
        backgroundColor: AppColors.primaryBackground,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.quaternaryText),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Add Unit From Local File',
            style: TextStyle(color: AppColors.quaternaryText)),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Title Section
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.feed_outlined, color: AppColors.quaternaryText),
                SizedBox(width: 10.0),
                Text(
                  'Local File',
                  style: TextStyle(
                    color: AppColors.quaternaryText,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Choose file
            ElevatedButton(
              onPressed: _isLoading ? null : () => _selectFile(),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.secondaryBackground,
              ),
              child: const Text('Choose File',
                  style: TextStyle(color: AppColors.quaternaryText)),
            ),

            const SizedBox(height: 10),

            // Display file name after selection
            if (_fileName != null)
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.tertiaryBackground,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  _fileName!,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      color: AppColors.quaternaryText, fontSize: 16),
                ),
              ),

            const SizedBox(height: 20),

            // Connect button or CircularProgressIndicator
            _isLoading
                ? const CircularProgressIndicator(
                    color: AppColors.secondaryBackground)
                : ElevatedButton(
                    onPressed: () async {
                      await _onConnect();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.secondaryBackground,
                    ),
                    child: const Text('Connect',
                        style: TextStyle(color: AppColors.quaternaryText)),
                  ),
          ],
        ),
      ),
    );
  }

  /// Function to select a file
  Future<void> _selectFile() async {
    try {
      _result = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.custom,
      );

      if (_result != null && _result!.files.isNotEmpty) {
        setState(() {
          _filePath = _result!.files.single.path; // Store selected file path
          _fileName =
              _result!.files.single.name; // Store file name for UI display
        });
      } else {
        snackBarUtil.showDefault('No file selected');
      }
    } on PlatformException catch (e) {
      snackBarUtil.showDefault('Platform Exception: $e');
    } catch (e) {
      snackBarUtil.showDefault('Error: $e');
    }
  }

  Future<bool> _onConnect() async {
    if (_filePath == null) {
      snackBarUtil.showDefault('Please select a file first');
      return false;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final file = File(_filePath!);

      if (file.existsSync()) {
        final errorMessage = await readKnowledgeUnitViewModel
            .uploadFileFromLocal(knowledgeId: widget.knowledge.id, file: file);
        if (errorMessage != null) {
          snackBarUtil.showDefault('Error: $errorMessage');
          return false;
        } else {
          snackBarUtil.showDefault('File uploaded successfully!');
          return true;
        }
      } else {
        snackBarUtil.showDefault('File does not exist');
        return false;
      }
    } catch (e) {
      snackBarUtil.showDefault('Error accessing file: $e');
      return false;
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
}
