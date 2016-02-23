<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<div class="UI Block">
<p>
    <label class="UI Icon Info" style="font-style:italic;">Here you can find basic statistics about shortcuts. These are interesting statuses of a shortcut:</label>
</p>
    <table>
        <tr><td><label class="UI Label Inline"><span style="color:red">UNRESOLVED&nbsp;&nbsp;</span></label></td><td><label class="UI Label Inline">there is no full path for the shortcut on the repository and the shortcut should be resolved</label></td></tr>
        <tr><td><label class="UI Label Inline"><span style="color:blue">APPROVED&nbsp;&nbsp;</span></label></td><td><label class="UI Label Inline">there is no full path for the shortcut however this has been approved as a correct status</label></td></tr>
        <tr><td><label class="UI Label Inline"><span style="color:green">CALCULATED&nbsp;&nbsp;</span></label></td><td><label class="UI Label Inline">the shortcut has been calculated because there is a full path in the repository</label></td></tr>
    </table>
<br/>
<br/>
<syswf:component name="/admin/shortcut/browseStatistic" prefix="browserStatistic" wrap="false"/>
</div>