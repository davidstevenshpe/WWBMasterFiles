<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<%-- Import the JSTL fmt. --%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%-- Set Locale form globalSession. --%>
<c:if test="${not empty globalSession['userName']}">       
   <fmt:setLocale value="${globalSession['userDefaultLanguage']}" scope="page"/>
</c:if>

<%-- Set Bundles. --%>
<fmt:setBundle basename="com.systinet.webfw.ui.WebFrameworkUIMessages" var="webFrameworkUI_Messages"/>
<fmt:setBundle basename="com.systinet.webfw.ui.layout.LayoutMessages" var="layout_Messages"/>

<%-- Get Messages. --%>
<fmt:message key="back" var="back" bundle="${webFrameworkUI_Messages}"/>
<fmt:message key="cancel" var="cancel" bundle="${webFrameworkUI_Messages}"/>
<fmt:message key="reset" var="reset" bundle="${webFrameworkUI_Messages}"/>
<fmt:message key="save" var="save" bundle="${webFrameworkUI_Messages}"/>
<fmt:message key="move" var="move" bundle="${webFrameworkUI_Messages}"/>
<fmt:message key="add" var="add" bundle="${webFrameworkUI_Messages}"/>
<fmt:message key="change" var="change" bundle="${webFrameworkUI_Messages}"/>
<fmt:message key="customize" var="customize" bundle="${webFrameworkUI_Messages}"/>

<fmt:message key="layoutControls_backHint" var="backHint" bundle="${layout_Messages}"/>
<fmt:message key="layoutControls_cancelHint" var="cancelHint" bundle="${layout_Messages}"/>
<fmt:message key="layoutControls_resetHint" var="resetHint" bundle="${layout_Messages}"/>
<fmt:message key="layoutControls_saveHint" var="saveHint" bundle="${layout_Messages}"/>
<fmt:message key="layoutControls_saveAsRoleView" var="saveAsRoleView" bundle="${layout_Messages}"/>
<fmt:message key="layoutControls_saveAsRoleViewHint" var="saveAsRoleViewHint" bundle="${layout_Messages}"/>
<fmt:message key="layoutControls_chooseComponentToMoveHint" var="chooseComponentToMoveHint" bundle="${layout_Messages}"/>
<fmt:message key="layoutControls_chooseBoxMovedToHint" var="chooseBoxMovedToHint" bundle="${layout_Messages}"/>
<fmt:message key="layoutControls_moveHint" var="moveHint" bundle="${layout_Messages}"/>
<fmt:message key="layoutControls_chooseComponentToAddHint" var="chooseComponentToAddHint" bundle="${layout_Messages}"/>
<fmt:message key="layoutControls_chooseBoxAddedToHint" var="chooseBoxAddedToHint" bundle="${layout_Messages}"/>
<fmt:message key="layoutControls_addHint" var="addHint" bundle="${layout_Messages}"/>
<fmt:message key="layoutControls_changeMyViewHint" var="changeMyViewHint" bundle="${layout_Messages}"/>
<fmt:message key="layoutControls_customizeHint" var="customizeHint" bundle="${layout_Messages}"/>
<fmt:message key="layoutControls_changeRoleViewHint" var="changeRoleViewHint" bundle="${layout_Messages}"/>

<c:choose>
  <c:when test="${(layoutParameters.displayMode eq 'customize' and not empty logged) or not empty customizeLayoutSwitch}">
    <c:if test="${(empty customizeLayoutSwitch) or (customizeLayoutSwitch eq 'true')}">
    <c:choose>
      <c:when test="${layoutParameters.chooseLayoutMode eq 'chooseLayout'}">
          <c:if test="${panel.possibleLayoutCount > 1}">
            <p><fmt:message key="layoutControls_chooseLayout" bundle="${layout_Messages}"/>:</p>
            <c:forEach items="${panel.layoutList}" var="layout">
              <syswf:control action="layoutChange" mode="postanchor" caption="${layout.name}">
                <syswf:attribute name="class" value="Control ${layout.htmlClass}"/>
                <syswf:param name="layout" value="${layout.name}"/>
              </syswf:control>
            </c:forEach>
          </c:if>
          <syswf:control mode="postanchor" action="layoutMoveComponent" caption="${back}" hint="${backHint}" targetHistory="${currentHistory-1}"/>
      </c:when>
      <c:otherwise>
            <div class="Actions">
          <syswf:control action="layoutUndoChanges" mode="postanchor" caption="${cancel}" hint="${cancelHint}">
            <syswf:attribute name="class" value="Control UndoControl" />
          </syswf:control>
          
          <syswf:control action="layoutReset" mode="postanchor" caption="${reset}" hint="${resetHint}">
            <syswf:attribute name="class" value="Control ResetControl" />
          </syswf:control>
          
          <c:choose>
            <c:when test="${layoutParameters.preferUserCustomization}">
              <syswf:control action="layoutStoreChanges" mode="postanchor" caption="${save}" hint="${saveHint}">
                <syswf:attribute name="class" value="Control SaveControl" />
              </syswf:control>
            </c:when>
            <c:otherwise>
              <c:if test="${logged eq 'admin'}">
                <syswf:control action="layoutStoreChangesForRole" mode="postanchor" caption="${saveAsRoleView}" hint="${saveAsRoleViewHint}">
                  <syswf:attribute name="class" value="Control SaveForRoleControl" />
                </syswf:control>
              </c:if>
            </c:otherwise>
          </c:choose>
                                
            </div>
            <div class="Tasks">
          <c:if test="${panel.activeLayout.boxCount>1 and not empty panel.visibleAreas}">
            <div class="Task MoveComponent">
				<c:set var="selectOneMovedComponent">
					 <syswf:selectOne mode="menu" name="movedArea" optionValues="${panel.visibleAreas}" optionCaptions="${panel.visibleAreas}" value="${layoutParameters}" property="movedArea" optionCaptionsProperty="caption" optionValuesProperty="name" hint="${chooseComponentToMoveHint}"/>
				</c:set>
				<c:set var="selectOneMoveToBox">
					 <syswf:selectOne mode="menu" name="moveToBox" optionValues="${panel.activeLayout.boxList}" optionCaptions="${panel.activeLayout.boxList}" value="${layoutParameters}" property="moveToBox" optionCaptionsProperty="caption" optionValuesProperty="name" hint="${chooseBoxMovedToHint}"/>
				</c:set>
 				<fmt:message key="layoutControls_moveDescription" bundle="${layout_Messages}">
					<fmt:param value="${selectOneMovedComponent}"/>
					<fmt:param value="${selectOneMoveToBox}"/>
	 			</fmt:message>
				<syswf:control mode="button" action="layoutMoveComponent" caption="${move}" hint="${moveHint}"/>
            </div>
          </c:if>

          <c:if test="${panel.hiddenAreasCount>0}">
            <div class="Task AddComponent">
				<c:set var="selectOneAddedComponent">
					 <syswf:selectOne mode="menu" name="addedArea" optionValues="${panel.hiddenAreas}" optionCaptions="${panel.hiddenAreas}" value="${layoutParameters}" property="addedArea" optionCaptionsProperty="caption" optionValuesProperty="name" hint="${chooseComponentToAddHint}"/>
				</c:set>
				<c:set var="selectOneAddToBox">
					 <syswf:selectOne mode="menu" name="addToBox" optionValues="${panel.activeLayout.boxList}" optionCaptions="${panel.activeLayout.boxList}" value="${layoutParameters}" property="addToBox" optionCaptionsProperty="caption" optionValuesProperty="name" hint="${chooseBoxAddedToHint}"/>
				</c:set>
 				<fmt:message key="layoutControls_addDescription" bundle="${layout_Messages}">
					<fmt:param value="${selectOneAddedComponent}"/>
					<fmt:param value="${selectOneAddToBox}"/>
	 			</fmt:message>
                <syswf:control mode="button" action="layoutAddComponent" caption="${add}" hint="${addHint}"/>
            </div>
          </c:if>
          </div>
      </c:otherwise>
    </c:choose>
    </c:if>
  </c:when>
  <c:otherwise>
   <c:if test="${panel.customizable}">
      <c:if test="${not empty logged}">
        <div id="CustomizePage">
          <c:if test="${logged eq 'admin'}">
            <c:choose>
              <c:when test="${layoutParameters.preferUserCustomization}">
				<c:set var="controlChangeMyView">
					<syswf:control action="forceRoleView" mode="postanchor" caption="${change}" hint="${changeMyViewHint}">
		                <syswf:attribute name="class" value="Control ChangeViewControl" />
			        </syswf:control>
				</c:set>
				<c:set var="controlCustomizeMyView">
					<syswf:control action="layoutChangeToCustomizationMode" mode="postanchor" caption="${customize}" hint="${customizeHint}">
						<syswf:attribute name="class" value="Control CustomizeControl" />
					</syswf:control>
				</c:set>
				<fmt:message key="layoutControls_myViewList" bundle="${layout_Messages}">
					<fmt:param value="${controlChangeMyView}"/>
					<fmt:param value="${controlCustomizeMyView}"/>
	 			</fmt:message>
              </c:when>
              <c:otherwise>
				<c:set var="controlChangeRoleView">
					<syswf:control action="forceUserView" mode="postanchor" caption="${change}" hint="${changeRoleViewHint}">
						<syswf:attribute name="class" value="Control ChangeViewControl" />
                    </syswf:control>
				</c:set>
				<c:choose>
					<c:when test="${logged eq 'admin'}">
						<c:set var="controlCustomizeRoleView">
							<syswf:control action="layoutChangeToCustomizationMode" mode="postanchor" caption="${customize}" hint="${customizeHint}">
								<syswf:attribute name="class" value="Control CustomizeControl" />
							</syswf:control>
						</c:set>
						<fmt:message key="layoutControls_roleAdminViewList" bundle="${layout_Messages}">
							<fmt:param value="${controlChangeRoleView}"/>
							<fmt:param value="${controlCustomizeRoleView}"/>
	 					</fmt:message>
					</c:when>
					<c:otherwise>
						<fmt:message key="layoutControls_roleViewList" bundle="${layout_Messages}">
							<fmt:param value="${controlChangeRoleView}"/>
	 					</fmt:message>
					</c:otherwise>
				</c:choose>
              </c:otherwise>              
            </c:choose>                    
           </c:if>
        </div>
      </c:if>
   </c:if>
  </c:otherwise>
</c:choose>


<c:choose>
 <c:when test="${empty logged}">
   <%-- This caption is not to be localized --%>
   <syswf:control mode="script" caption="saveLayoutDesignV3" targetTask="/login" formName="ContentForm"/>
 </c:when>
 <c:otherwise>
   <%-- This caption is not to be localized --%>
   <syswf:control mode="ajax" caption="saveLayoutDesignV3" action="saveLayout" formName="ContentForm"/>
 </c:otherwise>
</c:choose>
