class UserChatInfo {
  const UserChatInfo({
    required this.id,
    required this.fullName,
    required this.avatarPath,
    required this.lastSeenText,
    required this.seedMessages,
  });

  final String id;
  final String fullName;
  final String avatarPath;
  final String lastSeenText;
  final List<UserChatSeedMessage> seedMessages;
}

class UserChatSeedMessage {
  const UserChatSeedMessage({
    required this.text,
    required this.isDoctor,
  });

  final String text;
  final bool isDoctor;
}

const List<UserChatInfo> kDoctorChats = [
  UserChatInfo(
    id: 'uliana',
    fullName: 'Ульяна Владимировна',
    avatarPath: 'assets/users/uliana.png',
    lastSeenText: 'Была в сети в 15:30',
    seedMessages: [
      UserChatSeedMessage(
        text:
            'Здравствуйте, Ульяна Владимировна! Меня зовут Евгения Александровна, я врач-нутрициолог.Буду рада помочь вам разобраться в вопросах питания и подобрать индивидуальный план для улучшения самочувствия и достижения ваших целей. Готова ответить на все ваши вопросы',
        isDoctor: true,
      ),
      UserChatSeedMessage(
        text:
            'Здравсвуйте. Хорошо, я вас поняла, Евгения Александровна',
        isDoctor: false,
      ),
    ],
  ),
  UserChatInfo(
    id: 'viktor',
    fullName: 'Виктор Андреевич',
    avatarPath: 'assets/users/viktor.png',
    lastSeenText: 'Был в сети в 12:10',
    seedMessages: [
      UserChatSeedMessage(
        text:
            'Здравствуйте, Виктор Андреевич! Меня зовут Евгения Александровна, я врач-нутрициолог. Буду рада помочь вам разобраться в вопросах питания и подобрать индивидуальный план для улучшения самочувствия и достижения ваших целей. Готова ответить на все ваши вопросы',
        isDoctor: true,
      ),
      UserChatSeedMessage(
        text: 'Здравсвуйте. Хорошо, я вас понял, Евгения Александровна',
        isDoctor: false,
      ),
    ],
  ),
  UserChatInfo(
    id: 'viktoriya',
    fullName: 'Виктория Витальевна',
    avatarPath: 'assets/users/viktoriya.png',
    lastSeenText: 'Была в сети в 09:45',
    seedMessages: [
      UserChatSeedMessage(
        text:
            'Здравствуйте, Виктория Витальевна! Меня зовут Евгения Александровна, я врач-нутрициолог.Буду рада помочь вам разобраться в вопросах питания и подобрать индивидуальный план для улучшения самочувствия и достижения ваших целей. Готова ответить на все ваши вопросы',
        isDoctor: true,
      ),
      UserChatSeedMessage(
        text: 'Здравсвуйте. Хорошо, я вас поняла, Евгения Александровна',
        isDoctor: false,
      ),
    ],
  ),
  UserChatInfo(
    id: 'ivan',
    fullName: 'Иван Иванович',
    avatarPath: 'assets/users/ivan.png',
    lastSeenText: 'Был в сети в 18:05',
    seedMessages: [
      UserChatSeedMessage(
        text:
            'Здравствуйте, Иван Иванович! Меня зовут Евгения Александровна, я врач-нутрициолог. Буду рада помочь вам разобраться в вопросах питания и подобрать индивидуальный план для улучшения самочувствия и достижения ваших целей. Готова ответить на все ваши вопросы',
        isDoctor: true,
      ),
      UserChatSeedMessage(
        text: 'Здравсвуйте. Хорошо, я вас понял, Евгения Александровна',
        isDoctor: false,
      ),
    ],
  ),
  UserChatInfo(
    id: 'elena',
    fullName: 'Елена Антоновна',
    avatarPath: 'assets/users/elena.png',
    lastSeenText: 'Была в сети в 16:20',
    seedMessages: [
      UserChatSeedMessage(
        text:
            'Здравствуйте, Елена Антоновна! Меня зовут Евгения Александровна, я врач-нутрициолог. Буду рада помочь вам разобраться в вопросах питания и подобрать индивидуальный план для улучшения самочувствия и достижения ваших целей. Готова ответить на все ваши вопросы',
        isDoctor: true,
      ),
      UserChatSeedMessage(
        text: 'Здравсвуйте. Хорошо, я вас поняла, Евгения Александровна',
        isDoctor: false,
      ),
    ],
  ),
];
