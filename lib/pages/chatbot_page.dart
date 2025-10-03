import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class ChatbotPage extends StatefulWidget {
   ChatbotPage({super.key});

  @override
  State<ChatbotPage> createState() => _ChatbotPageState();
}

class _ChatbotPageState extends State<ChatbotPage> {
   var messages = [
    {"role":"user", "content":"bonjour"},
    {"role":"assistant", "content":"salut, comment puis-je vous aider?"}, 

   ];

   TextEditingController userController = TextEditingController(text: "admin");
   ScrollController scrollcontroller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chatbot Page', 
        style: TextStyle(fontSize: 20, 
        fontWeight: FontWeight.bold,
         color: Theme.of(context).indicatorColor
         ),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        actions: [
          IconButton(onPressed: (){
            Navigator.of(context).pop();
            Navigator.pushNamed(context, '/');
          }, icon: Icon(Icons.logout, color: Colors.white,))
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: ListView.builder(
              controller: scrollcontroller,
              itemCount: messages.length,
              shrinkWrap: true,
              itemBuilder:   (context, index) {
              return Column(
                children: [
                  Row(
                    children: [
                      messages[index]['role'] == "user" 
                        ?SizedBox(width: 80,)
                        :SizedBox(width: 0,), 
                      Expanded(
                        child: Card.filled(
                          color: (messages[index]['role'] == "user") ? Color.fromARGB(40, 0, 255, 0) : Colors.white,
                          margin: EdgeInsets.all(6),
                          child: ListTile(
                            title: Text("${messages[index]['content']}"),
                          ),
                        ),
                      ),
                       messages[index]['role'] == "assistant" 
                        ?SizedBox(width: 80,)
                        :SizedBox(width: 0,), 
                    ],
                  ),
                  Divider(),
                ],
              );
            }),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: userController,
                    decoration: InputDecoration(
                      hintStyle: TextStyle(fontSize: 14),
                      hintText: 'Enter your username',
                      suffixIcon: Icon(Icons.person),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          width: 1,
                          color: Colors.grey,
                        ),
                      ),
                      // labelText: 'Username',
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    String question = userController.text;

                    // Utilisation de mon api 
                    // Uri url = Uri.https("api.onpenai.com", "v1/chat/completions");
                    Uri url = Uri.parse("http://192.168.1.48:11434/v1/chat/completions");

                    var header = {
                      "Content-role" : "application/json"
                    };
                    messages.add(
                      {
                              "role": "user", "content": question
                          }
                          );
                    var body = {
                      "model": "llama3.2",
                      "messages": messages,
                      // [
                      //     {
                      //         "role": "user", "content": question
                      //     }
                      // ]
                    };
                    // envoie de la requete vers le backend
                    http.post(url, headers:header, body: json.encode(body))
                    .then((resp){
                      print(resp.statusCode);
                      var aiResponse = json.decode(resp.body);
                      String answer = aiResponse["choices"][0]["message"]["content"];

                      setState(() {
                        messages.add({"role":"user", "content":question});
                        messages.add({"role":"assistant", "content":answer});
                        userController.clear();
                        //il me repond puis scroll jusqu'a la fin 
                        scrollcontroller.jumpTo(
                          scrollcontroller.position.maxScrollExtent + 800 
                        );
                      });


                    }).catchError((err){
                        print(err);
                    });


                  },
                   icon: Icon(Icons.send, color: Theme.of(context).primaryColor,)
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}