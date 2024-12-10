import 'package:flutter/material.dart';

class CipherButton extends StatelessWidget {
  final Function()? action;
  final String text;
  final String desc;
  final AssetImage image;
  final LinearGradient gradient; // This should be followed with fill

  const CipherButton({
    super.key,
    required this.action,
    required this.text,
    required this.desc,
    required this.image,
    required this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: (MediaQuery.of(context).size.height / 4.5) + 24,
      width: double.maxFinite,
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.only(top: 2),
      child: Container(
        decoration: BoxDecoration(
          gradient: gradient,
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.4),
              blurStyle: BlurStyle.outer,
              blurRadius: 8,
            ),
          ],
          borderRadius: BorderRadius.circular(16),
        ),
        child: ElevatedButton(
          onPressed: action,
          style: ButtonStyle(
            shadowColor: WidgetStatePropertyAll(Colors.transparent),
            backgroundColor: WidgetStatePropertyAll(Colors.transparent),
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      alignment: Alignment.centerRight,
                      image: image,
                    ),
                  ),
                ),
              ),
              Container(
                constraints: BoxConstraints(
                  maxWidth: 180,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 8),
                      child: Text(
                        text,
                        style: TextStyle(
                          wordSpacing: 4,
                          fontFamily: "Antipasto",
                          color: Colors.white,
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                    Text(
                      desc,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontFamily: "Antipasto",
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
