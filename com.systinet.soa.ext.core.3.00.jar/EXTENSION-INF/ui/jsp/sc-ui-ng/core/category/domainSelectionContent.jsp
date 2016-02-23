<%--
  ~ (C) Copyright 2003-2011 Hewlett-Packard Development Company, L.P.
  --%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<%--@elvariable id="matchingStatus" type="int"--%>
<%--@elvariable id="uuid" type="java.lang.String"--%>
<%--@elvariable id="mergeDuplicatesBean" type="com.hp.systinet.integration.ucmdbImport.MergeDuplicates.MergeDuplicatesBean"--%>
<%--@elvariable id="selectedDomainsBean" type="com.hp.systinet.sc.ui.category.DomainBagComponent.SelectedDomainsBean"--%>
<%--@elvariable id="prefix" type="java.lang.String"--%>

<fmt:setBundle basename="com.hp.systinet.sc.ui.impl.edit.EditMessages" var="editMessages"/>
<fmt:message key="mergeDuplicatesContent_detail" bundle="${editMessages}" var="detailLabel"/>
<fmt:message key="mergeDuplicatesContent_comparison" bundle="${editMessages}" var="comparisonLabel"/>


<syswf:selectMany name="selectedDomains" mode="checkbox" optionValues="${selectedDomainsBean.options}" optionValuesProperty="key"
              optionCaptions="${selectedDomainsBean.options}" id="box" optionCaptionsProperty="value" property="checked"
               value="${selectedDomainsBean}" >
    <syswf:attribute name="class" value="UI Form Checkbox Inline" />
</syswf:selectMany>

<script type="text/javascript">
//<![CDATA[


function updateCheckboxes(e) {
    var target;
    var e = e;
    if (e == undefined) {
        e = window.event;
        target = e.srcElement;
    } else {
        target = e.target;
    }

    var topDomain = target.id == "box_0";
    var reset = (target.id == "box_0"  && target.checked);
    var resetTop = (target.id != "box_0"  && !target.checked);
    if(topDomain) {
        for(var i = 1; i < ${fn:length(selectedDomainsBean.allDomains)}; i++ ) {
           document.getElementById('box_' + i).checked = reset;
        }
    }
    if(resetTop) {
        document.getElementById('box_0').checked = false;
    }
}



<c:forEach var="value" items="${selectedDomainsBean.allDomains}" varStatus="status">
   document.getElementById("box_${status.index}").onclick=updateCheckboxes;
</c:forEach>


//]]>
</script>

