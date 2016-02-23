<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<div style="margin:20px;width:60%">
    <i>
        To achieve good performance of Enterprise Maps, especially when building data sources for reports, Enterprise Maps maintain a fast in-memory index.
        This index is usually updated on every artifact change. This might be time consuming when performing bulk data imports - it is better to disable indexing
        during the import and rebuild the index afterwards.
    </i>
</div>

<div style="margin:20px;">


    <div class="Title">
        <h3 style="font-size:20px">
            <span>Configuration</span>
        </h3>
    </div>
    <br/>
    <table class="UI Table Properties">
        <tr>
            <th title="Index is automatically updated immediately when data change occurs">Update Index on Every Update:</th>
            <td>
                <syswf:selectOne id="onTheFly" name="onTheFly"
                                 value="${this}" property="onTheFlyIndexingEnabled"
                                 dataType="boolean" optionValues="true" optionCaptions=""
                                 mode="checkbox">
                    <syswf:attribute name="onclick" value="Ext4.get('saveButton').removeCls('Disabled');"/>
                </syswf:selectOne>
            </td>
            <td></td>
            <td></td>
        </tr>
        <tr>
            <th title="The index will be completely rebuilt at regular time intervals. This is necessary for clustered EM installation to keep nodes in sync.">Automatic Regular Index Rebuilding: </th>
            <td>
                <syswf:selectOne id="automaticIndexing" name="index"
                                 value="${this}" property="automaticIndexingEnabled"
                                 dataType="boolean" optionValues="true" optionCaptions=""
                                 mode="checkbox">
                    <syswf:attribute name="onclick" value="Ext4.get('saveButton').removeCls('Disabled');"/>
                </syswf:selectOne>
            </td>
            <td></td>
            <td></td>
        </tr>
        <tr>
            <th title="Indexing might be temporarily disabled during data import so that the import is not slowed down by index reorganization. The index will be completely rebuilt when the import is finished.">Temporarily Disabled Indexing:</th>
            <td>
                <c:choose>
                    <c:when test="${this.index.temporarilyDisabledIndexing}">
                        Yes, most probably a data import in progress.
                        <syswf:control mode="anchor" action="tempEnable" id="xw2" caption="(Override...)" hint="Use with caution - override this setting just in case the process that disabled indexing crashed"/>
                    </c:when>
                    <c:otherwise>
                        No
                    </c:otherwise>
                </c:choose>
            </td>
            <td></td>
            <td></td>
        </tr>
    </table>
    <br/>
    <syswf:control mode="script" action="update" id="saveButton2" caption="saveProperties"/>
    <syswf:control mode="button" action="update" disabled="true" id="saveButton" caption="Save">
        <syswf:attribute name="onclick" value="if (!Ext4.get('saveButton').hasCls('Disabled')) saveProperties();"/>
    </syswf:control>
    <br/>
    <br/>

    <div class="Title">
        <h3 style="font-size:20px">
            <span>Statistics</span>
        </h3>
    </div>
    <h1></h1>

    <br/>

    <div style="font-size:12px">

        <table class="UI Table Properties">

            <tr>
                <th title="Artifact count">Artifact Count:</th>
                <td>${this.index.artifactCount}</td>
                <td></td>
                <td></td>
            </tr>
            <tr>
                <th title="Relationship count">Relationship Count:</th>
                <td>${this.index.relationshipCount}</td>
                <td></td>
                <td></td>
            </tr>
            <tr>
                <th title="ACL profile count">ACL Profile Count:</th>
                <td>${this.index.ACLProfilesCount}</td>
                <td></td>
                <td></td>
            </tr>
            <tr>
                <th title="Last scan time">Last Scan Time:</th>
                <td>${this.index.scanTime}ms</td>
                <td></td>
                <td></td>
            </tr>
        </table>

        <br/>
        <br/>
        <div class="Title">
            <h3 style="font-size:20px">
                <span>Storage</span>
            </h3>
        </div>
        <br/>
        <table class="UI Table Properties">
            <tr>
                <th title="Current Storage Size">Current Storage Size:</th>
                <td><fmt:formatNumber pattern="0.0" value="${this.index.usedSize/1024/1024}"/>MB</td>
                <td></td>
                <td></td>
            </tr>
            <tr>
                <th title="Free Storage Space">Free Storage Space:</th>
                <td><fmt:formatNumber pattern="0.0" value="${this.index.freeSize/1024/1024}"/>MB</td>
                <td></td>
                <td></td>
            </tr>
            <tr>
                <th title="Storage Size Limit">Storage Size Limit:</th>
                <td><fmt:formatNumber pattern="0.0" value="${this.index.usedSize/1024/1024}"/>MB</td>
                <td></td>
                <td></td>
            </tr>
            <tr>
                <th title="Java Version">Java Version:</th>
                <td>${this.index.javaVersion}</td>
                <td></td>
                <td></td>
            </tr>
        </table>

        <br/>
        <br/>

        <syswf:control id="as1" hint="Full rescan" caption="Rescan" mode="button" action="scan" />
      <%--  <syswf:control id="as2" hint="Full rescan" caption="Test" mode="button" action="test" /> --%>
    </div>
</div>