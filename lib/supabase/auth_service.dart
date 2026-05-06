import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final SupabaseClient _client = Supabase.instance.client;

  /// Подписка на изменение состояния авторизации
  Stream<AuthState> get onAuthStateChange => _client.auth.onAuthStateChange;

  /// Текущий пользователь
  User? get currentUser => _client.auth.currentUser;

  /// Проверка, вошёл ли пользователь
  bool get isSignedIn => currentUser != null;

  /// 1️⃣ Отправляем OTP на телефон
  Future<void> sendOtp({required String phone}) async {
    await _client.auth.signInWithOtp(phone: phone);
  }

  /// 2️⃣ Проверяем OTP и возвращаем ответ
  Future<AuthResponse> verifyOtp({
    required String phone,
    required String token,
  }) async {
    final response = await _client.auth.verifyOTP(
      type: OtpType.sms,
      phone: phone,
      token: token,
    );
    return response;
  }

  /// 3️⃣ После успешной регистрации создаем профиль пользователя
  Future<void> createUserProfile({
    required String fullName,
    required String gender,
    required DateTime birthDate,
    required String country,
    required String phone,
  }) async {
    final user = _client.auth.currentUser;
    if (user == null) {
      throw Exception('Пользователь не авторизован');
    }

    final data = {
      'id': user.id,
      'full_name': fullName,
      'gender': gender,
      'birth_date': birthDate.toIso8601String(),
      'country': country,
      'phone': phone,
    };

    final response = await _client.from('profiles').insert(data);

    if (response.error != null) {
      throw Exception('Ошибка при сохранении профиля: ${response.error!.message}');
    }
  }

  /// 4️⃣ Получение профиля пользователя
  Future<Map<String, dynamic>?> getUserProfile() async {
    final user = _client.auth.currentUser;
    if (user == null) return null;

    final response = await _client
        .from('profiles')
        .select()
        .eq('id', user.id)
        .maybeSingle();

    if (response == null) return null;
    return response;
  }

  /// 5️⃣ Выход
  Future<void> signOut() async {
    await _client.auth.signOut();
  }
}
