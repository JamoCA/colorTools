# colorTools
CFML function for color generation and manipulation

NOTE: This CFC is still in the early stages of development. More functions and better documentation will be coming in the future.

## Usage

```cfscript
colorTools = new colorTools();
```

## makeWCAGChartColor(*makeUnique*, *usedHexColors*, *fallbackHexColor*, *minContrast*, *maxLuminance*, *returnAs*)

Returns a random WCAG HEX color with minimum contrast and maximum luminance filters with option to make unique and ensure that next color isn't too similiar to previously generated color. 

```cfscript
for (i = 1; i lte 25; i += 1) {
	color = colorTools.makeWCAGChartColor();
	writeoutput('<div style="display:inline-block; width:100px; height:50px; background-color:##' & color & '; border:1px solid ##000; margin:5px; text-align:center; line-height:50px; font-family:Arial, sans-serif; font-size:14px; color:##fff; text-shadow:0 0 2px ##000;">' & color & '</div>');
}
```

## calculateContast(color1, color2) 

Description & example coming soon.

## calculateLuminance(*r*, *g*, *b*, *color*)

Description & example coming soon.

## hexToRGB(hexColor, *returnAs*)

Description & example coming soon.

## rgbToHex(r, g, b)

Description & example coming soon.
