import 'package:pechkin_flutter/index.dart';

createProject(BuildContext context) {
  // show dialog
  showDialog(
    context: context,
    dismissWithEsc: true,
    builder: (context) {
      return CreateProjectModal();
    },
  );
}

class CreateProjectModal extends StatefulWidget {
  @override
  State<CreateProjectModal> createState() => _CreateProjectModalState();
}

class _CreateProjectModalState extends State<CreateProjectModal> {
  String loading = LoadState.none;
  String error = '';

  String name = '';
  String description = '';

  @override
  Widget build(BuildContext context) {
    return ContentDialog(
      title: const Text('Новый проект', style: TextStyle(fontSize: 20)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextBox(placeholder: 'Название проекта', autofocus: true, onChanged: (value) => name = value, readOnly: loading == LoadState.loading),
          const SizedBox(height: 10),
          TextBox(
              placeholder: 'Описание проекта', minLines: 2, maxLines: 10, onChanged: (value) => description = value, readOnly: loading == LoadState.loading),
          if (error.isNotEmpty) ...[
            const SizedBox(height: 10),
            Text(error, style: TextStyle(color: Colors.red)),
          ]
        ],
      ),
      actions: [
        Button(
          child: const Text('Отмена'),
          onPressed: loading == LoadState.loading ? null : () {
            Navigator.pop(context);
          },
        ),
        FilledButton(
          child: const Text('Создать'),
          onPressed: loading == LoadState.loading ? null : () async {
            final res = await Api.createProject(name, description);
            if (res.data != null) {
              setState(() => loading = LoadState.success);
              if (mounted) {
                Navigator.pop(context);
              }
            } else {
              error = 'Не удалось создать проект';
              setState(() => loading = LoadState.error);
            }
          },
        ),
      ],
    );
  }
}
