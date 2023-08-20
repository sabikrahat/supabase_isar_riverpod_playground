import 'dart:async';

import 'package:supabase_flutter/supabase_flutter.dart';

import '../utils/logger/logger_helper.dart';

const supabaseUrl = 'https://oyckesnrwaxmidnvgdtr.supabase.co';
const supabaseAnonKey =
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im95Y2tlc25yd2F4bWlkbnZnZHRyIiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTI0OTAwNzUsImV4cCI6MjAwODA2NjA3NX0.cUXzUD3niOMP7ArlpnigGtOTL52VsT8bl8EAiaxiHGY';

late Supabase sb;
late SupabaseClient sbc;

Future<void> initSupabase() async {
  sb = await Supabase.initialize(
    debug: false,
    url: supabaseUrl,
    anonKey: supabaseAnonKey,
  );
  sbc = Supabase.instance.client;

  log.i('Supabase initialized: ${sbc.auth.currentUser?.toJson()}');
}

// final authStreamPd = StreamProvider((_) => sbc.auth.onAuthStateChange);
