var chart;
var height = 200;
var width = 300;
//DEFINE YOUR VARIABLES UP HERE


// {
//   const container = d3.create('svg')
//     .attr('width', width)
//     .attr('height', height)
//     .style('border', '1px dotted #999');  

//   container.append('g')
//     .attr('transform', `translate(0, ${height - margin.bottom})`)
//     .call(d3.axisBottom(xMargin));

//   container.append('g')
//     .attr('transform', `translate(${margin.left}, 0)`)
//     .call(d3.axisLeft(yMargin));

//   return container.node();
// }

//Gets called when the page is loaded.
function init(){
//   chart = d3.select('#vis').append('svg');
//   vis = chart.append('g');
//   //PUT YOUR INIT CODE BELOW
  
  
}

//Called when the update button is clicked
function updateClicked(){
  // d3.csv('data/CoffeeData.csv',update);
  var xdropdown = getXSelectedOption();
  var ydropdown = getYSelectedOption();
  if (xdropdown == "region" && ydropdown == "profit") {
    d3.csv('data/reg_profit.csv').then(update);
  }
  if (xdropdown == "region" && ydropdown == "sales") {
    d3.csv('data/reg_sales.csv').then(update);
  }
  if (xdropdown == "category" && ydropdown == "profit") {
    d3.csv('data/cat_profit.csv').then(update);
  }
  if (xdropdown == "category" && ydropdown == "sales") {
    d3.csv('data/cat_sales.csv').then(update);
  }
}

//Callback for when data is loaded
function update(rawdata){
  //PUT YOUR UPDATE CODE BELOW
  var xdropdown = getXSelectedOption();
  var ydropdown = getYSelectedOption();

  let data = rawdata;

  var svg_removed = d3.select("svg").selectAll("*").remove();

  var svg = d3.select("svg"),
    margin = 200,
    width = svg.attr("width") - margin,
    height = svg.attr("height") - margin;

  var xScale = d3.scaleBand().range([0, width]).padding(0.4),
  yScale = d3.scaleLinear().range([height, 0]);

  var g = svg.append("g").attr("transform", "translate(" + 100 + "," + 100 + ")");

  xScale.domain(data.map(function (d) { return d[xdropdown]; }));
  yScale.domain([0, d3.max(data,function(d){return d[ydropdown];})]);
  // yScale.domain([0,d3.aggregate(data,function(d){return d.profit;})]);
  // yScale.domain([0,1000000]);

  g.append("g")
  .attr('transform', 'translate(0, ' + height + ')')
  .call(d3.axisBottom(xScale))
  .append("text")
  .attr("y",'40')
  .attr("x",'140')
  .attr("text-anchor","end")
  .attr("stroke","black")
  .text("X Axis")

  g.append('g').attr('transform', 'translate(' + width + ', 0)')
  .call(d3.axisRight(yScale)
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
  .text("Y Axis");


  // var barColors = d3.scaleOrdinal(["red", "green","blue","orange","brown"]);
  var color = d3.scaleOrdinal(["#2c7cb1", "#e97a13", "#3daf2d", "#FF0000"]);

  g.selectAll(".bar")
    .data(data)
    .enter().append("rect")
    // .attr('fill',function(d,i){return color(i);})
    .attr("fill", function (d, i) { return color(i); })
    // .attr("class","bar")
    .attr("x", function (d) { return xScale(d[xdropdown]); })
    .attr("y", function (d) { return yScale(d[ydropdown]); })
    .attr("width", xScale.bandwidth() + 19)
    .attr("height",function(d){return height-yScale(d[ydropdown]);});
    // .attr("fill", function(d,i) { return barColors[i];


}

// Returns the selected option in the X-axis dropdown. Use d[getXSelectedOption()] to retrieve value instead of d.getXSelectedOption()
function getXSelectedOption(){
  var node = d3.select('#xdropdown').node();
  var i = node.selectedIndex;
  return node[i].value;
}

// Returns the selected option in the X-axis dropdown. 
function getYSelectedOption(){
  var node = d3.select('#ydropdown').node();
  var i = node.selectedIndex;
  return node[i].value;
}
