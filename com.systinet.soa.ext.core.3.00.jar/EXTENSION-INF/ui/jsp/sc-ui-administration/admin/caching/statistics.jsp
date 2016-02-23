<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<div class="Title">
    <h3>
        <span>Caching Statistics </span> <span style="font-size:9px">(<syswf:control id="as1" hint="Clean the cache" caption="Reset..." mode="anchor" action="reset" />)</span>
    </h3>
</div>
<h1></h1>


<br/>

<div style="font-size:12px">


<table class="UI Table Properties">


  <tr>
    <th title="Number of different evaluations (for differnt users or input parameters)">Entries:</th>
    <td>${this.cacheStatistics.entries}</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <th title="Ammount of memory/resources consumed by the cache of this datasource">Size Total (all entries):</th>
    <td>${this.cacheStatistics.sizeTotal/1000.0}kb</td>
    <td></td>
    <td></td>
  </tr>
</table>

<br/>
<br/>

<table class="UI Table Properties">

  <tr>
    <th></th>
    <td>Minimum</td>
    <td>Average</td>
    <td>Maximum</td>
  </tr>

  <tr>
    <th>Time to calculate:</th>
    <td>${this.cacheStatistics.timeToCalculateMin/1000.0}s</td>
    <td>${this.cacheStatistics.timeToCalculateAvg/1000.0}s</td>
    <td>${this.cacheStatistics.timeToCalculateMax/1000.0}s</td>
  </tr>
  <tr>
    <th>Result Size (per entry):</th>
    <td>${this.cacheStatistics.minEntrySize/1000.0}kb</td>
    <td>${this.cacheStatistics.avgEntrySize/1000.0}kb</td>
    <td>${this.cacheStatistics.maxEntrySize/1000.0}kb</td>
  </tr>

</table>

</div>
