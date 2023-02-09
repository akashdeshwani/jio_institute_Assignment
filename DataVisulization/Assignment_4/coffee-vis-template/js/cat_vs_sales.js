function main()
{
var svg=d3.select("svg"), 
margin=250, 
width=svg.attr("width")-margin, 
height=svg.attr("height")-margin;

svg.append("text")
.attr("transform", "translate(100,0)")
.attr("x", 100)
.attr("y", 50)
.attr("font-size", "12px")
.text("Sales by Month");

// var color = d3.scaleOrdinal(['#4daf4a','#377eb8','#ff7f00','#984ea3','#e41a1c']);


var xScale=d3.scaleBand().range([0,width]).padding(0.4), 
    yScale=d3.scaleLinear().range([height,0]);

var g=svg.append("g")
.attr("transform","translate("+100+","+100+")");

d3.csv("/data/cat_sales.csv").then(function(data){
    
    xScale.domain(data.map(function(d){ return d.category;}));
    yScale.domain([0,d3.max(data,function(d){return d.sales;})]);
    // yScale.domain([0,d3.aggregate(data,function(d){return d.profit;})]);
    // yScale.domain([0,1000000]);
    

    g.append("g")
    .attr('transform','translate(0,'+height+')')
    .call(d3.axisBottom(xScale))
    .append("text")
    .attr("y",'40')
    .attr("x",'140')
    .attr("text-anchor","end")
    .attr("stroke","black")
    .text("Category");

    g.append('g')
    .attr("transform","translate("+width+",0)")
    .call(d3.axisRight(yScale).tickFormat(function(d){
        return d;})
    .ticks(6))
    .append("text")
    .attr("transform","rotate(-90)")
    .attr("y",15)
    // .attr("y",height-320)
    .attr("dy","50")
    .attr("x",10)
    .attr("dx","-8em")
    .attr("text-anchor","end")
    .attr("stroke","black")
    .text("Sales");

    // var barColors = d3.scaleOrdinal(["red", "green","blue","orange","brown"]);
    var color = d3.scaleOrdinal(["#2c7cb1","#e97a13","#3daf2d","#FF0000"]);

    g.selectAll(".bar")
    .data(data)
    .enter().append("rect")
    // .attr('fill',function(d,i){return color(i);})
    .attr("fill", function(d,i){return color(i);})
    // .attr("class","bar")
    .attr("x",function(d){return xScale(d.category);})
    .attr("y",function(d){return yScale(d.sales);})
    .attr("width",xScale.bandwidth()+15)
    .attr("height",function(d){return height-yScale(d.sales);})
    .attr("fill", function(d,i) { return barColors[i]; });


});
}