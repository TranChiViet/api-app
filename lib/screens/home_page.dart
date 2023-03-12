import 'package:api_app/blocs/product_bloc/product_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../models/product.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  Future<void> _create() async {
    await showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext ctx) {
        return Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 20,
            bottom: MediaQuery.of(ctx).viewInsets.bottom + 20,
          ),
          child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                  autofocus: true,
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  controller: _priceController,
                  decoration: const InputDecoration(labelText: 'Price'),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: () async {
                      var product = Product(
                        id: DateTime.now().toString(),
                        name: _nameController.text,
                        price: int.parse(_priceController.text),
                      );
                      if (product.price != null) {
                        context.read<ProductBloc>().add(Create(product));
                        _nameController.text = '';
                        _priceController.text = '';
                        Navigator.of(context).pop();
                      }
                    },
                    child: const Text('Create'))
              ]),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<ProductBloc>(context).add(GetData());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("API App"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _create(),
        child: const Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {

          if (state is ProductLoaded) {

            List<Product> productList = state.productList;

            return ListView.builder(
                itemCount: productList.length,
                itemBuilder: (_, index) {
                  Product product = productList[index];
                  return Card(
                    child: ListTile(
                      title: Text(product.name),
                      subtitle: Text(product.price.toString()),
                      trailing: IconButton(onPressed: (){
                        context.read<ProductBloc>().add(Delete(product));
                      }, icon: Icon(Icons.delete)),
                    ),
                  );
                });
          } else if (state is ProductLoading){
            return const Center(child: CircularProgressIndicator(),);
          }else{
            return Container();
          }
        },
      ),
    );
  }
}
