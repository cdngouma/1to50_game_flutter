import 'dart:math';

class Board {
  int rows = 5;
  int cols = 5;
  int nextNumber = 1;
  int highestNumber = 0;
  Map<int, int> gridValues = {};
  List<int> gridIndices = [];

  Board({required rows, required cols}) {
    rows = rows;
    cols = cols;
    initGrid();
  }

  void initGrid() {
    gridIndices = List.filled(rows*cols, 0);
    for(int i=0; i<rows*cols; i++) {
      gridValues[i] = i + 1;
      gridIndices[i] = i;
    }
    gridIndices.shuffle();
    nextNumber = 1;
    highestNumber = rows*cols + 1;
  }

  Map<int, int> getGridValues() {
    return gridValues;
  }

  List<int> getGridIndices() {
    return gridIndices;
  }

  int updateCell(int id) {
    if(gridValues[id] == nextNumber) {
      nextNumber = min(2*cols*rows, nextNumber + 1);
      if(highestNumber > 2*cols*rows) {
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

class GameLogic {
  int nextNumber = 1;
  Board board = Board(rows: 5, cols: 5);

  List<int> getGridIds() {
    return board.gridIndices;
  }

  int getCellValue(int id) {
    return board.gridValues[id] ?? 0;
  }

  bool updateGameState(int id) {
    // Update cell value
    board.updateCell(id);
    nextNumber = board.nextNumber;

    // Check if game was completed
    return board.isCompleted();
  }
}
