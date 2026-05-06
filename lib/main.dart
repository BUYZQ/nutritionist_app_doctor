import 'package:flutter/material.dart';
import 'package:nutritionist_app/app.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('ru_RU', null);

  await Supabase.initialize(
    url: "https://jjdnfyfmmcqjxdgeayqk.supabase.co",
    anonKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImpqZG5meWZtbWNxanhkZ2VheXFrIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjIwNDc1MTYsImV4cCI6MjA3NzYyMzUxNn0.l5W6_z1a0EgR41UD2MUtZQLQWEKlqA2CN4jmgGtMlOU",
  );

  runApp(const NutritionistApp());
}

