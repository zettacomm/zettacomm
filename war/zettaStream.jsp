<!-- will be the new stream handler -->
<%! 
public static int countOccurrences(String haystack, char needle) {
    int count = 0;
    for (int i=0; i < haystack.length(); i++)
    {
        if (haystack.charAt(i) == needle)
        {
             count++;
        }
    }
    return count;
}
%>
<%! 
public String[] pathToArray(String path) {				//break  path in the form of /streamname/sizeX/sizeY down into array	
	String myPath = path;
	String[] retval = new String[0];
	if (myPath != null && myPath.length() > 1) { //jetty passes null instead of "" grrrrrrrr
		if (myPath.charAt(0) == '/') { myPath = myPath.substring(1); } //del leading /'s
		if (myPath.length() > 0 && myPath.charAt(myPath.length() - 1) == '/') {myPath = myPath.substring(0, myPath.length() - 1);} //del trailing /'s
		if (countOccurrences(myPath,'/') > 0) {
			retval = myPath.split("/");
		}
		else {
			retval = new String[1];
			retval[0] = myPath;
		}
	}
	return retval;
}
%>
<!-- path: <%= request.getPathInfo() %> -->
<%
	String[] mystr;
	String path = request.getPathInfo();
	mystr=pathToArray(path);
	String playerWidth="480";	//sane defaults
	String playerHeight="500";
	String channelName=""; // 	//don't be too clever with defaults. that's handled in zettaMain
	if (mystr.length >= 1) { channelName = mystr[0]; }
	if (mystr.length >= 2) { playerWidth = mystr[1]; }
	if (mystr.length >= 3) { playerHeight = mystr[2]; }
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="en" xml:lang="en">
<head><meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" /></head>
<body style="background: #000;">
<!-- <script type="text/javascript" src="http://static.livestream.com/scripts/playerv2.js?channel=<%= channelName %>&layout=playerEmbedDefault&backgroundColor=0x000000&backgroundAlpha=1&backgroundGradientStrength=0&chromeColor=0x000000&headerBarGlossEnabled=true&controlBarGlossEnabled=true&chatInputGlossEnabled=false&uiWhite=true&uiAlpha=0.5&uiSelectedAlpha=1&dropShadowEnabled=true&dropShadowHorizontalDistance=0&dropShadowVerticalDistance=0&paddingLeft=0&paddingRight=0&paddingTop=0&paddingBottom=0&cornerRadius=0&backToDirectoryURL=null&bannerURL=null&bannerText=null&bannerWidth=0&bannerHeight=0&showViewers=true&embedEnabled=true&chatEnabled=false&onDemandEnabled=true&programGuideEnabled=false&fullScreenEnabled=true&reportAbuseEnabled=false&gridEnabled=false&initialIsOn=true&initialIsMute=false&initialVolume=10&contentId=null&initThumbUrl=null&playeraspectwidth=4&playeraspectheight=3&mogulusLogoEnabled=true&width=<%= playerWidth %>&height=<%= playerHeight %>&wmode=window"></script> -->
<div>
<script type="text/javascript" src="http://static.livestream.com/scripts/playerv2.js?channel=<%= channelName %>&layout=playerEmbedDefault&backgroundColor=0x000000&backgroundAlpha=1&backgroundGradientStrength=0&chromeColor=0x000000&headerBarGlossEnabled=true&controlBarGlossEnabled=true&chatInputGlossEnabled=false&uiWhite=true&uiAlpha=0.5&uiSelectedAlpha=1&dropShadowEnabled=true&dropShadowHorizontalDistance=0&dropShadowVerticalDistance=0&paddingLeft=0&paddingRight=0&paddingTop=0&paddingBottom=0&cornerRadius=0&backToDirectoryURL=null&bannerURL=null&bannerText=null&bannerWidth=0&bannerHeight=0&showViewers=true&embedEnabled=true&chatEnabled=false&onDemandEnabled=true&programGuideEnabled=false&fullScreenEnabled=true&reportAbuseEnabled=false&gridEnabled=false&initialIsOn=true&initialIsMute=false&initialVolume=10&contentId=null&initThumbUrl=null&mogulusLogoEnabled=true&width=<%= playerWidth %>&height=<%= playerHeight %>&wmode=window"></script>
</div>
</body>
</html>

