<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:if test="${not empty globalSession['userName']}">
   <fmt:setLocale value="${globalSession['userDefaultLanguage']}" scope="page"/>
</c:if>

<fmt:setBundle basename="com.hp.systinet.sc.ui.admin.config.license.LicenseMessages" var="license_Messages"/>

<c:choose>
    <c:when test="${not hasAdminPermission}">

        <fmt:setBundle basename="com.hp.systinet.platform.rebranding" var="rebranding_Messages"/>

        <fmt:message key="rebranding.productName" var="productName" bundle="${rebranding_Messages}"/>        

        <syswf:component name="/admin/common/noPermission" prefix="noPermission">
            <c:choose>
                <c:when test="${licenseInvalid}">
                    <syswf:param name="noPermissionMessage">
                        <fmt:message key="license_no_permission_invalid" bundle="${license_Messages}">
                            <fmt:param value="${productName}"/>
                        </fmt:message>
                    </syswf:param>
                </c:when>
                <c:otherwise>
                    <syswf:param name="noPermissionMessage"><fmt:message key="license_no_permission" bundle="${license_Messages}"/></syswf:param>
                </c:otherwise>
            </c:choose>
        </syswf:component>
    </c:when>
    <c:otherwise>
        <c:if test="${enabledSystinetLic}">
        <script type="text/javascript">
        //<![CDATA[
            Ext.onReady(function() {
                var isAutopassJ = ${isAutopassJ};
                //Ext.get('${prefix}_select_autopassj_0').dom.checked = true;
                if(isAutopassJ) {
                    Ext.get('${prefix}_select_autopassj_0').dom.checked = true;
                    Ext.get('${prefix}$licenseKey').dom.disabled = true;
                    Ext.get('${prefix}$licensedTo').dom.disabled = true;
                }
                else {
                    Ext.get('${prefix}_select_systinet_0').dom.checked = true;
                    Ext.get('${prefix}$licenseKeyFile').dom.disabled = true;
                }
                //Ext.get('${prefix}_autopassjselection').enableDisplayMode();
                //Ext.get('${prefix}_systinetselection').enableDisplayMode();
                attachOn('${prefix}_select_autopassj_0','click',licenseApiChange);
                attachOn('${prefix}_select_systinet_0','click',licenseApiChange);
            });
            function licenseApiChange() {
                if(Ext.get('${prefix}_select_autopassj_0').dom.checked) {
                    //alert("0");
                    Ext.get('${prefix}$licenseKey').dom.disabled = true;
                    Ext.get('${prefix}$licensedTo').dom.disabled = true;
                    Ext.get('${prefix}$licenseKeyFile').dom.disabled = false;
                 } else if(Ext.get('${prefix}_select_systinet_0').dom.checked){
                    //alert("1");
                    Ext.get('${prefix}$licenseKey').dom.disabled = false;
                    Ext.get('${prefix}$licensedTo').dom.disabled = false;
                    Ext.get('${prefix}$licenseKeyFile').dom.disabled = true;
                }
            }
        //]]>
        </script>
        </c:if>
        <table class="UI Layout">
            <tbody>
                <tr>
                    <td class="UI Middle">
                        <div class="UI PageIdentity">
                            <h1>
                                <fmt:message key="licenseKeyPageIndetity_Label" bundle="${license_Messages}" />
                            </h1>
                            <fmt:message key="licenseKeyPageIndetity_Note" bundle="${license_Messages}" />
                        </div>
                        <syswf:block className="UI Block Common">
                            <div class="Title">
                                <h3><fmt:message key="licenseConditions_title" bundle="${license_Messages}" /></h3>
                            </div>
                            <div class="Content">
                            <table class="UI Table Properties">
                                <col class="LabelCol">
                                <col>
                                <c:if test="${enabledSystinetLic}">
                                <tr>
                                    <td colspan=2>
                                    <syswf:selectOne id="${prefix}_select_autopassj" mode="radio" value="file" optionValues="file" optionCaptions="Enter license file:" name="licenseApiType">
                                        <syswf:attribute name="class" value="UI Form Checkbox" />
                                    </syswf:selectOne>
                                    </td>
                                </tr>
                                </c:if>
                                <tr>
                                    <td>
                                        <label class="Label Inline">
                                         <fmt:message key="licenseKey_licenseFile_title" bundle="${license_Messages}"/><acronym>*</acronym>
                                        </label>
                                    </td>
                                    <td>
                                        <fmt:message key="licenseKey_licenseFile_inputHint" var="licenseKeyInputHint" bundle="${license_Messages}"/>
                                        <syswf:input id="${prefix}$licenseKeyFile" name="newLicenseKeyFile" value="" mode="file" hint="${licenseKeyInputHint}">
                                            <syswf:attribute name="class" value="UI Form FileInput"/>
                                            <syswf:attribute name="size" value="45"/>
                                         </syswf:input>
                                    </td>
                                </tr>
                                <c:if test="${enabledSystinetLic}">
                                <tr>
                                    <td colspan=2>
                                        <syswf:selectOne id="${prefix}_select_systinet" mode="radio" value="key" optionValues="key" optionCaptions="Enter license key:" name="licenseApiType">
                                            <syswf:attribute name="class" value="UI Form Checkbox" />
                                        </syswf:selectOne>
                                    </td>
                                </tr>
                                
                                <tr>
                                    <td>
                                        <label class="Label Inline">
                                            <fmt:message key="licenseKey_userName_title" bundle="${license_Messages}"/><acronym>*</acronym>
                                        </label>
                                    </td>
                                    <td class="UI Form Text Full">
                                        <fmt:message key="licenseKey_userName_inputHint" var="userNameInputHint" bundle="${license_Messages}" />
                                        <syswf:input id="${prefix}$licensedTo" name="licensedTo" value="${newLicenseKeyInfo.licensedTo}"
                                                property="licensedTo" mode="text" hint="${userNameInputHint}" >
                                            <syswf:attribute name="class" value="UI Form Text Full" />
                                        </syswf:input>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <label class="Label Inline">
                                           <fmt:message key="licenseKey_licenseKey_title" bundle="${license_Messages}"/><acronym>*</acronym>
                                        </label>
                                    </td>
                                    <td>
                                        <fmt:message key="licenseKey_licenseKey_inputHint" var="licenseKeyInputHint" bundle="${license_Messages}"/>
                                        <syswf:input id="${prefix}$licenseKey" name="licenseKey" value="${newLicenseKeyInfo}" property="licenseKey" mode="text"
                                                     hint="${licenseKeyInputHint}">
                                             <syswf:attribute name="class" value="UI Form Text Full" />
                                        </syswf:input>
                                    </td>
                                </tr>
                                </c:if>
                            </table>
                            </div>
                        </syswf:block>
                        <syswf:block className="UI Block Green">
                            <div class="UI Form Controls">
                                <fmt:message key="finishButton_label" var="finishButton" bundle="${license_Messages}"/>
                                <fmt:message key="cancelButton_label" var="cancelButton" bundle="${license_Messages}"/>
                                <syswf:control mode="button" caption="${finishButton}" hint="${finishButton}" action="finish">
                                    <syswf:attribute name="class" value="btn btn-primary" />
                                </syswf:control>
                                <syswf:control mode="button" caption="${cancelButton}" hint="${cancelButton}" action="cancel" targetDepth="${sessionStack.currentDepth -1}">
                                    <syswf:attribute name="class" value="btn btn-gray" />
                                </syswf:control>
                            </div>
                        </syswf:block>
                    </td>
                </tr>
            </tbody>
        </table>
    </c:otherwise>
</c:choose>
