import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

import 'package:appcrudsqlite/data/dbhorta.dart';

class EditProduto extends StatefulWidget {
  int rollno;

  EditProduto({required this.rollno}); //constructor for class

  @override
  State<StatefulWidget> createState() {
    return  _EditProduto();
  }
}

class _EditProduto extends State<EditProduto> {
  TextEditingController produto = TextEditingController();

  TextEditingController tipo = TextEditingController();

  TextEditingController preco = TextEditingController();

  TextEditingController peso = TextEditingController();

  TextEditingController roll_no = TextEditingController();

  MyDb mydb = new MyDb();

  @override
  void initState() {
    mydb.open();

    Future.delayed(Duration(milliseconds: 500), () async {
      var data = await mydb.getHorta(
          widget.rollno); //widget.rollno is passed paramater to this class

      if (data != null) {
        produto.text = data["produto"];

        tipo.text = data["tipo"];

        preco.text = data["preco"];

        peso.text = data["peso"];

        roll_no.text = data["roll_no"].toString();

        setState(() {});
      } else {
        print("Não encontrado dados com roll no: " + widget.rollno.toString());
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Editar Produto"),
        ),
        body: Container(
          padding: EdgeInsets.all(30),
          child: Column(
            children: [
              TextField(
                controller: produto,
                decoration: InputDecoration(
                  hintText: "Produto",
                ),
              ),
              TextField(
                controller: tipo,
                decoration: InputDecoration(
                  hintText: "Tipo",
                ),
              ),
              TextField(
                controller: preco,
                decoration: InputDecoration(
                  hintText: "Preço(R\$)",
                ),
              ),
              TextField(
                controller: peso,
                decoration: InputDecoration(
                  hintText: "Peso",
                ),
              ),
              TextField(
                controller: roll_no,
                decoration: InputDecoration(
                  hintText: "Roll_no",
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    mydb.db.rawInsert(
                        "UPDATE horta SET produto = ?, tipo = ?, preco = ?, peso=?, roll_no = ? WHERE roll_no = ?",
                        [
                          produto.text,
                          tipo.text,
                          preco.text,
                          peso.text,
                          roll_no.text,
                          widget.rollno
                        ]);

                    //update table with roll no.

                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Produto Alterado!")));
                  },
                  child: Text("Alterar Produto")),
            ],
          ),
        ));
  }
}
