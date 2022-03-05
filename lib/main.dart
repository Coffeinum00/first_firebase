import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/screens/auth/data/providers/auth_state.dart';
import 'package:flutter_firebase/screens/auth/sign_up.dart';
import 'package:flutter_firebase/screens/home/home.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) => AuthState(FirebaseAuth.instance)),
        StreamProvider(
            create: (context) => context.read<AuthState>().userChanges,
            initialData: null),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: LogInHandler(),
      ),
    );
  }
}

class LogInHandler extends StatefulWidget {
  const LogInHandler({Key? key}) : super(key: key);

  @override
  State<LogInHandler> createState() => _LogInHandlerState();
}

class _LogInHandlerState extends State<LogInHandler> {
  @override
  Widget build(BuildContext context) {
    final _firebaseUser = context.watch<User?>();
    return _firebaseUser == null ? SignUpPage() : Home();
  }
}
