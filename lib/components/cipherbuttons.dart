import 'package:flutter/material.dart';

class CipherButton extends StatelessWidget {
  final Function()? action;
  final String text;
  final String desc;
  final AssetImage image;
  static const Color imageColor =
      Color.fromRGBO(237, 237, 233, 1); // This should be followed with fill

  const CipherButton({
    super.key,
    required this.action,
    required this.text,
    required this.desc,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: action,
        child: Container(
            height: 186,
            width: double.maxFinite,
            padding: EdgeInsets.all(16),
            margin: EdgeInsets.only(top: 2),
            child: Ink(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: LinearGradient(
                    colors: [
                      Colors.blue[400]!,
                      Colors.blue[300]!,
                      Colors.blue,
                      Colors.lightBlue,
                      Colors.lightBlue[400]!,
                      Colors.lightBlue[300]!,
                    ],
                    transform: GradientRotation(180),
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
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
                    onPressed: () {},
                    style: ButtonStyle(
                      shadowColor: WidgetStatePropertyAll(Colors.transparent),
                      backgroundColor:
                          WidgetStatePropertyAll(Colors.transparent),
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
                              Text(
                                text,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 32,
                                    fontFamily: "Courier New",
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                desc,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontFamily: "Courier New",
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ))));
  }
}