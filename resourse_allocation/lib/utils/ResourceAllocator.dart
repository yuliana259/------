class ResourceAllocator {
  List<List<int>> task = [
    [0, 1, 2, 3, 4, 5, 6],
    [0, 3, 4, 5, 8, 9, 10],
    [0, 2, 3, 7, 9, 12, 13],
    [0, 1, 2, 6, 11, 11, 13]
  ];
  List<dynamic> _allocationPlan;
  int _profit;
  ResourceAllocator();

  get allocationPlan => _allocationPlan;

  get profit => _profit;

  factory ResourceAllocator.empty() {
    return ResourceAllocator();
  }

  void allocateResources(int years) {
    int n = task.length - 1;
    int c = task[0].length;

    var x = [], xn = [];

    for (var k = 0; k < n; k++) {
      x.add(List.filled(c, 0));
      for (var y = 0; y < c; y++) {
        x[k][y] = _bellman(k + 1, y)[1];
      }
    }
    print('x=$x');
    int y = c - 1;
    int k = n - 1;
    print('y=$y,k=$k');

    x[0] = List.generate(c, (index) => index);
    int fx = 0;

    while (k >= 0) {
      xn.insert(0, x[k][y]);
      fx += task[k + 1][xn[0]];
      y = y - x[k][y];
      k -= 1;
    }

    _allocationPlan = xn;
    _profit = fx * years;
  }

  List<int> _bellman(int k, int y) {
    if (k == 1) {
      return [task[k][y], 0];
    }
    // var b = List.generate(y + 1, (z) => task[k][z] + _bellman(k - 1, y - z)[0]);
    var b = [];
    for (var i = 0; i < y + 1; i++) {
      print('i=$i');
      b.add(task[k][i] + _bellman(k - 1, y - i)[0]);
    }
    // Поиск максимального значения
    int bk = b.reduce((curr, next) => curr > next ? curr : next);
    int xk = b.indexOf(bk);

    return [bk, xk];
  }
}
