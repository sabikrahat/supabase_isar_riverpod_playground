import 'package:supabase_flutter/supabase_flutter.dart';

const supabaseUrl = 'https://cyjrbubummqezxzryfre.supabase.co';
const supabaseAnonKey =
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImN5anJidWJ1bW1xZXp4enJ5ZnJlIiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTEyMzE2MTIsImV4cCI6MjAwNjgwNzYxMn0.X3BR9XeadIJBzxiPqf7vIZaHHI7IU7ybGw9kinaP144';

late Supabase sb;
late SupabaseClient sbc;

Future<void> initSupabase() async {
  sb = await Supabase.initialize(
    url: supabaseUrl,
    anonKey: supabaseAnonKey,
  );
  sbc = Supabase.instance.client;
}
