import 'package:flutter/material.dart';
import 'package:nutritionist_app/constants.dart';
import 'package:nutritionist_app/features/home/widgets/custom_app_bar.dart';
import 'package:nutritionist_app/widgets/my_button.dart';

class RecordScreen extends StatefulWidget {
  final String title;
  final String content;
  final ValueChanged<String>? onContentChanged;

  const RecordScreen({
    super.key,
    required this.title,
    required this.content,
    this.onContentChanged,
  });

  @override
  State<RecordScreen> createState() => _RecordScreenState();
}

class _RecordScreenState extends State<RecordScreen> {
  late String _content;

  @override
  void initState() {
    super.initState();
    _content = widget.content;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8F1EA),
      body: SafeArea(
        child: Column(
          children: [
            const CustomAppBar(title: 'Важная\nинформация'),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 8,
                ),
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: const Color(0xffFFFDFA),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.all(20),
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        widget.title,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'ActayWide',
                          color: kPrimaryColor,
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
                      child: Text(
                        _content,
                        style: const TextStyle(
                          fontSize: 16,
                          height: 1.5,
                          fontFamily: 'Actay',
                          color: kPrimaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 50,
              child: MyButton(
                title: 'Редактировать текст',
                onPressed: _editContent,
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Future<void> _editContent() async {
    final updatedContent = await showDialog<String>(
      context: context,
      builder: (_) => _EditContentDialog(initialContent: _content),
    );

    if (!mounted || updatedContent == null || updatedContent == _content) {
      return;
    }

    setState(() {
      _content = updatedContent;
    });
    widget.onContentChanged?.call(updatedContent);
  }
}

class _EditContentDialog extends StatefulWidget {
  final String initialContent;

  const _EditContentDialog({required this.initialContent});

  @override
  State<_EditContentDialog> createState() => _EditContentDialogState();
}

class _EditContentDialogState extends State<_EditContentDialog> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialContent);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color(0xffFFFDFA),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: const Text(
        'Редактировать текст',
        style: TextStyle(
          color: kPrimaryColor,
          fontSize: 18,
          fontFamily: 'ActayWide',
        ),
      ),
      content: SizedBox(
        width: double.maxFinite,
        child: TextField(
          controller: _controller,
          maxLines: 14,
          minLines: 10,
          autofocus: true,
          style: const TextStyle(
            color: kPrimaryColor,
            fontSize: 15,
            fontFamily: 'Actay',
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: kPrimaryColor),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: kPrimaryColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: kPrimaryColor, width: 2),
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Отмена', style: TextStyle(color: kPrimaryColor)),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(_controller.text),
          child: const Text(
            'Сохранить',
            style: TextStyle(color: kPrimaryColor),
          ),
        ),
      ],
    );
  }
}
