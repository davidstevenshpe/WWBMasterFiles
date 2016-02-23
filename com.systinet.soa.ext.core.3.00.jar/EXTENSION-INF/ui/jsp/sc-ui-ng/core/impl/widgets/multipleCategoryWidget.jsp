<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<c:if test="${mode eq 'edit'}">
  <syswf:selectMany 
            id="${prefix}multipleCategoryWidget" name="multipleCategoryWidget" mode="checkbox" 
            value="${this}" property="multiValues" 
            optionValues="${this.values}" optionCaptions="${this.captions}" size="1"
  >
     <syswf:attribute name="class" value="UI Checkbox Inline" />
  </syswf:selectMany>
</c:if>