import 'package:cannabis_track_and_trace_application/screens/login/login.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isHidden = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/bg_register.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 30,
                        ),
                        const Text(
                          "Register",
                          style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF036568)),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: TextFormField(
                            obscureText: false,
                            style: const TextStyle(
                                color: Color.fromARGB(255, 0, 0, 0)),
                            decoration: const InputDecoration(
                                errorBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15.0)),
                                  borderSide:
                                      BorderSide(color: Color(0xFFF2F2F2)),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15.0)),
                                  borderSide:
                                      BorderSide(color: Color(0xFFF2F2F2)),
                                ),
                                fillColor: Color(0xFFF2F2F2),
                                filled: true,
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15.0)),
                                  borderSide:
                                      BorderSide(color: Color(0xFFF2F2F2)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15.0)),
                                  borderSide:
                                      BorderSide(color: Color(0xFFF2F2F2)),
                                ),
                                prefixIcon: Icon(
                                  Icons.person_outline,
                                  color: Color(0xFFC1BD02),
                                ),
                                hintText: "ชื่อ(ภาษาไทย)",
                                hintStyle: TextStyle(
                                    color: Color(0xFF828282), fontSize: 16),
                                contentPadding: EdgeInsets.zero),
                            validator: RequiredValidator(
                                errorText: 'กรุณาป้อนชื่อภาษาไทย'),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: TextFormField(
                            obscureText: false,
                            style: const TextStyle(
                                color: Color.fromARGB(255, 0, 0, 0)),
                            decoration: const InputDecoration(
                                errorBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15.0)),
                                  borderSide:
                                      BorderSide(color: Color(0xFFF2F2F2)),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15.0)),
                                  borderSide:
                                      BorderSide(color: Color(0xFFF2F2F2)),
                                ),
                                fillColor: Color(0xFFF2F2F2),
                                filled: true,
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15.0)),
                                  borderSide:
                                      BorderSide(color: Color(0xFFF2F2F2)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15.0)),
                                  borderSide:
                                      BorderSide(color: Color(0xFFF2F2F2)),
                                ),
                                prefixIcon: Icon(
                                  Icons.person_outline,
                                  color: Color(0xFFC1BD02),
                                ),
                                hintText: "นามสกุล(ภาษาไทย)",
                                hintStyle: TextStyle(
                                    color: Color(0xFF828282), fontSize: 16),
                                contentPadding: EdgeInsets.zero),
                            validator: RequiredValidator(
                                errorText: 'กรุณาป้อนนามสกุลภาษาไทย'),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: TextFormField(
                            obscureText: false,
                            style: const TextStyle(
                                color: Color.fromARGB(255, 0, 0, 0)),
                            decoration: const InputDecoration(
                                errorBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15.0)),
                                  borderSide:
                                      BorderSide(color: Color(0xFFF2F2F2)),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15.0)),
                                  borderSide:
                                      BorderSide(color: Color(0xFFF2F2F2)),
                                ),
                                fillColor: Color(0xFFF2F2F2),
                                filled: true,
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15.0)),
                                  borderSide:
                                      BorderSide(color: Color(0xFFF2F2F2)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15.0)),
                                  borderSide:
                                      BorderSide(color: Color(0xFFF2F2F2)),
                                ),
                                prefixIcon: Icon(
                                  Icons.person_outline,
                                  color: Color(0xFFC1BD02),
                                ),
                                hintText: "ชื่อ(ภาษาอังกฤษ)",
                                hintStyle: TextStyle(
                                    color: Color(0xFF828282), fontSize: 16),
                                contentPadding: EdgeInsets.zero),
                            validator: RequiredValidator(
                                errorText: 'กรุณาป้อนชื่อภาษาอังกฤษ'),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: TextFormField(
                            obscureText: false,
                            style: const TextStyle(
                                color: Color.fromARGB(255, 0, 0, 0)),
                            decoration: const InputDecoration(
                                errorBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15.0)),
                                  borderSide:
                                      BorderSide(color: Color(0xFFF2F2F2)),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15.0)),
                                  borderSide:
                                      BorderSide(color: Color(0xFFF2F2F2)),
                                ),
                                fillColor: Color(0xFFF2F2F2),
                                filled: true,
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15.0)),
                                  borderSide:
                                      BorderSide(color: Color(0xFFF2F2F2)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15.0)),
                                  borderSide:
                                      BorderSide(color: Color(0xFFF2F2F2)),
                                ),
                                prefixIcon: Icon(
                                  Icons.person_outline,
                                  color: Color(0xFFC1BD02),
                                ),
                                hintText: "นามสกุล(ภาษาอังกฤษ)",
                                hintStyle: TextStyle(
                                    color: Color(0xFF828282), fontSize: 16),
                                contentPadding: EdgeInsets.zero),
                            validator: RequiredValidator(
                                errorText: 'กรุณาป้อนนามสกุลภาษาอังกฤษ'),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: TextFormField(
                            obscureText: false,
                            style: const TextStyle(
                                color: Color.fromARGB(255, 0, 0, 0)),
                            decoration: const InputDecoration(
                                errorBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15.0)),
                                  borderSide:
                                      BorderSide(color: Color(0xFFF2F2F2)),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15.0)),
                                  borderSide:
                                      BorderSide(color: Color(0xFFF2F2F2)),
                                ),
                                fillColor: Color(0xFFF2F2F2),
                                filled: true,
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15.0)),
                                  borderSide:
                                      BorderSide(color: Color(0xFFF2F2F2)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15.0)),
                                  borderSide:
                                      BorderSide(color: Color(0xFFF2F2F2)),
                                ),
                                prefixIcon: Icon(
                                  Icons.email_outlined,
                                  color: Color(0xFFC1BD02),
                                ),
                                hintText: "Email",
                                hintStyle: TextStyle(
                                    color: Color(0xFF828282), fontSize: 16),
                                contentPadding: EdgeInsets.zero),
                            validator: MultiValidator([
                              RequiredValidator(errorText: 'กรุณาป้อนอีเมล'),
                              EmailValidator(errorText: 'รูปแบบอีเมลไม่ถูกต้อง')
                            ]),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: TextFormField(
                            obscureText: false,
                            style: const TextStyle(
                                color: Color.fromARGB(255, 0, 0, 0)),
                            decoration: const InputDecoration(
                                errorBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15.0)),
                                  borderSide:
                                      BorderSide(color: Color(0xFFF2F2F2)),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15.0)),
                                  borderSide:
                                      BorderSide(color: Color(0xFFF2F2F2)),
                                ),
                                fillColor: Color(0xFFF2F2F2),
                                filled: true,
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15.0)),
                                  borderSide:
                                      BorderSide(color: Color(0xFFF2F2F2)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15.0)),
                                  borderSide:
                                      BorderSide(color: Color(0xFFF2F2F2)),
                                ),
                                prefixIcon: Icon(
                                  Icons.person_outline,
                                  color: Color(0xFFC1BD02),
                                ),
                                hintText: "Username",
                                hintStyle: TextStyle(
                                    color: Color(0xFF828282), fontSize: 16),
                                contentPadding: EdgeInsets.zero),
                            validator: RequiredValidator(
                                errorText: 'กรุณาป้อน Username'),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: TextFormField(
                            obscureText: _isHidden,
                            style: const TextStyle(
                                color: Color.fromARGB(255, 0, 0, 0)),
                            decoration: InputDecoration(
                                errorBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15.0)),
                                  borderSide:
                                      BorderSide(color: Color(0xFFF2F2F2)),
                                ),
                                focusedErrorBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15.0)),
                                  borderSide:
                                      BorderSide(color: Color(0xFFF2F2F2)),
                                ),
                                fillColor: const Color(0xFFF2F2F2),
                                filled: true,
                                enabledBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15.0)),
                                  borderSide:
                                      BorderSide(color: Color(0xFFF2F2F2)),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15.0)),
                                  borderSide:
                                      BorderSide(color: Color(0xFFF2F2F2)),
                                ),
                                prefixIcon: const Icon(
                                  Icons.lock_outlined,
                                  color: Color(0xFFC1BD02),
                                ),
                                suffixIcon: InkWell(
                                  onTap: _togglePasswordView,
                                  child: Icon(
                                    _isHidden
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: const Color(0xFF828282),
                                  ),
                                ),
                                hintText: "Password",
                                hintStyle: const TextStyle(
                                    color: Color(0xFF828282), fontSize: 16),
                                contentPadding: EdgeInsets.zero),
                            validator: RequiredValidator(
                                errorText: 'กรุณาป้อนรหัสผ่าน'),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: TextFormField(
                            obscureText: _isHidden,
                            style: const TextStyle(
                                color: Color.fromARGB(255, 0, 0, 0)),
                            decoration: InputDecoration(
                                errorBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15.0)),
                                  borderSide:
                                      BorderSide(color: Color(0xFFF2F2F2)),
                                ),
                                focusedErrorBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15.0)),
                                  borderSide:
                                      BorderSide(color: Color(0xFFF2F2F2)),
                                ),
                                fillColor: const Color(0xFFF2F2F2),
                                filled: true,
                                enabledBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15.0)),
                                  borderSide:
                                      BorderSide(color: Color(0xFFF2F2F2)),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15.0)),
                                  borderSide:
                                      BorderSide(color: Color(0xFFF2F2F2)),
                                ),
                                prefixIcon: const Icon(
                                  Icons.lock_outlined,
                                  color: Color(0xFFC1BD02),
                                ),
                                suffixIcon: InkWell(
                                  onTap: _togglePasswordView,
                                  child: Icon(
                                    _isHidden
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: const Color(0xFF828282),
                                  ),
                                ),
                                hintText: "Confirm Password",
                                hintStyle: const TextStyle(
                                    color: Color(0xFF828282), fontSize: 16),
                                contentPadding: EdgeInsets.zero),
                            validator: RequiredValidator(
                                errorText: 'กรุณายืนยันรหัสผ่าน'),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        SizedBox(
                            height: 63, //height of button
                            width: 193, //width of button
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    textStyle: TextStyle(fontSize: 20),
                                    primary: Color(0xFF036568),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    padding: const EdgeInsets.all(20)),
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    _formKey.currentState!
                                        .reset(); //ลบค่าที่ป้อนในฟอร์ม
                                  }
                                },
                                child: Text("Register"))),
                        const SizedBox(
                          height: 30,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => LoginScreen(),
                              ),
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: const [
                              Text(
                                "If you already have an account, just ",
                                style: TextStyle(
                                    fontSize: 16, color: Color(0xDDAA3333)),
                              ),
                              SizedBox(width: 10),
                              Hero(
                                tag: '1',
                                child: Text(
                                  'login',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xFF036568)),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }
}
