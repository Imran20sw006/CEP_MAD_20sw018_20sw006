import 'package:calculator/database.dart';
import 'package:calculator/datamodel.dart';
import 'package:flutter/material.dart';

class PreviousRedults extends StatefulWidget {
  const PreviousRedults({super.key});

  @override
  State<PreviousRedults> createState() => _PreviousRedultsState();
}

class _PreviousRedultsState extends State<PreviousRedults> {
  Helper? dbhelper;

  late Future<List<BMiMODEL>> noteslist;

  @override
  void initState() {
    super.initState();
    dbhelper = Helper();
    loadData();
  }

  loadData() async {
    try {
      noteslist = dbhelper!.getNOteList();
    } catch (error) {
      print("Error loading data: $error");
    }
    print(noteslist);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Previous Records"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
                future: noteslist,
                builder: (context, AsyncSnapshot<List<BMiMODEL>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    print('Error: ${snapshot.error} ${snapshot.stackTrace}');
                    return Text('Error: ${snapshot.error} ${snapshot.stackTrace}');
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No data available'));
                  } else {
                    // Data is available, build the ListView.
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (BuildContext context, int index) {
                        print("this is item numberis : ${index}");
                        return Card(
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(0),
                            title:
                                Text(snapshot.data![index].height.toString()),
                            subtitle:
                                Text(snapshot.data![index].weight.toString()),
                            trailing:
                                Text(snapshot.data![index].bmi.toString()),
                          ),
                        );
                      },
                    );
                  }
                }),
          )
        ],
      ),
    );
  }
}
