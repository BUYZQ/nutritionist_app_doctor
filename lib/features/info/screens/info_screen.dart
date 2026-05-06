import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nutritionist_app/constants.dart';
import 'package:nutritionist_app/features/home/widgets/person_container.dart';
import 'package:nutritionist_app/features/info/screens/new_record_screen.dart';
import 'package:nutritionist_app/features/info/screens/record_screen.dart';
import 'package:nutritionist_app/widgets/my_button.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

class InfoScreen extends StatefulWidget {
  const InfoScreen({super.key});

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  static const String _windowsDocsDirectoryPath =
      r'C:\Users\admin\StudioProjects\nutritionist_app_doctor\docs';
  static const String _pinnedDocumentName = 'Список продуктов.docx';
  static final List<InfoArticle> _articles = [
    const InfoArticle(
      title: 'Что такое детокс и зачем он нужен',
      content:
          'Слово детокс (от англ. detoxification — обезвреживание, выведение токсичных веществ) сегодня звучит повсеместно: соки-детоксы, курсы очищения, специальные диеты, БАДы и даже детокс-уколы. Однако за модным термином скрывается смесь медицинских фактов, маркетинга и распространённых мифов. Разберёмся, что такое детокс на самом деле, как работает организм и когда очищение действительно необходимо.\n\n'
          'Что такое детокс с научной точки зрения?\n'
          'В медицине детоксикация — это комплекс диагностических и лечебных мер, направленных на выведение или нейтрализацию токсических веществ из организма. Это строго регламентированный процесс, применяемый при острых отравлениях лекарствами, химикатами, угарным газом или грибами; при алкогольной или наркотической абстиненции; при хронических профессиональных интоксикациях тяжёлыми металлами, пестицидами, промышленными растворителями; а также при нарушении функции печени или почек, требующем вспомогательной терапии.\n'
          'В бытовом и маркетинговом смысле детокс часто означает программы очищения для улучшения самочувствия, похудения или вывода шлаков. Научных доказательств эффективности таких программ нет.\n\n'
          'Как организм очищается сам?\n'
          'Здоровое тело — это отлаженная, круглосуточно работающая система детоксикации. Печень преобразует жирорастворимые токсины в водорастворимые формы, безопасные для выведения. Почки фильтруют кровь, выводят продукты обмена и водорастворимые токсины с мочой. Лёгкие удаляют летучие вещества, например углекислый газ или пары спирта. Кожа выделяет часть метаболитов с потом и кожным салом. Кишечник формирует и выводит каловые массы, содержащие отработанные желчные кислоты и непереваренные остатки. Иммунная система нейтрализует патогены, аллергены и клеточный мусор.\n'
          'Ни один здоровый человек не нуждается в дополнительном очищении извне. Органы справляются самостоятельно, если им не мешать хроническим стрессом, недосыпом, избытком алкоголя или ультраобработанными продуктами.\n\n'
          'Когда детокс действительно нужен?\n'
          'Медицинская детоксикация назначается только врачом в конкретных клинических ситуациях: поступление яда или токсина в организм; синдром отмены при зависимости; подтверждённое накопление тяжёлых металлов или промышленных токсинов; острая или хроническая печёночная или почечная недостаточность.\n'
          'В этих случаях используются сорбенты, антидоты, внутривенные инфузии, гемодиализ, плазмаферез или специфическая медикаментозная поддержка. Никакие смузи, чаи или детокс-браслеты здесь не заменят доказательную медицину.\n\n'
          'Популярные детокс-программы: мифы и реальность\n\n'
          'На полках магазинов и в соцсетях полно курсов 7-дневного очищения, голоданий, лимонадов с кайенским перцем, гидроколонотерапии и БАДов от шлаков. Что говорит наука?\n'
          'Миф: в организме копятся шлаки, которые нужно выводить. Реальность: шлаки — не медицинский термин. В физиологии такого понятия не существует. Организм не накапливает отходы бесконечно, а постоянно их перерабатывает и выводит.\n'
          'Миф: соки и монодиеты очищают организм. Реальность: они лишают тело белка, жиров и клетчатки, что может нарушить микробиом, замедлить метаболизм и снизить детоксикационную способность печени.\n'
          'Миф: после детокса чувствуется лёгкость. Реальность: чаще всего это результат потери воды, опорожнения кишечника и снижения калорийности, а не выведения токсинов.\n'
          'Миф: детокс-БАДы безопасны. Реальность: многие содержат слабительные, мочегонные или неизвестные растительные экстракты, которые могут повредить почки, печень или нарушить электролитный баланс.\n'
          'Риск таких программ превышает потенциальную пользу, особенно при хронических заболеваниях, беременности, приёме лекарств или расстройствах пищевого поведения.\n\n'
          'Как поддержать естественное очищение организма?\n'
          'Вместо поиска волшебного детокса лучше создать условия, при которых органы детоксикации работают максимально эффективно.\n'
          'Сбалансированное питание: достаточно белка как строительного материала для ферментов печени, овощей, фруктов, цельных злаков и полезных жиров.\n'
          'Достаточное потребление воды: 1,5–2 литра в сутки с учётом активности, климата и состояния здоровья. Вода необходима почкам и кишечнику.\n'
          'Регулярная физическая активность: улучшает кровообращение, лимфодренаж и перистальтику кишечника.\n'
          'Качественный сон 7–9 часов: ночью активнее всего работают восстановительные и глифатические процессы в мозге и печени.\n'
          'Ограничение токсинов: отказ от курения, умеренность в алкоголе, минимизация ультраобработанных продуктов и пластика при нагревании пищи.\n'
          'Контроль здоровья: регулярные анализы, лечение хронических заболеваний, коррекция дефицитов, например железа, витамина D, магния.\n'
          'Это и есть настоящий, научно обоснованный детокс-лайфстайл.',
      imageAsset: 'assets/info/products.png',
    ),
    const InfoArticle(
      title: 'Фитоксины в еде',
      content:
          'Фитоксины в еде — это тема, которую важно разбирать без крайностей. В некоторых растениях действительно есть природные защитные вещества, но в обычном рационе они редко представляют опасность. Гораздо важнее качество продуктов, разнообразие питания и корректная термическая обработка.',
    ),
    const InfoArticle(
      title: 'Разнообразное питание',
      content:
          'Разнообразное питание помогает получать более широкий спектр витаминов, минералов, клетчатки и других полезных веществ. Чем меньше рацион зациклен на нескольких продуктах, тем проще поддерживать баланс и снижать риск дефицитов.',
    ),
    const InfoArticle(
      title: 'Масло ГХИ и топлёное масло: в чём отличие',
      content:
          'Масло ГХИ и топлёное масло похожи, но не всегда полностью идентичны по технологии приготовления. Главное отличие обычно связано с более длительным выпариванием влаги и удалением молочных белков, что влияет на вкус, аромат и устойчивость при нагревании.',
    ),
    const InfoArticle(
      title: 'Что такое стресс и как его минимизировать',
      content:
          'Стресс — это естественная реакция организма на нагрузку, изменения и угрозу. Полностью убрать его нельзя, но можно уменьшить влияние: наладить сон, питание, режим дня, физическую активность и восстановление.',
    ),
    const InfoArticle(
      title: 'Сон, как нормализовать его',
      content:
          'Качественный сон напрямую влияет на аппетит, уровень энергии, настроение и восстановление организма. Для нормализации сна полезны стабильный режим, ограничение яркого света вечером и снижение стимуляторов во второй половине дня.',
    ),
    const InfoArticle(
      title: 'Чем полезна вода для организма человека',
      content:
          'Вода участвует в терморегуляции, транспорте питательных веществ, пищеварении и выведении продуктов обмена. Достаточное потребление жидкости помогает поддерживать самочувствие, концентрацию и нормальную работу органов.',
    ),
    const InfoArticle(
      title: 'Почему иногда стоит отказаться от мяса',
      content:
          'В некоторых ситуациях снижение количества мяса или временный отказ от него может помочь разнообразить рацион и добавить больше растительных источников клетчатки. Важно, чтобы такие изменения были осознанными и не приводили к дефициту белка, железа и витамина B12.',
    ),
    const InfoArticle(
      title:
          'Продукты для здоровья печени и желчного как основных органов детокса',
      content:
          'Печень и желчный пузырь играют важную роль в обмене веществ и выведении ненужных соединений. Поддержка этих органов обычно строится не на “чистках”, а на регулярном питании, умеренности в алкоголе, достаточном количестве клетчатки и общем здоровом образе жизни.',
    ),
    const InfoArticle(
      title: 'Тонкий кишечник',
      content:
          'Тонкий кишечник — ключевой отдел пищеварительной системы, где происходит основное всасывание питательных веществ. Его работа зависит от общего состояния ЖКТ, качества рациона и переносимости отдельных продуктов.',
    ),
    const InfoArticle(
      title: 'Толстый кишечник',
      content:
          'Толстый кишечник отвечает за формирование стула, всасывание воды и взаимодействие с кишечной микрофлорой. Для его здоровья особенно важны клетчатка, достаточное питьё и регулярная физическая активность.',
    ),
  ];

  bool isSelectMainInfo = true;
  bool _isLoadingDocuments = true;
  final List<File> _documents = [];
  String? _documentsError;

  @override
  void initState() {
    super.initState();
    _loadDocuments();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8F1EA),
      body: Column(
        children: [
          const PersonContainer(),
          const SizedBox(height: 20),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                spacing: 10,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 50,
                    child: MyButton(
                      foregroundColor: isSelectMainInfo
                          ? Colors.white
                          : kPrimaryColor,
                      bgColor: isSelectMainInfo ? kPrimaryColor : Colors.white,
                      title: 'Рецепты и продукты',
                      onPressed: () {
                        setState(() {
                          isSelectMainInfo = true;
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    height: 50,
                    child: MyButton(
                      foregroundColor: !isSelectMainInfo
                          ? Colors.white
                          : kPrimaryColor,
                      bgColor: !isSelectMainInfo ? kPrimaryColor : Colors.white,
                      title: 'Важная информация',
                      onPressed: () {
                        setState(() {
                          isSelectMainInfo = false;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 20),
              child: isSelectMainInfo
                  ? _buildDocumentsSection()
                  : _buildPostsSection(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDocumentsSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withAlpha(200),
                  blurRadius: 1,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: Material(
              color: const Color(0xffFFFDFA),
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              child: InkWell(
                onTap: _pickAndAddWordFile,
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 22,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Добавить новый файл',
                        style: TextStyle(
                          color: kPrimaryColor,
                          fontSize: 16,
                          fontFamily: 'ActayWide',
                        ),
                      ),
                      IconButton(
                        onPressed: _pickAndAddWordFile,
                        icon: Image.asset('assets/home/add.png', width: 30),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 4),
          if (_isLoadingDocuments)
            const Padding(
              padding: EdgeInsets.only(top: 40),
              child: Center(
                child: CircularProgressIndicator(color: kPrimaryColor),
              ),
            )
          else if (_documentsError != null)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: const Color(0xffFFFDFA),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                _documentsError!,
                style: const TextStyle(
                  color: kPrimaryColor,
                  fontSize: 14,
                  fontFamily: 'Actay',
                ),
              ),
            )
          else if (_documents.isEmpty)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: const Color(0xffFFFDFA),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                'В папке docs пока нет Word-документов.',
                style: TextStyle(
                  color: kPrimaryColor,
                  fontSize: 14,
                  fontFamily: 'Actay',
                ),
              ),
            )
          else
            ..._documents.map(_buildDocumentCard),
        ],
      ),
    );
  }

  Widget _buildPostsSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withAlpha(200),
                  blurRadius: 1,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: Material(
              color: const Color(0xffFFFDFA),
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              child: InkWell(
                onTap: _openNewRecordScreen,
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 22,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Добавить новый файл',
                        style: TextStyle(
                          color: kPrimaryColor,
                          fontSize: 16,
                          fontFamily: 'ActayWide',
                        ),
                      ),
                      IconButton(
                        onPressed: _openNewRecordScreen,
                        icon: Image.asset('assets/home/add.png', width: 30),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 4),
          ..._articles.map(_buildArticleCard),
        ],
      ),
    );
  }

  Widget _buildArticleCard(InfoArticle article) {
    return Card(
      color: const Color(0xffFFFDFA),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () => _openArticle(article),
        child: Container(
          padding: const EdgeInsets.all(20),
          child: ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Image.asset(article.imageAsset),
            title: Text(
              article.title,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                fontFamily: 'ActayWide',
                color: kPrimaryColor,
              ),
            ),
            trailing: IconButton(
              onPressed: () => _deleteArticle(article),
              icon: Image.asset('assets/home/close.png', width: 25),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDocumentCard(File file) {
    final fileName = p.basenameWithoutExtension(file.path);

    return Card(
      color: const Color(0xffFFFDFA),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () => _openDocument(file),
        child: Container(
          padding: const EdgeInsets.all(20),
          child: ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(40),
                border: Border.all(color: const Color(0xff313F3F)),
              ),
              child: Image.asset('assets/info/list.png', width: 25),
            ),
            title: Text(
              _formatDocumentTitle(fileName),
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                fontFamily: 'ActayWide',
                color: kPrimaryColor,
              ),
            ),
            trailing: IconButton(
              onPressed: () => _deleteDocument(file),
              icon: Image.asset(
                'assets/home/close.png',
                width: 30,
                color: kPrimaryColor,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _openNewRecordScreen() async {
    final newRecord = await Navigator.of(context).push<NewRecordResult>(
      MaterialPageRoute(
        builder: (context) {
          return const NewRecordScreen();
        },
      ),
    );

    if (!mounted || newRecord == null) return;

    setState(() {
      _articles.insert(
        0,
        InfoArticle(
          title: newRecord.title,
          content: newRecord.content,
          imageAsset: 'assets/info/products.png',
        ),
      );
    });
    _showSnackBar('Новый пост добавлен.');
  }

  void _openArticle(InfoArticle article) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return RecordScreen(
            title: article.title,
            content: article.content,
            onContentChanged: (updatedContent) {
              _updateArticleContent(article, updatedContent);
            },
          );
        },
      ),
    );
  }

  void _updateArticleContent(InfoArticle article, String updatedContent) {
    final articleIndex = _articles.indexOf(article);
    if (articleIndex == -1) return;

    setState(() {
      _articles[articleIndex] = article.copyWith(content: updatedContent);
    });
  }

  Future<void> _deleteArticle(InfoArticle article) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: const Color(0xffFFFDFA),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text(
            'Удалить статью?',
            style: TextStyle(
              color: kPrimaryColor,
              fontSize: 18,
              fontFamily: 'ActayWide',
            ),
          ),
          content: Text(
            'Статья "${article.title}" будет удалена из списка.',
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

    setState(() {
      _articles.remove(article);
    });
    _showSnackBar('Статья удалена.');
  }

  Future<void> _loadDocuments() async {
    try {
      final docsDirectory = await _resolveDocumentsDirectory();

      if (!await docsDirectory.exists()) {
        await docsDirectory.create(recursive: true);
      }

      if (!Platform.isWindows) {
        await _seedBundledDocuments(docsDirectory);
      }

      final documents =
          docsDirectory
              .listSync()
              .whereType<File>()
              .where(_isWordDocument)
              .toList()
            ..sort((a, b) {
              final aName = p.basename(a.path);
              final bName = p.basename(b.path);
              final aPinned =
                  aName.toLowerCase() == _pinnedDocumentName.toLowerCase();
              final bPinned =
                  bName.toLowerCase() == _pinnedDocumentName.toLowerCase();

              if (aPinned && !bPinned) return -1;
              if (!aPinned && bPinned) return 1;

              return aName.toLowerCase().compareTo(bName.toLowerCase());
            });

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

  Future<void> _openDocument(File file) async {
    final result = await OpenFilex.open(file.path);

    if (!mounted) return;
    if (result.type == ResultType.done) return;

    _showSnackBar(
      result.message.isNotEmpty
          ? result.message
          : 'Не удалось открыть документ во внешней программе.',
    );
  }

  Future<void> _pickAndAddWordFile() async {
    final pickedFile = await FilePicker.pickFiles(
      type: FileType.custom,
      allowedExtensions: const ['doc', 'docx'],
      allowMultiple: false,
    );

    if (pickedFile == null || pickedFile.files.single.path == null) return;

    final sourceFile = File(pickedFile.files.single.path!);
    final docsDirectory = await _resolveDocumentsDirectory();

    if (!await docsDirectory.exists()) {
      await docsDirectory.create(recursive: true);
    }

    final targetPath = await _buildUniqueDocumentPath(
      docsDirectory.path,
      p.basename(sourceFile.path),
    );

    try {
      await sourceFile.copy(targetPath);
      await _loadDocuments();

      if (!mounted) return;
      _showSnackBar('Файл добавлен в список документов.');
    } catch (_) {
      _showSnackBar('Не удалось прикрепить Word-файл.');
    }
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
      _showSnackBar('Документ удалён.');
    } catch (error) {
      _showSnackBar('Не удалось удалить документ: $error');
    }
  }

  Future<String> _buildUniqueDocumentPath(
    String directoryPath,
    String originalFileName,
  ) async {
    final extension = p.extension(originalFileName);
    final name = p.basenameWithoutExtension(originalFileName);
    var index = 0;

    while (true) {
      final candidateName = index == 0
          ? '$name$extension'
          : '$name ($index)$extension';
      final candidatePath = p.join(directoryPath, candidateName);

      if (!await File(candidatePath).exists()) {
        return candidatePath;
      }

      index++;
    }
  }

  bool _isWordDocument(File file) {
    final extension = p.extension(file.path).toLowerCase();
    return extension == '.doc' || extension == '.docx';
  }

  String _formatDocumentTitle(String fileName) {
    return fileName
        .replaceAll('_', ' ')
        .replaceAllMapped(
          RegExp(r'(^|\s)([a-zA-Zа-яА-Я])'),
          (match) => '${match.group(1)}${match.group(2)!.toUpperCase()}',
        );
  }

  void _showSnackBar(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  Future<Directory> _resolveDocumentsDirectory() async {
    if (Platform.isWindows) {
      return Directory(_windowsDocsDirectoryPath);
    }

    final appDirectory = await getApplicationDocumentsDirectory();
    return Directory(p.join(appDirectory.path, 'doctor_docs'));
  }

  Future<void> _seedBundledDocuments(Directory targetDirectory) async {
    final manifestContent = await rootBundle.loadString('AssetManifest.json');
    final manifestMap = jsonDecode(manifestContent) as Map<String, dynamic>;

    final bundledDocs = manifestMap.keys
        .where(
          (assetPath) =>
              assetPath.startsWith('docs/') &&
              (assetPath.toLowerCase().endsWith('.doc') ||
                  assetPath.toLowerCase().endsWith('.docx')),
        )
        .toList();

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
}

class InfoArticle {
  final String title;
  final String content;
  final String imageAsset;

  const InfoArticle({
    required this.title,
    required this.content,
    this.imageAsset = 'assets/info/Intestine.png',
  });

  InfoArticle copyWith({String? title, String? content, String? imageAsset}) {
    return InfoArticle(
      title: title ?? this.title,
      content: content ?? this.content,
      imageAsset: imageAsset ?? this.imageAsset,
    );
  }
}
