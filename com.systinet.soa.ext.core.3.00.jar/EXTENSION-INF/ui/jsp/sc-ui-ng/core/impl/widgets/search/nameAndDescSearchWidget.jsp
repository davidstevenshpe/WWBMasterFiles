<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<fmt:setBundle basename="com.hp.systinet.sc.ui.search.searchmessages" var="searchmessages"/>

<c:forEach items="${this.webConditions}" var="condition" varStatus="status">
    <c:set var="inputId" value="${prefix}nameDescSearchWgt${status.index}"/>
    
    <syswf:control id="${prefix}remove${status.index}" mode="script" caption="${prefix}remove${status.index}" action="onRemove" affects=".">
        <syswf:param name="condition" value="${condition}" />
    </syswf:control>  

    <c:set var="content">
        <syswf:input id="${inputId}" name="${inputId}" value="${condition}" property="value">
             <syswf:attribute name="class">x-form-text x-form-field SearchBox Full Filter</syswf:attribute>
            <br />
        </syswf:input>
    </c:set>
    
    <syswf:component name="/core/impl/widget/search/widgetWrapper" prefix="${inputId}Wrapped">
            <syswf:param name="content" value="${content}"/>
            <syswf:param name="webCondition" value="${webCondition}"/>
            <syswf:param name="inputId" value="${inputId}"/>
            <syswf:param name="visible" value="${visible}"/>
            <syswf:param name="status" value="${status}"/>
            <syswf:param name="firstRemovable" value="${this.model.firstRemovable}" />
            <syswf:param name="removeFce" value="${prefix}remove${status.index}"/>
        </syswf:component>
    
    <script type="text/javascript">
//<![CDATA[

        Ext.onReady(function() {
            if(Ext.get('${inputId}')) {
                var search = new Ext.form.TextField({
                    id: '${inputId}',
                    emptyText: '${this.searchForLabel}',
                    applyTo: '${inputId}',
                    stateful: false
                });
<%-- react upon ENTER key when pressed in the input field --%>
                search.on('specialkey', function(input, e) {
                    if (e.getKey() === e.ENTER) {
                        // execute search
                        <c:set var="splitPrefix" value="${fn:split(prefix,'_')}" />
                        ${fn:substring(prefix,0,fn:length(prefix)-fn:length(splitPrefix[fn:length(splitPrefix)-1])-1)}ExecuteSearch();
                        e.stopEvent();
                        return false;
                    }
                });
            };
        });
    
//]]>
</script>
</c:forEach>