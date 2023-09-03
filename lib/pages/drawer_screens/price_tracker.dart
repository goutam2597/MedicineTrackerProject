import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PriceTrackerScreen extends StatefulWidget {
  const PriceTrackerScreen({super.key});

  @override
  State<PriceTrackerScreen> createState() => _PriceTrackerScreenState();
}

class _PriceTrackerScreenState extends State<PriceTrackerScreen> {
  CollectionReference referenceMedicinePrice =
      FirebaseFirestore.instance.collection('medicine_price');
  late Stream<QuerySnapshot> streamMedicinePrice;

  @override
  void initState() {
    super.initState();
    streamMedicinePrice = referenceMedicinePrice.snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Medicine Price'),),
      body: StreamBuilder<QuerySnapshot>(
        stream: streamMedicinePrice,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          if (snapshot.connectionState == ConnectionState.active) {
            QuerySnapshot querySnapshot = snapshot.data;
            List<QueryDocumentSnapshot> listQueryDocumentSnapshot =
                querySnapshot.docs;

           return ListView.builder(
              itemCount: listQueryDocumentSnapshot.length,
              itemBuilder: (context, index) {
                QueryDocumentSnapshot document =
                    listQueryDocumentSnapshot[index];
                return ListTile(
                  title: Text(document['name'],style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Text('Group:',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),),
                          Text(document['group'],style: const TextStyle(fontSize: 15,fontWeight: FontWeight.w500),),
                        ],
                      ),
                      Text(document['mg'],style: const TextStyle(fontSize: 15,fontWeight: FontWeight.w500,color: Colors.black87),),

                    ],
                  ),
                  trailing: Text(document['price'],style: const TextStyle(fontSize: 15,fontWeight: FontWeight.w600),),
                );
              },
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}