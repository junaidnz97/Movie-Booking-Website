var express=require("express");
var movieController = require('./controller/movieController');

var app = express();

app.use("/public",express.static("public"));

app.set("view engine","ejs");

movieController(app);

var server=app.listen("8080",function(){

	console.log("server working");
});
