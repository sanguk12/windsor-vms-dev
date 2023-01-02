//ActiveWidgets Configuration Start
var string = new AW.Formats.String;
var str = new AW.Formats.String;
var number = new AW.Formats.Number;
var num = new AW.Formats.Number;
var num0 = new AW.Formats.Number;
var num1 = new AW.Formats.Number;
var num2 = new AW.Formats.Number;
var num3 = new AW.Formats.Number;
var num4 = new AW.Formats.Number;
var num5 = new AW.Formats.Number;
var date = new AW.Formats.Date;
var html = new AW.Formats.HTML; 
var htm = new AW.Formats.HTML;
var amt = new AW.Formats.Number;

number.setTextFormat("#,###.#");
num.setTextFormat("#,###.");
num0.setTextFormat("#,###.");
num1.setTextFormat("#,###.#");
num2.setTextFormat("#,###.##");
num3.setTextFormat("#,###.###");
num4.setTextFormat("#,###.####");
num5.setTextFormat("#,###.#####");
date.setDataFormat("ISO8601");
date.setTextFormat("yyyy.mm.dd");
amt.setTextFormat("#,###.##");


function gridClear(grid){
	grid.setCellData(new Array());
	grid.setRowCount(0);
	grid.refresh();
}

//ActiveWidgets Configuration End