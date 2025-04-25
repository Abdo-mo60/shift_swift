import 'package:flutter/material.dart';

class ProfilePerson extends StatelessWidget {
  const ProfilePerson({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // الجزء العلوي الأزرق الكامل
          Container(
            width: double.infinity,
            height: 200,
            color: Colors.blue.shade700,
            child: Stack(
              children: [
                // زر الرجوع في أعلى اليسار
                Positioned(
                  top: 40,
                  left: 16,
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                  ),
                ),
                // الصورة والاسم في منتصف الحاوية
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      CircleAvatar(
                        radius: 35,
                        backgroundImage: AssetImage('asstes/d1.png'),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Savannah Nguyen',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // باقي المحتوى
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Row(children: [Icon(Icons.reply), Text('last work')]),
                ListTile(
                  subtitle: Row(
                    children: [
                      Image.asset('asstes/pre.png', width: 40, height: 40),
                      SizedBox(width: 8,),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          
                          const Text(
                            'Medical Assistant',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Text('Bank of America'),
                          const Text('February 28, 2018 - present'),
                          const SizedBox(height: 5),
                          Row(
                            children: List.generate(
                              4,
                              (index) => const Icon(
                                Icons.star,
                                color: Colors.amber,
                                size: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const Divider(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                Icon(Icons.school_outlined),
                SizedBox(width: 8,),
                    Text('Education',style: TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold
                    ),),
                  ],
                ),
              ),
                ListTile(
                
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 8),
                      const Text(
                        'Diploma In Microsoft',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text('Salam University'),
                      const Text('February 28, 2018 - 2022'),
                    ],
                  ),
                ),
                const Divider(height: 30),
                Row(
                  children: [
                 Icon(Icons.location_on_outlined),
                  const Text('Location',style: TextStyle(fontSize: 18 , fontWeight: FontWeight.bold),),
                  ],
                ),
                Container(
  width: double.infinity, // يخلي العنصر ياخد كل عرض الشاشة
  child: Text(
    'Cairo, Egypt',
    textAlign: TextAlign.start,
    style: TextStyle(fontSize: 16),
  ),
)

              ],
            ),
          ),
        ],
      ),
    );
  }
}
