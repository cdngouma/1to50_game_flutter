import 'dart:math';

class Board {
  final int ROWS = 5;
  final int COLS = 5;
  int nextNumber = 1;
  int highestNumber = 0;
  Map<int, int> gridValues = {};
  List<int> gridIndices = [];

  Board() {
    initGrid();
  }

  void initGrid() {
    gridIndices = List.filled(ROWS*COLS, 0);
    for(int i=0; i<ROWS*COLS; i++) {
      gridValues[i] = i + 1;
      gridIndices[i] = i;
    }
    gridIndices.shuffle();
    nextNumber = 1;
    highestNumber = ROWS*COLS + 1;
  }

  Map<int, int> getGridValues() {
    return gridValues;
  }

  List<int> getGridIndices() {
    return gridIndices;
  }

  int updateCell(int id) {
    if(gridValues[id] == nextNumber) {
      nextNumber = min(2*COLS*ROWS, nextNumber + 1);
      if(highestNumber > 2*COLS*ROWS) {
        gridValues[id] = 0;
      } else {
        gridValues[id] = highestNumber;
        highestNumber += 1;
      }
    }
    return gridValues[id] ?? 0;
  }

  bool isCompleted() {
    for(int v in gridValues.values) {
      if(v > 0) {
        return false;
      }
    }
    return true;
  }
}