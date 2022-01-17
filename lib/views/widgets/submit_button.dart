import 'package:flutter/material.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton({Key? key, required this.callback}) : super(key: key);
  final VoidCallback callback;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: callback,
      child: Container(
        margin: EdgeInsets.only(left: 16, right: 16, bottom: 20),
        height: 50,
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                offset: Offset(1, 1),
                blurRadius: 1,
                spreadRadius: 1,
              ),
            ]),
        child: Center(
          child: Text("Save"),
        ),
      ),
    );
  }
}
