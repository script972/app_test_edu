import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foxtrot_app/pages/sign_in_up_page/sign_in_page.dart';

class SignUpLayout extends StatelessWidget {
  const SignUpLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xff27C189),
                Color(0xff237BBF),
              ],
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SvgPicture.asset('assets/images/Union.svg'),
                const SizedBox(
                  height: 70,
                ),
                const SizedBox(
                  width: 264,
                  child: Text(
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt",
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(color: Color.fromRGBO(255, 255, 255, 0.54)),
                  ),
                ),
                const SizedBox(
                  height: 100,
                ),
                Form(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 300,
                        height: 48,
                        child: TextFormField(
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            hintStyle: const TextStyle(
                                color: Color.fromRGBO(0, 0, 0, 0.5)),
                            hintText: 'Email',
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      SizedBox(
                        width: 300,
                        height: 48,
                        child: TextFormField(
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            hintStyle: const TextStyle(
                                color: Color.fromRGBO(0, 0, 0, 0.5)),
                            hintText: 'Password',
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 26,
                      ),
                      SizedBox(
                        height: 48,
                        width: 300,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xffFF473D)),
                          child: const Text("Отправить код"),
                        ),
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Оферта на использование личных данных",
                            style: TextStyle(color: Colors.white, fontSize: 10),
                          ),
                          ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (_) => const SignInPage(),
                                ));
                              },
                              child: const Text("Sign In"))
                        ],
                      ),
                      const SizedBox(
                        height: 32,
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
