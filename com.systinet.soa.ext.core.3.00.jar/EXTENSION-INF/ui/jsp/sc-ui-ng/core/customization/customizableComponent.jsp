<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:set var="customizedContent">
<c:choose>
	<c:when test="${not canCustomize}">
        <c:choose>
            <c:when test="${empty customizationError}">
            	<c:choose>
            		<c:when test="${fn:endsWith(customizationId,'Actions')}">
            			<%-- add padding for context button --%>
            			<div class="context-button-padding">
	            			<syswf:component prefix="customized" name="${customizedComponent}">
			                    <syswf:paramSet value="${customizedParams}"/>
			                </syswf:component>
		                </div>
            		</c:when>
            		<c:otherwise>
            			<syswf:component prefix="customized" name="${customizedComponent}">
		                    <syswf:paramSet value="${customizedParams}"/>
		                </syswf:component>
            		</c:otherwise>
           		</c:choose>
            </c:when>
            <c:otherwise>
                <div class="UI SystemMessage Error">
                    <div class="MessageContainer">
                        <div class="Text">${customizationError}</div>
                        <div class="x-clear"></div>
                    </div>
                </div>
                <c:remove var="customizationError" scope="request"/>
            </c:otherwise>
        </c:choose>
	</c:when>
	<c:otherwise>
	    <%-- customizationUI comes here --%>
	    
		<%--Set Locale form globalSession. --%>
		<c:if test="${not empty globalSession['userName']}">
		   <fmt:setLocale value="${globalSession['userDefaultLanguage']}" scope="page"/>
		</c:if>
	
		<%--Set Bundle. --%>
		<fmt:setBundle basename="com.hp.systinet.sc.ui.customization.customizationmessages" var="cust_Message"/>
		
		<%-- Get Message --%>
		<fmt:message key="customize_caption" var="customize_caption" bundle="${cust_Message}"/>	
		<fmt:message key="discard_caption" var="discard_caption" bundle="${cust_Message}"/>	
		<fmt:message key="save_caption" var="save_caption" bundle="${cust_Message}"/>	
		<fmt:message key="cancel_caption" var="cancel_caption" bundle="${cust_Message}"/>

        <fmt:setBundle basename="com.systinet.webfw.ui.FrameworkJspMessages" var="messages"/>

        <fmt:message key="error_technicalDetails" var="technicalDetails" bundle="${messages}"/>
        <fmt:message key="error_stackTrace" var="stackTrace" bundle="${messages}"/>
        <fmt:message key="error_at" var="at" bundle="${messages}"/>
        <fmt:message key="error_OK" var="ok" bundle="${messages}"/>

        <c:set var="customizeLinks">
            <a href="#" class="UI Customize Icon" onclick="${prefix}openEditor();">Customize</a>

            <div style="display:none">
              <syswf:control mode="script" action="saveDialog" caption="${prefix}save">
              </syswf:control>
              <syswf:textArea name="${prefix}textEditorContent" value="${bean}" property="content" id="${prefix}Content" escapeXml="true"/>
            </div>
            <script>
                //<![CDATA[
					${prefix}openEditor=function() {

                  var win = new Ext4.Window({
					id: '${prefix}extWindow',
                    title: '<syswf:out context="HtmlBody" value="${customizationTitle}"/>',
                    layout: 'fit',
                    height: 600,
                    modal:true,                      
                    maximizable: true,
                    width: 800,
                    html:'<pre id="${prefix}customizationSource" style="font-size:13px;" class="code-editor"></pre>',
                    buttons: [{
						text: 'Save',
						handler: function() {
						   Ext.get('${prefix}Content').dom.value=editor.getValue();
					       win.destroy();
					       ${prefix}save();
						}
			  		},{
			  			text: 'Cancel',
			  			handler: function() {
			  				win.destroy();
			  			}
			  		}]
                });

                win.show();
                
                var editor = ace.edit('${prefix}customizationSource');
    			editor.setValue(Ext.get('${prefix}Content').dom.value , -1);
				editor.setTheme('ace/theme/' + (layoutManager.localStorage.get('ace/theme/') ? layoutManager.localStorage.get('ace/theme/') : 'chrome'));
				editor.getSession().setMode('ace/mode/xml');
				var resize=function() {
				    	$('#${prefix}customizationSource').height(win.getHeight() - 100);
				    	editor.resize();
			    }
			    win.on('resize',resize);
			    resize();
              }

            
//]]>
</script>
		</c:set>

        <c:choose>
            <c:when test="${empty customizationError}">

                <syswf:catch var="customizationException">
                    <c:set var="component">
                    <syswf:component prefix="customized" name="${customizedComponent}">
                        <syswf:paramSet value="${customizedParams}"/>
                        <c:if test="${rendersCustomizeLinks}">
                            <syswf:param name="customizeLinks" value="${customizeLinks}" />
                        </c:if>
                    </syswf:component>
                    </c:set>
                
                    <c:if test="${not rendersCustomizeLinks}">
                        <c:if test="${not empty customizeLinks}">
                        <div class="UI Form Controls Custom-Mode">
                           <c:out value="${customizeLinks}" escapeXml="false"/>
                        </div>
                        </c:if>
                    </c:if>
                    <c:out value="${component}" escapeXml="false" />
				</syswf:catch>

                <c:if test="${not empty customizationException}">

                    <div class="UI Form Controls">
                        <c:out value="${customizeLinks}" escapeXml="false" />
                    </div>

                    <jsp:useBean id="logger" class="com.hp.systinet.sc.ui.customization.Logger"/>
                    <c:set target="${logger}" property="error" value="${customizationException}" />

                    <div class="UI SystemMessage Error">
                        <div class="MessageContainer">
                            <div class="Text"><fmt:message var="msg" key="component_processing_exception" bundle="${cust_Message}">
                                    <fmt:param value="${customizedComponent}" />
                                    <fmt:param value="${customizationId}" />
                                </fmt:message>
                                <c:out value="${msg}" /><br/>
                                <c:set var="customizationException2" value="${logger.cause}" />
                    <c:out value="${customizationException2.class.name} - ${customizationException2.localizedMessage} " /> <br>

                                <a href="javascript:void(0)" class="UI PageAction ViewDetails" id="${prefix}TechDetails"><span>${technicalDetails}</span></a>


                            </div>
                            <div class="x-clear"></div>
                        </div>
                    </div>
                    
                    <div class="webfw-Window" id="${prefix}-webfw-Window"> 
                    <div id="<c:out value="${prefix}TechDetailsContent"/>" class="x-hidden">
                    <div class="x-window-header">${technicalDetails} (${stackTrace})</div>
                    <div class="x-window-body">
                        <div class="UI Offset">
                        <!--The following PRE tag has this nasty feature with formating, thus the foreach-->
                        <!--must be at the beginning of the line.-->
                        <!--TODO: ask Mac to use DIV with span classes as it was before instead of the PRE tag -->
                        <!--TODO: ask Mac how to align the popoup to the left instead of center.-->
                        <pre>
${customizationException2.class.name} - ${customizationException2.localizedMessage}
    <c:forEach items="${customizationException2.stackTrace}" var="varTraceLine">${at} <c:out value="${varTraceLine}" escapeXml="true"/>
    </c:forEach>
                        </pre>
                        </div>
                    </div>
                </div>
                </div>

                <script type="text/javascript">
//<![CDATA[

                    SPopup.Window.init('${prefix}TechDetails', '${prefix}TechDetailsContent', {
                        width:800,
                        height:400,
                        plain:false,
                        autoScroll:true,
                        centerOnScreen:true,
                        buttonAlign:'center',
                        buttons:[{
                            text:'${ok}',
                            handler:function() {
                                SPopup.Window.Instance['${prefix}TechDetails'].hide();
                            },
                            id: '${prefix}_okButton'
                        }]
                    });
                
//]]>
</script>
                    
                     <%--<br/>
                    <ul>
                    <c:forEach items="${customizationException2.stackTrace}" var="element">
                    <li><c:out value="${element}" /></li>
                    </c:forEach>
                    </ul>--%>
                    
                </c:if>
                <c:remove var="customizationException"/>
            </c:when>
			<c:otherwise>
                <div class="UI Form Controls">
                <c:out value="${customizeLinks}" escapeXml="false"/>
                </div>

                <div class="UI SystemMessage Error">
                    <div class="MessageContainer">
                        <div class="Text">${customizationError}</div>
                        <div class="x-clear"></div>
                    </div>
                </div>
                <c:remove var="customizationError" scope="request"/>
            </c:otherwise>
		</c:choose>   			    
		
	</c:otherwise>
</c:choose>
</c:set>

<c:choose>
    <c:when test="${hasWrap}">
        <c:if test="${empty wrapStyle}">
            <c:set var="wrapStyle" value="Common"/>
        </c:if>
        <syswf:block className="UI Block ${wrapStyle}">
            <c:if test="${not empty wrapCaption}">
                <div class="Title">
                    <h3><span>${wrapCaption}</span></h3>
                </div>
            </c:if>
            <div class="Content">
                <c:out value="${customizedContent}"escapeXml="false"/>
            </div>
        </syswf:block>
    </c:when>
    <c:otherwise>
        <c:out value="${customizedContent}" escapeXml="false"/>
    </c:otherwise>
</c:choose>
