import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:just_audio/just_audio.dart';
import 'package:nutritionist_app/constants.dart';
import 'package:nutritionist_app/features/message/data/user_chat_info.dart';
import 'package:nutritionist_app/features/message/widgets/chat_user_bar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({
    super.key,
    required this.patient,
  });

  final UserChatInfo patient;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  static final Map<String, List<_ChatMessage>> _chatStorage = {};

  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final ImagePicker _imagePicker = ImagePicker();
  final AudioRecorder _audioRecorder = AudioRecorder();
  final AudioPlayer _audioPlayer = AudioPlayer();

  late final List<_ChatMessage> _messages;

  StreamSubscription<PlayerState>? _playerStateSubscription;
  Timer? _recordingTimer;

  bool _isSend = false;
  bool _isRecording = false;
  bool _isAudioPlaying = false;
  String? _playingMessageId;
  DateTime? _recordingStartedAt;
  Duration _recordingDuration = Duration.zero;

  @override
  void initState() {
    super.initState();
    _messages = _chatStorage.putIfAbsent(
      widget.patient.id,
      () => widget.patient.seedMessages
          .map(
            (message) => _ChatMessage.text(
              id: '${widget.patient.id}-${message.text.hashCode}',
              text: message.text,
              isUser: message.isDoctor,
            ),
          )
          .toList(),
    );
    _playerStateSubscription = _audioPlayer.playerStateStream.listen((state) {
      if (!mounted) return;

      final isCompleted = state.processingState == ProcessingState.completed;

      setState(() {
        _isAudioPlaying = state.playing && !isCompleted;
        if (isCompleted) {
          _playingMessageId = null;
        }
      });
    });
  }

  @override
  void dispose() {
    _playerStateSubscription?.cancel();
    _recordingTimer?.cancel();
    _controller.dispose();
    _scrollController.dispose();
    unawaited(_disposeMedia());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/message/background.jpg',
              fit: BoxFit.fill,
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                ChatUserBar(patient: widget.patient),
                Expanded(
                  child: ListView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.all(16),
                    reverse: true,
                    itemCount: _messages.length,
                    itemBuilder: (context, index) {
                      final message = _messages[_messages.length - 1 - index];

                      return Align(
                        alignment: message.isUser
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: _buildMessageBubble(message),
                      );
                    },
                  ),
                ),
                _buildComposer(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildComposer() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 25, horizontal: 15),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xffFFFDFA),
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Color(0x26313F3F),
            blurRadius: 2,
            offset: Offset(1, 1),
          ),
        ],
      ),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 220),
        child: _isRecording
            ? _buildRecordingComposer()
            : _buildDefaultComposer(),
      ),
    );
  }

  Widget _buildDefaultComposer() {
    return Row(
      key: const ValueKey('default-composer'),
      children: [
        Expanded(
          child: TextField(
            controller: _controller,
            minLines: 1,
            maxLines: 4,
            onChanged: (value) {
              setState(() {
                _isSend = value.trim().isNotEmpty;
              });
            },
            style: const TextStyle(
              fontFamily: 'Actay',
              fontWeight: FontWeight.w600,
              fontSize: 15,
              color: kPrimaryColor,
            ),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(vertical: 12),
              prefixIcon: IconButton(
                onPressed: _showImageSourceSheet,
                icon: Image.asset('assets/message/clip.png', width: 20),
              ),
              hintText: 'Введите сообщение...',
              hintStyle: const TextStyle(
                color: Color(0xff899595),
                fontFamily: 'Actay',
              ),
              border: InputBorder.none,
            ),
          ),
        ),
        _isSend ? _buildSendButton() : _buildVoiceButton(),
      ],
    );
  }

  Widget _buildRecordingComposer() {
    return Row(
      key: const ValueKey('recording-composer'),
      children: [
        const SizedBox(width: 12),
        Text(
          _formatDuration(_recordingDuration),
          style: const TextStyle(
            color: kPrimaryColor,
            fontSize: 14,
            fontWeight: FontWeight.w600,
            fontFamily: 'Actay',
          ),
        ),
        const Spacer(),
        TextButton(
          onPressed: _cancelVoiceRecording,
          child: const Text(
            'Отмена',
            style: TextStyle(
              color: kPrimaryColor,
              fontFamily: 'Actay',
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const Spacer(),
        IconButton(
          onPressed: () => _stopVoiceRecording(send: true),
          icon: Image.asset('assets/message/send.png', width: 20),
        ),
      ],
    );
  }

  Widget _buildSendButton() {
    return IconButton(
      onPressed: _sendTextMessage,
      icon: Image.asset('assets/message/send.png', width: 20),
    );
  }

  Widget _buildVoiceButton() {
    return Tooltip(
      message: 'Удерживайте для записи голосового сообщения',
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(18),
          onTap: () {
            _showSnackBar('Зажмите микрофон, чтобы начать запись.');
          },
          onLongPress: _startVoiceRecording,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Image.asset('assets/message/micro.png', width: 15),
          ),
        ),
      ),
    );
  }

  Widget _buildMessageBubble(_ChatMessage message) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(12),
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width * 0.75,
      ),
      decoration: BoxDecoration(
        color: const Color(0xffFFFDFA),
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Color(0x26313F3F),
            blurRadius: 2,
            offset: Offset(1, 1),
          ),
        ],
      ),
      child: _buildMessageContent(message),
    );
  }

  Widget _buildMessageContent(_ChatMessage message) {
    switch (message.type) {
      case _ChatMessageType.text:
        return Text(
          message.text ?? '',
          style: const TextStyle(
            color: kPrimaryColor,
            fontSize: 14,
            fontFamily: 'Actay',
          ),
        );
      case _ChatMessageType.image:
        final path = message.filePath;
        if (path == null || !File(path).existsSync()) {
          return const Text(
            'Изображение недоступно',
            style: TextStyle(
              color: kPrimaryColor,
              fontSize: 14,
              fontFamily: 'ActayWide',
            ),
          );
        }

        return ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.file(
            File(path),
            width: 220,
            height: 220,
            fit: BoxFit.cover,
          ),
        );
      case _ChatMessageType.audio:
        final isPlayingCurrent =
            _playingMessageId == message.id && _isAudioPlaying;

        return InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () => _playOrPauseAudio(message),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: const BoxDecoration(
                  color: Color(0xffEEF2ED),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  isPlayingCurrent ? Icons.pause_rounded : Icons.play_arrow_rounded,
                  color: kPrimaryColor,
                ),
              ),
              const SizedBox(width: 12),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Голосовое сообщение',
                      style: TextStyle(
                        color: kPrimaryColor,
                        fontSize: 13,
                        fontFamily: 'ActayWide',
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _formatDuration(message.audioDuration ?? Duration.zero),
                      style: const TextStyle(
                        color: Color(0xff899595),
                        fontSize: 13,
                        fontFamily: 'Actay',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
    }
  }

  Future<void> _showImageSourceSheet() async {
    final source = await showModalBottomSheet<ImageSource>(
      context: context,
      backgroundColor: Colors.white,
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.photo_library_outlined),
                title: const Text('Галерея'),
                onTap: () => Navigator.of(context).pop(ImageSource.gallery),
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera_outlined),
                title: const Text('Камера'),
                onTap: () => Navigator.of(context).pop(ImageSource.camera),
              ),
            ],
          ),
        );
      },
    );

    if (source == null || !mounted) return;
    await _pickImage(source);
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final image = await _imagePicker.pickImage(
        source: source,
        imageQuality: 88,
      );

      if (image == null || !mounted) return;

      setState(() {
        _messages.add(
          _ChatMessage.image(
            id: DateTime.now().microsecondsSinceEpoch.toString(),
            filePath: image.path,
            isUser: true,
          ),
        );
      });

      _scrollToLatest();
    } catch (_) {
      _showSnackBar('Не удалось прикрепить изображение.');
    }
  }

  Future<void> _startVoiceRecording() async {
    if (_isRecording) return;

    try {
      final hasPermission = await _audioRecorder.hasPermission();
      if (!hasPermission) {
        _showSnackBar('Нет доступа к микрофону.');
        return;
      }

      await _audioPlayer.stop();

      final directory = await getTemporaryDirectory();
      final filePath =
          '${directory.path}\\voice_${DateTime.now().millisecondsSinceEpoch}.m4a';

      await _audioRecorder.start(
        const RecordConfig(encoder: AudioEncoder.aacLc),
        path: filePath,
      );

      _recordingTimer?.cancel();
      _recordingStartedAt = DateTime.now();

      setState(() {
        _isRecording = true;
        _recordingDuration = Duration.zero;
      });

      _recordingTimer = Timer.periodic(const Duration(seconds: 1), (_) {
        final startedAt = _recordingStartedAt;
        if (!mounted || startedAt == null) return;

        setState(() {
          _recordingDuration = DateTime.now().difference(startedAt);
        });
      });
    } catch (_) {
      _showSnackBar('Не удалось начать запись.');
    }
  }

  Future<void> _cancelVoiceRecording() async {
    if (!_isRecording) return;

    try {
      await _audioRecorder.cancel();
    } catch (_) {
      _showSnackBar('Не удалось отменить запись.');
    } finally {
      _resetRecordingState();
    }
  }

  Future<void> _stopVoiceRecording({required bool send}) async {
    if (!_isRecording) return;

    final startedAt = _recordingStartedAt;
    final duration = startedAt == null
        ? _recordingDuration
        : DateTime.now().difference(startedAt);

    try {
      final path = await _audioRecorder.stop();
      _resetRecordingState();

      if (!send || path == null || !mounted) return;

      setState(() {
        _messages.add(
          _ChatMessage.audio(
            id: DateTime.now().microsecondsSinceEpoch.toString(),
            filePath: path,
            audioDuration:
                duration < const Duration(seconds: 1)
                    ? const Duration(seconds: 1)
                    : duration,
            isUser: true,
          ),
        );
      });

      _scrollToLatest();
    } catch (_) {
      _resetRecordingState();
      _showSnackBar('Не удалось сохранить голосовое сообщение.');
    }
  }

  Future<void> _playOrPauseAudio(_ChatMessage message) async {
    final path = message.filePath;
    if (path == null || !File(path).existsSync()) {
      _showSnackBar('Аудиофайл недоступен.');
      return;
    }

    try {
      if (_playingMessageId == message.id) {
        if (_isAudioPlaying) {
          await _audioPlayer.pause();
          return;
        }

        if (_audioPlayer.processingState == ProcessingState.completed) {
          await _audioPlayer.seek(Duration.zero);
        }

        await _audioPlayer.play();
        return;
      }

      await _audioPlayer.setFilePath(path);

      if (!mounted) return;
      setState(() {
        _playingMessageId = message.id;
      });

      await _audioPlayer.play();
    } catch (_) {
      _showSnackBar('Не удалось воспроизвести голосовое сообщение.');
    }
  }

  void _sendTextMessage() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _messages.add(
        _ChatMessage.text(
          id: DateTime.now().microsecondsSinceEpoch.toString(),
          text: text,
          isUser: true,
        ),
      );
      _isSend = false;
    });

    _controller.clear();
    _scrollToLatest();
  }

  void _scrollToLatest() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_scrollController.hasClients) return;
      _scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 240),
        curve: Curves.easeOut,
      );
    });
  }

  void _resetRecordingState() {
    _recordingTimer?.cancel();
    _recordingTimer = null;

    if (!mounted) return;
    setState(() {
      _isRecording = false;
      _recordingStartedAt = null;
      _recordingDuration = Duration.zero;
    });
  }

  void _showSnackBar(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  Future<void> _disposeMedia() async {
    try {
      if (_isRecording) {
        await _audioRecorder.cancel();
      }
    } catch (_) {}

    await _audioRecorder.dispose();
    await _audioPlayer.dispose();
  }

  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }
}

enum _ChatMessageType { text, image, audio }

class _ChatMessage {
  const _ChatMessage._({
    required this.id,
    required this.type,
    required this.isUser,
    this.text,
    this.filePath,
    this.audioDuration,
  });

  factory _ChatMessage.text({
    required String id,
    required String text,
    required bool isUser,
  }) {
    return _ChatMessage._(
      id: id,
      type: _ChatMessageType.text,
      isUser: isUser,
      text: text,
    );
  }

  factory _ChatMessage.image({
    required String id,
    required String filePath,
    required bool isUser,
  }) {
    return _ChatMessage._(
      id: id,
      type: _ChatMessageType.image,
      isUser: isUser,
      filePath: filePath,
    );
  }

  factory _ChatMessage.audio({
    required String id,
    required String filePath,
    required Duration audioDuration,
    required bool isUser,
  }) {
    return _ChatMessage._(
      id: id,
      type: _ChatMessageType.audio,
      isUser: isUser,
      filePath: filePath,
      audioDuration: audioDuration,
    );
  }

  final String id;
  final _ChatMessageType type;
  final bool isUser;
  final String? text;
  final String? filePath;
  final Duration? audioDuration;
}
