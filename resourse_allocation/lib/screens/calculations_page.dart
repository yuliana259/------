import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:resourse_allocation/screens/container_card.dart';
import 'package:resourse_allocation/utils/ResourceAllocator.dart';

class CalculationsPage extends StatelessWidget {
  final int years;
  List<dynamic> allocationPlan;
  int profit;
  CalculationsPage({Key key, this.years}) : super(key: key) {
    var allocator = ResourceAllocator.empty();

    allocator.allocateResources(years);

    this.allocationPlan = allocator.allocationPlan;
    this.profit = allocator.profit;
  }

  List<Widget> _buildAllocations() {
    List<Widget> allocations = [];

    for (var i = 0; i < allocationPlan.length; i++) {
      allocations
          .add(Text('Предприятие номер ${i + 1}: ${allocationPlan[i]} ед.'));
    }

    return allocations;
  }

  @override
  Widget build(BuildContext context) {
    int resoursesToAllocation =
        allocationPlan.reduce((value, element) => value + element);
    print('allocationPlan=$allocationPlan');
    return Scaffold(
      appBar: AppBar(title: Text('Расчёты за $years лет')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Container(
            child: Column(
              children: [
                Text('Результат',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 36,
                    )),
                Padding(
                  padding: const EdgeInsets.only(top: 48),
                  child: ContainerCard(
                    child: Center(
                        child: Text(
                            'Количество денег к распределению: $resoursesToAllocation')),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: ContainerCard(
                    child: Center(
                        child: Column(
                      children: [
                        ..._buildAllocations(),
                      ],
                    )),
                  ),
                ),
                ContainerCard(
                  child: Center(
                      child:
                          Text('Максимальная прибыль за $years лет: $profit')),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
