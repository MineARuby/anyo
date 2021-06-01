const execute_stockfish = () => {
  if(document.getElementById('stockfish_exec') != null) {
    let stockfish = new Worker("stockfish.js");
  }

};

export { execute_stockfish };

