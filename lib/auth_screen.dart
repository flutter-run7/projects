import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'auth_service.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'home_screen.dart';
import 'register_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _checkCredentials();
  }

  Future<void> _checkCredentials() async {
    bool hasCredentials = await checkCredentials();
    if (hasCredentials) {
      Navigator.pushReplacementNamed(context, '/home');
    }
  }

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      String username = _usernameController.text;
      String password = _passwordController.text;

      bool isAuthenticated = await authenticateUser(username, password);

      if (isAuthenticated) {
        await saveCredentials(username, password);
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Usuário ou senha inválidos')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextFormField(
                controller: _usernameController,
                decoration: InputDecoration(labelText: 'Usuário'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o usuário';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'Senha'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira a senha';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _login,
                  child: Text('Entrar'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> saveCredentials(String username, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', username);
    await prefs.setString('password', password);
  }

  Future<bool> checkCredentials() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? username = prefs.getString('username');
    String? password = prefs.getString('password');
    return username != null && password != null;
  }

  Future<bool> authenticateUser(String username, String password) async {
    return true;
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';
  bool _isLogin = true;
  String _errorMessage = '';

  void _submit() async {
    setState(() {
      _errorMessage = '';
    });
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) {
      return;
    }
    _formKey.currentState?.save();

    try {
      if (_isLogin) {
        UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: _email,
          password: _password,
        );
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      } else {
        UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
          email: _email,
          password: _password,
        );
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      }
    } on FirebaseAuthException catch (error) {
      String errorMessageInPortuguese = '';
      switch (error.code) {
        case 'invalid-email':
          errorMessageInPortuguese = 'O email fornecido é inválido.';
          break;
        case 'user-disabled':
          errorMessageInPortuguese = 'Este usuário foi desabilitado.';
          break;
        case 'user-not-found':
          errorMessageInPortuguese = 'Nenhum usuário encontrado com este email.';
          break;
        case 'wrong-password':
          errorMessageInPortuguese = 'Senha incorreta.';
          break;
        case 'too-many-requests':
          errorMessageInPortuguese = 'Muitas tentativas de login. Tente novamente mais tarde.';
          break;
        default:
          errorMessageInPortuguese = 'A credencial de autenticação fornecida está incorreta, inválida ou expirou.';
      }
      setState(() {
        _errorMessage = errorMessageInPortuguese;
      });
    } catch (error) {
      setState(() {
        _errorMessage = 'Um erro ocorreu.';
      });
    }
  }

  Future<void> _signInWithGoogle() async {
    print("Função _signInWithGoogle chamada!");
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        return;
      }
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      UserCredential userCredential = await _auth.signInWithCredential(credential);

      if (userCredential.user != null) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      } else {
        setState(() {
          _errorMessage = 'Google sign in failed. User is null.';
        });
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        _errorMessage = 'Google sign in failed: ${e.message}';
      });
    } catch (error) {
      setState(() {
        _errorMessage = 'Um erro inesperado ocorreu: ${error.toString()}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: Text(_isLogin ? 'Login' : 'Register')),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Image.asset('assets/images/logo.jpg'),
                    SizedBox(height: 20),
                    TextFormField(
                      key: ValueKey('email'),
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(labelText: 'E-Mail'),
                      validator: (value) {
                        if (value!.isEmpty || !value.contains('@')) {
                          return 'Por favor insira um E-mail válido.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _email = value!;
                      },
                    ),
                    TextFormField(
                      key: ValueKey('password'),
                      decoration: InputDecoration(labelText: 'Senha'),
                      obscureText: true,
                      validator: (value) {
                        if (value!.isEmpty || value.length < 6) {
                          return 'A senha deve possuir 6 caracteres ou mais.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _password = value!;
                      },
                    ),
                    if (_errorMessage.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          _errorMessage,
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _submit,
                        child: Text(_isLogin ? 'Login' : 'Registrar'),
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            _isLogin = !_isLogin;
                          });
                          if (!_isLogin) {
                            Navigator.pushNamed(context, '/registro');
                          }
                        },
                        child: Text(
                          _isLogin ? 'Criar nova conta' : 'Eu já tenho uma conta',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}