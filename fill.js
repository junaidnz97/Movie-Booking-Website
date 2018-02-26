var mysql = require('mysql');
var con = mysql.createConnection({
  host: "localhost",
  user: "root",
  password: "Ad_07_",
  database: "dbmsAssignment"
});

con.connect(function(err) {
  if (err) throw err;
  var qr = "insert into screen values ";
  var c = 1;
  for(var j = 65; j < 74 ; j++){
  	for(var i = 1; i <= 30 ; i++){
  		qr = qr + "(" + (c++) + ",1,\"" + String.fromCharCode(j) + "\",\"" + i + "\",\"The Godfather\",false)," ;
  }
 }
  for(var i = 1; i <= 29 ; i++){
  		qr = qr + "(" + (c++) + ",1,\"" + String.fromCharCode(74) + "\",\"" + i + "\",\"The Godfather\",false)," ;
  }
  qr = qr + "(" + (c++) + ",1,\"" + String.fromCharCode(74) + "\",\"" + 30 + "\",\"The Godfather\",false),";
  c=1;
  for(var j = 65; j < 74 ; j++){
    for(var i = 1; i <= 30 ; i++){
      qr = qr + "(" + (c++) + ",2,\"" + String.fromCharCode(j) + "\",\"" + i + "\",\"Shawshank Redemption\",false)," ;
  }
 }
  for(var i = 1; i <= 29 ; i++){
      qr = qr + "(" + (c++) + ",2,\"" + String.fromCharCode(74) + "\",\"" + i + "\",\"Shawshank Redemption\",false)," ;
  }
  qr = qr + "(" + (c++) + ",2,\"" + String.fromCharCode(74) + "\",\"" + 30 + "\",\"Shawshank Redemption\",false)";
  console.log(qr);
  var q = con.query("delete from screen",function(err,res){
    if(err) throw err;
    console.log(res);
  });
  q = con.query(qr,function(err,res){
  	if(err) throw err;
  	console.log(res);
  });
  console.log('Connected to the database');

});
