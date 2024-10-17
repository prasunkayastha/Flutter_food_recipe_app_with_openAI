import 'package:flutter/material.dart';
import 'package:food_recipe_app/homepage_repo.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late TextEditingController controller;
  late FocusNode focusNode;
  final List<String> inputTags = [];
  String response = '';

  @override
  void initState() {
    controller = TextEditingController();
    focusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text(
              'Find the bet recipe for cooking!',
              maxLines: 3,
              style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Flexible(
                  child: TextFormField(
                    autofocus: true,
                    autocorrect: true,
                    focusNode: focusNode,
                    controller: controller,
                    onFieldSubmitted: (value) {
                      controller.clear();
                      setState(() {
                        inputTags.add(value);
                        focusNode.requestFocus();
                      });
                      print(inputTags);
                    },
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(5.5),
                            bottomLeft: Radius.circular(5.5)),
                      ),
                      enabledBorder:
                          const OutlineInputBorder(borderSide: BorderSide()),
                      labelText: "Enter the ingredients you have....",
                      labelStyle: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                ),
                Container(
                  color: Theme.of(context).colorScheme.primary,
                  child: Padding(
                    padding: const EdgeInsets.all(9),
                    child: IconButton(
                        onPressed: () {
                          controller.clear();
                          setState(() {
                            inputTags.add(controller.text);
                            focusNode.requestFocus();
                          });
                          print(inputTags);
                        },
                        icon: const Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 30,
                        )),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Wrap(
                children: [
                  for (int i = 0; i < inputTags.length; i++)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: Chip(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        label: Text(inputTags[i]),
                        deleteIcon: const Icon(
                          Icons.close,
                          size: 20,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            Expanded(
              child: SizedBox(
                child: Center(
                  child: SingleChildScrollView(
                    child: Text(
                      response,
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton(
                  onPressed: () async {
                    setState(() => response = 'Thinking..');
                    var temp = await HomePageRepo().askAI(inputTags.toString());
                    setState(() => response = temp);
                  },
                  child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.auto_awesome),
                        Text('Create recipe')
                      ])),
            )
          ],
        ),
      )),
    );
  }
}
