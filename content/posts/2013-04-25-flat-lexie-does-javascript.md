---
categories:
- development
comments: true
date: "2013-04-25T00:00:00Z"
excerpt: This week I threw together a little site for the daughter of some friends.
  Lexie is my friends' daughter and she is lovely. She had to do a Flat Stanley project
  but she named it Flat Lexie instead. So they sent me a Flat Lexie and we basically
  travelled the world together -- flat lexie and I. We had a few adventures so I wanted
  to try to capture the pictures I took but also to capture the geography and background
  of the different places.
meta: true
published: true
tags:
- ruby
- javascript
- google maps
title: Flat Lexie Does Javascript
---

This week I threw together a little site for the daughter of some friends. Lexie is my friends' daughter and she is lovely. She had to do a Flat Stanley project but she named it Flat Lexie instead. So they sent me a Flat Lexie and we basically travelled the world together -- flat lexie and I. We had a few adventures so I wanted to try to capture the pictures I took but also to capture the geography and background of the different places. Indeed, this is supposed to be the point of the Flat Stanley/Flat Lexie exercises for kids to know about the world. In any event, [here](http://flatlexie.caseykuhlman.com) is the result; [here](https://github.com/compleatang/flat-lexie) is the code. 

It is a simple Sinatra app (first for me), running on Heroku (another first for me), which integrates the [gMaps](https://github.com/HPNeo/gmaps) package I installed with Bower (first, first), and a bit of jQuery I added along the way to tie everything together (not a first). 

## Lessons Learned

What did I learn?

* I like Ruby.
* I'm not sure I like javascript.
* At a minimum, I'm pretty awful at javascript.
* In any event I'm more comfortable with Ruby.
* Sinatra is smooth.
* Heroku is smooth.
* I still have to figure out how to pass JSON data to javascript run views from Ruby controllers that doesn't rely on data attributes -- as that feels like such a patch.

## How

The chunk that took me the biggest portion of time was building the javascript file that would tie gMaps, jQuery and the view together. I built the view so it would preload all of the images in boxes that I wanted to slideToggle the display of in sequence. This was straight-forward jQuery, nothing special there. 

Then I wanted the map which comprises a 100%x100% background to move around zoom in and zoom out on certain events. Basically I wanted the map to start zoomed out, so that Lexie could see the context, and then after waiting a few seconds I wanted to zoom in to the pinpoint location. When moving to the next picture in the series I wanted the sequence to run like this: slideToggle the old picture/entry, I wanted the map to zoom out to a preestablished zoom level (which depended on how "big" the transition was), then I wanted to put a marker in the new location, then I wanted the map to slide its center over to the new location. It turned out to be not that difficult. gMaps is a great API wrapper for Google Maps API. Between gMaps and jQuery it wasn't that difficult to craft. 

Still I have some issues with javascript. My issues aren't with javascript per se, as in they are the language's problem, they are my problem in that I don't really know how to use the language properly yet. I still don't fully understand how to call functions and functions as extensable objects is still quite confusing to me and also variable scope is killing me. Both of these Ruby is much more straight-forward about (or else I've read more about and understand better). So if anyone wants to point out the innumerable flaws and less than optimal code in the javascript below I'm happy to learn. 

In any event, my script that tied the whole thing together and made Flat Lexie works.

{{< highlight javascript >}}
$(document).ready(function(){

  // Hide the boxes that are not the first box
  $('.box').slice(1).hide();
  $(".section a[href^='http://']").attr("target","_blank");

  // Title toggles the view of the content box
  $(".title > a").click(function(){
    $("content").slideToggle('fast');
  });

  // Initial variables
  var LAT = $('.box').first().data('lat'),
      LNG = $('.box').first().data('long'),
      ZM_OUT = 4,
      ZM_IN = 20;

  // Set the initial map
  map = new GMaps({
    div: '#map',
    zoom: ZM_OUT,
    mapTypeId: google.maps.MapTypeId.HYBRID,
    lat: LAT,
    lng: LNG
  });
  setTimeout(function() {map.addMarker({ lat: LAT, lng: LNG, });}, 1250);
  setTimeout(function() {map.setZoom(ZM_IN);}, 2500);

  // Previous_event clicks should be hidden on the first box, the rest should run the previous transition
  $(".previous_event").click(prevTransition);
  $('.box').first().children('.previous_event').hide();

  // Next event should run, and reloop if it is the last box
  $(".next_event").click(nextTransition);
  $('.box').last().children(".next_event").click(reloopTransition);

  function nextTransition() {
    $('.nav a').addClass('disabled');
    TRANS = $(this).parents('.box').data('transition');
    if(TRANS == "bigTrans")
      ZM_OUT = 4;
    if(TRANS == "medTrans")
      ZM_OUT = 8;
    if(TRANS == "smallTrans")
      ZM_OUT = 16;
    if(TRANS == "microTrans")
      ZM_OUT = 20;
    map.setZoom(ZM_OUT);
    $(this).parents(".box").slideToggle('slow', function(){
      $(this).next().slideToggle('slow', function(){
        var LAT = $(this).data('lat'),
            LNG = $(this).data('long');
        setTimeout(function() {map.addMarker({ lat: LAT, lng: LNG, });}, 750); 
        setTimeout(function() {map.setCenter(map.markers[map.markers.length-1].getPosition().lat(), map.markers[map.markers.length-1].getPosition().lng());}, 1200);
        setTimeout(function() {map.setZoom(ZM_IN);}, 3750);
        setTimeout(function() {$('.nav a').removeClass('disabled')}, 4000);
      });
    });
  };

  function prevTransition() {
    $('a').addClass('disabled');
    TRANS = $(this).parents('.box').prev().data('transition');
    if(TRANS == "bigTrans")
      ZM_OUT = 4;
    if(TRANS == "medTrans")
      ZM_OUT = 8;
    if(TRANS == "smallTrans")
      ZM_OUT = 16;
    if(TRANS == "microTrans")
      ZM_OUT = 20;
    map.setZoom(ZM_OUT);
    $(this).parents(".box").slideToggle('slow', function(){
      $(this).prev().slideToggle('slow', function(){
        var LAT = $(this).data('lat'),
            LNG = $(this).data('long');
        setTimeout(function() {map.addMarker({ lat: LAT, lng: LNG, });}, 750); 
        setTimeout(function() {map.setCenter(map.markers[map.markers.length-1].getPosition().lat(), map.markers[map.markers.length-1].getPosition().lng());}, 1200);
        setTimeout(function() { map.setZoom(ZM_IN); }, 3750);
        setTimeout(function() {$('a').removeClass('disabled')}, 4500);
      });
    });
  };

  function reloopTransition() {
    ZM_OUT = 4;
    map.setZoom(ZM_OUT);
    $(this).parents(".box").slideToggle('slow', function(){
      $(this).siblings(":first").slideToggle('slow', function(){
        var LAT = $(this).data('lat'),
            LNG = $(this).data('long');
        setTimeout(function() {map.addMarker({ lat: LAT, lng: LNG, });}, 750); 
        setTimeout(function() {map.setCenter(map.markers[map.markers.length-1].getPosition().lat(), map.markers[map.markers.length-1].getPosition().lng());}, 1200);
        setTimeout(function() { map.setZoom(ZM_IN); }, 3750);
        setTimeout(function() {$('a').removeClass('disabled')}, 4500);
      });
    });    
  };
});
{{< / highlight >}}

For the record, Flat Lexie can easily be adopted to your needs if you have a Flat Stanley project to do. Just fork the repo, add your pictures, add the datapoints.json lat/longs, write any copy you may want and `git push heroku`. Voila. 

Happy Hacking everyone!

~ # ~