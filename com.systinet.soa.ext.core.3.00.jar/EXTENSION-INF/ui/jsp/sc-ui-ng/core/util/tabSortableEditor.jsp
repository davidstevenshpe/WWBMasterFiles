<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<%--
Parameters:
   * listWrapper 
      * object wrapping list of items
      * object defines column components
      * see =com.hp.systinet.sc.ui.util.SortableEditor.SortableEditorData=
   * listEditorListener - events listener; it is possible to register event listener
   * sortable - sortable mode
      * sortable - flat hiearchy
      * nestedSortable -  two level hiearchy
   * selectable - if row is selectable
   * confirmDelete - if confirm box should be shown for deleting items
   * deleteConfirmText - confirm delete window text
   * deleteTitle - confirm delete window title
   * emptyTableTitle - text when table is empty
--%>

<fmt:setBundle basename="com.hp.systinet.sc.ui.util.utilmessages" var="bundle"/>

<c:if test="${empty confirmDelete}">
    <c:set var="confirmDelete" value="false"/>
</c:if>
<c:if test="${empty deleteTitle}">
    <fmt:message var="deleteTitle" key="listEditorHiearchical.deletePopUp.title" bundle="${bundle}"/>
</c:if>

<c:set var="selectedItemId" value="${listWrapper.selectedItemId}"/>


<%--delete tabs - non AJAX, whole page refresh needed --%>
<c:choose>
    <c:when test="${empty affects}">
        <syswf:control mode="script" action="delete" caption="${prefix}_delete"/>
    </c:when>
    <c:otherwise>
        <syswf:control mode="script" action="delete" caption="${prefix}_delete"  affects="." loadingMask="true"/>
    </c:otherwise>
</c:choose>

<syswf:input id="${prefix}_to_delete_id" name="columnId" value="" mode="hidden"/>

<c:if test="${sortable eq 'sortable' or sortable eq 'nestedSortable'}">
<syswf:control mode="script" action="move" caption="${prefix}_move" loadingMask="true"/>
<syswf:input id="${prefix}_to_move_id" name="hash" value="" mode="hidden"/>
</c:if>

<c:if test="${selectable}">
<syswf:control mode="script" action="select" caption="${prefix}_select"/>
<syswf:input id="${prefix}_selected_id" name="selectedId" value="" mode="hidden"/>
</c:if>

<script type="text/javascript">
//<![CDATA[

function ${prefix}_handle_delete(id) {
    var element = Ext.get('${prefix}_to_delete_id');
    element.dom.value = id;
    ${prefix}_delete();        
}

<c:if test="${sortable eq 'sortable' or sortable eq 'nestedSortable'}">
function ${prefix}_handle_move(hash) {
    var element = Ext.get('${prefix}_to_move_id');
    element.dom.value = hash;
    ${prefix}_move();        
}
</c:if>

<c:if test="${selectable}">
function ${prefix}_handle_select(id) {
    var element = Ext.get('${prefix}_selected_id');
    element.dom.value = id;
    ${prefix}_select();        
}
</c:if>

//]]>
</script>

<%-- rendering pop up windows for confirm delete, must be here --%>
<c:forEach items="${listWrapper.list}" var="column" varStatus="columnStatus">
    <script type="text/javascript">
//<![CDATA[

        function ${prefix}_delete_${column.id4Web}() {
            ${prefix}_handle_delete('${column.id}');   
        }
    
//]]>
</script>
                    
    <c:if test="${column.deletable and confirmDelete}">
    <syswf:component name="/core/util/confirmPopUp" prefix="deleteConfirmPopUp_${column.id}">
        <syswf:param name="winOpenFunctionName" value="${prefix}_openDeleteConfirmPopUp_${column.id4Web}" />
        <syswf:param name="winOkAction" value="${prefix}_delete_${column.id4Web}" />
        <syswf:param name="confirmMessage" value="${deleteConfirmText}" />
        <syswf:param name="title" value="${deleteTitle}" />
    </syswf:component>
    </c:if>

    <c:forEach items="${column.items}" var="subColumn" varStatus="subColumnStatus">
        <script type="text/javascript">
//<![CDATA[

            function ${prefix}_delete_${subColumn.id4Web}() {
                ${prefix}_handle_delete('${subColumn.id}');   
            }
        
//]]>
</script>
        
        <c:if test="${column.deletable and confirmDelete}">
        <syswf:component name="/core/util/confirmPopUp" prefix="deleteConfirmPopUp_${subColumn.id}">
            <syswf:param name="winOpenFunctionName" value="${prefix}_openDeleteConfirmPopUp_${subColumn.id4Web}" />
            <syswf:param name="winOkAction" value="${prefix}_delete_${subColumn.id4Web}" />
            <syswf:param name="confirmMessage" value="${deleteConfirmText}" />
            <syswf:param name="title" value="${deleteTitle}" />
        </syswf:component>
        </c:if>
    </c:forEach>
</c:forEach>

<c:choose>
<c:when test="${empty listWrapper or empty listWrapper.list}">
    <c:if test="${empty emptyTableTitle}">
        <fmt:message var="emptyTableTitle" key="listEditorHiearchical.emptyTable" bundle="${bundle}"/>
    </c:if>
    <div class="UI SystemMessage Info">
        <div class="MessageContainer">
            <div class="Text">${emptyTableTitle}</div>
            <div class="x-clear"></div>
        </div>
    </div>
</c:when>

<c:otherwise>
<c:if test="${sortable eq 'nestedSortable'}">
<div id="${prefix}_myAJAXArea" class="com_sortable JQSortableArea JQNested">
    <div class="wrap">
        <ul id="${prefix}_spans-divs" class="page-list">
            <c:if test="${not empty listWrapper.list}">
                <c:forEach items="${listWrapper.list}" var="column" varStatus="columnStatus">
                    
                    <c:choose>
                        <c:when test="${column.deletable and confirmDelete}">
                            <c:set var="funcDelete" value="${prefix}_openDeleteConfirmPopUp_${column.id4Web}"/>
                        </c:when>
                        <c:when test="${column.deletable}">
                            <c:set var="funcDelete" value="${prefix}_delete_${column.id4Web}"/>                    
                        </c:when>
                    </c:choose>
                    
                <li class="JQSortable sort-handle left <c:if test="${selectable and selectedItemId eq column.id}">Selected</c:if>" id="${column.id}">
                    <div class="Item">
                        <syswf:component name="/core/impl/util/tabSortableEditorRow" prefix="row_${column.id}">
                            <syswf:param name="column" value="${column}" />
                            <syswf:param name="listener" value="${listEditorListener}" />
                            <syswf:param name="columnsDescriptions" value="${listWrapper.columns}" />
                            <syswf:param name="hintListener" value="${hintListener}" />
                            <syswf:param name="confirmDelete" value="${confirmDelete}" />
                            <syswf:param name="deleteConfirmText" value="${deleteConfirmText}" />
                            <syswf:param name="deleteTitle" value="${deleteTitle}" />
                            <syswf:param name="funcDelete" value="${funcDelete}" />
                            <syswf:param name="containerId" value="${prefix}_myAJAXArea" />
                        </syswf:component>
                    </div>
                    <c:if test="${not empty column.items}">
                        <ul>
                            <c:forEach items="${column.items}" var="subColumn" varStatus="subColumnStatus">
                                    <c:choose>
                                        <c:when test="${subColumn.deletable and confirmDelete}">
                                            <c:set var="funcDelete" value="${prefix}_openDeleteConfirmPopUp_${subColumn.id4Web}"/>
                                        </c:when>
                                        <c:when test="${subColumn.deletable}">
                                            <c:set var="funcDelete" value="${prefix}_delete_${subColumn.id4Web}"/>                    
                                        </c:when>
                                    </c:choose>
                                <li id="${subColumn.id}" class="JQSortable clear-element sort-handle left <c:if test="${selectable and selectedItemId eq column.id}">Selected</c:if>">
                                    <div class="Item ui-droppable">
                                        <syswf:component name="/core/impl/util/tabSortableEditorRow" prefix="row_${subColumn.id}">
                                            <syswf:param name="column" value="${subColumn}" />
											<syswf:param name="listener" value="${listEditorListener}" />
                                            <syswf:param name="columnsDescriptions" value="${listWrapper.columns}" />
                                            <syswf:param name="hintListener" value="${hintListener}" />
                                            <syswf:param name="confirmDelete" value="${confirmDelete}" />
                                            <syswf:param name="deleteConfirmText" value="${deleteConfirmText}" />
                                            <syswf:param name="deleteTitle" value="${deleteTitle}" />
                                            <syswf:param name="funcDelete" value="${funcDelete}" />
                                            <syswf:param name="containerId" value="${prefix}_myAJAXArea" />
                                        </syswf:component>                                            
                                    </div>
                                </li>
                            </c:forEach>
                        </ul>
                    </c:if>
                </li>
                </c:forEach>
            </c:if>
        </ul>
    </div>
</div>

<script type="text/javascript">
//<![CDATA[

	// Initial variable - this is a CSS selector of the hierarchy root
	var section_sortable_root = '#${prefix}_spans-divs';
	
	// Parses the HTML hierarchy below the root and returns a nested array
	// of objects with following properties:
	//		id: 		HTML ID of the element/node
	//		node:		Reference to the HTML object, containing all its properties
	//		children:	(optional) Array of children (nested nodes within this one)
	//
	// @param	needle	: CSS Selector to look for
	// @param	haystack: CSS Selector of the root to begin searching from
	var sections_sortable_traverseState = function(needle,haystack)
	{
		var raw = $(haystack).find(needle);
		var res = [];
		
		for(var i=0;i<raw.length; i++)
		{
			var item = {};
				item.id = raw[i].id;
				item.node = raw[i];
				item.children = sections_sortable_traverseState('> UL > LI.JQSortable', '#'+raw[i].id);
			res.push(item);
		}
		
		return res;
	};
	
	// Translates array of parsed objects (above) into a HTML encoded string
	// suitable for passing to the server.
	// @param	src			: Array of objects to be flattened
	// @param	masterKey	: String prefix, the output array's name
	var sections_sortable_translateState = function(src,masterKey)
	{
		var res = [];
		for(var i=0; i<src.length;i++)
		{
			res.push(masterKey+'['+i+'][id]='+src[i].id);
			if(src[i].children.length > 0)
			{
				res.push(sections_sortable_translateState(src[i].children,masterKey+'['+i+'][children]'));
			}
		}
		return res.join('&');
	}
	
	// Call the parsing and translation functions in proper order.
	// This function contains the CSS selectors and the final array name required
	var sections_sortable_serializeState = function()
	{
		// We need to traverse from the root and find all first-level LIs
		// Then, loop over them and find their children
		var res = sections_sortable_traverseState('> LI.JQSortable', section_sortable_root);
		var str = sections_sortable_translateState(res,'spans-divs');
		return str;
	};
	
	// This is a key function for retrieving the current state
	// and for eventually going back in history.
	var sections_sortable_history = {
		stack: new Array(),
		temp: null,
		//takes an element and saves it's position in the sections_sortable.
		//note: doesn't commit the save until commit() is called!
		//this is because we might decide to cancel the move
		saveState: function(item) {
			sections_sortable_history.temp = { item: $(item), itemParent: $(item).parent(), itemAfter: $(item).prev() };
		},
		commit: function() {
			if (sections_sortable_history.temp != null) sections_sortable_history.stack.push(sections_sortable_history.temp);
			
			/********************************************************************/
			// IMPORTANT: 	Here we need to retrieve the serialized string of
			// 				all children of this sortable. For the demonstration,
			//				the output is only passed to alert() method.
			/********************************************************************/
			${prefix}_handle_move(sections_sortable_serializeState());
			/********************************************************************/
			// And that's all
			/********************************************************************/
			
		},
		//restores the state of the last moved item.
		restoreState: function() {
			var h = sections_sortable_history.stack.pop();
			if (h == null) return;
			if (h.itemAfter.length > 0) {
				h.itemAfter.after(h.item);
			}
			else {
				h.itemParent.prepend(h.item);
			}
			//checks the classes on the lists
			$(section_sortable_root+' li.sm2_liOpen').not(':has(li)').removeClass('sm2_liOpen');
			$(section_sortable_root+' li:has(ul li):not(.sm2_liClosed)').addClass('sm2_liOpen');
		}
	}

	//init functions
	$(function() {
		$(section_sortable_root+' li').prepend('<div class="dropzone x-hidden"></div>');

		$(section_sortable_root+' DIV.Item, '+section_sortable_root+' .dropzone').droppable({
			accept: section_sortable_root+' li',
			tolerance: 'pointer',
			drop: function(e, ui) {
				var li = $(this).parent();
				var child = !$(this).hasClass('dropzone');
				if (child && li.children('ul').length == 0) {
					li.append('<ul/>');
				}
				if (child) {
					li.addClass('sm2_liOpen').removeClass('sm2_liClosed').children('ul').append(ui.draggable);
				}
				else {
					li.before(ui.draggable);
				}
				$(section_sortable_root+' li.sm2_liOpen').not(':has(li:not(.ui-draggable-dragging))').removeClass('sm2_liOpen');
				li.find('DIV.Item,.dropzone').removeClass('JQSortHelper');
				$(this).filter('.dropzone').removeClass('Active');
				sections_sortable_history.commit();
				if(ui)	{ ui.draggable.css({position:'',opacity:'',zIndex:'',left:'',top:''});}
			},
			over: function() {
				$(this).filter('DIV.Item').addClass('JQSortHelper');
				$(this).filter('.dropzone').addClass('Active');
			},
			out: function() {
				$(this).filter('DIV.Item').removeClass('JQSortHelper');
				$(this).filter('.dropzone').removeClass('Active');
			},
			deactivate: function() {
				//if(ui)	{ ui.draggable.css({position:'',opacity:'',zIndex:'',left:'',top:''});}
			}
		});
		$(section_sortable_root+' li').draggable({
			handle: ' > DIV.Item',
			opacity: .8,
			addClasses: false,
			helper: 'original',
			zIndex: 100,
			start: function(e, ui) {
				sections_sortable_history.saveState(this);
			},
			stop: function(e, ui)	{
				$(this).css({position:'',left:'',top:''});
				$(this).attr({style:''});
			}
		});
		$('.sitemap_undo').click(sections_sortable_history.restoreState);
		$(document).bind('keypress', function(e) {
			if (e.ctrlKey && (e.which == 122 || e.which == 26))
				sections_sortable_history.restoreState();
		});
		$('.sm2_expander').live('click', function() {
			$(this).parent().parent().toggleClass('sm2_liOpen').toggleClass('sm2_liClosed');
			return false;
		});
		$(section_sortable_root+' li DIV.dropzone').removeClass('x-hidden');
	});


//]]>
</script>

</c:if>

<c:if test="${sortable eq 'sortable'}">
<div id="${prefix}_myAJAXArea" class="com_sortable JQSortableArea">    
    <div class="wrap">
        <span id="${prefix}_spans-divs" class="page-list">
            <c:if test="${not empty listWrapper.list}">
                <c:forEach items="${listWrapper.list}" var="column" varStatus="columnStatus">
                    <c:choose>
                        <c:when test="${column.deletable and confirmDelete}">
                            <c:set var="funcDelete" value="${prefix}_openDeleteConfirmPopUp_${column.id4Web}"/>
                        </c:when>
                        <c:when test="${column.deletable}">
                            <c:set var="funcDelete" value="${prefix}_delete_${column.id4Web}"/>                    
                        </c:when>
                    </c:choose>
                <div class="JQSortable clear-element page-item3 sort-handle left <c:if test="${selectable and selectedItemId eq column.id}">Selected</c:if>" id="${column.id}">
                    <div class="Item">
                        <syswf:component name="/core/impl/util/tabSortableEditorRow" prefix="row_${column.id}">
                            <syswf:param name="column" value="${column}" />
							<syswf:param name="listener" value="${listEditorListener}" />
                            <syswf:param name="columnsDescriptions" value="${listWrapper.columns}" />
                            
                            <syswf:param name="confirmDelete" value="${confirmDelete}" />
                            <syswf:param name="deleteConfirmText" value="${deleteConfirmText}" />
                            <syswf:param name="deleteTitle" value="${deleteTitle}" />
                            <syswf:param name="funcDelete" value="${funcDelete}" />
                            <syswf:param name="containerId" value="${prefix}_myAJAXArea" />
                        </syswf:component>
                    </div>
                    <%-- this is only sortable - there are no children handled, nestedSortable should be used for nested sortable
                    <c:if test="${not empty column.items}">
                        <span class="page-list">
                            <c:forEach items="${column.items}" var="subColumn" varStatus="subColumnStatus">
                                    <div class="JQSortable clear-element page-item3 sort-handle left <c:if test="${selectable and selectedItemId eq subColumn.id}">Selected</c:if>" id="${subColumn.id}">
                                        <div class="Item">
                                            <syswf:component name="/core/impl/util/tabSortableEditorRow" prefix="row_${subColumn.id}">
                                                <syswf:param name="column" value="${subColumn}" />
												<syswf:param name="listener" value="${listEditorListener}" />
                                                <syswf:param name="columnsDescriptions" value="${listWrapper.columns}" />
                                                
                                                <syswf:param name="confirmDelete" value="${confirmDelete}" />
                                                <syswf:param name="deleteConfirmText" value="${deleteConfirmText}" />
                                                <syswf:param name="deleteTitle" value="${deleteTitle}" />
                                                <syswf:param name="funcDelete" value="${funcDelete}" />
                                                <syswf:param name="containerId" value="${prefix}_myAJAXArea" />
                                            </syswf:component>                                            
                                        </div>
                                    </div>
                            </c:forEach>
                        </span>
                    </c:if>
                    --%>
                </div>
                </c:forEach>
            </c:if>
        </span>
    </div>
</div>

<script type="text/javascript">
//<![CDATA[

$(document).ready(function(){
    /*$('#${prefix}_spans-divs').SortableDestroy();*/
    /* Initialize simple JQUI Sortable for tabs */
	$('#${prefix}_spans-divs').sortable({
		placeholder: 'JQSortHelper Fixed',
		
		/* Custom function which transforms default "flat-array" response into NestedSortable-like response */
		update: function(event,ui) {
			var serializer = new Array();
			var list = $('#${prefix}_spans-divs').sortable('toArray');
			
			for(var i=0;i<list.length;i++){	serializer.push('spans-divs['+i+'][id]='+list[i]);	}
			serializer = serializer.join('&');
			
			${prefix}_handle_move(serializer);
			//alert(serializer);
		}
	});
});

//]]>
</script>
</c:if>

<c:if test="${selectable}">
<script type="text/javascript">
//<![CDATA[

$(document).ready(function(){
    
    /* SORTABLE ITEMS: ROW SELECTION */
    $('#${prefix}_spans-divs .JQSortable').bind('click',function(){
        $('#${prefix}_spans-divs .JQSortable').removeClass('Selected');
        $(this).addClass('Selected');

        var myID        = $(this).attr('id');
        ${prefix}_handle_select(myID);
    });

    <%--
	// This function stops events beyond the element
	// We do this to stop selection of the row when the tab name is clicked.
	$('#${prefix}_spans-divs .JQSortable .EditableLabel').bind('click',function(){
		return false;
	});
    --%>

	// This function stops events beyond the element
    // this selector stops selecting row when moving
	$('#${prefix}_spans-divs .JQSortable .DragnDrop').bind('click',function(){
		return false;
	});
    
});

//]]>
</script>
</c:if>

</c:otherwise>
</c:choose>