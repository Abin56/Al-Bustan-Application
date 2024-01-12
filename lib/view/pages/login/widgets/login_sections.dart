import 'package:canteen_productadd_application/view/fonts/google_poppins.dart';
import 'package:flutter/material.dart';

class LoginSections extends StatelessWidget {
  const LoginSections({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: 
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 50,
                  width: 50,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image:
                              AssetImage("assets/images/albustanblack.png"))),
                ),Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Column(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GooglePoppinsWidgets(
                      text: 'ALBUSTAN', fontsize: 15, textAlign: TextAlign.center,fontWeight: FontWeight.w600,),  GooglePoppinsWidgets(
                      text: 'BAKERY N SWEETS', fontsize: 15, textAlign: TextAlign.center,fontWeight: FontWeight.w600, ),
                    ],
                  ),
                ),
              ],
            ),
            
        
      ),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/Al_bustan.jpg'),
                  fit: BoxFit.cover)),
       child: const Column(children: [],),
        ),
      ),
    );
  }
}
