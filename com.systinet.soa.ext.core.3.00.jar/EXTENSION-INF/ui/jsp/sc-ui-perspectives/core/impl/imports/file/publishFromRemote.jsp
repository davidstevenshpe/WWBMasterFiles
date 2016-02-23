<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<syswf:block className="UI Block Common">
    
        <syswf:component name="/core/impl/imports/file/locationOptions" prefix="remoteOptions">
            <syswf:param name="importFileBean" value="${importFileBean}"/>
            <syswf:param name="importType" value="remote"/>
        </syswf:component>
        <syswf:component name="/core/impl/imports/file/advancedOptions" prefix="advancedOptionsRemote">
            <syswf:param name="importFileBean" value="${importFileBean}"/>
            <syswf:param name="importType" value="remote"/>
            <syswf:param name="locationOptionsPrefix" value="${prefix}_remoteOptions"/>
        </syswf:component>
    
</syswf:block>