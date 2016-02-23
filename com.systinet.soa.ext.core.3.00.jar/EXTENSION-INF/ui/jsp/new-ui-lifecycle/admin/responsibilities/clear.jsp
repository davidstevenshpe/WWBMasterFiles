<%-- (C) Copyright 2003-2011 Hewlett-Packard Development Company, L.P. --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<div class="UI OffsetLeft">
    <syswf:selectMany name="check" mode="checkbox" optionValues="${clearBean.options}" optionValuesProperty="key"
                      optionCaptions="${clearBean.options}" optionCaptionsProperty="value" property="checked"
                      optionClasses="${responsibilitiesBean.styleClassesForResponsibilities}" value="${clearBean}" size="1">
            <syswf:attribute name="class" value="UI Checkbox Inline" />
    </syswf:selectMany>
</div>
