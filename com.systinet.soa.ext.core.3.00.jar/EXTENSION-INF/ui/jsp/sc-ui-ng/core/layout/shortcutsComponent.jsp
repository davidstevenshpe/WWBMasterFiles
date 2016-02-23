<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>

<c:set var="shortcuts" value="${this.shortcuts}"/>

<c:choose>
	<c:when test="${not empty shortcuts}">
		<c:forEach var="item" items="${shortcuts}" varStatus="status">
			<syswf:component name="/core/layout/shortcutItemComponent" prefix="${prefix}${status.index}id" wrap="false">
			    <syswf:param name="model" value="${model}" />
			    <syswf:param name="mode" value="${mode}" />
			    <syswf:param name="artifact" value="${artifact}" />
			    <syswf:param name="relationshipName" value="${item.relationshipName}" />
			    <syswf:param name="artifactType" value="${item.artifactType}" />
			    <syswf:param name="label" value="${item.label}" />
			    <syswf:param name="fullPath" value="${item.fullPath}" />
				<syswf:param name="tableViewOnly" value="${tableViewOnly}" />		
				<syswf:param name="outGoing" value="${item.outGoing}" />
				<syswf:param name="paths" value="${item.paths}" />		
				<syswf:param name="shortcutDefinition" value="${item.definition}" />
				<syswf:param name="canBeEntered" value="${item.canBeEntered}" />
				<syswf:param name="childItemLimitedInfos" value="${item.childItemLimitedInfos}" />
				<syswf:param name="childDefinitions" value="${item.childDefinitions}" />
				<%-- these parameters only are available/used in doSurvey page --%>
				<syswf:param name="showLabel" value="${showLabel}"/>
				<syswf:param name="isSurveyPage" value="${isSurveyPage}"/>
				<syswf:param name="relationSurveyId" value="${relationSurveyId}"/>
			</syswf:component>
		</c:forEach>
		<p></p>
	</c:when>
	<c:otherwise>
		<%-- No shortcut found --%>
	</c:otherwise>
</c:choose>
<script type="text/javascript">
//<![CDATA[
    
    document.onkeydown = fkey;
    var wasPressed = false;
	function fkey(e) {
		e = e || window.event;
		if (wasPressed) {
			return;
		}
		if (e.keyCode == 116) { // f5
			wasPressed = true;
			e.preventDefault();
			var windows = getEditingResolveWindow(opening);
			windows = windows.concat(getEditingResolveWindow(resuming));
			sessionStorage.clear();
			clearSessionData(windows, function(){
				window.location.reload(true);
			});
		}
	}
	
	// On DOM ready, just resume editing shortcut resolve window
	Ext4.onReady(function(){
        resumeEditingResolveWindow();
    });
	
	var opening = '1';
	var resuming = '0';
	
	function clearSessionData(editingShortcutResolveWindows, fnCallback) {
		if (!editingShortcutResolveWindows
                || editingShortcutResolveWindows.length <= 0) {
			fnCallback();
            return;
        }
		var shortcutKeys = Ext.encode(editingShortcutResolveWindows);
		cancelShortcuts(shortcutKeys, function(result){
			fnCallback();
		});
	}

	function createResolveWindowSession(shortcutKey, sourceUuid, sourceName, tarUuid, targetName, parentPrefix) {
		if (!sessionStorage) {
			return true;
		}
		var key = getSessionStorageShortcutKey(shortcutKey, sourceUuid, sourceName, tarUuid, targetName, parentPrefix);
		if (!sessionStorage.getItem(key) || sessionStorage.getItem(key) != opening) {
			sessionStorage.setItem(key, opening);
			return true;
		}
		return false;
	}
	
	function markResolveWindowResume(shortcutKey, sourceUuid, sourceName, tarUuid, targetName, parentPrefix) {
		if (!sessionStorage) {
            return true;
        }
        var key = getSessionStorageShortcutKey(shortcutKey, sourceUuid, sourceName, tarUuid, targetName, parentPrefix);
        if (!sessionStorage.getItem(key)) {
        	return;
        }
        sessionStorage.setItem(key, resuming);
	}
	
	function markOpeningWindowResuming() {
		var editingShortcutResolveWindows = getEditingResolveWindow(opening);
        if (!editingShortcutResolveWindows
                || editingShortcutResolveWindows.length <= 0) {
            return;
        }
        for ( var i = 0; i < editingShortcutResolveWindows.length; i++) {
            var wind = editingShortcutResolveWindows[i];
            var shortcutKey = wind[0];
            var sourceUuid = wind[1];
            var sourceName = wind[2];
            var targetUuid = wind[3];
            var targetName = wind[4];
            var parentPrefix = wind[5];
            markResolveWindowResume(shortcutKey, sourceUuid, sourceName, targetUuid, targetName, parentPrefix);
        }
	}

	function cancelResolveWindowSession(shortcutKey, sourceUuid, sourceName, tarUuid, targetName, parentPrefix) {
		if (!sessionStorage) {
			return true;
		}
		var key = getSessionStorageShortcutKey(shortcutKey, sourceUuid, sourceName, tarUuid, targetName, parentPrefix);
		sessionStorage.removeItem(key);
	}

	function resumeEditingResolveWindow() {
		var editingShortcutResolveWindows = getEditingResolveWindow(resuming);
		sessionStorage.clear();
		if (!editingShortcutResolveWindows
				|| editingShortcutResolveWindows.length <= 0) {
			return;
		}
		for ( var i = 0; i < editingShortcutResolveWindows.length; i++) {
			var wind = editingShortcutResolveWindows[i];
			var shortcutKey = wind[0];
			var sourceUuid = wind[1];
			var sourceName = wind[2];
			var targetUuid = wind[3];
			var targetName = wind[4];
			var parentPrefix = wind[5];
			openUnresolvedShortcutDialog(shortcutKey, sourceUuid, sourceName, targetUuid, targetName, parentPrefix);
		}
	}

	function getEditingResolveWindow(flag) {
		if (!sessionStorage) {
			return [];
		}
		var result = new Array();
		for ( var i = 0; i < sessionStorage.length; i++) {
			var key = sessionStorage.key(i);
			if (sessionStorage.getItem(key) == flag) {
				if (key.indexOf('shortcutWind@') == 0) {
					var items = key.split('@');
					if (items.length != 7) {
						continue;
					}
					var shortcutKey = items[1];
					var sourceUuid = items[2];
					var sourceName = items[3];
					var targetUuid = items[4];
					var targetName = items[5];
					var parentPrefix = items[6];
					var targetSdm = items[7];
					result.push([ shortcutKey, sourceUuid, sourceName, targetUuid, targetName, parentPrefix ]);
				}
			}
		}
		return result;
	}

	function getSessionStorageShortcutKey(shortcutKey, sourceUuid, sourceName, tarUuid, tarName, parentPrefix) {
		return "shortcutWind@" + shortcutKey + "@" + sourceUuid + "@" + sourceName + '@' + tarUuid + "@" + tarName + "@" + parentPrefix;
	}

	//
</script>