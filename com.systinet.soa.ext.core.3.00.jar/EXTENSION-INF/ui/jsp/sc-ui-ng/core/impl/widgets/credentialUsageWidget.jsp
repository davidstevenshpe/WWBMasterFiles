<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>


<syswf:selectOne id="${prefix}categoryWidget" name="categoryWidget" value="${this}" property="singleCategoryValue"
            mode="radio" optionValues="${this.values}"
            optionCaptions="${this.captions}"
            displayAsRow="true" >
</syswf:selectOne>
<c:forEach items="${allCrdUsages}" varStatus ="index">
    <script type="text/javascript">
//<![CDATA[

        Ext.onReady(function() {
            attachOn('${prefix}categoryWidget_${index.count -1}','click',function() {
            	${onSelectAction}();
            });
        });
    
//]]>
</script> 
</c:forEach>
               
