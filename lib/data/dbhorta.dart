import 'package:path/path.dart'; 

import 'package:sqflite/sqflite.dart'; 

  

class MyDb { 

  late Database db; 

  

  Future open() async { 

    // Get a location using getDatabasesPath 

    var databasesPath = await getDatabasesPath(); 

    String path = join(databasesPath, 'bdcrud.db'); 

    //join is from path package 

    print( 

        path); //output /data/user/0/com.testapp.flutter.testapp/databases/demo.db 

  

    db = await openDatabase(path, version: 1, 

        onCreate: (Database db, int version) async { 

      // When creating the db, create the table 

      await db.execute(''' 

                  CREATE TABLE IF NOT EXISTS horta (  

                        id primary key, 

                        produto varchar(150) not null, 

                        tipo varchar(100) not null, 

                        preco varchar(80) not null, 

                        peso varchar(10)

                        roll_no int not null, 

                        

                       

                    ); 

  

                    //create more table here 

                 

                '''); 

      print("Tabela Criada com Sucesso!"); 

    }); 

  } 

  

  //método de consulta de dados 

  Future<Map<dynamic, dynamic>?> getHorta(int rollno) async { 

    List<Map> maps = 

        await db.query('horta', where: 'roll_no = ?', whereArgs: [rollno]); 

    //getting student data with roll no. 

    if (maps.length > 0) { 

      return maps.first; 

    } 

    return null; 

  } 

} 