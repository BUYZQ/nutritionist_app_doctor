class AuthValidators {
  /// Валидация номера телефона
  /// Проверяет, что номер телефона не пусто и содержит только цифры
  static String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Пожалуйста, введите номер телефона';
    }
    
    // Удаляем все нецифровые символы для проверки
    final digitsOnly = value.replaceAll(RegExp(r'[^\d]'), '');
    
    if (digitsOnly.length < 10) {
      return 'Номер телефона должен содержать минимум 10 цифр';
    }
    
    if (digitsOnly.length > 15) {
      return 'Номер телефона слишком длинный';
    }
    
    return null;
  }

  /// Валидация пароля
  /// Проверяет минимальную длину пароля
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Пожалуйста, введите пароль';
    }
    
    if (value.length < 6) {
      return 'Пароль должен содержать минимум 6 символов';
    }
    
    return null;
  }

  /// Валидация совпадения пароли
  static String? validatePasswordMatch(String? value, String? password) {
    if (value == null || value.isEmpty) {
      return 'Пожалуйста, повторите пароль';
    }
    
    if (value != password) {
      return 'Пароли не совпадают';
    }
    
    return null;
  }

  /// Валидация ФИО
  static String? validateFullName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Пожалуйста, введите ФИО';
    }
    
    if (value.length < 3) {
      return 'ФИО должно содержать минимум 3 символа';
    }
    
    if (value.length > 100) {
      return 'ФИО слишком длинное';
    }
    
    return null;
  }

  /// Валидация пола
  static String? validateGender(String? value) {
    if (value == null || value.isEmpty) {
      return 'Пожалуйста, выберите пол';
    }
    
    final validGenders = ['Мужской', 'Женский', 'Другое', 'М', 'Ж'];
    if (!validGenders.contains(value)) {
      return 'Пожалуйста, выберите корректный пол';
    }
    
    return null;
  }

  /// Валидация даты рождения
  static String? validateDateOfBirth(String? value) {
    if (value == null || value.isEmpty) {
      return 'Пожалуйста, введите дату рождения';
    }
    
    // Проверка формата даты (DD.MM.YYYY или DD/MM/YYYY)
    final dateFormat = RegExp(r'^\d{2}[./]\d{2}[./]\d{4}$');
    if (!dateFormat.hasMatch(value)) {
      return 'Пожалуйста, используйте формат ДД.ММ.ГГГГ';
    }
    
    try {
      final parts = value.replaceAll(RegExp(r'[./]'), '/').split('/');
      final day = int.parse(parts[0]);
      final month = int.parse(parts[1]);
      final year = int.parse(parts[2]);
      
      final date = DateTime(year, month, day);
      final now = DateTime.now();
      
      if (date.isAfter(now)) {
        return 'Дата рождения не может быть в будущем';
      }
      
      final age = now.year - date.year;
      if (age < 13) {
        return 'Минимальный возраст 13 лет';
      }
      
    } catch (e) {
      return 'Пожалуйста, введите корректную дату';
    }
    
    return null;
  }

  /// Валидация страны
  static String? validateCountry(String? value) {
    if (value == null || value.isEmpty) {
      return 'Пожалуйста, выберите страну';
    }
    
    if (value.length < 2) {
      return 'Название страны слишком короткое';
    }
    
    return null;
  }

  /// Валидация кода подтверждения
  static String? validateOtpCode(String? value) {
    if (value == null || value.isEmpty) {
      return 'Пожалуйста, введите код подтверждения';
    }
    
    if (value.length < 4) {
      return 'Код должен содержать минимум 4 символа';
    }
    
    if (value.length > 6) {
      return 'Код должен содержать максимум 6 символов';
    }
    
    // Проверяем, что код содержит только цифры
    if (!RegExp(r'^\d+$').hasMatch(value)) {
      return 'Код должен содержать только цифры';
    }
    
    return null;
  }

  /// Валидация всех полей регистрации
  static Map<String, String?> validateRegistration({
    required String fullName,
    required String gender,
    required String dateOfBirth,
    required String country,
    required String phone,
    required String password,
    required String confirmPassword,
  }) {
    return {
      'fullName': validateFullName(fullName),
      'gender': validateGender(gender),
      'dateOfBirth': validateDateOfBirth(dateOfBirth),
      'country': validateCountry(country),
      'phone': validatePhone(phone),
      'password': validatePassword(password),
      'confirmPassword': validatePasswordMatch(confirmPassword, password),
    };
  }

  /// Валидация всех полей логирования
  static Map<String, String?> validateLogin({
    required String phone,
    required String password,
  }) {
    return {
      'phone': validatePhone(phone),
      'password': validatePassword(password),
    };
  }

  /// Проверка есть ли ошибки валидации
  static bool hasValidationErrors(Map<String, String?> errors) {
    return errors.values.any((error) => error != null);
  }
}
