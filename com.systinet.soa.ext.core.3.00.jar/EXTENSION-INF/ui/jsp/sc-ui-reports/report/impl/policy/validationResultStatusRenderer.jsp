<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%--@elvariable id="bean" type="com.hp.systinet.report.ui.impl.policy.ValidationResultStatusRenderer.ValidationResultStatusRendererBean"--%>

<span class="${bean.style}"><c:out escapeXml="true" value="${bean.label}"/></span>
