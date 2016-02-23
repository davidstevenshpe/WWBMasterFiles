<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:if test="${(not empty facets) && (not empty facets.facets)}">
   <hr/>
   <table class="UI Table Properties">
      <col class="LabelCol"/>
      <col/>
      <c:forEach items="${facets.facets}" var="facet" varStatus="status">
      <tr>        
        <th>
            <c:choose>
                <c:when test="${not empty facet.label}">                                
                    <label class="UI Label">${facet.label}:</label>
                </c:when>                                            
                <c:otherwise>
                    <%-- A default fallback as the label is optional. --%>
                    <label class="UI Label">${facet.id}:</label>
                </c:otherwise>
            </c:choose>            
        </th>
        <td>
         <c:choose>
            <c:when test="${facet.type eq 'category' or empty facet.type}">
               <syswf:component name="/core/impl/table/categoryFacet" prefix="fc${status.index}" ajax="true">
                  <syswf:param name="facet" value="${facet}"/>
                  <syswf:param name="datasource" value="${datasource}"/>
               </syswf:component>
            </c:when>
         </c:choose>
        </td>
      </tr>
      </c:forEach>
   </table>
   <hr/>
</c:if>
