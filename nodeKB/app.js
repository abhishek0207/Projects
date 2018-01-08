var express = require('express');
var path = require('path');
var mongoose= require('mongoose');
var bodyParser = require('body-parser')
//fetch articles from the database
var Article = require('./models/article');

mongoose.connect('mongodb://localhost/nodekb');
var db = mongoose.connection;

//check connection
db.once('open', function(){
	console.log("Connected to mongo db");
})

//check for db errors
db.on('error', function(err){
	console.log(err);
})



//data from mongo


//Init App
var app =express();

//set up view engine

app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'pug');

// parse application/x-www-form-urlencoded
app.use(bodyParser.urlencoded({ extended: false }))
 
// parse application/json
app.use(bodyParser.json())

//set pubic folder

app.use(express.static(path.join(__dirname, "public")));

//Route to get individual artiles

app.get('/article/:id', function(req, res){
	Article.findById(req.params.id, function(err, article){
		if(err)
		{
			console.log(err);
		}
		else
		{
			res.render('article', {
				eachArticle: article
			})
		}
	})
})

//Route to load edit form

app.get('/article/edit/:id', function(req, res){
	Article.findById(req.params.id, function(err, article){
		if(err)
		{
			console.log(err);
		}
		else
		{
			res.render('article_edit', {
				eachArticle: article
			})
		}
	})
})

//Home Route
app.get('/', function(req, res){
	 Article.find({}, function(err, randomArticles){
	 	if(err){
	 		console.log(err);

	 	}
	 	else
	 	{
	 	 	res.render('index', {
		    title:'Abhishek Ahuja',
		    articleList : randomArticles

	});
	 	}

});

	
})


app.get('/articles/add', function(req, res){
	var articledata = [
	{
	id:1,
	name:'Abhishek Ahuja',
	Article	: 'Hi its great to be simple',
	},
	{
	id:2,
	name:'Shipra Valecha',
	Article	: 'Hi its great not to be simple',
	},
	{
	id:1,
	name:'Vijay Yadav',
	Article	: 'Hi I am the best',
	}

	];
	res.render('articles', {
		title:'Add Articles here',
		article:articledata
	});
})

//add submit posst request

app.post('/articles/add', function(req, res){
	var article = new Article();
	article.title = req.body.title;
	article.author = req.body.author;
	article.body = req.body.body;
	article.save(function(err){
		if(err)
		{
			console.log(err);
		}
		else
		{
			res.redirect('/');
		}
	})

})


//Update an article

app.post('/articles/edit/:id', function(req, res){
	var article = {};
	article.title = req.body.title;
	article.author = req.body.author;
	article.body = req.body.body;
	var query = {_id:req.params.id}

	Article.update(query, article, function(err){
		if(err)
		{
			console.log(err);
		}
		else
		{
			res.redirect('/');
		}
	})

})

app.delete('/article/:id', function(req, res)
{
var query = { _id:req.params.id }
Article.remove(query, function(err){
if(err)
{
	console.log(err);
}
res.send('Success');
});
});
//start server
app.listen(4000, function(){
	console.log("server are you sure started");
})