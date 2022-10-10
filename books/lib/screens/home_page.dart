import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/book_bloc.dart';
import 'details.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _textFieldController = TextEditingController();
  List<dynamic> _listBooks = [];
  String _error = '';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('Libreria free to play'),
        ),
        body: Column(
          children: [
            _search(context),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.8,
                child: _searching()
            )
          ],
        )
      ),
    );
  }

  Padding _search(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
      child: TextField(
        controller: _textFieldController,
        decoration: InputDecoration(
          labelText: "Ingresa título",
          border: OutlineInputBorder(),
          suffixIcon: IconButton(
            icon: Icon(Icons.search), 
            onPressed: () {
              BlocProvider.of<BookBloc>(context).add(BookEventSearch(
                request: _textFieldController.text,
              ));
              FocusScope.of(context).unfocus();
            },
          ),
        ),
        style: TextStyle(
          fontSize: 15
        ),
      ),
    );
  }

  BlocConsumer _searching() {
    return BlocConsumer<BookBloc, BookState>(
      listener: (context, state) {
        if (state is BookErrorState) {
          print(state.error);
          _error = state.error;
        }
      },
      builder: (context, state) {
        if (state is BookErrorState) {
          return _empty(state.error);
        } else if (state is BookLoadingState) {
          return Column(
            children: [
              Expanded(
                child: SizedBox(
                  child: Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: _shimmering(context)
                  ),
                ),
              ),
            ],
          );
        } else if (state is BookLoadedState) {
          _listBooks = state.props;
          if (_listBooks.length == 0) return _empty(_error);
          else return Column(
            children: [
              Expanded(
                child: SizedBox(
                  child: _found(context)
                )
              ),
            ],
          );
        } else {
          return _empty("Ingrese palabra para buscar libro");
        }
      },
    );
  }

  Column _empty(String texto){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          texto,
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    );
  }

  GridView _found(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.all(20),
      scrollDirection: Axis.vertical,
      physics: ScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 25,
        childAspectRatio: MediaQuery.of(context).size.width /
        (MediaQuery.of(context).size.height / 1.5),
      ),
      itemCount: _listBooks.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          padding: EdgeInsets.all(4),
          //color: Colors.teal[100],
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => Details(
                        image: _listBooks[index]["image"],
                        title: _listBooks[index]['title'],
                        publishedDate: _listBooks[index]['publishedDate'],
                        description: _listBooks[index]['description'],
                        pageCount: _listBooks[index]['pageCount'],
                      )
                    )
                  );
                },
                child: Container(
                  height: (MediaQuery.of(context).size.height / 4.4),
                  child: Image.network(
                    "${_listBooks[index]["image"]}", 
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              SizedBox(height: 8,),
              Text(
                "${_listBooks[index]["title"]}",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
      },
    );
  }

  GridView _shimmering(BuildContext context) {
    return GridView.builder (
      padding: EdgeInsets.all(20),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: MediaQuery.of(context).size.width /
        (MediaQuery.of(context).size.height / 1.5),
      ),// cuantos elementos quieres lado a lado
      scrollDirection: Axis.vertical,
      physics: ScrollPhysics(),
      itemCount: 6,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          padding: EdgeInsets.all(4),
          //color: Colors.teal[100],
          child: Column(
            children: [
              Container(
                height: (MediaQuery.of(context).size.height / 4.4),
                color: Colors.grey[300],
              ),
              SizedBox(height: 8,),
              Container(
                height: 19,
                color: Colors.grey[300],
              ),
            ],
          ),
        );
      },
    );
  }

}
