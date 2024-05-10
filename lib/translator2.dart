import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:travelguide/translator.dart';

class Translator2 extends StatefulWidget {
  const Translator2({super.key});

  @override
  State<Translator2> createState() => _Translator2State();
}

class _Translator2State extends State<Translator2> {
  void listenForPermissions() async {
    final status = await Permission.microphone.status;
    switch (status) {
      case PermissionStatus.denied:
        requestForPermission();
        break;
      case PermissionStatus.granted:
        break;
      case PermissionStatus.limited:
        break;
      case PermissionStatus.permanentlyDenied:
        break;
      case PermissionStatus.restricted:
        break;
      case PermissionStatus.provisional:
        break;
    }
  }

  Future<void> requestForPermission() async {
    await Permission.microphone.request();
  }

  var _localeId = "ar";
  bool _isListening = false;
  final SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  String _lastWords = '';
  final TextEditingController _outputController = TextEditingController();

  Timer? _debounce;
  bool _isLoading =
      false; // Flag to control the visibility of loading animation

  final TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (!_speechEnabled) {
      _initSpeech();
    }
    listenForPermissions();
  }

  /// This has to happen only once per app
  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }

  /// Each time to start a speech recognition session
  void _startListening() async {
    String languageCode;

    // Match the language name with its corresponding code
    switch (_localeId) {
      case 'english':
        languageCode = Language.english.code;
        break;
      case 'arabic':
        languageCode = Language.arabic.code;
        break;
      case 'spanish':
        languageCode = Language.spanish.code;
        break;
      case 'german':
        languageCode = Language.german.code;
        break;
      default:
        languageCode = Language.english.code;
        return;
    }

    // Start listening using the language code
    await _speechToText.listen(
        onResult: _onSpeechResult, localeId: languageCode);
    _isListening = true;
    setState(() {});
  }

  /// Manually stop the active speech recognition session
  /// Note that there are also timeouts that each platform enforces
  /// and the SpeechToText plugin supports setting timeouts on the
  /// listen method.
  void _stopListening() async {
    await _speechToText.stop();
    _isListening = false;
    setState(() {});
  }

  /// This is the callback that the SpeechToText plugin calls when
  /// the platform returns recognized words.
  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      _lastWords = result.recognizedWords;
      _translateText(_lastWords);
      // _outputController.text = _lastWords;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('voice recognition'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // floatingActionButton: FloatingActionButton(
              //   onPressed:
              //       // If not yet listening for speech start, otherwise stop
              //       _speechToText.isNotListening ? _startListening : _stopListening,
              //   tooltip: 'Listen',
              //   child: Icon(_speechToText.isNotListening ? Icons.mic_off : Icons.mic),
              // ),
              GestureDetector(
                onLongPress: _startListening,
                onLongPressUp: _stopListening,
                child: Material(
                  borderRadius: const BorderRadius.all(Radius.circular(60)),
                  elevation: 4.0,
                  child: CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.black,
                    child: IconButton(
                        // focusColor: Colors.yellow,
                        // splashColor: Colors.green,
                        // disabledColor: Colors.amber,
                        // highlightColor: Colors.black,
                        // hoverColor: Colors.blueGrey,
                        onPressed: () {
                          setState(() {});
                        },
                        icon: const Icon(
                          Icons.mic,
                          size: 95.0,
                          color: Colors.white,
                        )),
                  ),
                ),
                // child: ElevatedButton.icon(
                //     onPressed: () {},
                //     // onLongPress: _speechToText.isNotListening
                //     //     ? _startListening
                //     //     : _stopListening,

                //     icon: Icon(Icons.mic_off),
                //     label: Text("")),
              ),
              // Container(
              //   padding: EdgeInsets.all(16),
              //   child: Text(
              //     'Recognized words:',
              //     style: TextStyle(fontSize: 20.0),
              //   ),
              // ),
              Container(
                padding: const EdgeInsets.all(16),
                child: Text(
                  // If listening is active show the recognized words
                  _speechToText.isListening
                      ? '$_lastWords'
                      // If listening isn't active but could be tell the user
                      // how to start it, otherwise indicate that speech
                      // recognition is not yet ready or not supported on
                      // the target device
                      : _speechEnabled
                          ? 'Tap the microphone to start listening...'
                          : 'Speech not available',
                ),
              ),

              const SizedBox(height: 20.0),
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: 30), // Add padding here
                  Text(
                    "Language Name",
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
              const SizedBox(height: 6.0),
              Material(
                borderRadius: const BorderRadius.all(Radius.circular(40)),
                elevation: 4.0,
                child: SizedBox(
                  width: 350, // Set the width as per your requirement
                  child: TextField(
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Color.fromARGB(255, 210, 223, 239),
                      contentPadding:
                          EdgeInsets.all(25), // Adjust padding as needed
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(40)),
                      ),
                    ),
                    maxLines: null,
                    onChanged: (text) {
                      debugPrint('changed text $text');
                      setState(() {
                        _localeId = '$text';
                      });
                    },
                  ),
                ),
              ),

              // TextField(
              //   decoration: const InputDecoration(
              //     filled: true,
              //     fillColor: Color.fromARGB(255, 210, 223, 239),
              //     contentPadding: EdgeInsets.all(55),
              //     border: OutlineInputBorder(
              //         borderRadius: BorderRadius.all(Radius.circular(40))),
              //   ),
              //   maxLines: null,
              //   onChanged: (text) {
              //     debugPrint('changed text $text');
              //     // _translateText(text);
              //     setState(() {
              //       _localeId = '$text';
              //     });
              //   },
              // ),
              // Translated Text
              const SizedBox(height: 44.0),
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: 30), // Add padding here
                  Text(
                    "Arabic",
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),

              const SizedBox(height: 6.0),
              Material(
                borderRadius: const BorderRadius.all(Radius.circular(40)),
                elevation: 4.0,
                child: SizedBox(
                  width: 350, // Set the width as per your requirement
                  child: InputDecorator(
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Color.fromARGB(255, 210, 223, 239),
                      contentPadding:
                          EdgeInsets.all(25), // Adjust padding as needed
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(40)),
                      ),
                    ),
                    child: _isLoading
                        ? Text(
                            '${_outputController.text}...',
                            style: const TextStyle(
                              fontSize: 16.0,
                            ),
                            maxLines: null,
                            textDirection: TextDirection.rtl,
                          )
                        : TextField(
                            controller: _outputController,
                            maxLines: null,
                            readOnly: true,
                            textDirection: TextDirection.rtl,
                            decoration: const InputDecoration.collapsed(
                              hintText: "",
                              hintStyle: TextStyle(color: Colors.grey),
                              fillColor: Colors.grey,
                            ),
                          ),
                  ),
                ),
              ),

              const SizedBox(height: 56),
              /*InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Translator()),
                  );
                },
                child: const Text(
                  "Or Try Typing it out",
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                    decorationColor: Colors.blue, // Set the underline color
                    shadows: [
                      Shadow(
                        blurRadius: 40.0,
                        color: Colors.grey,
                        offset: Offset(1.0, 3.0),
                      ),
                    ],
                  ),
                ),
              ),*/

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Timer? _timer;

  void _startTimer() {
    _timer = Timer(const Duration(milliseconds: 500), () {
      // If the timer completes, start listening
      _startListening();
    });
  }

  void _cancelTimer() {
    // if (_timer != null) {
    _timer?.cancel();
    // }
    // If long press ended before the timer, stop listening
    if (_isListening) {
      _stopListening();
    }
  }

  Future<void> _translateText(String inputText) async {
    _debounce?.cancel();
    setState(() {
      _isLoading = true;
    });

    // time for better feel, like google translate
    _debounce = Timer(const Duration(milliseconds: 500), () async {
      try {
        String translatedText = await translate(inputText);
        setState(() {
          _outputController.text = translatedText;
        });
      } catch (e) {
        // Handle translation errors
        debugPrint(e.toString());
      } finally {
        setState(() {
          _isLoading = false; // Hide loading animation
        });
      }
    });
  }

  Future<String> translate(String text) async {
    var translationRequest = TranslationRequest("auto", "ar", text);
    var encoded = jsonEncode(translationRequest.toJson());

    final response = await http.post(
      Uri.parse("https://deep-translator-api.azurewebsites.net/google/"),
      headers: {
        'Content-Type': 'application/json',
        'accept': 'application/json',
      },
      body: encoded,
    );

    String utf8String = json.decode(response.body)['translation'];
    String parsed = utf8.decode(utf8String.codeUnits);

    if (response.statusCode == 200) {
      return parsed;
    } else {
      debugPrint('Failed with status: ${response.statusCode}');
      throw Exception('Failed to translate text');
      // Never
    }
  }
}

class TranslationRequest {
  final String source;
  final String target;
  final String text;
  final List proxies;

  TranslationRequest(this.source, this.target, this.text,
      {this.proxies = const []});

  Map<String, dynamic> toJson() => {
        'source': source,
        'target': target,
        'text': text,
        'proxies': proxies,
      };
}

enum Language { english, arabic, spanish, german }

extension LanguageExtension on Language {
  String get code {
    switch (this) {
      case Language.english:
        return 'en_EN';
      case Language.arabic:
        return 'ar_AR';
      case Language.spanish:
        return 'es_ES';
      case Language.german:
        return 'de_DE';
    }
  }
}
