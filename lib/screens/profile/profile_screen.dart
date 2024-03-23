import 'package:pechkin_flutter/index.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  static const route = "/profile";

  @override
  Widget build(BuildContext context) {
    if (authCubit.state.loadState != LoadState.success) {
      Future.delayed(Duration.zero, () => context.go(AuthScreen.route));
    }

    return ScaffoldPage.withPadding(
      header: const PageHeader(
        title: Text('Профиль'),
      ),
      content: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // to TextRich
              Text.rich(
                TextSpan(
                  children: [
                    const TextSpan(text: "ФИО: ", style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(text: " ${state.user.name}"),
                    const TextSpan(text: "\n"),
                    const TextSpan(text: "Email: ", style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(text: " ${state.user.email}"),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
