<%@page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<table class="UI Layout">
    <tbody>
        <tr>
            <td class="UI Middle">
                <!-- Title and description -->
                <div class="UI PageIdentity">
                    <h1>${title}</h1>
                </div>

                <div class="UI Text Description">
                    This is an area with development tools.
                </div>

                <syswf:block className="UI Block Common">
                    <div class="Content">
                    <table class="UI Table Properties">
                        <col class="LabelCol">
                        <col>
                        <tbody>
                            <syswf:component name="/util/devel/refreshWebui" prefix="refreshWebui" wrap="false"/>
                            <syswf:component name="/util/devel/refreshWidgets" prefix="refreshWidgets" wrap="false"/>
                            <syswf:component name="/util/devel/refreshBundles" prefix="refreshBundles" wrap="false"/>
                            <syswf:component name="/util/devel/refreshUIComponent" prefix="refreshUIComponent" wrap="false"/>
                            <syswf:component name="/util/devel/refreshInjectionCaches" prefix="refreshInjectionCaches" wrap="false"/>
                            <syswf:component name="/util/devel/generateArtifacts" prefix="generateArtifacts" wrap="false"/>
                            <syswf:component name="/util/devel/dbAnalyzer" prefix="enableAnalyzer" wrap="false"/>
                        </tbody>
                    </table>
                    </div>
                    </div>
                </syswf:block>
            </td>
        </tr>
    </tbody>
</table>