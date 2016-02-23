<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 

<c:choose>
  <c:when test="${mode eq 'view' || mode eq 'table' || (fn:length(this.bean.values) lt 2)}">
        <c:choose>
          <c:when test="${empty this.bean.value}">
            <i>default</i>
          </c:when>
          <c:otherwise>
              <c:choose>
                <c:when test="${(not empty uuid)}">
                    <a title="${this.bean.value}" href="${webdataPath}/../../../remote/sync/any/${uuid}/config?alt=text/html" target="syncRepositoryDeveloperTools"><c:out value="${this.bean.caption}"/></a>
                </c:when>
                <c:otherwise>
                  <c:choose>
                    <c:when test="${raw eq 'true'}">
                      <a href="${webdataPath}/../../../remote/sync/mappingConfiguration/${this.bean.value}/config?alt=text/html" target="syncRepositoryDeveloperTools"><c:out value="${this.bean.value}"/></a>
                    </c:when>
                    <c:otherwise>
                      <a title="${this.bean.value}" href="${webdataPath}/../../../remote/sync/mappingConfiguration/${this.bean.value}/config?alt=text/html" target="syncRepositoryDeveloperTools"><c:out value="${this.bean.caption}"/></a>
                    </c:otherwise>
                  </c:choose>
                </c:otherwise>
              </c:choose>
          </c:otherwise>
        </c:choose>
  </c:when>
  <c:when test="${mode eq 'edit'}">
      <syswf:selectOne id="${prefix}_mc" name="${prefix}_mc" 
               value="${this.bean}" property="value" mode="menu"
               optionValues="${this.bean.values}" optionCaptions="${this.bean.captions}"/>
  </c:when>
</c:choose>
