import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nutritionist_app/constants.dart';
import 'package:nutritionist_app/features/profile/widgets/profile_card2.dart';
import 'package:nutritionist_app/widgets/my_button.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  static const _fullNameKey = 'profile_full_name';
  static const _birthDateKey = 'profile_birth_date';
  static const _countryKey = 'profile_country';
  static const _cityKey = 'profile_city';
  static const _profileDocsSeededKey = 'profile_docs_seeded';
  static const _windowsProfileDocsPath =
      r'C:\Users\admin\StudioProjects\nutritionist_app_doctor\profile_docs';

  final ScrollController _scroll = ScrollController();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _birthDateController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final List<File> _documents = [];

  String _fullName = 'Бикетова Евгения Александровна';
  String _birthDate = '23.05.1982';
  String _country = 'Россия';
  String _city = 'г. Нерюнгри';
  bool _isEditing = false;
  bool _isLoadingDocuments = true;
  String? _documentsError;

  @override
  void initState() {
    super.initState();
    _syncControllers();
    _loadPersonalData();
    _loadDocuments();
  }

  @override
  void dispose() {
    _scroll.dispose();
    _fullNameController.dispose();
    _birthDateController.dispose();
    _countryController.dispose();
    _cityController.dispose();
    super.dispose();
  }

  Future<void> _loadPersonalData() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      _fullName = prefs.getString(_fullNameKey) ?? _fullName;
      _birthDate = prefs.getString(_birthDateKey) ?? _birthDate;
      _country = prefs.getString(_countryKey) ?? _country;
      _city = prefs.getString(_cityKey) ?? _city;
      _syncControllers();
    });
  }

  Future<void> _loadDocuments() async {
    try {
      final documentsDirectory = await _resolveDocumentsDirectory();

      if (!await documentsDirectory.exists()) {
        await documentsDirectory.create(recursive: true);
      }

      if (!Platform.isWindows) {
        final prefs = await SharedPreferences.getInstance();
        final isSeeded = prefs.getBool(_profileDocsSeededKey) ?? false;

        if (!isSeeded) {
          await _seedBundledDocuments(documentsDirectory);
          await prefs.setBool(_profileDocsSeededKey, true);
        }
      }

      final documents =
          documentsDirectory
              .listSync()
              .whereType<File>()
              .where(_isSupportedDocument)
              .toList()
            ..sort(
              (a, b) => p
                  .basename(a.path)
                  .toLowerCase()
                  .compareTo(p.basename(b.path).toLowerCase()),
            );

      if (!mounted) return;
      setState(() {
        _documents
          ..clear()
          ..addAll(documents);
        _documentsError = null;
        _isLoadingDocuments = false;
      });
    } catch (error) {
      if (!mounted) return;
      setState(() {
        _documents.clear();
        _documentsError = 'Не удалось загрузить документы: $error';
        _isLoadingDocuments = false;
      });
    }
  }

  void _syncControllers() {
    _fullNameController.text = _fullName;
    _birthDateController.text = _birthDate;
    _countryController.text = _country;
    _cityController.text = _city;
  }

  void _startEditing() {
    setState(() {
      _isEditing = true;
      _syncControllers();
    });
  }

  void _cancelEditing() {
    setState(() {
      _isEditing = false;
      _syncControllers();
    });
  }

  Future<void> _savePersonalData() async {
    final fullName = _fullNameController.text.trim();
    final birthDate = _birthDateController.text.trim();
    final country = _countryController.text.trim();
    final city = _cityController.text.trim();

    if ([fullName, birthDate, country, city].any((value) => value.isEmpty)) {
      _showSnackBar('Заполните все персональные данные');
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_fullNameKey, fullName);
    await prefs.setString(_birthDateKey, birthDate);
    await prefs.setString(_countryKey, country);
    await prefs.setString(_cityKey, city);

    if (!mounted) return;

    setState(() {
      _fullName = fullName;
      _birthDate = birthDate;
      _country = country;
      _city = city;
      _isEditing = false;
    });

    _showSnackBar('Персональные данные сохранены');
  }

  Future<void> _pickAndAddDocument() async {
    final pickedFile = await FilePicker.pickFiles(
      type: FileType.custom,
      allowedExtensions: const ['pdf', 'doc', 'docx'],
      allowMultiple: false,
    );

    if (pickedFile == null || pickedFile.files.single.path == null) return;

    final sourceFile = File(pickedFile.files.single.path!);
    final documentsDirectory = await _resolveDocumentsDirectory();

    if (!await documentsDirectory.exists()) {
      await documentsDirectory.create(recursive: true);
    }

    final targetPath = await _buildUniqueDocumentPath(
      documentsDirectory.path,
      p.basename(sourceFile.path),
    );

    try {
      await sourceFile.copy(targetPath);
      await _loadDocuments();

      if (!mounted) return;
      _showSnackBar('Документ добавлен');
    } catch (error) {
      _showSnackBar('Не удалось добавить документ: $error');
    }
  }

  Future<void> _openDocument(File file) async {
    final result = await OpenFilex.open(file.path);

    if (!mounted) return;
    if (result.type == ResultType.done) return;

    _showSnackBar(
      result.message.isNotEmpty
          ? result.message
          : 'Не удалось открыть документ во внешнем приложении',
    );
  }

  Future<void> _deleteDocument(File file) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: const Color(0xffFFFDFA),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text(
            'Удалить документ?',
            style: TextStyle(
              color: kPrimaryColor,
              fontSize: 18,
              fontFamily: 'ActayWide',
            ),
          ),
          content: Text(
            'Документ "${_formatDocumentTitle(p.basenameWithoutExtension(file.path))}" будет удалён из списка.',
            style: const TextStyle(
              color: kPrimaryColor,
              fontSize: 14,
              fontFamily: 'Actay',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(false),
              child: const Text(
                'Отмена',
                style: TextStyle(color: kPrimaryColor),
              ),
            ),
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(true),
              child: const Text('Удалить', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );

    if (confirmed != true) return;

    try {
      if (await file.exists()) {
        await file.delete();
      }

      if (!mounted) return;
      setState(() {
        _documents.removeWhere((document) => document.path == file.path);
        _documentsError = null;
      });
      _showSnackBar('Документ удалён');
    } catch (error) {
      _showSnackBar('Не удалось удалить документ: $error');
    }
  }

  Future<Directory> _resolveDocumentsDirectory() async {
    if (Platform.isWindows) {
      return Directory(_windowsProfileDocsPath);
    }

    final appDirectory = await getApplicationDocumentsDirectory();
    return Directory(p.join(appDirectory.path, 'profile_docs'));
  }

  Future<void> _seedBundledDocuments(Directory targetDirectory) async {
    final manifestContent = await rootBundle.loadString('AssetManifest.json');
    final manifestMap = jsonDecode(manifestContent) as Map<String, dynamic>;

    final bundledDocs =
        manifestMap.keys
            .where(
              (assetPath) =>
                  assetPath.startsWith('profile_docs/') &&
                  _hasSupportedExtension(assetPath),
            )
            .toList()
          ..sort((a, b) => a.toLowerCase().compareTo(b.toLowerCase()));

    for (final assetPath in bundledDocs) {
      final fileName = p.basename(assetPath);
      final targetFile = File(p.join(targetDirectory.path, fileName));

      if (await targetFile.exists()) {
        continue;
      }

      final data = await rootBundle.load(assetPath);
      await targetFile.writeAsBytes(data.buffer.asUint8List(), flush: true);
    }
  }

  Future<String> _buildUniqueDocumentPath(
    String directoryPath,
    String originalFileName,
  ) async {
    final extension = p.extension(originalFileName);
    final fileName = p.basenameWithoutExtension(originalFileName);
    var index = 0;

    while (true) {
      final candidateName = index == 0
          ? '$fileName$extension'
          : '$fileName ($index)$extension';
      final candidatePath = p.join(directoryPath, candidateName);

      if (!await File(candidatePath).exists()) {
        return candidatePath;
      }

      index++;
    }
  }

  bool _isSupportedDocument(File file) {
    return _hasSupportedExtension(file.path);
  }

  bool _hasSupportedExtension(String path) {
    final extension = p.extension(path).toLowerCase();
    return extension == '.pdf' || extension == '.doc' || extension == '.docx';
  }

  String _formatDocumentTitle(String fileName) {
    final text = fileName
        .replaceAll('\u00A0', ' ')
        .replaceAll('_', ' ')
        .toLowerCase();

    return text[0].toUpperCase() + text.substring(1);
  }

  void _showSnackBar(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  Widget _buildDocumentsSection() {
    if (_isLoadingDocuments) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 30),
        child: Center(child: CircularProgressIndicator(color: kPrimaryColor)),
      );
    }

    if (_documentsError != null) {
      return _buildDocumentsMessage(_documentsError!);
    }

    if (_documents.isEmpty) {
      return _buildDocumentsMessage(
        'В папке profile_docs пока нет документов.',
      );
    }

    return Column(
      spacing: 10,
      children: _documents
          .map(
            (file) => ProfileCard2(
              title: _formatDocumentTitle(
                p.basenameWithoutExtension(file.path),
              ),
              imagePath: 'assets/home/docs_icon.png',
              onTap: () => _openDocument(file),
              onDelete: () => _deleteDocument(file),
            ),
          )
          .toList(),
    );
  }

  Widget _buildDocumentsMessage(String message) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xffF6EEE9),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        message,
        style: const TextStyle(
          color: kPrimaryColor,
          fontSize: 15,
          fontFamily: 'Actay',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8F1EA),
      body: Stack(
        children: [
          SafeArea(
            child: SingleChildScrollView(
              controller: _scroll,
              child: Column(
                children: [
                  const SizedBox(height: 210),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      spacing: 10,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: const Color(0xffFFFDFA),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withAlpha(50),
                                blurRadius: 1,
                                spreadRadius: 1,
                                offset: const Offset(-1, 1),
                              ),
                            ],
                          ),
                          child: Column(
                            spacing: 10,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Персональные данные',
                                    style: const TextStyle(
                                      color: kPrimaryColor,
                                      fontSize: 18,
                                      fontFamily: 'ActayWide',
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(),
                              _PersonalDataField(
                                controller: _fullNameController,
                                value: _fullName,
                                isEditing: _isEditing,
                                hintText: 'ФИО',
                              ),
                              _PersonalDataField(
                                controller: _birthDateController,
                                value: _birthDate,
                                isEditing: _isEditing,
                                hintText: 'Дата рождения',
                              ),
                              _PersonalDataField(
                                controller: _countryController,
                                value: _country,
                                isEditing: _isEditing,
                                hintText: 'Страна',
                              ),
                              _PersonalDataField(
                                controller: _cityController,
                                value: _city,
                                isEditing: _isEditing,
                                hintText: 'Город',
                              ),
                              const SizedBox(),
                              _isEditing
                                  ? Row(
                                      children: [
                                        Expanded(
                                          child: SizedBox(
                                            height: 40,
                                            child: MyButton(
                                              title: 'Отмена',
                                              bgColor: const Color(0xffF6EEE9),
                                              foregroundColor: kPrimaryColor,
                                              onPressed: _cancelEditing,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Expanded(
                                          child: SizedBox(
                                            height: 40,
                                            child: MyButton(
                                              title: 'Сохранить',
                                              onPressed: _savePersonalData,
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  : SizedBox(
                                      height: 40,
                                      width: 200,
                                      child: MyButton(
                                        title: 'Редактировать',
                                        onPressed: _startEditing,
                                      ),
                                    ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: const Color(0xffFFFDFA),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withAlpha(50),
                                blurRadius: 1,
                                spreadRadius: 1,
                                offset: const Offset(-1, 1),
                              ),
                            ],
                          ),
                          child: Column(
                            spacing: 10,
                            children: [
                              Row(
                                children: [
                                  Flexible(
                                    child: Text(
                                      'Квалификационные документы',
                                      style: const TextStyle(
                                        color: kPrimaryColor,
                                        fontSize: 17,
                                        fontFamily: 'ActayWide',
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Material(
                                color: const Color(0xffF6EEE9),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(10),
                                ),
                                child: InkWell(
                                  onTap: _pickAndAddDocument,
                                  borderRadius: BorderRadius.circular(10),
                                  child: Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 20,
                                      vertical: 20,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Добавить файл',
                                          style: const TextStyle(
                                            color: kPrimaryColor,
                                            fontSize: 15,
                                            fontFamily: 'Actay',
                                          ),
                                        ),
                                        InkWell(
                                          borderRadius: BorderRadius.circular(
                                            30,
                                          ),
                                          onTap: _pickAndAddDocument,
                                          child: Image.asset(
                                            'assets/home/add.png',
                                            width: 30,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              _buildDocumentsSection(),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: const Color(0xffFFFDFA),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withAlpha(50),
                  blurRadius: 1,
                  spreadRadius: 1,
                  offset: const Offset(-1, 1),
                ),
              ],
            ),
            width: double.infinity,
            height: 180,
          ),
          AnimatedBuilder(
            animation: _scroll,
            builder: (context, _) {
              final offset = _scroll.hasClients ? _scroll.offset : 0.0;
              final progress = (offset / 80).clamp(0.0, 1.0);
              final top = 80 - (25 * progress);
              final size = 150 - (40 * progress);

              return Positioned(
                top: top,
                left: 0,
                right: 0,
                child: Center(
                  child: SizedBox(
                    width: size,
                    height: size,
                    child: Image.asset(
                      'assets/users/evgeniya.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              );
            },
          ),
          Positioned(
            top: 80,
            left: 20,
            child: Center(
              child: SizedBox(
                width: 50,
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Image.asset('assets/message/left_icon.png', width: 32),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PersonalDataField extends StatelessWidget {
  final TextEditingController controller;
  final String value;
  final bool isEditing;
  final String hintText;

  const _PersonalDataField({
    required this.controller,
    required this.value,
    required this.isEditing,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xffF6EEE9),
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: isEditing
          ? TextField(
              controller: controller,
              style: const TextStyle(
                color: kPrimaryColor,
                fontSize: 15,
                fontFamily: 'Actay',
              ),
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: TextStyle(
                  color: kPrimaryColor.withAlpha(150),
                  fontSize: 15,
                  fontFamily: 'Actay',
                ),
                border: InputBorder.none,
              ),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(vertical: 14),
              child: Text(
                value,
                style: const TextStyle(
                  color: kPrimaryColor,
                  fontSize: 15,
                  fontFamily: 'Actay',
                ),
              ),
            ),
    );
  }
}
