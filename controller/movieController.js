var mysql = require('mysql');
var bodyParser=require("body-parser");
var randomstring = require("randomstring");
var includes = require('array-includes');
var urlencodedParser = bodyParser.urlencoded({ extended: false });
var jsonParser = bodyParser.json();


module.exports = function(app){
  var con = mysql.createConnection({
    host: "localhost",
    user: "root",
    password: "zynu456$",
    database: "dbmsproject1"
  });

  con.connect(function(err) {
    if (err) throw err;
    console.log('Connected to the database');

  });

  var bookingid;
  var x=[],y=[];
  var screen,movie;
  app.get("/",function(req,res) {
    var q = "select m_name,sc_id from movie_data,movie \
     where movie_data.m_id in (select m_id from movie) \
     and movie_data.m_id = movie.m_id";
    con.query(q,function(err,resp){
        if(err) throw err;
        console.log(resp);
        var o = JSON.parse(JSON.stringify(resp));
        res.render("chooseScreen",{data:o});
        });

  });
  app.post("/screen",urlencodedParser,function(req,res){
  	var data={cols:[],
  		rows:[],
  		selected:[]
  		 };
    console.log(req.body);
    //console.log(res);
    var q = `select m_name,row, cols, status from screen,movie_data,movie
      where screen.sc_id = ${req.body.screen} and movie.m_id=movie_data.m_id and movie.sc_id=screen.sc_id`
  	var val = con.query(q,function(err,response) {
  		if(err) throw err;
  		var o = JSON.parse(JSON.stringify(response));
  		//console.log(o);
  		for(var i = 0;i<o.length;i++)
  		{
  				if(includes(data.cols,o[i].row)==false)
  					data.cols.push(o[i].row);
  				if(includes(data.rows,o[i].cols)==false)
  					data.rows.push(o[i].cols);
  				data.selected.push(o[i].status);
  		}
      screen = req.body.screen;
      movie = o[0].m_name;
  		console.log(movie);
  		//console.log(data);
      res.render("main_page",{data:data});
    });
  });

  app.post("/booked",urlencodedParser,function(req,res){
      //console.log(x);
      //console.log(y);

      name=req.body.name;
      phone=req.body.mobile;
      //console.log(name);
      //console.log(phone);
      //res.render("navbar");
    	qry="update screen set status = true where sc_id  = "+screen+" and (";
    	var i = 0;

    	for(  i = 0; i < x.length - 1 ; i++ )
    		qry = qry + " seat_no = " + x[i] + " or ";
    		qry = qry + " seat_no = " + x[i] +")";
    	console.log(qry);
    	con.query(qry,function(err,response){
    		if(err)	throw err;
    		console.log(response);
        //console.log(x.length);
        var qy = "select price from movie where sc_id="+screen;
        con.query(qy,function(err,r) {
          if(err) throw err;
          var price = JSON.parse(JSON.stringify(r));
          var q =`insert into ticket (b_id,cus_name,phone,seat_no,sc_id) values `;
          for( i = 0; i < x.length - 1 ; i++)
            q = q + `('${bookingid}','${name}','${phone}' ,${x[i]},${screen}),`;
          q = q + `('${bookingid}','${name}','${phone}' ,${x[i]},${screen})`;
          console.log(q);
          con.query(q,function(err,resp){
              if(err) throw err;
              console.log(resp);
              });
            console.log(price[0].price*y.length);
        res.render("booked",{seats:y,b_id:bookingid,seatNo:x,cus_name:name,phone:phone,movie:movie,price:price[0].price*y.length});
          });

        });

    });
    app.get("/cancellation",function(req,res){
      res.render("cancel");

    });
    app.post("/cancelled",urlencodedParser,function(req,res){

        bid=req.body.bid;
        phone=req.body.mobile;
        console.log(bid);
        console.log(phone);
        var q = `update screen set status = false
                where sc_id in (select sc_id from ticket where b_id = "${bid}" and phone="${phone}") and
                seat_no in (select seat_no from ticket where b_id = "${bid}" and phone="${phone}")`;
        console.log(q);
        con.query(q,function(err,resp){
          if(err) throw err;
          //console.log(resp);
          var qry=`select sc_id,seat_no,row,cols from screen where
            seat_no in (select seat_no from ticket where b_id = "${bid}" and phone = "${phone}") and
            sc_id in (select sc_id from ticket where b_id = "${bid}" and phone = "${phone}")`
          console.log(qry);
          con.query( qry,function(err,response){
            if(err) throw err;

            var o = JSON.parse(JSON.stringify(response));
            console.log(o);
            y=[];
            for(var i = 0;i<o.length;i++)
            {
                y.push(o[i].row + o[i].cols);
            }
            console.log("test\n");
            var qr =`delete from ticket where sc_id=${o[0].sc_id} and(`;
            for( i = 0; i < o.length - 1 ; i++)
              qr = qr + `seat_no=${o[i].seat_no} or `;
            qr = qr + `seat_no=${o[i].seat_no})`
            console.log(qr);
            con.query(qr,function(err,r){
              if(err) throw err;
              console.log(r);
            res.render("Cancelled",{b_id:bid,seats :y});
          });

        });
        });


    });
    app.get("/home",function(req,res){
      var q="select m_name,imdb_rating,p_name from movie_data,crew,personals\
      where movie_data.m_id in (select m_id from movie)\
      and movie_data.m_id=crew.m_id \
      and crew.dir_id=personals.p_id";
      con.query(q,function(err,response){
        if(err)	throw err;
        console.log(response);
        var op = JSON.parse(JSON.stringify(response));
        console.log(op);
        res.render("home",{movie:op});
      });
    });
    app.get("/navbar",function(req,res){
    	res.render("navbar");
    	console.log("hello")
    });
    app.post("/cus_form",urlencodedParser,function(req,res){

      var ticket=req.body;
      x=[];
      y=[];

      console.log(req.body);
      for(var i in req.body)
      {
          x.push(ticket[i]);
      }
      bookingid=randomstring.generate(7);
      //console.log(x);
      var q = "select row,cols from screen where sc_id= "+screen+" and (";
      for(var i = 0; i < x.length - 1 ; i++)
        q = q + "seat_no = " + x[i] + " or ";
      q = q + "seat_no = " +x[x.length-1]+")";
      //console.log(q);
      if(x.length !== 0){
        con.query(q,function(err,response){
          if(err)	throw err;
          //console.log(response);

          var o = JSON.parse(JSON.stringify(response));
          //console.log(o);
          for(var i = 0;i<o.length;i++)
          {
              y.push(o[i].row + o[i].cols);
          }
          //console.log(y);
        res.render("customer_form.ejs");

        });
      }
      else{
        console.log("err");
        res.render("error");
      }
    });
    app.get("/choice",function(req,res){
        console.log(req.query.option);
        if(req.query.option === 'bookTicket')
          res.redirect("/");
        else if (req.query.option =='cancelTicket') {
          res.redirect("/cancellation");
        }
        else if(req.query.option =='ticketDetails'){
          res.redirect("/getTicketDetails");
        }
    });
    app.get("/getTicketDetails",function (req,res) {
      res.render("getTicketDetails");

    });
    app.post("/ticket",urlencodedParser,function(req,res) {
      bid=req.body.bid;
      phone=req.body.mobile;
      var q = "select ticket.sc_id,seat_no,b_id,m_name,cus_name from ticket,movie,movie_data \
       where b_id=\""+bid+"\" and phone = \""+phone+"\"\
        and movie.sc_id = ticket.sc_id and movie.m_id = movie_data.m_id"
      console.log(q);
      con.query(q,function(err,resp) {
          if(err) throw err;
          console.log(resp);
          var o = JSON.parse(JSON.stringify(resp));
          var qr = "select price from movie where sc_id="+o[0].sc_id;
          con.query(qr,function(err,response) {
              if(err) throw err;
              var price = JSON.parse(JSON.stringify(response));
              var qy =`select row,cols from screen where sc_id=${o[0].sc_id} and(`;
              for(var i = 0; i < o.length - 1 ; i++)
                  qy = qy + "seat_no = " + o[i].seat_no + " or ";
                qy = qy + "seat_no = " +o[o.length-1].seat_no+")";
              console.log(qy);
              con.query(qy,function (req,r) {
                if(err) throw err;

                var rc = JSON.parse(JSON.stringify(r));
                console.log(r);
                y=[];
                for(var i = 0;i<rc.length;i++)
                {
                    y.push(rc[i].row + rc[i].cols);
                }
                console.log(y)
                res.render("ticket",{movie:o[0].m_name,seats:y,b_id:bid,phone:phone,name:o[0].cus_name,price:y.length*price[0].price});
              });

          });

      });


    })
    app.get("/admin",function(req,res){

    res.render("admin");

});

  app.post("/adminlogged",urlencodedParser,function(req,res){

    console.log(req.body.username);
    var username=req.body.username;
    var password=req.body.password;
    var mname=req.body.moviename;
    var dirname=req.body.director;
    var prn=req.body.production;
    var rating=req.body.rating;
    var data="";
    if(username==="junaid" && password==="junaid")
        res.render("adminlogged",{data:data});
    else if(String(req.username)==="undefined" && String(req.username)==="undefined")
    {
        console.log(req.body.x);


        if(String(req.body.x)=="s1")
        {
            console.log("hello");
            data="Movie details of screen1 changed";
            con.query("delete from movie where sc_id=1",function(err,r){
              if(err) throw err;
              //console.log(r);
              var q=`insert into movie values("${mname}","${dirname}","${prn}",${rating},1,${req.body.price})`;
              console.log(q);
              con.query(q,function (err,re) {
                if(err) throw err;
                //console.log(re);
                var qr=`insert into screen values `;
                var c = 1;
                for(var j = 65; j < 74 ; j++){
  	               for(var i = 1; i <= 30 ; i++){
  		                 qr = qr + `( ${c++} ,1, "${String.fromCharCode(j)}", "${i}" ,"${mname}",false),` ;
                     }
                   }
                   for(var i = 1; i <= 29 ; i++){
  		                 qr = qr + `( ${c++} ,1, "${String.fromCharCode(74)}", ${i} ,"${mname}",false),`;
                     }
                    qr = qr + `( ${c++} ,1, "${String.fromCharCode(74)}", "30" ,"${mname}",false)`;
                //console.log(qr);
                con.query(qr,function(req,resp) {
                  if(err) throw err;
                  console.log(resp);
                  res.render("adminlogged",{data:data});

                })
              });
            });
        }
        else if(String(req.body.x)=="s2")
        {
            data="Movie details of screen2 changed";
            con.query("delete from movie where sc_id=2",function(err,r){
              if(err) throw err;
              //console.log(r);
              var q=`insert into movie values("${mname}","${dirname}","${prn}",${rating},2,${req.body.price})`;
              //console.log(q);
              con.query(q,function (err,re) {
                if(err) throw err;
                //console.log(re);
                var qr=`insert into screen values `;
                var c = 1;
                for(var j = 65; j < 74 ; j++){
  	               for(var i = 1; i <= 30 ; i++){
  		                 qr = qr + `( ${c++} ,2, "${String.fromCharCode(j)}", "${i}" ,"${mname}",false),` ;
                     }
                   }
                   for(var i = 1; i <= 29 ; i++){
  		                 qr = qr + `( ${c++} ,2, "${String.fromCharCode(74)}", ${i} ,"${mname}",false),`;
                     }
                    qr = qr + `( ${c++} ,2, "${String.fromCharCode(74)}", "30" ,"${mname}",false)`;
                //console.log(qr);
                con.query(qr,function(req,resp) {
                  if(err) throw err;
                  console.log(resp);
                  res.render("adminlogged",{data:data});

                })
              });
            });
        }
        else if(String(req.body.x)=="r1")
        {

            data="Seats of screen1 flushed";
            con.query("update screen set status=0 where sc_id=1",function(err,repond){

                if(err)
                    throw err;
                con.query("delete from ticket where sc_id=1",function(err,resp){
                      if(err)
                        throw err;
                        res.render("adminlogged",{data:data});

                    });

            });
        }
        else if(String(req.body.x)=="r2")
        {
            data="Seats of screen2 flushed";
            con.query("update screen set status=0 where sc_id=2",function(err,repond){
                if(err)
                    throw err;
                  con.query("delete from ticket where sc_id=2",function(err,resp){
                    if(err)
                      throw err;

                      res.render("adminlogged",{data:data});
                  })

            });
        }
        else if(String(req.body.x)=="ml")
        {
            con.query("select * from movie_log",function(err,response){
                 mlog = JSON.parse(JSON.stringify(response));
                console.log(mlog);
                 res.render("movie_log",{data:data,mlog:mlog});
                if(err)
                    throw err;

                

            });
        }
        else if(String(req.body.x)=="tl")
        {
            con.query("select * from ticket_log",function(err,response){
                 tlog = JSON.parse(JSON.stringify(response));
                console.log(tlog);
                 res.render("ticket_log",{data:data,tlog:tlog});
                if(err)
                    throw err;
                res.render("adminlogged",{data:data});

            });
        }

        else if(String(req.body.x)=="cr")
        {
          console.log(req.body.x);
          data="revenue = ";

          rev=con.query("select price from screen,movie where screen.sc_id=movie.sc_id and status=1",function(err,response){
            var sum=0;
            var temp=JSON.parse(JSON.stringify(response));
            
            if(err)
              throw err;
            for(var key in temp)
            {
             
              sum=sum+parseInt(temp[key].price);
            }
            console.log(sum);
            data=data+sum+" rupees";
            res.render("adminlogged",{data:data});
          });
          
        }


        console.log(data);


    }
    else
    {
        res.redirect("admin");
    }


  });
  app.post("/search",urlencodedParser,function(req,res){

    console.log(req.body);
    con.query("select m_name from movie_data",function(err,resp) {
        if(err) throw err;
        var movie = JSON.parse(JSON.stringify(resp));
        con.query("select p_name from personals",function(err,resp2){
          if(err) throw err;
          var personals=JSON.parse(JSON.stringify(resp2));
          con.query("select distinct p_name from personals,crew where personals.p_id=crew.dir_id",function(err,resp3){
            if(err) throw err;
            var directors =JSON.parse(JSON.stringify(resp3));
            con.query("select min(release_year) as start, max(release_year) as end from movie_data",function(err,resp4){
              if(err) throw err;
              var time=JSON.parse(JSON.stringify(resp4));
              res.render("searchpage",{movie:movie,actor:personals,directors:directors,time:time});
            });

        });
    });
  });
});
app.post("/set_movie",urlencodedParser,function(req,res){
 //console.log(req.body);
 var m_name = req.body.MovieName;
 var actor_name = req.body.ActorName;
 var director_name = req.body.DirectorName;
 var actor_gender = req.body.ActorGender;
 var director_gender = req.body.DirectorGender;
 var ratingUL = req.body.MovieRatingTop;
 var ratingLL = req.body.MovieRatingBottom;
 var start = req.body.StartYear;
 var end =  req.body.EndYear;
 var mov_id = req.body.movie_id;
 var sc_id = req.body.sc_id;
 var price =req.body.price;
 console.log(mov_id);
 if(mov_id!=undefined && sc_id!=undefined)
 {
   var q = "delete from ticket where sc_id="+sc_id;
   con.query(q,function(err,resp1) {
     if(err)  throw err;
     console.log(resp1);
     var q1="update screen set status = 0 where sc_id="+sc_id;
     con.query(q1,function(err,resp2) {
       if(err)  throw err;
       var q2="delete from movie where sc_id="+sc_id;
       con.query(q2,function(err,resp3) {
         if(err)  throw err;
         var q3="insert into movie (m_id,price,sc_id) values ("+mov_id+","+price+","+sc_id+")";
         console.log(q3);
         con.query(q3,function(err,resp4) {
           if(err)  throw err;
           res.render("adminlogged",{data:"Movie Changed Successfully"});
       });
     });

   });
 });
}
 else{
 console.log("im here nigga");

 var q = `select movie_data.m_id,movie_data.m_name, p_name as d_name,c1,c2,c3,imdb_rating,release_year
         from movie_data,crew,personals,
         (select m_name,gender,p_name as c1 from movie_data,crew,personals where (movie_data.m_id=crew.m_id and crew.c_id1=personals.p_id)) as T1,
         (select m_name,gender,p_name as c2 from movie_data,crew,personals where (movie_data.m_id=crew.m_id and crew.c_id2=personals.p_id)) as T2,
         (select m_name,gender,p_name as c3 from movie_data,crew,personals where (movie_data.m_id=crew.m_id and crew.c_id3=personals.p_id)) as T3
         where
         movie_data.m_id=crew.m_id
         and
         crew.dir_id=personals.p_id
         and
         movie_data.m_name = T1.m_name and movie_data.m_name= T2.m_name and T3.m_name = movie_data.m_name `;
 //console.log(q);
 if(m_name!=='None')
    q = q + "and movie_data.m_name=" + `"${m_name}" `;
 if(actor_name !=='None')
    q = q + "and (personals.p_name=" + `"${actor_name}" or T1.c1="${actor_name}" or T2.c2="${actor_name}") `;
 if(director_name!=='None')
    q = q + "and personals.p_name=" + `"${director_name}" `;
 if(actor_gender!=='None')
    q = q +" and (T1.gender=" + `"${actor_gender}" or T2.gender="${actor_gender}" or T3.gender="${actor_gender}") `;
 if(director_gender!=='None')
    q = q +` and personals.gender = "${director_gender}" `;
 if(ratingUL!=='None')
 {
   if(ratingLL!=='None')
   q = q + `and imdb_rating between ${ratingLL} and ${ratingUL} `;
   else {
     q = q + `and imdb_rating <= ${ratingUL} `
   }
 }
 else if(ratingLL!=='None')
 {
   if(ratingUL!=='None')
   q = q + `and imdb_rating between ${ratingLL} and ${ratingUL} `;
   else {
     q = q + `and imdb_rating >= ${ratingLL} `
   }
 }
 if(start!=='None')
 {
   if(end!=='None')
   q = q + `and release_year between ${start} and ${end} `;
   else {
     q = q + `and release_year >= ${start} `
   }
 }
 else if(end!=='None')
 {
   if(ratingUL!=='None')
   q = q + `and release_year between ${start} and ${end} `;
   else {
     q = q + `and release_year <= ${end} `
   }
 }
 //console.log(ratingLL,ratingUL);
 console.log(q);
 con.query(q,function(err,resp) {
   if(err) throw err;
   console.log(resp);
   var data = JSON.parse(JSON.stringify(resp))
   res.render("set_movie",{data:data});
 });
 //res.render("searchpage");
}

});

app.post("/c_queries",urlencodedParser,function(req,res){

	var temp=req.body;
	console.log(temp);
	var data1="";
	var data2="";
	var data3="";
	var data4="";
	var data5="";
	if(req.body.x==="average rating of each actor")
	{
	var q1="select p_name,avg(imdb_rating) as rating from movie_data,crew,personals where crew.m_id = movie_data.m_id"+ 
			" and(p_id = c_id1 or p_id=c_id2 or p_id = c_id3) group by p_name;"
	con.query(q1,function(err,resp){
		if(err)
			throw err;

		 data1 = JSON.parse(JSON.stringify(resp));
		res.render("Complex_queries",{data1:data1,data2:data2,data3:data3,data4:data4,data5:data5});
	});

	}
	else if(req.body.x==="Highest average rating for an actor")
	{
		var q1="select max(rating) as rating from (select p_name,avg(imdb_rating) as rating"+
				" from movie_data,crew,personals where crew.m_id = movie_data.m_id"+
				" and(p_id = c_id1 or p_id=c_id2 or p_id = c_id3) group by p_name) as T1;";
	
		console.log(q1);
		con.query(q1,function(err,resp){
		if(err)
			throw err;

		 data2 = JSON.parse(JSON.stringify(resp));
		console.log(data2);
		res.render("Complex_queries",{data1:data1,data2:data2,data3:data3,data4:data4,data5:data5});
	});
	}
	else if(req.body.x==="movies with female lead")
	{
		var q1='select m_name,p_name  from movie_data,crew,personals where gender="F"'+ 
		' and movie_data.m_id=crew.m_id and (p_id=c_id1 or p_id =c_id2 or p_id = c_id3);'
		console.log(q1);
		con.query(q1,function(err,resp){

			if(err)
				throw err;
			data3 = JSON.parse(JSON.stringify(resp));
			console.log(data3);
			res.render("Complex_queries",{data1:data1,data2:data2,data3:data3,data4:data4,data5:data5});


		});
	}
	else if(req.body.x==="directors who did movies with a female lead")
	{
		var q1='select distinct d_name from (select movie_data.m_id as m1,p_name'+
				' from movie_data,crew,personals where gender="F" and movie_data.m_id=crew.m_id and'+
				' (p_id=c_id1 or p_id =c_id2 or p_id = c_id3)) as T1,'+
				' (select movie_data.m_id as m2,p_name as d_name from personals,crew,movie_data'+
				' where p_id = dir_id and crew.m_id = movie_data.m_id) as T2 where m1 = m2;'

			//console.log(q1);
				con.query(q1,function(err,resp){

					if(err)
						throw err;
					data4=JSON.parse(JSON.stringify(resp));
					console.log(data4);
					res.render("Complex_queries",{data1:data1,data2:data2,data3:data3,data4:data4,data5:data5});

				});
	}

	else if(req.body.x==="Actor with maximum movies")
	{
		var q1='select distinct(p_name) from personals,crew,movie_data'+
				' where movie_data.m_id = crew.m_id'+
				' and (p_id = c_id1 or p_id = c_id2 or p_id = c_id3)'+
				' and p_id in (select p_id from movie_data,crew,personals'+
				' where movie_data.m_id = crew.m_id and (p_id = c_id1 or p_id = c_id2 or p_id = c_id3)'+
				' group by p_id having count(movie_data.m_id)=(select max(c) from'+
				' (select count(movie_data.m_id) as c from movie_data,crew,personals'+
				' where movie_data.m_id = crew.m_id and (p_id = c_id1 or p_id = c_id2 or p_id = c_id3) group by p_id) as T1));';
	
		con.query(q1,function(err,resp){

			if(err)
				throw err;

			data5=JSON.parse(JSON.stringify(resp));
		//	console.log(data5);
			res.render("Complex_queries",{data1:data1,data2:data2,data3:data3,data4:data4,data5:data5});
		});
	}

	

});

app.get("/c_queries",function(req,res){

	var data1="",data2="",data3="",data4="",data5="";
	res.render("Complex_queries",{data1:data1,data2:data2,data3:data3,data4:data4,data5:data5});
	
});
}
