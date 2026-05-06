import 'package:flutter/material.dart';
import 'package:nutritionist_app/constants.dart';
import 'package:nutritionist_app/features/home/widgets/custom_app_bar.dart';
import 'package:nutritionist_app/widgets/my_button.dart';

class NewRecordScreen extends StatefulWidget {
  const NewRecordScreen({super.key});

  @override
  State<NewRecordScreen> createState() => _NewRecordScreenState();
}

class _NewRecordScreenState extends State<NewRecordScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _bodyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8F1EA),
      body: SafeArea(
        child: Column(
          children: [
            const CustomAppBar(title: 'Новая запись'),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 8,
                ),
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: const Color(0xffFFFDFA),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.all(20),
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: TextField(
                        controller: _titleController,
                        minLines: 2,
                        maxLines: 4,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'ActayWide',
                          color: kPrimaryColor,
                        ),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Введите заголовок статьи',
                          hintStyle: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'ActayWide',
                            color: Color(0xff9FA8A8),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: const Color(0xffFFFDFA),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.all(20),
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: TextField(
                        controller: _bodyController,
                        minLines: 14,
                        maxLines: 20,
                        style: const TextStyle(
                          fontSize: 16,
                          height: 1.5,
                          fontFamily: 'Actay',
                          color: kPrimaryColor,
                        ),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Введите основной текст статьи',
                          hintStyle: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Actay',
                            color: Color(0xff9FA8A8),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 50,
              child: MyButton(title: 'Сохранить', onPressed: _savePost),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  void _savePost() {
    final title = _titleController.text.trim();
    final body = _bodyController.text.trim();

    if (title.isEmpty || body.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Заполните заголовок и текст статьи.')),
      );
      return;
    }

    Navigator.of(context).pop(NewRecordResult(title: title, content: body));
  }
}

class NewRecordResult {
  final String title;
  final String content;

  const NewRecordResult({required this.title, required this.content});
}
