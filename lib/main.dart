import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'dart:async';
import 'package:flutter/widgets.dart';
//options.dsn = 'https://10834599cbb5066f18ee019bfac67464@o1377784.ingest.us.sentry.io/4508978129731585';
import 'dart:js' as js;

Future<void> main() async {
  // creating a zone for Sentry testing
  await runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await SentryFlutter.init(
          (SentryFlutterOptions options) {
        options.dsn = 'https://10834599cbb5066f18ee019bfac67464@o1377784.ingest.us.sentry.io/4508978129731585';
      },
    );
    runApp(MyApp());
  }, (exception, stackTrace) async {
    await Sentry.captureException(exception, stackTrace: stackTrace);
  });
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  js.context.callMethod('pauseRecording');
                },
                child: Text("Pause Recording"),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  js.context.callMethod('continueRecording');
                },
                child: Text("Continue Recording"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}