<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<fmt:setBundle basename="com.hp.systinet.sc.ui.util.uimessages" var="uiMessages"/>

<fmt:message key="FACETS_SELECT_ALL" bundle="${uiMessages}" var="labelSelectAll"/>
<fmt:message key="FACETS_CLEAR" bundle="${uiMessages}" var="labelClear"/>

         <syswf:control id="${prefix}2" mode="script" action="refreshFacet" caption="reloadFacet${prefix}" onSubmit="${tableId}ShowLoading"/>

         <span>
         <c:forEach items="${data.categories}" var="category" varStatus="status">
             <c:choose>
                 <c:when test="${data.checkboxes}">
                     <syswf:selectOne id="${prefix}a${status.index}" name="${status.index}" displayAsRow="true"
                                          value="${category}" property="checked" mode="checkbox" optionValues="true"
                                          optionCaptions=" " dataType="boolean">
                        <syswf:attribute name="class" value="UI Form Checkbox Inline"/>
                     </syswf:selectOne>
                 </c:when>
                 <c:otherwise>
                     <syswf:selectOne id="${prefix}a${status.index}" name="selection" displayAsRow="true"
                                          value="${data}" property="selectedValue" mode="radio" optionValues="${status.index} "
                                          optionCaptions=" ">
                        <syswf:attribute name="class" value="UI Form Radio Inline"/>
                     </syswf:selectOne>
                 </c:otherwise>
             </c:choose>
             <c:if test="${data.checkboxes}"></c:if>
               <label for="${prefix}a${status.index}_0" class="UI Label Inline">
                <c:choose>
                    <c:when test="${category.system}"><i>${category.name}</i></c:when>
                    <c:otherwise>${category.name}</c:otherwise>
                </c:choose>
               </label>
         </c:forEach>
         </span>
        <c:if test="${data.checkboxes}">
            (<syswf:control id="${prefix}0" mode="postanchor" action="selectAll" caption="${labelSelectAll}" onSubmit="${tableId}ShowLoading"/> |
               <syswf:control id="${prefix}1" mode="postanchor" action="clear" caption="${labelClear}" onSubmit="${tableId}ShowLoading"/>)

        </c:if>
<script type="text/javascript">
//<![CDATA[


    Ext.onReady(function() {
     <c:forEach items="${data.categories}" var="category" varStatus="status">
          Ext.get("${prefix}a${status.index}_0").on("click", reloadFacet${prefix});
     </c:forEach>
    });

//]]>
</script>

  