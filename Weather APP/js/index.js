$(document).ready(function(){
  if(navigator.geolocation){
  navigator.geolocation.getCurrentPosition(function(position){
      var lati = position.coords.latitude;
      var longi =  position.coords.longitude;
    $("#lati").text(lati);
     $("#longi").text(longi);
      //console.log("lati: " + lati);
      //console.log("longi:" + longi);
    var url = "https://fcc-weather-api.glitch.me/api/current?lat=" + lati + "&lon=" + longi;
ajaxCall(url);    
      
    });
     
  }
  $("#fahrenheit").on('click', function(){
    var max_temp = $("#max").text();
    var min_temp = $("#min").text();
    var temp = $(".bigTemp").text();
    //console.log(max_temp);
    max_temp = (max_temp * (9/5)) + 32;
    min_temp = (min_temp * (9/5)) + 32;
    temp = Math.round((temp * (9/5)) + 32);
    console.log(max_temp);
    $("#max").text(max_temp);
    $("#min").text(min_temp);
    $(".bigTemp").text(temp);
    $(".unit").text(" Fahreheits");
    $("#fahrenheit").css("display", "none");
    $("#celsius").css("display", "block");
  });
  $("#celsius").on('click', function(){
    var max_temp = $("#max").text();
    var min_temp = $("#min").text();
    var temp = $(".bigTemp").text();
    console.log(max_temp);
    max_temp = Math.round((max_temp - 32)*(5/9));
    min_temp = Math.round((min_temp - 32)*(5/9));
     temp = Math.round((temp - 32)*(5/9));
    console.log(max_temp);
    $("#max").text(max_temp);
    $("#min").text(min_temp);
    $(".bigTemp").text(temp);
    $(".unit").text(" Celsius");
    $("#fahrenheit").css("display", "block");
    $("#celsius").css("display", "none");
  });
  });
function ajaxCall(url){
  //console.log(url);
 $.ajax({
   url: "https://fcc-weather-api.glitch.me/api/current?lat=" + $("#lati").text() + "&lon=" +
   $("#longi").text(),
   dataType: 'json',
   type:'get',
   success : function(data) {
 // console.log(data["weather"]);
     //console.log(data);
$("#city").text(data["name"]);    data["weather"].forEach(function(element){
      $("#weather-description").text(element["description"]);
       $("#weather-description").before("<img src='" + element["icon"] + "' />");
 $("#weather-description").after("<br ><span id='maximum'> Max Temp : <span id='max'> " + data["main"]["temp_max"] + "</span> <span class='unit'> Celsius</span></span><br><span id='minimum'> Min Temp : <span id='min'>" + data["main"]["temp_min"] + "</span><span class='unit'> Celsius</span>");
       $(".bigTemp").text(data["main"]["temp"]); 
     });
     
   }
 });
}