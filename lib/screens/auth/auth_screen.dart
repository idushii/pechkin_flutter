import 'package:pechkin_flutter/index.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  static const route = "/auth";

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _formKey = GlobalKey<FormState>();
  String _username = '';
  String _password = '';
  String loadState = LoadState.none;
  String error = '';

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage.withPadding(
        header: const PageHeader(
          title: Text('Авторизация в сервисе'),
        ),
        content: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Form login and password
              BlocConsumer<AuthCubit, AuthState>(
                listener: (context, state) async {
                  if (authCubit.state.loadState == LoadState.success) {
                    await Future.delayed(Duration.zero);
                    context.go('/');
                  }
                },
                builder: (context, state) {
                  return SizedBox(
                    width: 300,
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextBox(
                            placeholder: 'Логин',
                            onChanged: (value) => setState(() => _username = value),
                          ),
                          const SizedBox(height: 10),
                          TextBox(
                            placeholder: 'Пароль',
                            obscureText: true,
                            onChanged: (value) => setState(() => _password = value),
                          ),
                          const SizedBox(height: 10),
                          Button(
                            child: const Text('Войти'),
                            onPressed: state.loadState == LoadState.loading
                                ? null
                                : () async {
                                    authCubit.auth(_username, _password);
                                  },
                          ),
                          const SizedBox(height: 10),
                          if (state.error != '') Text(state.error)
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ));
  }
}
