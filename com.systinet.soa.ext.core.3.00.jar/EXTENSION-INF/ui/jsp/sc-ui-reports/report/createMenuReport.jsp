<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<fmt:setBundle basename="com.hp.systinet.report.ui.l10n.ReportMessages" var="report_Message"/>

                <table class="UI Table Properties">
                    <col class="LabelCol"/>
                    <col/>
                    <tbody>
                        <tr><td colspan="2"></td></tr>
                        <tr>
                            <td></td>
                            <td>
                                 <syswf:selectOne id="${prefix}_addLeftMenu" name="createMenuReport" 
                                          value="${menuBean}" property ="createReportMenu" mode="checkbox" optionValues="true"
                                          optionCaptions=""  dataType="boolean"/>
                                 <fmt:message key="birt_policy_report.create_menu_report.label" bundle="${report_Message}"/>
                            </td>
                        </tr>
                    </tbody>
                </table>
