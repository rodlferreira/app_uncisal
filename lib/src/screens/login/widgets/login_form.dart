import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginForm extends StatelessWidget {
  const LoginForm();
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: 290
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            decoration: InputDecoration(
              hintText: 'Usuário',
              filled: true,
              fillColor: Color(0xffececec),
              contentPadding: const EdgeInsets.only(
                top: 3,
                bottom: 3,
                left: 14,
                right: 8
              ),
              focusedBorder: const OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(12)),
                borderSide: const BorderSide(width: 0, style: BorderStyle.none,),
              ),
              enabledBorder: const OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(12)),
                borderSide: const BorderSide(width: 0, style: BorderStyle.none,),
              ),
              border: const OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(12)),
                borderSide: const BorderSide(width: 0, style: BorderStyle.none,),
              ),
            ),
          ),
          const SizedBox(height: 6,),
          TextField(
            obscureText: true,
            decoration: InputDecoration(
              hintText: 'Senha',
              filled: true,
              fillColor: Color(0xffececec),
              contentPadding: const EdgeInsets.only(
                top: 3,
                bottom: 3,
                left: 14,
                right: 8
              ),
              focusedBorder: const OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(12)),
                borderSide: const BorderSide(width: 0, style: BorderStyle.none,),
              ),
              enabledBorder: const OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(12)),
                borderSide: const BorderSide(width: 0, style: BorderStyle.none,),
              ),
              border: const OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(12)),
                borderSide: const BorderSide(width: 0, style: BorderStyle.none,),
              ),
            ),
          ),
          const SizedBox(height: 12,),
          SizedBox(
            width: double.infinity,
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: const BorderRadius.all(Radius.circular(10))
              ),
              color: Colors.lightGreen,
              textColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Text(
                'Entrar',
                style: TextStyle(
                  fontSize: 16
                ),
              ),
              onPressed: () {
                Get.offNamed('/home');
              }
            ),
          ),
        ],
      ),
    );
  }
}