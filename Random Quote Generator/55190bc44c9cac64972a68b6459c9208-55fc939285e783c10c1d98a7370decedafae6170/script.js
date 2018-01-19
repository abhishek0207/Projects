$(document).ready(function(){
  
  $.getJSON(
  "https://quotesondesign.com/wp-json/posts?filter[orderby]=rand&filter[posts_per_page]=1",
  function(data) {

    // Success! Do stuff with data.
    var post = data.shift();
        $("#quote-title").text(post.title);
        $("#quote-content").html( post.content); 
    $(".twitter-share-button").prop("href", "https://twitter.com/intent/tweet?text=" + post.title + "<br>" + post.content  );
  });
  $("#get-quote").on('click', function(){
      $.ajax({
      url: "https://quotesondesign.com/wp-json/posts?filter[orderby]=rand&filter[posts_per_page]=1",
       dataType: 'json',
      type:'get',
      success : function(data) {
        //console.log(data);
       
        //alert("hit success");
        var post = data.shift();
        $("#quote-title").text(post.title);
        $("#quote-content").html(post.content); 
          $(".twitter-share-button").prop("href", "https://twitter.com/intent/tweet?text=" + post.title + "<br>" + post.content  );
      },
       cache: false
    });
   });
});