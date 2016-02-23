<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<c:set var="children" scope="request">
[ <c:forEach var="childLoop" items="${node.children}" varStatus="childStatus">
      <syswf:component name="/core/impl/tree/table/renderJsonNode" prefix="b${childStatus.index}" wrap="false">
        <syswf:param name="table" value="${table}"/>
        <syswf:param name="node" value="${childLoop}"/>
        <syswf:param name="child" value="${true}"/>
      </syswf:component>
      <c:if test="${not childStatus.last}">,</c:if>
   </c:forEach> ]
</c:set>

<c:choose>
  <c:when test="${child}">
   {
   <c:if test="${not empty table.rowId.queryColumn}">
     id : '<c:out value="${node.attributes[table.rowId.queryColumn]}"/>',
   </c:if>
   uiProvider:'col',
   <c:forEach var="columnDescriptor" items="${table.columns}" varStatus="s">
      <c:set target="${encoder}" property="encoded">
      <c:forEach items="${columnDescriptor.contents}" var="c" varStatus="contentStatus">
      <c:choose>
         <c:when test="${not empty c.componentName}">
            <syswf:component name="${c.componentName}" prefix="a${childStatus.index}_${contentStatus.index}">
               <c:if test="${not empty c.queryColumn}">
                  <syswf:param name="queryColumn" value="${node.attributes[c.queryColumn]}"/>
               </c:if>
               <c:forEach var="p" items="${c.contentParameters}">
                  <c:choose>
                     <c:when test="${not empty p.queryColumn}">
                        <syswf:param name="${p.name}" value="${node.attributes[p.queryColumn]}"/>
                     </c:when>
                     <c:otherwise>
                        <syswf:param name="${p.name}" value="${p.value}"/>
                     </c:otherwise>
                  </c:choose>
               </c:forEach>
            </syswf:component>
         </c:when>
         <c:otherwise>
            <c:out value="${node.attributes[c.queryColumn]}" escapeXml="false"/>
         </c:otherwise>
      </c:choose>
      </c:forEach></c:set>
      <c:out escapeXml="false" value="${columnDescriptor.id}:'${encoder.encoded}'"/>,
   </c:forEach>
   <c:choose>
      <c:when test="${not empty node.children}">
      children: <c:out value="${children}" escapeXml="false"/>
      </c:when>
      <c:otherwise>
      leaf : true
      </c:otherwise>
   </c:choose>
   }
  </c:when>
  <c:otherwise>
     <c:out value="${children}" escapeXml="false"/>
  </c:otherwise>
</c:choose>
