import 'dart:async';

import 'event.dart';

class CounterBlock {
  int _counter = 0;

  // Output Stream Controller
  final _counterStateController = StreamController<int>();
  // Input Stream Controller
  final _eventStateController = StreamController<Event>();
  get _incCounter => _counterStateController.sink;

  // Output Data Stream
  get counter => _counterStateController.stream;
  // Input Event Sink
  get event => _eventStateController.sink;

  CounterBlock() {
    _eventStateController.stream.listen(_mapEventToState);
  }

  void _mapEventToState(Event event) {
    if (event is IncrementEvent) {
      _counter++;
      _incCounter.add(_counter);
    }
  }

  void dispose() {
    _counterStateController.close();
    _eventStateController.close();
  }
}
