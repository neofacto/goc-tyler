<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>

<c:url value="/css/custom.css" var="css" />

	
<!DOCTYPE html>
<html lang="en">
<head>
<title>Explore data by topics | (BnL) </title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
<link href="${css}"rel="stylesheet" />

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

<style type="text/css">
    #mainBubble {
      background: #fff;
      border: solid 1px #ddd;
      box-shadow: 0 0 4px rgba(0,0,0,0);
      font: 10px sans-serif;
      height: 800px;
      position: relative;
      width: 80%;
    }
             
    #mainBubble svg {
      left: 0;
      position: absolute;
      top: 0;
    }
                         
    #mainBubble circle.topBubble {
      fill: #aaa;
      stroke: #666;
      stroke-width: 1.5px;
     }
    </style>
    <script type="text/javascript" src="http://d3js.org/d3.v3.min.js" charset="utf-8"></script>

</head>
<body class="page-chart">
<header>
  <nav class="navbar" role="navigation">
    <div class="logo">
      <h1><a href="#" title="Back to homepage"> <img src="images/logo-bnl.svg" alt="BNL logo" /> </a> </h1>
    </div>
    <ul class="nav">
      <li> <a href="/" class="link-topics selected">
        <svg version="1.1" class="icon" id="ico-themes" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px"
	 viewBox="0 0 40 35.2" style="enable-background:new 0 0 40 35.2;" xml:space="preserve">
          <path class="st0" d="M35.7,25.8v-7.7h-0.5h-0.5H20.5V9.4c2.4-0.3,4.2-2.2,4.2-4.7C24.7,2.1,22.6,0,20,0c-2.6,0-4.7,2.1-4.7,4.7
	c0,2.4,1.9,4.4,4.2,4.7v8.7H5.2H4.7H4.2v7.6h0.5c-2.6,0-4.7,2.1-4.7,4.7c0,2.6,2.1,4.7,4.7,4.7c2.6,0,4.7-2.1,4.7-4.7
	c0-2.6-2.1-4.7-4.7-4.7h0.5v-6.6h14.2v6.7c-2.4,0.3-4.2,2.2-4.2,4.7c0,2.6,2.1,4.7,4.7,4.7c2.6,0,4.7-2.1,4.7-4.7
	c0-2.4-1.9-4.4-4.2-4.7v-6.7h14.2v6.7c-2.4,0.3-4.2,2.2-4.2,4.7c0,2.6,2.1,4.7,4.7,4.7s4.7-2.1,4.7-4.7C40,28,38.1,26,35.7,25.8z"/>
        </svg>
        <span class="link-text">Explore data by topic</span></a> </li>
      <li> <a href="/maps" class="link-location">
        <svg version="1.1" class="icon" id="ico-map" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px"
	 viewBox="0 0 38 35.1" style="enable-background:new 0 0 38 35.1;" xml:space="preserve">
          <path id="TracÃ©_248" d="M38,35.1c-1.2-1-2.4-2-3.7-3c-1.8-1.4-3.5-2.9-5.2-4.3c-0.1-0.1-0.2-0.3-0.2-0.5c0-5,0-9.9,0-14.9
	c0,0,0-0.1,0-0.2l9.1,7.5L38,35.1z"/>
          <path id="TracÃ©_249" d="M0,19.7l8-6.5l1-0.8c0,0.1,0,0.2,0,0.3c0,4.9,0,9.9,0,14.8c0,0.2-0.1,0.3-0.2,0.4c-2.9,2.4-5.8,4.8-8.7,7.2
	c0,0-0.1,0.1-0.1,0.1V19.7z"/>
          <path id="TracÃ©_250" d="M9.7,12.3l3.4,2.8c1.7,1.4,3.5,2.9,5.2,4.3c0.2,0.2,0.4,0.4,0.4,0.7c0,4.8,0,9.7,0,14.5v0.5
	c-0.1-0.1-0.2-0.2-0.3-0.2c-2.8-2.3-5.6-4.6-8.4-6.9c-0.1-0.1-0.2-0.3-0.3-0.5c0-5,0-9.9,0-14.9C9.7,12.5,9.7,12.4,9.7,12.3z"/>
          <path id="TracÃ©_251" d="M19.4,35c0-0.2,0-0.3,0-0.4c0-4.9,0-9.7,0-14.6c0-0.2,0.1-0.4,0.2-0.5c2.8-2.3,5.6-4.6,8.4-6.9
	c0,0,0.1-0.1,0.2-0.1c0,0.1,0,0.2,0,0.3c0,4.9,0,9.8,0,14.8c0,0.2-0.1,0.3-0.2,0.5c-2.8,2.3-5.6,4.6-8.4,6.9
	C19.6,34.9,19.5,34.9,19.4,35z"/>
          <path id="TracÃ©_252" d="M19.7,15.8c-0.1-0.1-0.2-0.2-0.2-0.3c-1.5-2.2-3-4.3-4.5-6.5c-1.8-2.6-1.2-6.2,1.4-8c2.6-1.8,6.2-1.2,8,1.4
	c0.5,0.7,0.8,1.5,1,2.4c0.3,1.5-0.1,3-1,4.2c-1.5,2.1-3,4.3-4.5,6.4C19.9,15.6,19.8,15.7,19.7,15.8z M22.5,5.8
	c0-1.6-1.3-2.9-2.9-2.9c-1.6,0-2.9,1.3-2.9,2.9c0,1.6,1.3,2.9,2.9,2.9c0,0,0,0,0,0C21.2,8.6,22.5,7.3,22.5,5.8L22.5,5.8z"/>
        </svg>
        <span class="link-text">Explore data by location</span></a> </li>
    </ul>
  </nav>
</header>
<main role="main" class="container">
<div id="mainBubble" style="height: 652px;"><svg class="mainBubbleSVG" width="930.24" height="652"><text id="bubbleItemNote" x="10" y="450.12" font-size="12" dominant-baseline="middle" alignment-baseline="middle" style="fill: rgb(136, 136, 136);">D3.js bubble menu developed by Shipeng Sun (sunsp.gis@gmail.com), Institute of Environment, University of Minnesota, and University of Springfield, Illinois.</text></svg></div>
</main>
<aside class="timeline">
  <nav>
    <ul>
      <li><a href="#">2018</a></li>
      <li><a href="#">2005</a></li>
      <li><a href="#">1985</a></li>
      <li><a href="#">1975</a></li>
      <li><a href="#">1968</a></li>
      <li><a href="#">1947</a></li>
    </ul>
  </nav>
</aside>
<section class="aside"> <a href="#" class="close"><span class="at">open/close</span></a>
  <header>
    <h1>List of articles</h1>
    <form>
      <mat-form-field>
        <mat-chip-list #chipList>
          <mat-chip>train</mat-chip>
        </mat-chip-list>
        <input [matChipInputFor]="chipList" placeholder="Your keyword">
      </mat-form-field>
    </form>
    <div class="search-meta">
      <div class="search-meta-count">22 aticles found</div>
      <div class="search-meta-sort">
        <label for="select-order">Order by</label>
        <select id="select-order">
          <option>Pertinance â†‘</option>
          <option>Pertinance â†“</option>
          <option>Date â†‘</option>
          <option>Date â†“</option>
          <option>Titre â†‘</option>
          <option>Titre â†“</option>
        </select>
      </div>
    </div>
  </header>
  <div class="content-aside">
    <ol class="search-results">
      <li>
        <article class="article">
          <h2>Lorem ipsum
            <mark>train</mark>
            title</h2>
          <div class="article-metas">
            <ul>
              <li><span class="label">Published date</span> <span class="value">2017</span></li>
              <li><span class="label">Editor</span> <span class="value">ABCDE</span></li>
              <li><span class="label">Language</span> <span class="value">French</span></li>
            </ul>
          </div>
          <div class="article-description"> Lorem ipsum first words of the
            <mark>train</mark>
            content of the article.. </div>
        </article>
      </li>
      <li>
        <article class="article">
          <h2>Lorem ipsum
            <mark>train</mark>
            title</h2>
          <div class="article-metas">
            <ul>
              <li><span class="label">Published date</span> <span class="value">2017</span></li>
              <li><span class="label">Editor</span> <span class="value">ABCDE</span></li>
              <li><span class="label">Language</span> <span class="value">French</span></li>
            </ul>
          </div>
          <div class="article-description"> Lorem ipsum first words of the
            <mark>train</mark>
            content of the article.. </div>
        </article>
      </li>
      <li>
        <article class="article">
          <h2>Lorem ipsum
            <mark>train</mark>
            title</h2>
          <div class="article-metas">
            <ul>
              <li><span class="label">Published date</span> <span class="value">2017</span></li>
              <li><span class="label">Editor</span> <span class="value">ABCDE</span></li>
              <li><span class="label">Language</span> <span class="value">French</span></li>
            </ul>
          </div>
          <div class="article-description"> Lorem ipsum first words of the
            <mark>train</mark>
            content of the article.. </div>
        </article>
      </li>
      <li>
        <article class="article">
          <h2>Lorem ipsum
            <mark>train</mark>
            title</h2>
          <div class="article-metas">
            <ul>
              <li><span class="label">Published date</span> <span class="value">2017</span></li>
              <li><span class="label">Editor</span> <span class="value">ABCDE</span></li>
              <li><span class="label">Language</span> <span class="value">French</span></li>
            </ul>
          </div>
          <div class="article-description"> Lorem ipsum first words of the
            <mark>train</mark>
            content of the article.. </div>
        </article>
      </li>
      <li>
        <article class="article">
          <h2>Lorem ipsum
            <mark>train</mark>
            title</h2>
          <div class="article-metas">
            <ul>
              <li><span class="label">Published date</span> <span class="value">2017</span></li>
              <li><span class="label">Editor</span> <span class="value">ABCDE</span></li>
              <li><span class="label">Language</span> <span class="value">French</span></li>
            </ul>
          </div>
          <div class="article-description"> Lorem ipsum first words of the
            <mark>train</mark>
            content of the article.. </div>
        </article>
      </li>
      <li>
        <article class="article">
          <h2>Lorem ipsum
            <mark>train</mark>
            title</h2>
          <div class="article-metas">
            <ul>
              <li><span class="label">Published date</span> <span class="value">2017</span></li>
              <li><span class="label">Editor</span> <span class="value">ABCDE</span></li>
              <li><span class="label">Language</span> <span class="value">French</span></li>
            </ul>
          </div>
          <div class="article-description"> Lorem ipsum first words of the
            <mark>train</mark>
            content of the article.. </div>
        </article>
      </li>
      <li>
        <article class="article">
          <h2>Lorem ipsum
            <mark>train</mark>
            title</h2>
          <div class="article-metas">
            <ul>
              <li><span class="label">Published date</span> <span class="value">2017</span></li>
              <li><span class="label">Editor</span> <span class="value">ABCDE</span></li>
              <li><span class="label">Language</span> <span class="value">French</span></li>
            </ul>
          </div>
          <div class="article-description"> Lorem ipsum first words of the
            <mark>train</mark>
            content of the article.. </div>
        </article>
      </li>
      <li>
        <article class="article">
          <h2>Lorem ipsum
            <mark>train</mark>
            title</h2>
          <div class="article-metas">
            <ul>
              <li><span class="label">Published date</span> <span class="value">2017</span></li>
              <li><span class="label">Editor</span> <span class="value">ABCDE</span></li>
              <li><span class="label">Language</span> <span class="value">French</span></li>
            </ul>
          </div>
          <div class="article-description"> Lorem ipsum first words of the
            <mark>train</mark>
            content of the article.. </div>
        </article>
      </li>
      <li>
        <article class="article">
          <h2>Lorem ipsum
            <mark>train</mark>
            title</h2>
          <div class="article-metas">
            <ul>
              <li><span class="label">Published date</span> <span class="value">2017</span></li>
              <li><span class="label">Editor</span> <span class="value">ABCDE</span></li>
              <li><span class="label">Language</span> <span class="value">French</span></li>
            </ul>
          </div>
          <div class="article-description"> Lorem ipsum first words of the
            <mark>train</mark>
            content of the article.. </div>
        </article>
      </li>
    </ol>
  </div>
</section>
<script>
$( "a.close" ).click(function() {
  $( "body" ).toggleClass( "aside-closed" );
    return false;
});

var w = window.innerWidth*0.68*0.95;
   var h = Math.ceil(w*0.7);
   var oR = 0;
   var nTop = 0;
    
   var svgContainer = d3.select("#mainBubble")
      .style("height", h+"px");
    
   var svg = d3.select("#mainBubble").append("svg")
        .attr("class", "mainBubbleSVG")
        .attr("width", w)
        .attr("height",h)
        .on("mouseleave", function() {return resetBubbles();});
         
   var mainNote = svg.append("text")
    .attr("id", "bubbleItemNote")
    .attr("x", 10)
    .attr("y", w/2-15)
    .attr("font-size", 12)
    .attr("dominant-baseline", "middle")
    .attr("alignment-baseline", "middle")
    .style("fill", "#888888")
    .text(function(d) {return "Neofacto";});   
 
 
    d3.json("main_bubble.json", function(error, root) {
        console.log(error);
     
        var bubbleObj = svg.selectAll(".topBubble")
                .data(root.children)
            .enter().append("g")
                .attr("id", function(d,i) {return "topBubbleAndText_" + i});
             
        console.log(root);  
        nTop = root.children.length;
        oR = w/(1+3*nTop);  
 
    h = Math.ceil(w/nTop*2);
    svgContainer.style("height",h+"px");
         
        var colVals = d3.scale.category10();
         
        bubbleObj.append("circle")
            .attr("class", "topBubble")
            .attr("id", function(d,i) {return "topBubble" + i;})
            .attr("r", function(d) { return oR; })
            .attr("cx", function(d, i) {return oR*(3*(1+i)-1);})
            .attr("cy", (h+oR)/3)
            .style("fill", function(d,i) { return colVals(i); }) // #1f77b4
        .style("opacity",0.3)
            .on("mouseover", function(d,i) {return activateBubble(d,i);});
         
             
        bubbleObj.append("text")
            .attr("class", "topBubbleText")
            .attr("x", function(d, i) {return oR*(3*(1+i)-1);})
            .attr("y", (h+oR)/3)
        .style("fill", function(d,i) { return colVals(i); }) // #1f77b4
            .attr("font-size", 30)
            .attr("text-anchor", "middle")
        .attr("dominant-baseline", "middle")
        .attr("alignment-baseline", "middle")
            .text(function(d) {return d.name})      
            .on("mouseover", function(d,i) {return activateBubble(d,i);});
         
         
        for(var iB = 0; iB < nTop; iB++)
        {
            var childBubbles = svg.selectAll(".childBubble" + iB)
                .data(root.children[iB].children)
                .enter().append("g");
                 
        //var nSubBubble = Math.floor(root.children[iB].children.length/2.0);   
             
            childBubbles.append("circle")
                .attr("class", "childBubble" + iB)
                .attr("id", function(d,i) {return "childBubble_" + iB + "sub_" + i;})
                .attr("r",  function(d) {return oR/3.0;})
                .attr("cx", function(d,i) {return (oR*(3*(iB+1)-1) + oR*1.5*Math.cos((i-1)*45/180*3.1415926));})
                .attr("cy", function(d,i) {return ((h+oR)/3 +        oR*1.5*Math.sin((i-1)*45/180*3.1415926));})
                .attr("cursor","pointer")
                .style("opacity",0.5)
                .style("fill", "#eee")
                .on("click", function(d,i) {
                window.open(d.address);                 
              })
            .on("mouseover", function(d,i) {
              //window.alert("say something");
              var noteText = "";
              if (d.note == null || d.note == "") {
                noteText = d.address;
              } else {
                noteText = d.note;
              }
              d3.select("#bubbleItemNote").text(noteText);
              })
            .append("svg:title")
            .text(function(d) { return d.address; });   
 
            childBubbles.append("text")
                .attr("class", "childBubbleText" + iB)
                .attr("x", function(d,i) {return (oR*(3*(iB+1)-1) + oR*1.5*Math.cos((i-1)*45/180*3.1415926));})
                .attr("y", function(d,i) {return ((h+oR)/3 +        oR*1.5*Math.sin((i-1)*45/180*3.1415926));})
                .style("opacity",0.5)
                .attr("text-anchor", "middle")
            .style("fill", function(d,i) { return colVals(iB); }) // #1f77b4
                .attr("font-size", 6)
                .attr("cursor","pointer")
                .attr("dominant-baseline", "middle")
            .attr("alignment-baseline", "middle")
                .text(function(d) {return d.name})      
                .on("click", function(d,i) {
                window.open(d.address);
                }); 
 
        }
 
         
        }); 
 
    resetBubbles = function () {
      w = window.innerWidth*0.68*0.95;
      oR = w/(1+3*nTop);
       
      h = Math.ceil(w/nTop*2);
      svgContainer.style("height",h+"px");
 
      mainNote.attr("y",h-15);
           
      svg.attr("width", w);
      svg.attr("height",h);       
       
      d3.select("#bubbleItemNote").text("D3.js bubble menu developed by Shipeng Sun (sunsp.gis@gmail.com), Institute of Environment, University of Minnesota, and University of Springfield, Illinois.");
       
      var t = svg.transition()
          .duration(650);
         
        t.selectAll(".topBubble")
            .attr("r", function(d) { return oR; })
            .attr("cx", function(d, i) {return oR*(3*(1+i)-1);})
            .attr("cy", (h+oR)/3);
 
        t.selectAll(".topBubbleText")
        .attr("font-size", 30)
            .attr("x", function(d, i) {return oR*(3*(1+i)-1);})
            .attr("y", (h+oR)/3);
     
      for(var k = 0; k < nTop; k++) 
      {
        t.selectAll(".childBubbleText" + k)
                .attr("x", function(d,i) {return (oR*(3*(k+1)-1) + oR*1.5*Math.cos((i-1)*45/180*3.1415926));})
                .attr("y", function(d,i) {return ((h+oR)/3 +        oR*1.5*Math.sin((i-1)*45/180*3.1415926));})
            .attr("font-size", 6)
                .style("opacity",0.5);
 
        t.selectAll(".childBubble" + k)
                .attr("r",  function(d) {return oR/3.0;})
            .style("opacity",0.5)
                .attr("cx", function(d,i) {return (oR*(3*(k+1)-1) + oR*1.5*Math.cos((i-1)*45/180*3.1415926));})
                .attr("cy", function(d,i) {return ((h+oR)/3 +        oR*1.5*Math.sin((i-1)*45/180*3.1415926));});
                     
      }   
    }
         
         
        function activateBubble(d,i) {
            // increase this bubble and decrease others
            var t = svg.transition()
                .duration(d3.event.altKey ? 7500 : 350);
     
            t.selectAll(".topBubble")
                .attr("cx", function(d,ii){
                    if(i == ii) {
                        // Nothing to change
                        return oR*(3*(1+ii)-1) - 0.6*oR*(ii-1);
                    } else {
                        // Push away a little bit
                        if(ii < i){
                            // left side
                            return oR*0.6*(3*(1+ii)-1);
                        } else {
                            // right side
                            return oR*(nTop*3+1) - oR*0.6*(3*(nTop-ii)-1);
                        }
                    }               
                })
                .attr("r", function(d, ii) { 
                    if(i == ii)
                        return oR*1.8;
                    else
                        return oR*0.8;
                    });
                     
            t.selectAll(".topBubbleText")
                .attr("x", function(d,ii){
                    if(i == ii) {
                        // Nothing to change
                        return oR*(3*(1+ii)-1) - 0.6*oR*(ii-1);
                    } else {
                        // Push away a little bit
                        if(ii < i){
                            // left side
                            return oR*0.6*(3*(1+ii)-1);
                        } else {
                            // right side
                            return oR*(nTop*3+1) - oR*0.6*(3*(nTop-ii)-1);
                        }
                    }               
                })          
                .attr("font-size", function(d,ii){
                    if(i == ii)
                        return 30*1.5;
                    else
                        return 30*0.6;              
                });
     
            var signSide = -1;
            for(var k = 0; k < nTop; k++) 
            {
                signSide = 1;
                if(k < nTop/2) signSide = 1;
                t.selectAll(".childBubbleText" + k)
                    .attr("x", function(d,i) {return (oR*(3*(k+1)-1) - 0.6*oR*(k-1) + signSide*oR*2.5*Math.cos((i-1)*45/180*3.1415926));})
                    .attr("y", function(d,i) {return ((h+oR)/3 + signSide*oR*2.5*Math.sin((i-1)*45/180*3.1415926));})
                    .attr("font-size", function(){
                            return (k==i)?12:6;
                        })
                    .style("opacity",function(){
                            return (k==i)?1:0;
                        });
                     
                t.selectAll(".childBubble" + k)
                    .attr("cx", function(d,i) {return (oR*(3*(k+1)-1) - 0.6*oR*(k-1) + signSide*oR*2.5*Math.cos((i-1)*45/180*3.1415926));})
                    .attr("cy", function(d,i) {return ((h+oR)/3 + signSide*oR*2.5*Math.sin((i-1)*45/180*3.1415926));})
                    .attr("r", function(){
                            return (k==i)?(oR*0.55):(oR/3.0);               
                    })
                    .style("opacity", function(){
                            return (k==i)?1:0;                  
                        }); 
            }                   
        }
     
    window.onresize = resetBubbles;
</script>
</body>
</html>
