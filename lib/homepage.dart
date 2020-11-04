import 'listbook.dart';
import 'package:flutter/material.dart';
import 'search.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<BooksModel> filtered = [];

  Icon seaicon = Icon(Icons.search);

  Widget seabar = Text(
    "My Book Search Bar",
  );
  Future<BooksModel> _booksModel;
  // ignore: unused_field

  TextEditingController controller = new TextEditingController();

  @override
  void initState() {
    _booksModel = API_Manager().getbooks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.menu), onPressed: () {}),
        centerTitle: true,
        title: seabar,
        actions: <Widget>[
          IconButton(
            icon: seaicon,
            onPressed: () {
              setState(() {
                if (this.seaicon.icon == Icons.search) {
                  this.seaicon = Icon(Icons.cancel);
                  this.seabar = TextField(
                    controller: controller,
                    textInputAction: TextInputAction.go,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Search",
                    ),
                    onChanged: (value) {
                      setState(() {});
                    },
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                    ),
                  );
                } else {
                  this.seaicon = Icon(Icons.search);
                  this.seabar = Text("AppBar");
                }
              });
            },
          )
        ],
      ),
      body: Container(
        child: FutureBuilder<BooksModel>(
          future: _booksModel,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data.items.length,
                  itemBuilder: (context, index) {
                    var article = snapshot.data.items[index];
                    return Container(
                      height: 120,
                      margin: const EdgeInsets.all(8),
                      child: Row(
                        children: <Widget>[
                          Card(
                            clipBehavior: Clip.antiAlias,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: AspectRatio(
                                aspectRatio: 1,
                                child: Image.network(
                                  article.volumeInfo.imageLinks.thumbnail,
                                  fit: BoxFit.cover,
                                )),
                          ),
                          SizedBox(width: 16),
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  article.volumeInfo.title ?? "",
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  article.volumeInfo.description ?? "",
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  });
            } else
              return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
