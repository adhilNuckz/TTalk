import 'package:flutter/material.dart';








class CustomFormField extends StatelessWidget {
  
  final String hintText;
  final double height;
  final RegExp validationRegEx ;
  final bool obscureText ;
  final void Function(String?) onSaved ;
  
  const CustomFormField({
    super.key,
    required this.hintText,
    required this.height,
    required this.validationRegEx ,
    required this.onSaved,
    this.obscureText = false,S
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: TextFormField(
        onSaved: onSaved,
        obscureText: obscureText,
        validator: (value) { 
        if(value != null && validationRegEx.hasMatch(value)) {
          return null ;
        } 
        return "Enter  a Valid ${hintText.toLowerCase()} " ; 
        },

        
        decoration: InputDecoration(
          hintText: hintText,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }





  Widget getErrorMessage(String hintText) {
  return RichText(
    text: TextSpan(
      text: "Enter a Valid ",
      style: TextStyle(color: Colors.white, fontSize: 16),
      children: [
        TextSpan(
          text: hintText.toLowerCase(),
          style: TextStyle(color: Colors.red, fontSize: 16),
        ),
      ],
    ),
  );
}

}






// class CustomFormField extends StatefulWidget {

  
//   const CustomFormField({super.key});

//   @override
//   State<CustomFormField> createState() => _CustomFormFieldState();
// }

// class _CustomFormFieldState extends State<CustomFormField> {
  

  
  
//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//       decoration: InputDecoration (
//         border: OutlineInputBorder() ,
        
        

//       ),
//     ) ;
//   }
// }