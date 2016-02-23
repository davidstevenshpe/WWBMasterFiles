<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<div class="UI Block">
<p>
    <label class="UI Icon Info" style="font-style:italic">When you definde a shortcut, the system calculates all the shortcuts based on the data in the repository. Here you can analyze performance of these calculations</label>
</p>
    <table>
        <tr><td><label class="UI Label Inline">)*&nbsp;&nbsp;</label></td><td><label class="UI Label Inline">Shows calculation time for a single source artifact</label></td></tr>
        <tr><td><label class="UI Label Inline">)**&nbsp;&nbsp;</label></td><td><label class="UI Label Inline">Shows time needed for recalculation of all shortcuts of the given type</label></td></tr>
    </table>
<br/>
<br/>
<syswf:component name="/admin/shortcut/browsePerformance" prefix="browsePerformance" wrap="false"/>
</div>