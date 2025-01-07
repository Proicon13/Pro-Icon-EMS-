
  import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class CardMadsWidget extends StatefulWidget {
    const CardMadsWidget({super.key});

    @override
    State<CardMadsWidget> createState() => _CardMadsWidgetState();
  }

  class _CardMadsWidgetState extends State<CardMadsWidget> {
    @override
    Widget build(BuildContext context) {
      return SizedBox(
        height: 600,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
            itemCount: 2,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 398,
                  height: 137,
                  decoration: BoxDecoration(
                    color: Colors.grey[800],
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: const Image(image: AssetImage("assets/images/layers 1.png")),
                        ),
                         SizedBox(width: 16),


                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [

                              Row(
                                children: [
                                  const Text(
                                    "No.",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Text(
                                    "123456789",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),


                              Row(
                                children: [
                                  Image.asset(
                                    "assets/images/Vector (1).png",
                                    width: 20,
                                    height: 20,
                                  ),
                                  const SizedBox(width: 8),
                                  const Text(
                                    "5 Sessions",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),

                            ],
                          ),
                        ),


                        const Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                          size: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      );
    }
  }
