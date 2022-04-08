
import 'package:edge_client/modules/water_service/user_details.dart';
import 'package:flutter/material.dart';

import 'consumer_details.dart';

class ConsumerResult extends StatelessWidget {
  final List<UserDetails> consumerList;
  final Map category;
  const ConsumerResult(this.consumerList, this.category, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: ListView.builder(
            itemCount: consumerList.length,
            itemBuilder: (_, index) => _buildCard(consumerList[index], context)
        ),
      ),
    );
  }


    Widget _buildCard(UserDetails consumerDetails, BuildContext context) {
      return Card(
        child: Container(
          child: Wrap(
            spacing: 5,
            direction: Axis.vertical,
            children: [
              _buildLabel('Name', consumerDetails.name),
              _buildLabel('Father Name', consumerDetails.username),
              _buildLabel('Phone', consumerDetails.phone),
              _buildLabel('E-mail', consumerDetails.email),
              _buildLabel('Street', consumerDetails.address?.street),
              _buildLabel('Zip code', consumerDetails.address?.zipcode),
              ElevatedButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (_)=> ConsumerView(category, consumer: consumerDetails)));
              }, child: Text('update'))
            ],
          ),
        ),
      );
    }

    Widget _buildLabel(String label, String? value) {
    return Text('$label : $value');
    }
}
