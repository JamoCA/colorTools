/*
	@name:			colorTools.cfc
	@author:		James Moberg / SunStar Media
	@date:			2/27/2025
	@version:		1.1
	@contact:		james @ sunstarmedia DOT com
	@purpose:		Functions for color generation and manipulation

	@usage:
					Initialize
					colorTools = new colorTools();

	@caveat:		Use at your own risk.  I assume no responsibility.
	@Changelog
		2025-03-06: 1.1 Add excelColors palette; add new heatColor method w/array & named palette support

*/

component
	output=false
	displayname="colorTools"
	hint="I perform tasks for color generation and manipulation" {

	variables.textCase = "ucase"; // Better readability/scannability; Wider adoption in professional style guides/tools; Consistency with historical & team-based workflows

	/**
	ColorBrewer colors for chroma.js

	Copyright (c) 2002 Cynthia Brewer, Mark Harrower, and The Pennsylvania State University.

	Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License.	You may obtain a copy of the License at	http://www.apache.org/licenses/LICENSE-2.0

	Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.
	*/
	variables.colorBrewerPalette = [
		"Accent": ["7FC97F", "BEAED4", "FDC086", "FFFF99", "386CB0", "F0027F", "BF5B17", "666666"]
		,"Blues": ["F7FBFF", "DEEBF7", "C6DBEF", "9ECAE1", "6BAED6", "4292C6", "2171B5", "08519C", "08306B"]
		,"BrBG": ["543005", "8C510A", "BF812D", "DFC27D", "F6E8C3", "F5F5F5", "C7EAE5", "80CDC1", "35978F", "01665E", "003C30"]
		,"BuGn": ["F7FCFD", "E5F5F9", "CCECE6", "99D8C9", "66C2A4", "41AE76", "238B45", "006D2C", "00441B"]
		,"BuPu": ["F7FCFD", "E0ECF4", "BFD3E6", "9EBCDA", "8C96C6", "8C6BB1", "88419D", "810F7C", "4D004B"]
		,"Dark2": ["1B9E77", "D95F02", "7570B3", "E7298A", "66A61E", "E6AB02", "A6761D", "666666"]
		,"GnBu": ["F7FCF0", "E0F3DB", "CCEBC5", "A8DDB5", "7BCCC4", "4EB3D3", "2B8CBE", "0868AC", "084081"]
		,"Greens": ["F7FCF5", "E5F5E0", "C7E9C0", "A1D99B", "74C476", "41AB5D", "238B45", "006D2C", "00441B"]
		,"Greys": ["FFFFFF", "F0F0F0", "D9D9D9", "BDBDBD", "969696", "737373", "525252", "252525", "000000"]
		,"Oranges": ["FFF5EB", "FEE6CE", "FDD0A2", "FDAE6B", "FD8D3C", "F16913", "D94801", "A63603", "7F2704"]
		,"OrRd": ["FFF7EC", "FEE8C8", "FDD49E", "FDBB84", "FC8D59", "EF6548", "D7301F", "B30000", "7F0000"]
		,"Paired": ["A6CEE3", "1F78B4", "B2DF8A", "33A02C", "FB9A99", "E31A1C", "FDBF6F", "FF7F00", "CAB2D6", "6A3D9A", "FFFF99", "B15928"]
		,"Pastel1": ["FBB4AE", "B3CDE3", "CCEBC5", "DECBE4", "FED9A6", "FFFFCC", "E5D8BD", "FDDAEC", "F2F2F2"]
		,"Pastel2": ["B3E2CD", "FDCDAC", "CBD5E8", "F4CAE4", "E6F5C9", "FFF2AE", "F1E2CC", "CCCCCC"]
		,"PiYG": ["8E0152", "C51B7D", "DE77AE", "F1B6DA", "FDE0EF", "F7F7F7", "E6F5D0", "B8E186", "7FBC41", "4D9221", "276419"]
		,"PRGn": ["40004B", "762A83", "9970AB", "C2A5CF", "E7D4E8", "F7F7F7", "D9F0D3", "A6DBA0", "5AAE61", "1B7837", "00441B"]
		,"PuBu": ["FFF7FB", "ECE7F2", "D0D1E6", "A6BDDB", "74A9CF", "3690C0", "0570B0", "045A8D", "023858"]
		,"PuBuGn": ["FFF7FB", "ECE2F0", "D0D1E6", "A6BDDB", "67A9CF", "3690C0", "02818A", "016C59", "014636"]
		,"PuOr": ["7F3B08", "B35806", "E08214", "FDB863", "FEE0B6", "F7F7F7", "D8DAEB", "B2ABD2", "8073AC", "542788", "2D004B"]
		,"PuRd": ["F7F4F9", "E7E1EF", "D4B9DA", "C994C7", "DF65B0", "E7298A", "CE1256", "980043", "67001F"]
		,"Purples": ["FCFBFD", "EFEDF5", "DADAEB", "BCBDDC", "9E9AC8", "807DBA", "6A51A3", "54278F", "3F007D"]
		,"RdBu": ["67001F", "B2182B", "D6604D", "F4A582", "FDDBC7", "F7F7F7", "D1E5F0", "92C5DE", "4393C3", "2166AC", "053061"]
		,"RdGy": ["67001F", "B2182B", "D6604D", "F4A582", "FDDBC7", "FFFFFF", "E0E0E0", "BABABA", "878787", "4D4D4D", "1A1A1A"]
		,"RdPu": ["FFF7F3", "FDE0DD", "FCC5C0", "FA9FB5", "F768A1", "DD3497", "AE017E", "7A0177", "49006A"]
		,"RdYlBu": ["A50026", "D73027", "F46D43", "FDAE61", "FEE090", "FFFFBF", "E0F3F8", "ABD9E9", "74ADD1", "4575B4", "313695"]
		,"RdYlGn": ["A50026", "D73027", "F46D43", "FDAE61", "FEE08B", "FFFFBF", "D9EF8B", "A6D96A", "66BD63", "1A9850", "006837"]
		,"Reds": ["FFF5F0", "FEE0D2", "FCBBA1", "FC9272", "FB6A4A", "EF3B2C", "CB181D", "A50F15", "67000D"]
		,"Set1": ["E41A1C", "377EB8", "4DAF4A", "984EA3", "FF7F00", "FFFF33", "A65628", "F781BF", "999999"]
		,"Set2": ["66C2A5", "FC8D62", "8DA0CB", "E78AC3", "A6D854", "FFD92F", "E5C494", "B3B3B3"]
		,"Set3": ["8DD3C7", "FFFFB3", "BEBADA", "FB8072", "80B1D3", "FDB462", "B3DE69", "FCCDE5", "D9D9D9", "BC80BD", "CCEBC5", "FFED6F"]
		,"Spectral": ["9E0142", "D53E4F", "F46D43", "FDAE61", "FEE08B", "FFFFBF", "E6F598", "ABDDA4", "66C2A5", "3288BD", "5E4FA2"]
		,"YlGn": ["FFFFE5", "F7FCB9", "D9F0A3", "ADDD8E", "78C679", "41AB5D", "238443", "006837", "004529"]
		,"YlGnBu": ["FFFFD9", "EDF8B1", "C7E9B4", "7FCDBB", "41B6C4", "1D91C0", "225EA8", "253494", "081D58"]
		,"YlOrBr": ["FFFFE5", "FFF7BC", "FEE391", "FEC44F", "FE9929", "EC7014", "CC4C02", "993404", "662506"]
		,"YlOrRd": ["FFFFCC", "FFEDA0", "FED976", "FEB24C", "FD8D3C", "FC4E2A", "E31A1C", "BD0026", "800026"]
	];

	// TODO: Add support for X11 color names
	/* X11 color names https://en.wikipedia.org/wiki/X11_color_names */
	variables.w3cx11 = [
		"indigo": "4B0082", "gold": "FFD700", "hotpink": "FF69B4", "firebrick": "B22222", "indianred": "CD5C5C", "yellow": "FFFF00", "mistyrose": "FFE4E1", "darkolivegreen": "556B2F", "olive": "808000", "darkseagreen": "8FBC8F", "pink": "FFC0CB", "tomato": "FF6347", "lightcoral": "F08080", "orangered": "FF4500", "navajowhite": "FFDEAD", "lime": "00FF00", "palegreen": "98FB98", "darkslategrey": "2F4F4F", "greenyellow": "ADFF2F", "burlywood": "DEB887", "seashell": "FFF5EE", "mediumspringgreen": "00FA9A", "fuchsia": "FF00FF", "papayawhip": "FFEFD5", "blanchedalmond": "FFEBCD", "chartreuse": "7FFF00", "dimgray": "696969", "black": "000000", "peachpuff": "FFDAB9", "springgreen": "00FF7F", "aquamarine": "7FFFD4", "white": "FFFFFF", "orange": "FFA500", "lightsalmon": "FFA07A", "darkslategray": "2F4F4F", "brown": "A52A2A", "ivory": "FFFFF0", "dodgerblue": "1E90FF", "peru": "CD853F", "lawngreen": "7CFC00", "chocolate": "D2691E", "crimson": "DC143C", "forestgreen": "228B22", "darkgrey": "A9A9A9", "lightseagreen": "20B2AA", "cyan": "00FFFF", "mintcream": "F5FFFA", "silver": "C0C0C0", "antiquewhite": "FAEBD7", "mediumorchid": "BA55D3", "skyblue": "87CEEB", "gray": "808080", "darkturquoise": "00CED1", "goldenrod": "DAA520", "darkgreen": "006400", "floralwhite": "FFFAF0", "darkviolet": "9400D3", "darkgray": "A9A9A9", "moccasin": "FFE4B5", "saddlebrown": "8B4513", "grey": "808080", "darkslateblue": "483D8B", "lightskyblue": "87CEFA", "lightpink": "FFB6C1", "mediumvioletred": "C71585", "slategrey": "708090", "red": "FF0000", "deeppink": "FF1493", "limegreen": "32CD32", "darkmagenta": "8B008B", "palegoldenrod": "EEE8AA", "plum": "DDA0DD", "turquoise": "40E0D0", "lightgrey": "D3D3D3", "lightgoldenrodyellow": "FAFAD2", "darkgoldenrod": "B8860B", "lavender": "E6E6FA", "maroon": "800000", "yellowgreen": "9ACD32", "sandybrown": "F4A460", "thistle": "D8BFD8", "violet": "EE82EE", "navy": "000080", "magenta": "FF00FF", "dimgrey": "696969", "tan": "D2B48C", "rosybrown": "BC8F8F", "olivedrab": "6B8E23", "blue": "0000FF", "lightblue": "ADD8E6", "ghostwhite": "F8F8FF", "honeydew": "F0FFF0", "cornflowerblue": "6495ED", "slateblue": "6A5ACD", "linen": "FAF0E6", "darkblue": "00008B", "powderblue": "B0E0E6", "seagreen": "2E8B57", "darkkhaki": "BDB76B", "snow": "FFFAFA", "sienna": "A0522D", "mediumblue": "0000CD", "royalblue": "4169E1", "lightcyan": "E0FFFF", "green": "008000", "mediumpurple": "9370DB", "midnightblue": "191970", "cornsilk": "FFF8DC", "paleturquoise": "AFEEEE", "bisque": "FFE4C4", "slategray": "708090", "darkcyan": "008B8B", "khaki": "F0E68C", "wheat": "F5DEB3", "teal": "008080", "darkorchid": "9932CC", "deepskyblue": "00BFFF", "salmon": "FA8072", "darkred": "8B0000", "steelblue": "4682B4", "palevioletred": "DB7093", "lightslategray": "778899", "aliceblue": "F0F8FF", "lightslategrey": "778899", "lightgreen": "90EE90", "orchid": "DA70D6", "gainsboro": "DCDCDC", "mediumseagreen": "3CB371", "lightgray": "D3D3D3", "mediumturquoise": "48D1CC", "lemonchiffon": "FFFACD", "cadetblue": "5F9EA0", "lightyellow": "FFFFE0", "lavenderblush": "FFF0F5", "coral": "FF7F50", "purple": "800080", "aqua": "00FFFF", "whitesmoke": "F5F5F5", "mediumslateblue": "7B68EE", "darkorange": "FF8C00", "mediumaquamarine": "66CDAA", "darksalmon": "E9967A", "beige": "F5F5DC", "blueviolet": "8A2BE2", "azure": "F0FFFF", "lightsteelblue": "B0C4DE", "oldlace": "FDF5E6", "rebeccapurple": "663399"
	];

	variables.excelColors = ["E48701", "A5BC4E", "1B95D9", "CACA9E", "6693B0", "F05E27", "86D1E4", "E4F9A0", "FFD512", "75B000", "0662B0", "EDE8C6", "CC3300", "D1DFE7", "52D4CA", "C5E05D", "E7C174", "FFF797", "C5F68F", "BDF1E6", "9E987D", "EB988D", "91C9E5", "93DC4A", "FFB900", "9EBBCD", "009797", "0DB2C2"];

	variables.boldColors = [
		"FF6384" // red
		,"FF9F40" // orange
		,"FFCD56" // yellow
		,"4BC0C0" // green
		,"36A2EB" // blue
		,"9966FF" // purple
		,"C9CBCF" // grey
		,"008080" // teal
		,"A52A2A" // brown
	];

	variables.baseHexColors = variables.colorBrewerPalette["Set1"];


	public colorTools function init(any baseHexColors="", string textCase="ucase"){
		// use colorBrewerPalette if string matches
		if (issimplevalue(arguments.baseHexColors) && len(arguments.baseHexColors) && structkeyexists(variables.colorBrewerPalette, arguments.baseHexColors)){
			setVariable("baseHexColors", variables.colorBrewerPalette[arguments.baseHexColors]);
		// use array if explicitly passed
		} else if (isarray(arguments.baseHexColors)){
			setVariable("baseHexColors", arguments.baseHexColors);
		} else if (issimplevalue(arguments.baseHexColors) && arguments.baseHexColors eq "excel"){
			setVariable("baseHexColors", variables.excelColors);
		}
		// set HEX case (defaults to uppercase)
		if (listfind("ucase,lcase,upper,lower", lcase(arguments.textCase))){
			setCase(arguments.textCase);
		}
		return this;
	}

	public void function setBaseHexColors(array colors=[]){
		setVariable("baseHexColors", arguments.colors);
	}
	public void function setCase(string textCase="ucase"){
		if (listfind("upper,ucase", lcase(arguments.textCase))){
			setVariable("textCase", "ucase");
		} else if (listfind("lower,lcase", lcase(arguments.textCase))){
			setVariable("textCase", "lcase");
		}
	}

	public any function getVariable(string varName="") output=false hint="I return a raw internal variable" {
		try {
			return variables[arguments.varName];
		} catch (any error){
			throw(message=error);
		}
	}
	public void function setVariable(string varName="", any varValue="") output=false hint="I set a raw internal variable" {
		if (!variables.keyexists(arguments.varName)){
			throw(message="colorToolsCFC-setVariable: Variable '#arguments.varName#' does not exist.");
		}
		variables[arguments.varName] = arguments.varValue;
	}

	// helper functions

	public array function makeWCAGChartColors(numeric quantity=1, boolean makeUnique=true, array usedHexColors=[], string fallbackHexColor="333333", numeric minContrast=0, numeric maxLuminance=0, returnAs="hex") hint="I return an array of colors" {
		if (arguments.quantity lte 0){
			return [];
		}
		local.colors = [];
		local.params = duplicate(arguments);
		structdelete(local.params, "quantity");
		for (local.i=1; local.i lte arguments.quantity; local.i+=1){
			arrayappend(local.colors, makeWCAGChartColor(argumentcollection=local.params));
		}
		return local.colors;
	}

	public struct function hexToRGBasStruct(required string hexColor) hint="Converts a 6-character HEX color code to struct with r, g, b keys" {
		return hexToRGB(hexColor=arguments.hexColor, returnAs="struct");
	}

	public array function hexToRGBasArray(required string hexColor) hint="Converts a 6-character HEX color code to [r, g, b] array" {
		return hexToRGB(hexColor=arguments.hexColor, returnAs="array");
	}

	public string function hexToRGBasString(required string hexColor) hint="Converts a 6-character HEX color code to 'r,g,b' string" {
		return hexToRGB(hexColor=arguments.hexColor, returnAs="string");
	}

	// core functions

	public any function makeWCAGChartColor(boolean makeUnique=true, array usedHexColors=[], string fallbackHexColor="333333", numeric minContrast=0, numeric maxLuminance=0, returnAs="hex") hint="I generate a random WCAG HEX color" {
		// returnAs: hex, rgb (rgb-array, rgb-struct, rgb-string)
		if (arguments.makeUnique && !request.keyexists("colorToolsCFC_usedHexColors")){
			request.colorToolsCFC_usedHexColors = [];
		}
		local.usedHexColors = (arraylen(arguments.usedHexColors)) ? arguments.usedHexColors : (arguments.makeUnique) ? request.colorToolsCFC_usedHexColors : [];
		local.lastColor = (arraylen(local.usedHexColors)) ? local.usedHexColors[arraylen(local.usedHexColors)] : "";
		local.maxAttempts = 100;
		local.color = "";
		local.contrastRatio = 0;
		local.luminance = 0;
		local.minContrast = (val(arguments.minContrast) gt 0) ? val(arguments.minContrast) : 4.5; // WCAG Level AA contrast minimum
		local.maxLuminance = (val(arguments.maxLuminance) gt 0) ? val(arguments.maxLuminance) : 0.7; // reject colors brighter than this (0-1 scale)

		local.attempt = 0;
		do {
			local.attempt += 1;
			local.r = tostring(right("0" & formatbasen(randrange(0, 255, "SHA1PRNG"), 16),2));
			local.g = tostring(right("0" & formatbasen(randrange(0, 255, "SHA1PRNG"), 16),2));
			local.b = tostring(right("0" & formatbasen(randrange(0, 255, "SHA1PRNG"), 16),2));

			local.color = doCase(r & g & b);

			local.luminance = calculateLuminance(inputbasen(local.r, 16), inputbasen(local.g, 16), inputbasen(local.b, 16));

			local.contrastRatio = local.minContrast + 1; // First color always passes
			if (len(local.lastColor)) {
				local.contrastRatio = calculateContrast(local.lastColor, local.color);
			}

		} while ((arrayfindnocase(local.usedHexColors, local.color) || local.contrastRatio lt local.minContrast || local.luminance gt local.maxLuminance) && local.attempt lt local.maxAttempts);

		if (local.luminance gt local.maxLuminance && local.attempt gte local.maxAttempts) {
			local.color = doCase(arguments.fallbackHexColor);
		}

		if (arguments.makeUnique){
			arrayappend(request.colorToolsCFC_usedHexColors, local.color);
		}
		if (left(arguments.returnAs,3) eq "rgb"){
			if (findnocase("array", arguments.returnAs)){
				return hexToRGBAsArray(local.color);
			} else if (findnocase("struct", arguments.returnAs)){
				return hexToRGBasStruct(local.color);
			} else {
				return hexToRGBasString(local.color);
			}
		}
		return local.color;
	}

	public numeric function calculateContrast(required string color1, required string color2) hint="Calculates contrast ratio between two hex colors" {
		// Calculate relative luminance for each color
		local.lum1 = calculateLuminance(color=arguments.color1);
		local.lum2 = calculateLuminance(color=arguments.color2);

		// Return contrast ratio (lighter/darker + 0.05)
		if (local.lum1 gt local.lum2){
			return (local.lum1 + 0.05) / (local.lum2 + 0.05);
		}
		return (local.lum2 + 0.05) / (local.lum1 + 0.05);
	}

	public numeric function calculateLuminance(numeric r=-1, numeric g=-1, numeric b=-1, string color="") hint="Calculates relative luminance" {
		// get RGB color triplets
		local.triplet = [val(arguments.r), val(arguments.g), val(arguments.b)];
		local.cleanHex = doCase(trim(arguments.color).replaceAll("##", ""));
		if (len(local.cleanHex)){
			local.triplet = (listlen(local.cleanHex) eq 3) ? listtoarray(local.cleanHex) : hexToRGB(local.cleanHex, "array");
		}
		// validate RGB color triplets
		if (local.triplet[1] lt 0 || local.triplet[1] gt 255 || local.triplet[2] lt 0 || local.triplet[2] gt 255 || local.triplet[3] lt 0 || local.triplet[3] gt 255) {
			throw(message="colorTools-calculateLuminance: RGB values must be between 0 and 255");
		}

		// Normalize to 0-1 and apply sRGB gamma correction
		local.rNorm = val(local.triplet[1]) / 255;
		local.gNorm = val(local.triplet[2]) / 255;
		local.bNorm = val(local.triplet[3]) / 255;

		local.rNorm = (local.rNorm lte 0.03928) ? local.rNorm / 12.92 : ((local.rNorm + 0.055) / 1.055) ^ 2.4;
		local.gNorm = (local.gNorm lte 0.03928) ? local.gNorm / 12.92 : ((local.gNorm + 0.055) / 1.055) ^ 2.4;
		local.bNorm = (local.bNorm lte 0.03928) ? local.bNorm / 12.92 : ((local.bNorm + 0.055) / 1.055) ^ 2.4;

		// Calculate luminance using standard coefficients
		return (0.2126 * local.rNorm) + (0.7152 * local.gNorm) + (0.0722 * local.bNorm);
	}

	public any function hexToRGB(required string hexColor, returnAs="struct") hint="Converts a 6-character HEX color code to RGB values" {
		local.cleanHex = doCase(trim(arguments.hexColor).replaceAll("##", ""));
		// validate 6-character hex
		if (len(local.cleanHex) neq 6 || !isvalid("regex", local.cleanHex, "^[0-9A-Fa-f]{6}$")) {
			throw(message="colorTools-hexToRGB: Invalid HEX color code '#encodeforhtml(local.cleanHex)#'. Please provide a 6-character hexadecimal value (e.g., 'FF0000')");
		}
		// extract RGB components and convert from hex to decimal
		local.colors = [
			"r": javacast("int", inputbasen(mid(cleanHex, 1, 2), 16))
			,"g": javacast("int", inputBaseN(mid(cleanHex, 3, 2), 16))
			,"b": javacast("int", inputBaseN(mid(cleanHex, 5, 2), 16))
		];
		if (arguments.returnAs eq "string"){
			return local.colors.r & "," & local.colors.g & "," & local.colors.b;
		} else if (arguments.returnAs eq "array"){
			return [local.colors.r, local.colors.g, local.colors.b];
		}
		return local.colors;
	}

	public string function rgbToHex(required numeric r, required numeric g, required numeric b) hint="Converts RGB values to a 6-character HEX color code" {
		// validate input ranges
		if (arguments.r lt 0 || arguments.r gt 255 || arguments.g lt 0 || arguments.g gt 255 || arguments.b lt 0 || arguments.b gt 255) {
			throw(message="colorTools-rgbToHex: RGB values must be between 0 and 255");
		}
		// convert to hex and ensure 2 digits per component
		local.hexR = right("0" & formatbasen(javacast("int", arguments.r), 16), 2);
		local.hexG = right("0" & formatbasen(javacast("int", arguments.g), 16), 2);
		local.hexB = right("0" & formatbasen(javacast("int", arguments.b), 16), 2);

		return doCase(local.hexR & local.hexG & local.hexB);
	}

	// utility UDFs

	// based on HeatColor jQuery  plugin http://www.jnathanson.com/blog/client/jquery/heatcolor/index.cfm
	// arguments: num, minval, maxval, colorStyle, lightness, reverseOrder
	// colorStyle accepts: "greentored", "rgb", array of colors, or color Brewer palatte key string
	public string function heatColor(numeric num, numeric minVal=1, numeric maxVal=100, any colorStyle="greentored", numeric lightness=0, boolean reverseOrder=false, boolean includePoundSymbol=true, returnAs="hex") output=true hint="Generates heat colors based on min, max & current values" {
		local.pound = (arguments.includePoundSymbol) ? "##" : "";
		// use array or an color brewer palatte key
		if (isarray(arguments.colorStyle) || structkeyexists(variables.colorBrewerPalette, arguments.colorStyle)){
			local.colors = (isarray(arguments.colorStyle)) ? arguments.colorStyle : variables.colorBrewerPalette[arguments.colorStyle];
			if (arguments.reverseOrder){
				local.colors = arrayReverseJava(local.colors);
			}
			local.clampedNumber = max(arguments.minVal, min(arguments.maxVal, arguments.num));
			// Calculate percentage (0 to 1)
			local.percentage = (local.clampedNumber - arguments.minVal) / (arguments.maxVal - arguments.minVal);
			// Calculate position in array (0-based index)
			local.arraySize = arraylen(local.colors);
			local.position = round(local.percentage * (local.arraySize - 1)) + 1;
			// Ensure position stays within array bounds
			local.position = max(0, min(local.arraySize, local.position));
			return (arguments.returnAs eq "rgb") ? hexToRGB(hexColor=local.colors[local.position], returnAs="string") : local.colors[local.position];
		}

		local.mn = arguments.reverseOrder ? arguments.maxVal : arguments.minVal;
		local.mx = arguments.reverseOrder ? arguments.minVal : arguments.maxVal;
		local.curval = arguments.num;

		// Calculate position (0 to 1) within range
		local.position = (local.curval - local.mn) / (local.mx - local.mn);

		// Calculate shift based on roygbiv style
		local.shft = (arguments.colorStyle eq "roygbiv") ? 0.5 * local.position + 1.7 * (1 - local.position) : local.position + 0.2 + 5.5 * (1 - local.position);

		// Scale for RGB values (0-255)
		local.scale = 128;
		local.period = 2 * pi();
		local.x = local.shft + local.position * local.period;
		if (arguments.colorStyle neq "roygbiv") {
			local.x = -local.x;
		}

		// Calculate RGB values using cosine waves
		local.r = (cos(local.x) + 1) * local.scale;
		local.r = floor(local.r + arguments.lightness * (256 - local.r));
		local.r = ucase(formatbasen(max(0, min(255, local.r)), 16)).replaceAll("^(.)$", "0$1");

		local.g = (cos(local.x + PI()/2) + 1) * local.scale;
		local.g = floor(local.g + arguments.lightness * (256 - local.g));
		local.g = ucase(formatbasen(max(0, min(255, local.g)), 16)).replaceAll("^(.)$", "0$1");

		local.b = (cos(local.x + PI()) + 1) * local.scale;
		local.b = floor(local.b + arguments.lightness * (256 - local.b));
		local.b = ucase(formatbasen(max(0, min(255, local.b)), 16)).replaceAll("^(.)$", "0$1");

		return (arguments.returnAs eq "rgb") ? hexToRGB(hexColor=local.r & local.g & local.b, returnAs="string") : local.pound & local.r & local.g & local.b;
	}

	private string function doCase(string textValue=""){
		return (variables.textCase eq "lcase") ? ucase(arguments.textValue) : lcase(arguments.textValue);
	}

	/*	1/7/2010 http://www.cflib.org/udf/ArrayReverse
	Reverses the order of elements in a one-dimensional array.
	@param InArray      One-dimensional array to be reversed.
	@return Returna a new one dimensional array.
	@author Raymond Simmons (raymond@terraincognita.com)
	@version 1.0, October 9, 2001  */
	array function arrayReverseJava(array inArray=[]) output=false hint="Reverses the order of elements in a one-dimensional array." {
		local.javaCollections = createobject("java", "java.util.Collections");
		local.outArray = duplicate(arguments.inArray);
		local.javaCollections.reverse(local.outArray);
		return local.outArray;
	}

}
