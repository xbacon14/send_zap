import 'package:fluent_ui/fluent_ui.dart';

class FormTextBox extends StatelessWidget {
  const FormTextBox({
    Key? key,
    required this.label,
    required this.controller,
    required this.focusNode,
    this.validator,
    this.onSubmit,
  }) : super(key: key);

  final String label;
  final TextEditingController controller;
  final FocusNode focusNode;
  final bool? Function()? validator;
  final Function()? onSubmit;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: SizedBox(
            width: 120,
            child: Text(label),
          ),
        ),
        SizedBox(
          width: 16,
        ),
        Flexible(
          child: SizedBox(
            width: 360,
            child: TextBox(
              focusNode: focusNode,
              controller: controller,
              placeholder: label.replaceAll(":", "").toLowerCase(),
              onChanged: (value) {},
              onSubmitted: (value) => onSubmit!(),
            ),
          ),
        )
      ],
    );
  }
}
