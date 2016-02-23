<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="modal-widget" id="${id}" style="display:none">
              <span class="modal-show-cover">
                  <%-- opacity cover widget --%>
              </span>
               <span class="modal-show"  style="border-color:${templateColor}">
                	<header style="background-color:${templateColor}">
                        <div class="close-btn" name="" onclick="hideTip('${id}');" title="Close"></div>
                        <h5>${title}</h5>
                    </header>
                    <section>
                        <div class="home-page-tip" style="padding:5px 5px 15px 5px">
                            <c:out value="${content}" escapeXml="false"/>
                        </div>
                    </section>
            </span>
</div>

