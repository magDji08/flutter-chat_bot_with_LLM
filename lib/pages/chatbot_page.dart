import 'package:flutter/material.dart';

class ChatbotPage extends StatefulWidget {
   ChatbotPage({super.key});

  @override
  State<ChatbotPage> createState() => _ChatbotPageState();
}

class _ChatbotPageState extends State<ChatbotPage> {
   var messages = [
    {"type":"user", "content":"bonjour"},
    {"type":"assistant", "content":"salut, comment puis-je vous aider?"}, 

   ];

   TextEditingController userController = TextEditingController(text: "admin");

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
              itemCount: messages.length,
              shrinkWrap: true,
              itemBuilder:   (context, index) {
              return Column(
                children: [
                  Row(
                    children: [
                      messages[index]['type'] == "user" 
                        ?SizedBox(width: 80,)
                        :SizedBox(width: 0,), 
                      Expanded(
                        child: Card.filled(
                          color: (messages[index]['type'] == "user") ? Color.fromARGB(40, 0, 255, 0) : Colors.white,
                          margin: EdgeInsets.all(6),
                          child: ListTile(
                            title: Text("${messages[index]['content']}"),
                          ),
                        ),
                      ),
                       messages[index]['type'] == "assistant" 
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
                    String reponse = "reponse a la question $question";
                    if (question.isNotEmpty) {
                      setState(() {
                      messages.add({"type":"user", "content":question});
                      messages.add({"type":"assistant", "content":reponse});
                      userController.clear();
                      });

                    }
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