// import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
// import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:kolkata_fatafat/utils/theme/colors.dart';
import 'package:kolkata_fatafat/utils/widgets/custom_text.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final String text;
  final TextEditingController? controller;
  final bool isPassword;
  final Widget? prefixIcon;
  final TextInputType keyboardType;
  final Color? color;
  final Widget? suffixIcon;
  final bool readOnly;
  final FocusNode? focusNode;
  final int? line;
  final int? maxLength;
  final Color? fillColor;
  final Color? borderColor;
  final Color? inputColor;
  final List<TextInputFormatter>? inputFormatters;
  final void Function()? onTap;
  final void Function(String)? onChanged;

  const CustomTextField({
    super.key,
    required this.hintText,
    this.controller,
    this.isPassword = false,
    this.readOnly = false,
    this.prefixIcon,
    this.suffixIcon,
    this.borderColor,
    this.maxLength,
    this.onChanged,
    this.inputColor,
    this.inputFormatters,
    this.color,
    this.text = '',
    this.focusNode,
    this.fillColor,
    this.keyboardType = TextInputType.text,
    this.line = 1,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (text.isNotEmpty) ...[
          CustomText(
            text: text,
            fontSize: 14,
            color: AppColor.themePrimaryColor,
          ),
          Gap(10),
        ],
        TextFormField(
          controller: controller,
          obscureText: isPassword,
          keyboardType: keyboardType,
          readOnly: readOnly,
          focusNode: focusNode,
          maxLines: line,
          minLines: line,
          maxLength: maxLength,
          onTap: onTap,
          onChanged: onChanged,
          inputFormatters: inputFormatters,
          cursorColor: inputColor ?? AppColor.themePrimary2Color,
          style: TextStyle(color: inputColor ?? AppColor.themePrimary2Color),
          decoration: InputDecoration(
            hintText: hintText,
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            fillColor: fillColor ?? AppColor.backgroundColor,
            hintStyle: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              fontFamily: 'DM Sans',

              color: color ?? AppColor.themePrimary2Color,
            ),
            filled: true,

            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: borderColor ?? AppColor.borderColor,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: borderColor ?? AppColor.borderColor,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: borderColor ?? AppColor.borderColor,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: borderColor ?? AppColor.borderColor,
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
          ),
        ),
      ],
    );
  }
}

// class CustomCountyTextfield extends StatelessWidget {
//   final TextEditingController controller;
//   final void Function(CountryCode) onChanged;
//   final String initialSelection;
//   const CustomCountyTextfield({
//     super.key,
//     required this.controller,
//     required this.onChanged,
//     required this.initialSelection,
//   });
//   @override
//   Widget build(BuildContext context) {
//     return CustomTextField(
//       hintText: 'Number',
//       keyboardType: TextInputType.number,
//       controller: controller,
//       prefixIcon: CountryCodePicker(
//         margin: const EdgeInsets.only(right: 10),
//         onChanged: onChanged,
//         initialSelection: initialSelection,
//         favorite: const ["+91", "IN"],
//         showCountryOnly: false,
//         showOnlyCountryWhenClosed: false,
//         alignLeft: false,
//       ),
//     );
//   }
// }

// class CustomTypeAheadField<T> extends StatelessWidget {
//   final TextEditingController controller;
//   final List<T> Function(String) suggestionsCallback;
//   final void Function(T) onSelected;
//   final String hintText;
//   final Widget Function(BuildContext, T) itemBuilder;

//   const CustomTypeAheadField({
//     super.key,
//     required this.controller,
//     required this.suggestionsCallback,
//     required this.onSelected,
//     required this.hintText,
//     required this.itemBuilder,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return TypeAheadField<T>(
//       suggestionsCallback: suggestionsCallback,
//       controller: controller,
//       builder: (context, controller, focusNode) {
//         return CustomTextField(
//           controller: controller,
//           hintText: hintText,
//           focusNode: focusNode,
//           suffixIcon: Icon(
//             Icons.arrow_drop_down_rounded,
//             color: AppColor.themePrimary2Color,
//           ),
//         );
//       },
//       itemBuilder: itemBuilder,
//       onSelected: onSelected,
//     );
//   }
// }

// class City {
//   final String name;
//   final String country;

//   City({required this.name, required this.country});
// }

// class CityService {
//   static List<City> cities = [
//     City(name: 'New York', country: 'USA'),
//     City(name: 'London', country: 'UK'),
//     City(name: 'Paris', country: 'France'),
//     City(name: 'Tokyo', country: 'Japan'),
//   ];

//   static List<City> find(String query) {
//     return cities
//         .where((city) => city.name.toLowerCase().contains(query.toLowerCase()))
//         .toList();
//   }
// }
