<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<syswf:block className="UI Block Common">
    
        <syswf:component name="/core/impl/imports/file/locationOptions" prefix="localOptions">
            <syswf:param name="importFileBean" value="${importFileBean}"/>
            <syswf:param name="importType" value="local"/>
        </syswf:component>
        <syswf:component name="/core/impl/imports/file/advancedOptions" prefix="advancedOptionsLocal">
            <syswf:param name="importFileBean" value="${importFileBean}"/>
            <syswf:param name="importType" value="local"/>
            <syswf:param name="locationOptionsPrefix" value="${prefix}_localOptions"/>
        </syswf:component>
    
</syswf:block>