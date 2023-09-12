import 'package:flutter/material.dart'; 

import 'package:appcrudsqlite/data/dbhorta.dart'; 

  

class Add extends StatefulWidget { 

  @override 

  State<StatefulWidget> createState() { 

    return _Add(); 

  } 

} 

  

class _Add extends State<Add> { 

  TextEditingController produto = TextEditingController(); 

  TextEditingController tipo = TextEditingController(); 

  TextEditingController preco = TextEditingController(); 

  TextEditingController  peso = TextEditingController(); 

  TextEditingController roll_no = TextEditingController(); 

  //test editing controllers for form 

  

  MyDb mydb = MyDb(); //mydb new object from db.dart 

  

  @override 

  void initState() { 

    mydb.open(); //initilization database 

    super.initState(); 

  } 

  

  @override 

  Widget build(BuildContext context) { 

    return Scaffold( 

        appBar: AppBar( 

          title: Text("Inserir"), 

        ), 

        body: Container( 

          padding: EdgeInsets.all(30), 

          child: Column( 

            children: [ 

              TextField( 

                controller: produto, 

                decoration: const InputDecoration( 

                  hintText: "produto", 

                ),

              ), 

              TextField( 

                controller: tipo, 

                decoration: const InputDecoration( 

                  hintText: "Tipo", 

                ), 

              ), 

              TextField( 

                controller: preco, 

                decoration: const InputDecoration( 

                  hintText: "Preço(R\$)", 

                ), 

              ), 

              TextField( 

                controller: peso, 

                decoration: const InputDecoration( 

                  hintText: "Peso", 

                ), 

              ), 


              TextField( 

                controller: roll_no, 

                decoration: const InputDecoration( 

                  hintText: "Roll No.", 

                ), 

              ), 








              ElevatedButton( 

                  onPressed: () { 

                    mydb.db.rawInsert( 

                        "INSERT INTO horta(produto, tipo, preco, peso, roll_no) VALUES (?, ?, ?, ?, ?);", 

                        [ 

                          produto.text, 

                          tipo.text, 

                          preco.text, 

                          peso.text, 

                          roll_no.text

                        ]); //add student from form to database 

  

                    ScaffoldMessenger.of(context).showSnackBar( 

                        SnackBar(content: Text("Produto Adicionado"))); 

  

                    produto.text = ""; 

                    tipo.text = ""; 

                    preco.text = ""; 

                    peso.text = " "; 

                    roll_no.text = " "; 

                  }, 

                  child: Text("Salvar Produto")), 

            ], 

          ), 

        )); 

  } 

} 