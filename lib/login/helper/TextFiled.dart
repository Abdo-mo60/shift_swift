import 'package:flutter/material.dart';

Widget customTextField({
  required TextEditingController controller,
  required String hinText,
  bool? isScure ,
  required IconData icon, 

}){
   
   return  Padding(
     padding: const EdgeInsets.all(8.0),
     child: TextFormField(
     
        controller: controller,
        validator: (input)
        {
          if (controller.text.isEmpty)
           {
            return '$hinText  must not be empty';
          }
          else{
            return null;
          }
     
        },
       obscureText: isScure ?? false,
      
       
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          prefixIcon: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              
            ),
            child: Icon(icon,
            color: Colors.black,
            
            ),
          ),
        //  suffixIcon: Icon(icon,
          //color: Colors.black,),
          hintText: hinText,
           
         
        ),
         
         ),
   );
}