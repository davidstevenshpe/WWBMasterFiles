<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<fmt:setBundle basename="com.hp.systinet.sc.ui.admin.config.basic.BasicSettingsMessages" var="basicSettings_Messages" />
<fmt:message key="saveButton_Label" var="save_label" bundle="${basicSettings_Messages}" />
<fmt:message key="defaultButtonLabel" var="default_label" bundle="${basicSettings_Messages}" />
<fmt:message key="preferences.certVerification_Hint" var="certVerificationHint" bundle="${basicSettings_Messages}" />
<fmt:message key="preferences.enableFts_Hint" var="enableFtsHint" bundle="${basicSettings_Messages}"/>
<fmt:message key="preferences.canCreateEmptyDataArtifacts_Hint" var="canCreateArtifactsHint" bundle="${basicSettings_Messages}"/>

<c:if test="${not empty globalSession['userName']}">
	<fmt:setLocale value="${globalSession['userDefaultLanguage']}"
		scope="page" />
</c:if>

<syswf:block className="UI SystemMessage Info">
    <div class="MessageContainer"><fmt:message
        key="systemMessage_Label" bundle="${basicSettings_Messages}" />
    </div>
</syswf:block> 
<syswf:block className="UI SystemMessage Warning">
    <div class="MessageContainer">
        <div class="Text">
             <fmt:message key="basicsettings.fultext_search.warning" bundle="${basicSettings_Messages}" />
        </div>
        <div class="x-clear"></div>
    </div>
</syswf:block>
<syswf:block className="UI Block Common">
     <div class="Content">
	      <table class="UI Table Properties">
	          <col class="MidLabelCol">
	          <col>
	          <tr>
	              <td>
	                  <label>
	                      <fmt:message key="preferences.enableFts_Label" bundle="${basicSettings_Messages}" />:
	                  </label>
	              </td>
	              <td>
	                  
	                  <syswf:selectOne id="${prefix}_enableFts" name="enableFts" hint="${enableFtsHint}" 
	                      value="${this.bean}" property="enabledFts" mode="checkbox" optionValues="true"
	                      optionCaptions=" " dataType="boolean">
	                      <syswf:attribute name="class" value="UI Form Checkbox" />
	                  </syswf:selectOne>
	              </td>
	          </tr>
	          <tr>
	              <td>
	                  <label>
	                      <fmt:message key="preferences.enableSendEmail" bundle="${basicSettings_Messages}" />:
	                  </label>
	              </td>
	              <td>
				      <syswf:selectOne id="${prefix}_enableSendEmail" name="enableSendEmail" hint="${enableSendEmailHint}" 
	                      value="${this.bean}" property="enableSendEmail" mode="checkbox" optionValues="true"
	                      optionCaptions=" " dataType="boolean">
	                      <syswf:attribute name="class" value="UI Form Checkbox" />
	                  </syswf:selectOne>
	              </td>
	          </tr>	
	          <tr>
	              <td>
	                  <label>
	                      <fmt:message key="preferences.currencySymbol" bundle="${basicSettings_Messages}" />:
	                  </label>
	              </td>
	              <td>
				    <syswf:input id="${prefix}_currencySymbol" name="currencySymbol" 
				            value="${this.bean}" property="currencySymbol">
							<syswf:attribute name="style" value="color: grey; background-color: #F0F0F0;"/>	
				           	<syswf:attribute name="class">x-form-text UI Input</syswf:attribute>
				    </syswf:input>
	              </td>
	          </tr>	          
	          <tr>
	              <td>
	                  <label>
	                      <fmt:message key="preferences.certVerification_Label" bundle="${basicSettings_Messages}" />: 
	                  </label>
	              </td>
	              <td>
	                  <syswf:selectOne id="${prefix}_certVerification"
	                      name="certVerification" value="${this.bean}" property="effective"
	                      mode="radio" hint="${certVerificationHint}" size="1"
	                      optionValues="${this.bean.options}" optionCaptions="${this.bean.captions}">
	                      <syswf:attribute name="class" value="UI Form Checkbox" />
	                  </syswf:selectOne>
	              </td>
	          </tr>
	      </table>
     </div>
</syswf:block>
<syswf:block className="UI Block Green">
    <div class="UI Form Controls">
	    <syswf:control mode="button"
	        caption="${save_label}" hint="${save_label}" action="save">
	        <syswf:attribute name="class" value="btn btn-primary" />
	    </syswf:control> 
	    <syswf:control mode="button" caption="${default_label}"
	        hint="${default_label}" action="resetDefault">
	        <syswf:attribute name="class" value="btn btn-gray" />
	    </syswf:control>
    </div>
</syswf:block>
