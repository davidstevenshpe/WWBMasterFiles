<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="headerSize" value="13"/>

<syswf:control id="tr1" mode="script" action="shift" caption="forward" targetDepth="${sessionStack.currentDepth}">
    <syswf:param name="quarterCount" value="${2}"/>
</syswf:control>

<syswf:control id="tr2" mode="script" action="shift" caption="backward" targetDepth="${sessionStack.currentDepth}">
    <syswf:param name="quarterCount" value="${-2}"/>
</syswf:control>

<style>
    tr.header {
        border-width: 1px;
        border-style: solid;
    }

    table.wrap {
        border-width: 1px;
        border-style: solid;
        width:100%;
    }

    td.year {
        border-width: 1px;
        border-style: solid;
        text-align:center;
        padding:4px;
    }

    td.project-header {
        border-width: 1px;
        border-style: solid;
        vertical-align:middle;
        padding:4px;
    }

    td.quater-header {
        border-width: 1px;
        border-style: solid;
        text-align:center;
        padding:4px;
    }

    tr.quater-header {
        border-width: 1px;
        border-style: solid;
    }

    div.deliverable {
        border-width: 1px 1px 0 1px;
        border-style: solid;
        border-top-color:lightgray;
        padding:4px;
        height:40px;
        text-align:left;
        font-size:12px;
        white-space: nowrap;
        text-overflow: ellipsis;
        overflow: hidden;
    }

    div.component-wrap {
        padding: 5px;
    }

    div.deliverable-undefined {
        border-width: 1px 1px 0 1px;
        border-style: solid;
        border-top-color:lightgray;
        padding:4px;
        height:40px;
        text-align:left;
        font-size:12px;
        white-space: nowrap;
        text-overflow: ellipsis;
        overflow: hidden;
        background-color: #F0F0F0;
        color: darkblue;
    }


    td.project-header {
        border-width: 1px;
        border-style: solid;
        padding:4px;
        font-size:12px;
    }

    div.deliverableWhite a:hover {
        text-decoration:underline;
        color: white;
    }

    div.deliverableWhite a{
        color: white;
    }

    div.deliverableBlack a:hover {
        text-decoration:underline;
        color: black;
    }

    div.deliverableBlack a{
        color: black;
    }

    td.project-header a:hover {
        text-decoration:underline;
    }

    td.project-body  {
        border-width: 1px;
        border-style: solid;
        vertical-align:top;
    }

    hr.rowSeparator {
        margin:0px;
        color: lightgray;
    }

</style>


<div id="roadmap-menu">
    <span><div id="visualizationSelection" style="float:left;margin: 5px"></div><span>
    <span style="float:right;margin: 5px">
      <span id="timeShiftBack"></span>
      <span id="timeShiftForward"></span>
    </span>
    <hr/>
</div>

<div>
    <div id="health" class="clear" style="margin-left: 5px; margin-top: 8px;display:none;">
        <div class="capa-legend-tile">
            <div class="view" style="background-color: #f76c51"></div>
            <div class="desc">Weak</div>
        </div>
        <div class="capa-legend-tile">
            <div class="view" style="background-color: #ffe554"></div>
            <div class="desc">Medium</div>
        </div>
        <div class="capa-legend-tile">
            <div class="view" style="background-color: #00a276"></div>
            <div class="desc">Strong</div>
        </div>
        <div class="capa-legend-tile">
            <div class="view" style="background-color: #ffffff"></div>
            <div class="desc">N/A</div>
        </div>
    </div>

    <div id="finishedDeliverables" class="clear" style="margin-left: 5px; margin-top: 8px;display:none;">

        <div class="capa-legend-tile">
            <div class="view" style="background-color: #f76c51"></div>
            <div class="desc">0%-25%</div>
        </div>
        <div class="capa-legend-tile">
            <div class="view" style="background-color: #ffe554"></div>
            <div class="desc">25%-50%</div>
        </div>
        <div class="capa-legend-tile">
            <div class="view" style="background-color: #55DD77"></div>
            <div class="desc">50%-75%</div>
        </div>
        <div class="capa-legend-tile">
            <div class="view" style="background-color: #00a276"></div>
            <div class="desc">75%-100%</div>
        </div>
        <div class="capa-legend-tile">
            <div class="view" style="background-color: #F0F0F0"></div>
            <div class="desc">No changes declared to deliver</div>
        </div>
    </div>

    <div id="unfinishedPrerequisites" class="clear" style="margin-left: 5px; margin-top: 8px;display:none;">

        <div class="capa-legend-tile">
            <div class="view" style="background-color: #8C4646"></div>
            <div class="desc">0%-25%</div>
        </div>
        <div class="capa-legend-tile">
            <div class="view" style="background-color: #f76c51"></div>
            <div class="desc">25%-50%</div>
        </div>
        <div class="capa-legend-tile" title="50%">
            <div class="view" style="background-color: #F2AE72"></div>
            <div class="desc">50%-75%</div>
        </div>
        <div class="capa-legend-tile" title="50%">
            <div class="view" style="background-color: #ffe554"></div>
            <div class="desc">75%-99%</div>
        </div>
        <div class="capa-legend-tile" title="100%">
            <div class="view" style="background-color: #00a276"></div>
            <div class="desc">100%</div>
        </div>
        <div class="capa-legend-tile">
            <div class="view" style="background-color: #F0F0F0"></div>
            <div class="desc">No prerequisites</div>
        </div>
    </div>

</div>

<hr/>


<div class="component-wrap">

    <div style="position:relative;left:0px;top:0px;margin:0px;padding:0px;width:100%;height:${(this.projectCount+1)*40}px">

        <c:if test="${this.nowPosition>0}">
            <div style="font-weight:bold;color:black;position:absolute;top:-24px;left:${headerSize+100*this.nowPosition/this.spread*(100-headerSize)/100}%;">
                Today
            </div>

            <div style="position:absolute;top:-7px;left:${headerSize+100*this.nowPosition/this.spread*(100-headerSize)/100}%;height:${(this.projectCount+1)*40+35}px;width:2px;background-color:black;opacity:0.4;z-index:200"></div>
            <div style="position:absolute;top:-7px;left:${headerSize+100*this.nowPosition/this.spread*(100-headerSize)/100}%;height:2px;width:40px;background-color:black;opacity:0.4;z-index:200"></div>
        </c:if>

        <div style="position:absolute;top:0px;left:0px;width:100%">

            <table class="wrap">
                <tr class="header">
                    <td width="10%" style="font-size:larger" class="project-header" width="${headerSize}%" rowspan="2">
                        <%--<syswf:control id="tr1" mode="anchor" caption="Projects" targetTask="/common/browseArtifact">
                            <syswf:param name="artifactType" value="projectArtifact"/>
                        </syswf:control>--%>
                        Projects
                    </td>
                    <td class="year" colspan="${5-this.currentQuater}">${this.currentYear}</td>
                    <td class="year" colspan="${this.currentQuater}">${this.currentYear+1}</td>
                </tr>
                <tr class="quater-header">
                    <c:forEach var="i" begin="${this.currentQuater}" end="4">
                        <td width="18%" class="quater-header">${this.roman[i]}.</td>
                    </c:forEach>
                    <c:forEach var="i" begin="1" end="${this.currentQuater}">
                        <td width="18%" class="quater-header">${this.roman[i]}.</td>
                    </c:forEach>
                </tr>
                <c:set var="counter" value="${0}"/>
                <c:set var="deliverableCounter" value="${0}"/>
                <c:forEach var="project" items="${this.projects}" varStatus="status">
                    <tr height="40px">
                        <c:set var="counter" value="${(counter+1)%2}"/>
                        <td width="10%" class="project-header project-${counter}" >
                            <div>
								<div class="print-hide">
									<syswf:component name="/core/impl/util/artifactLinkRenderer" prefix="proj${status.index}.${project.uuid}">
										<syswf:param name="uuid" value="${project.uuid}"/>
										<syswf:param name="caption" value="${project.name}"/>
									</syswf:component>
								</div>
								<span style="color:#579ddb" class="print-show hide-not-print">${project.name}</span>
							</div>
                        </td>
                        <td width="90%" colspan="5" class="project-body project-${counter}">
                            <div style="position:relative;left:0px;top:0px;margin:0px;padding:0px;overflow:visible;">
                                <c:set var="y" value="${0}"/>
                                <div id="proj.${project.uuid}"
                                     class="deliverable-undefined"
                                     style="position:absolute;left:${100*project.startPosition/this.spread}%;top:${y}px; width:${100*project.length/this.spread}%">
                                    <c:if test="${empty(project.deliverables)}">
                                        <span style="text-overflow: ellipsis" class="print-hide">
                                            <syswf:component wrap="false" name="/core/impl/util/artifactLinkRenderer" prefix="proj${status.index}.nodeliv.${project.uuid}">
                                                <syswf:param name="uuid" value="${project.uuid}"/>
                                                <syswf:param name="caption" value="No deliverables defined"/>
                                                <syswf:param name="title" value="No deliverables defined"/>
                                            </syswf:component>
                                        </span>
										<span style="color:black" class="print-show hide-not-print">No deliverables defined</span>
                                        </br>
                                        <span style="text-overflow: ellipsis;font-size:11px">
                                            <c:choose><c:when test="${project.days>=0}"> ${project.days} days</c:when><c:otherwise>N/A</c:otherwise></c:choose>
                                        </span>
                                    </c:if>
                                </div>
                                <c:forEach var="deliverable" items="${project.deliverables}">
                                    <c:set var="deliverableCounter" value="${deliverableCounter+1}"/>
                                    <div id="deliv.${deliverable.uuid}" class="deliverable"
                                         style="position:absolute;left:${100*deliverable.startPosition/this.spread}%;top:${y}px; width:${100*deliverable.length/this.spread}%">
                                        <span style="text-overflow: ellipsis" class="print-hide">
                                            <syswf:component wrap="false" name="/core/impl/util/artifactLinkRenderer" prefix="deliv${status.index}.${deliverable.uuid}">
                                                <syswf:param name="uuid" value="${deliverable.uuid}"/>
                                                <syswf:param name="caption" value="${deliverable.name}"/>
                                                <syswf:param name="title" value="${deliverable.name}"/>
                                            </syswf:component>
                                        </span>
										<span style="color:black" class="print-show hide-not-print">${deliverable.name}</span>
                                        </br>
                                        <span style="text-overflow: ellipsis;font-size:11px">
                                            <c:choose><c:when test="${deliverable.days>=0}"> ${deliverable.days} days</c:when><c:otherwise>N/A</c:otherwise></c:choose>
                                        </span>
                                    </div>
                                </c:forEach>
                            </div>
                            <hr class="rowSeparator"/>
                            <c:set var="y" value="${y+40}"/>
                        </td>
                    </tr>
                </c:forEach>
            </table>
        </div>
    </div>
</div>

<div style="display:none">
    <c:forEach var="project" items="${this.projects}">
        <div id="ptip-${project.uuid}">
            <div>
                <strong>${project.name}</strong>
            </div>
            <c:if test="${not empty(project.description)}">
                <br/>
                <div>
                        ${project.description}
                </div>
                <br/>
            </c:if>
            <br/>
            <table>
                <tr><td>Start date:&nbsp;&nbsp;&nbsp;</td><td><fmt:formatDate value="${project.startDate}" pattern="yyyy-MM-dd"/></td></tr>
                <tr><td>End date:</td><td><fmt:formatDate value="${project.endDate}" pattern="yyyy-MM-dd"/></td></tr>
            </table>
            <br/>
        </div>
        <c:forEach var="deliverable" items="${project.deliverables}">
            <div id="dtip-${deliverable.uuid}">
                <div>
                    <strong>${project.name}</strong>
                </div>
                <div>
                    <i>${deliverable.name}</i>
                </div>
                <c:if test="${not empty(deliverable.description)}">
                    <br/>
                    <div>
                            ${deliverable.description}
                    </div>
                    <br/>
                </c:if>
                <br/>
                <table>
                    <tr><td>Start date:</td><td><fmt:formatDate value="${deliverable.startDate}" pattern="yyyy-MM-dd"/></td></tr>
                    <tr><td>End date:</td><td><fmt:formatDate value="${deliverable.endDate}" pattern="yyyy-MM-dd"/></td></tr>
                    <tr><td>Prerequisites:&nbsp;&nbsp;</td><td>${deliverable.prequisitiesCount}</td></tr>
                    <tr><td>Deliverables:</td><td>${deliverable.itemCount}</td></tr>
                </table>
                <br/>
            </div>
        </c:forEach>
    </c:forEach>
</div>

<script>

Ext4.onReady(function() {
    <c:forEach var="project" items="${this.projects}">
    Ext4.create('Ext4.tip.ToolTip', {
        target: 'proj.${project.uuid}',
        trackMouse: true,
        contentEl: 'ptip-${project.uuid}',
        cls: 'contentbox-tooltip'
    });
    <c:forEach var="deliverable" items="${project.deliverables}">
    Ext4.create('Ext4.tip.ToolTip', {
        target: 'deliv.${deliverable.uuid}',
        trackMouse: true,
        contentEl: 'dtip-${deliverable.uuid}',
        cls: 'contentbox-tooltip'
    });
    </c:forEach>
    </c:forEach>


    Ext4.regModel('Visualization', {
        fields: [
            {type: 'string', name: 'value'},
            {type: 'string', name: 'name'},
            {type: 'function', name: 'deliverableHighlight'},
            {type: 'function', name: 'projectHighlight'}
        ]
    });

    var inverseText={'#ffe554':true,'#F2AE72':true,'#f76c51':true,'#F0F0F0':true};
    var schemas = {
        finishedDeliverables: {
            green0_25: '#f76c51',
            green25_50: '#ffe554',
            green50_75: '#55DD77',
            green75_100: '#00a276',
            noDeliverables: '#F0F0F0'
        },

        unfinishedPrerequisites: {
            redToGreen0_25: '#8C4646',
            redToGreen25_50: '#f76c51',
            redToGreen50_75: '#F2AE72',
            redToGreen75_99: '#ffe554',
            redToGreen100: '#00a276',
            noPrerequisites: '#F0F0F0'
        },
        health: {
            undefined: '#FFFFFF',
            weak:   '#f76c51',
            medium: '#ffe554',
            strong: '#00a276'
        }};

    var setBackgroundColor=function(e,color) {
        e.animate({to:{backgroundColor:color}});
        if(inverseText[color]) {
            e.addCls('deliverableBlack');
            e.removeCls('deliverableWhite');
        }
        else
        {
            e.addCls('deliverableWhite');
            e.removeCls('deliverableBlack');
        }
    }

    // The data store holding the states
    var store = Ext4.create('Ext4.data.Store', {
        model: 'Visualization',
        data: [
            {
                name : 'Ratio of completed/all deliverables',
                value:'finishedDeliverables',
                deliverableHighlight:function(project,deliverable,element) {
                    var k=deliverable.itemCount-deliverable.prerequisitiesCount;
                    if (k==0)
                    {
                        setBackgroundColor(element,schemas.finishedDeliverables.noDeliverables);
                    }
                    else
                    {
                        var ratio=k==0 ? 1.0: deliverable.finishedDeliverablesCount/k;
                        if(ratio<0.25) { setBackgroundColor(element,schemas.finishedDeliverables.green0_25); return; }
                        if(ratio<0.50) { setBackgroundColor(element,schemas.finishedDeliverables.green25_50); return; }
                        if(ratio<0.75) { setBackgroundColor(element,schemas.finishedDeliverables.green50_75); return; }
                        setBackgroundColor(element,schemas.finishedDeliverables.green75_100);
                    }
                },
                projectHighlight:function(project,element) {
                    setBackgroundColor(element,'#F0F0F0');
                }
            },
            {
                name : 'Ratio of completed/all prerequisites',
                value:'unfinishedPrerequisites',
                deliverableHighlight:function(project,deliverable,element) {
                    var k=deliverable.prerequisitiesCount;
                    if (k==0)
                    {
                        setBackgroundColor(element,schemas.unfinishedPrerequisites.noPrerequisites);
                    }
                    else
                    {
                        var ratio=k==0 ? 1.0: deliverable.finishedPrerequisitiesCount/k;
                        if(ratio<0.25) { setBackgroundColor(element,schemas.unfinishedPrerequisites.redToGreen0_25); return; }
                        if(ratio<0.50) { setBackgroundColor(element,schemas.unfinishedPrerequisites.redToGreen25_50); return; }
                        if(ratio<0.75) { setBackgroundColor(element,schemas.unfinishedPrerequisites.redToGreen50_75); return; }
                        if(ratio<0.99) { setBackgroundColor(element,schemas.unfinishedPrerequisites.redToGreen75_99); return; }
                        setBackgroundColor(element,schemas.unfinishedPrerequisites.redToGreen100);
                    }
                },
                projectHighlight:function(project,element) {
                    setBackgroundColor(element,'#F0F0F0');
                }
            },
            {
                name : 'Project health',
                value:'health',
                deliverableHighlight:function(project,deliverable,element) {
                    if(project.health=='Red') { setBackgroundColor(element,schemas.health.weak); return; }
                    if(project.health=='Yellow') { setBackgroundColor(element,schemas.health.medium); return; }
                    if(project.health=='Green') { setBackgroundColor(element,schemas.health.strong); return; }
                    setBackgroundColor(element,schemas.health.undefined);
                },
                projectHighlight:function(project,element) {
                    if(project.health=='Red') { setBackgroundColor(element,schemas.health.weak); return; }
                    if(project.health=='Yellow') { setBackgroundColor(element,schemas.health.medium); return; }
                    if(project.health=='Green') { setBackgroundColor(element,schemas.health.strong); return; }
                    setBackgroundColor(element,schemas.health.undefined);
                }
            }
        ]
    });

    var data=[
        <c:forEach var="project" items="${this.projects}" varStatus="pstat">
        {
            uuid: '${project.uuid}',
            stage: '${project.stage}',
            health: '${project.health}',
            deliverables: [
                <c:forEach var="deliverable" items="${project.deliverables}" varStatus="dstat">
                {
                    uuid: '${deliverable.uuid}',
                    name: "${deliverable.name}",
                    stage: '${deliverable.stage}',
                    finishedPrerequisitiesCount: ${deliverable.finishedPrerequisitiesCount},
                    prerequisitiesCount: ${deliverable.prequisitiesCount},
                    itemCount: ${deliverable.itemCount},
                    finishedDeliverablesCount: ${deliverable.finishedDeliverablesCount}
                }
                <c:if test="${not(dstat.last)}">,</c:if>
                </c:forEach>
            ]
        }
        <c:if test="${not(pstat.last)}">,</c:if>
        </c:forEach>
    ];
    
    function highlight(projectFn,deliverableFn) {
        for(var i=0;i<data.length;i++) {
            var project=data[i];
            projectFn(project,Ext4.get('proj.'+project.uuid));
            for(var j=0;j<project.deliverables.length;j++)
            {
                var deliverable=project.deliverables[j];
                deliverableFn(project,deliverable,Ext4.get('deliv.'+deliverable.uuid));
            }
        }
    }


    var lastSelection={ value: 'finishedDeliverables' };
    // Simple ComboBox using the data store

    var selectRecord=function(combo, record) {
        Ext4.get(record[0].data.value).setVisibilityMode(Ext4.dom.Element.DISPLAY);
        Ext4.get(lastSelection.value).setVisible(false);
        lastSelection.value=record[0].data.value;
        Ext4.get(record[0].data.value).setVisible(true);
        highlight(record[0].data.projectHighlight,record[0].data.deliverableHighlight);
    };

    var visualizationCombo = Ext4.create('Ext4.form.field.ComboBox', {
        fieldLabel: 'Select color visualization',
        renderTo: 'visualizationSelection',
        displayField: 'name',
        valueField:'value',
        width: 420,
        labelWidth: 170,
        store: store,
        editable:false,
        forceSelection: true,
        queryMode: 'local',
        listeners: {
            select:selectRecord
        }
    });

    Ext4.create('Ext4.button.Button',{
        renderTo:'timeShiftBack',
        iconCls: 'x4-tbar-page-prev',
        disabled: false,
        handler: function() { backward();}
    });

    Ext4.create('Ext4.button.Button',{
        renderTo:'timeShiftForward',
        hint: 'Half a year forward',
        //overflowText: me.prevText,
        iconCls: 'x4-tbar-page-next',
        disabled: false,
        handler: function() { forward(); }
    });

    visualizationCombo.select('finishedDeliverables');
    selectRecord(visualizationCombo,[store.getAt(0)]);
    
    setTimeout(function(){
    	
    	var container = $('div#roadmapContainer');
    	var bodyHeight = $(container).height();
        var portletHeight = Ext4.getCmp('roadmap').getHeight();
        
        if(bodyHeight > portletHeight){
        	//show vertical scrollbar
        	container.css('overflow-x', 'hidden');
        	container.addClass('height-scrollable');
        	container.height(portletHeight-50);
        }
    }, 200);
    
});


</script>


<div>
    <br/>
    <br/>
</div>