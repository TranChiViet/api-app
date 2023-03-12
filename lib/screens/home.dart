import 'package:api_app/blocs/bloc_export.dart';
import 'package:flutter/material.dart';

import 'home_page.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

    return BlocProvider(
      create: (context) => ProductBloc(
          productRepository: RepositoryProvider.of<ProductRepository>(context)),
      child: Scaffold(
          // key: scaffoldKey,
          body: BlocListener<ProductBloc, ProductState>(
              listener: (context, state) {
        if (state is ProductAdded) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Product added"),
            duration: Duration(seconds: 2),
          ));
        }
        if (state is ProductDeleted) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Product deleted"),
            duration: Duration(seconds: 2),
          ));
        }
      }, child: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is ProductAdding || state is ProductDeleting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ProductError) {
            return const Center(child: Text("Error"));
          }
          return const HomePage();
        },
      ))),
    );
  }
}
