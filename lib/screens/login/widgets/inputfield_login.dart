import 'package:flutter/material.dart';

class FormInput extends StatefulWidget {
  const FormInput({Key? key}) : super(key: key);

  @override
  State<FormInput> createState() => _FormInputState();
}

class _FormInputState extends State<FormInput> {
  bool _isHidden = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: const BoxDecoration(
          border:
              Border(bottom: BorderSide(color: Colors.white24, width: 0.5))),
      child: Column(
        children: [
          TextFormField(
            obscureText: false,
            style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
            decoration: const InputDecoration(
                fillColor: Color(0xFFF2F2F2),
                filled: true,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                  borderSide: BorderSide(color: Color(0xFFF2F2F2)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                  borderSide: BorderSide(color: Color(0xFFF2F2F2)),
                ),
                prefixIcon: Icon(
                  Icons.person_outline,
                  color: Color(0xFFC1BD02),
                ),
                hintText: "Username",
                hintStyle: TextStyle(color: Color(0xFF828282), fontSize: 16),
                contentPadding: EdgeInsets.zero),
          ),
          const SizedBox(
            height: 15,
          ),
          TextFormField(
            obscureText: _isHidden,
            style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
            decoration: InputDecoration(
                fillColor: const Color(0xFFF2F2F2),
                filled: true,
                enabledBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                  borderSide: BorderSide(color: Color(0xFFF2F2F2)),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                  borderSide: BorderSide(color: Color(0xFFF2F2F2)),
                ),
                prefixIcon: const Icon(
                  Icons.lock_outlined,
                  color: Color(0xFFC1BD02),
                ),
                suffixIcon: InkWell(
                  onTap: _togglePasswordView,
                  child: Icon(
                    _isHidden ? Icons.visibility : Icons.visibility_off,
                    color: const Color(0xFF828282),
                  ),
                ),
                hintText: "Password",
                hintStyle: const TextStyle(color: Color(0xFF828282), fontSize: 16),
                contentPadding: EdgeInsets.zero),
          ),
        ],
      ),
    );
  }

  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }
}
