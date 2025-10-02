import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  // declaration de 2 attributs pour recuperer les valeurs des champs
  TextEditingController usernameController = TextEditingController(text: "admin");
  TextEditingController passwordController = TextEditingController(text: "1234");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page', 
        style: TextStyle(fontSize: 20, 
        fontWeight: FontWeight.bold,
         color: Theme.of(context).indicatorColor
         ),
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(10),
            height: 500,
            color: Colors.white,
            
            child: Card.outlined(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Image.asset("images/MAG_logo_1.png", width: 500, height: 150,),
                    SizedBox(height: 20,), 
                    TextFormField(
                      controller: usernameController,
                      decoration: InputDecoration(
                        hintStyle: TextStyle(fontSize: 14),
                        hintText: 'Enter your username',
                        suffixIcon: Icon(Icons.lock),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            width: 1,
                            color: Colors.grey,
                          ),
                        ),
                        labelText: 'Username',
                      ),
                    ),
                    SizedBox(height: 20,),
                    TextFormField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintStyle: TextStyle(fontSize: 14),
                        hintText: 'Enter your password',
                        suffixIcon: Icon(Icons.visibility),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            width: 1,
                            color: Colors.grey,
                          ),
                        ),
                        labelText: 'Password',
                      ),
                    ),
                    SizedBox(height: 30,),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          String username = usernameController.text;
                          String password = passwordController.text;
                          print('Username: $username, Password: $password');
                          if(username == "admin" && password == "1234"){
                            // y'aura pas de page precedente sauf si on se deconnecte
                            Navigator.of(context).pop();
                            // naviguer vers la page chatbot
                            Navigator.pushNamed(context, '/chatbot');
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).primaryColor,
                          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: Text('Login', style: TextStyle(fontSize: 22, color: Theme.of(context).indicatorColor),),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ),
        ],
      ),
    );
  }
}