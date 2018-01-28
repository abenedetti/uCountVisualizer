<style>
p1{
 font-size:20px;
 text-align:justify;
}

p2{
 font-size:16px;
 text-align:justify;
}
</style>

<br>
<p id="top" style=" text-align:center;"><a href="#userguide">User guide</a>&nbsp;&nbsp;-&nbsp;&nbsp;<a href="#history">A little bit of history</a>&nbsp;&nbsp;-&nbsp;&nbsp;<a href="#reports">Yearly reports</a>&nbsp;&nbsp;-&nbsp;&nbsp;<a href="#versions">Versions</a>&nbsp;&nbsp;-&nbsp;&nbsp;<a href="#support">Support</a></p>
<br><br>

<hr><p1 id="userguide"><b>User guide</b></p1><hr>

<p><i>Home section</i></p>
<p2>This is the welcome page of the application. It contain a bunch of information and insights concerning the app.</p2>

<br>

<p><i>Data section</i></p>
<p2>This is the *substrate* of the app: the data with which the charts are made is loaded and represented in a tabular form in this tab. The fields of the table are those collected by <a href="https://docs.google.com/spreadsheets/d/1zlB1XxdITwGejHKXyL_yd8XCxkoCVh5RatQeaH2CJ4Q/edit?usp=sharing" target="_blank">uCount</a>.
The table can be filtered by using the provided control that can be reset with the appropriate button. In addition an aggregation summary of the variation fields and a download button that creates a csv report are available.
The data is refreshed on each load (keep in mind that uCount retrieves data on daily basis).
</p2>

<br>
	
<p><i>Charts section</i></p>
<p2>In this section the data is displayed through 6 charts, organized in three categories:
<br>
<ul>
 <li type="square">"Visualizer charts" tab: these are the new charts created on purpose for uCount Visualizer</li>
 <li type="square">"Katung's charts" tab: these are "baptized" after Robin Khun. Robin, better known among uTesters as <a href="https://www.utest.com/profile/Katung/about" target="_blank">@Katung</a>, is a member of the uTest Community. She is a very active user and entitled as a uTest forum moderator. To thank for her interest in uCount, as well as the analysis she did, I decided to include a couple of plot she made, obviously named after their authoress. Thanks again Robin! :) [<i>On the 25th of february 2017 Robin left the community to concentrate on new projects! :( here some <a href="https://www.utest.com/status/33486" target="_blank">farewell posts</i></a>]</li> 
 <li type="square">"uCount's charts" tab: these charts have a "legacy flavor" since the plot displayed are those that were initially made on uCount</li>
</ul>
</p2>

<br>

<p><i>&nbsp;"?"&nbsp; section</i></p>
<p2>Precisely this section!</p2>

<br>
<a href="#top" style="font-size:8pt">back to the top</a>
<br>

<hr><p1 id="history"><b>A little bit of history</b></p1><hr>

<p2>I released *uCount* the 17 of March 2016 on the <a href="https://developers.google.com/apps-script" target="_blank">google scripting platform</a>. It has the objective to retrieve the number of followers associated to some particular uTest accounts.
Since those particular accounts were made for the entire uTesters community, under certain limits, they would give an estimation of the uTesters population, which was an information I was interested in.
Beside the data collection, <a href="https://docs.google.com/spreadsheets/d/1zlB1XxdITwGejHKXyL_yd8XCxkoCVh5RatQeaH2CJ4Q/edit?usp=sharing" target="_blank">uCount</a> was provided with an aggregation view and a couple of charts.<br><br>
A few months later I started to think on how to integrate additional charts and analytics, and after a quick recon I've decided to move the project under the <a href="https://www.r-project.org" target="_blank">R</a> language and <a href="https://www.shinyapps.io" target="_blank">shiny apps</a> framework which are a powerful open source combination to develop web applications.<br>
<br><a href="https://docs.google.com/spreadsheets/d/1zlB1XxdITwGejHKXyL_yd8XCxkoCVh5RatQeaH2CJ4Q/edit?usp=sharing" target="_blank">uCount</a> will continue to be available, but from now his role will essentially be as a simple data scraper. From the 2nd of january 2017, the aggregation features of uCount became obsolete and therefore were discontinued.</p2>

<br>
<a href="#top" style="font-size:8pt">back to the top</a>
<br>

<hr><p1 id="reports"><b>Yearly reports</b></p1><hr>

<p2>Late in 2016 I decided to implement yearly reports with the main points emerged during the year. In this section you can find the links to the reports.</p2>
<ul style="padding-left:5em">
 <li type="square"><a href="http://rpubs.com/abenedetti/uCountReport2016" target="_blank">Year 2016</a></li>
</ul></p2>
<ul style="padding-left:5em">
 <li type="square"><a href="http://rpubs.com/abenedetti/uCountReport2017" target="_blank">Year 2017</a></li>
</ul></p2>

<br>
<a href="#top" style="font-size:8pt">back to the top</a>
<br>

<hr><p1 id="versions"><b>Versions</b></p1><hr>

<p2>
08th of july 2016&nbsp;&nbsp;
<b>version:</b> 1.0
<ul style="padding-left:5em">
 <li type="square">initial release</li>
</ul></p2>
<br>
<p2>
24th of july 2016&nbsp;&nbsp;
<b>version:</b> 1.1
<ul style="padding-left:5em">
 <li type="square">fixed the missing tuesday on Katung's charts</li>
 <li type="square">fixed uCount Visualizer github link</li>
</ul></p2>
<br>
<p2>
03rd of september 2016&nbsp;&nbsp;
<b>version:</b> 1.2
<ul style="padding-left:5em">
 <li type="square">fixed the week count on katung's charts</li> 
</ul></p2>
<br>
<p2>
29th of december 2016&nbsp;&nbsp;
<b>version:</b> 1.3
<ul style="padding-left:5em">
 <li type="square">fixed the csv export function on the Data tab</li> 
</ul></p2>
<br>
<p2>
31th of december 2016&nbsp;&nbsp;
<b>version:</b> 1.4
<ul style="padding-left:5em">
 <li type="square">fixed the data output when year and month filters are simultaneously applied</li> 
</ul></p2>
<br>
<p2>
02nd of january 2017&nbsp;&nbsp;
<b>version:</b> 1.5
<ul style="padding-left:5em">
 <li type="square">fixed the values listed in the year comboboxes (only 2016 value was available)</li> 
 <li type="square">made dynamic the year shown in the footer</li>
 <li type="square">changed the week format parameter from %W to %U in order to start the first week of the year with the value 1 and not 0</li>
 <li type="square">changed the week calculation for Katung's charts in order to properly manage years after 2016</li>
</ul></p2>
<br>
<p2>
02nd of january 2017&nbsp;&nbsp;
<b>version:</b> 1.6
<ul style="padding-left:5em">
 <li type="square">released the 2016 yearly report (help tab updated accordingly)</li>
 <li type="square">changed the license from MIT to CC (added the icon in the footer)</li>
</ul></p2>
<br>
<p2>
18th of april 2017&nbsp;&nbsp;
<b>version:</b> 1.7
<ul style="padding-left:5em">
 <li type="square">data table is now ordered by date desc</li>
 <li type="square">fixed aggregation bug in Katung's charts</li>
</ul></p2>
<br>
<p2>
28th of may 2017&nbsp;&nbsp;
<b>version:</b> 1.8
<ul style="padding-left:5em">
 <li type="square">modified the raw data load</li>
 <li type="square">updated input parameters for <i>checkboxGroupInput</i></li>
</ul></p2>
<br>
<p2>
01st of january 2018&nbsp;&nbsp;
<b>version:</b> 1.9
<ul style="padding-left:5em">
 <li type="square">released the 2017 yearly report (help tab updated accordingly)</li> 
</ul></p2>
<br>
 [//]: # (begin fix 1.1)
 <p2>For those of you curious about coding, you may have a look at the github repositories of <a href="https://github.com/abenedetti/uCount" target="_blank">uCount</a> and <a href="https://github.com/abenedetti/uCountVisualizer/tree/master" target="_blank">uCount Visualizer</a>.</p2>
 [//]: # (end fix 1.1)

<br>
<a href="#top" style="font-size:8pt">back to the top</a>
<br>

<hr><p1 id="support"><b>Support</b></p1><hr>

<p2>Work in progress.... I did not build any help form yet, so if you need support you should drop a message directly in <a href="https://www.utest.com/profile/alessio/about" target="_blank">my uTest account [@alessio]</a>.</p2>

<br>
<a href="#top" style="font-size:8pt">back to the top</a>
<br>
