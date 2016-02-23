/* ******************************************************* */
/* ******************************************************* */
/*  The script creates Rating Report.                      */
/* ******************************************************* */
/* ******************************************************  */
/* ******************************************************* */

Ext4.define('EA.scripts.RatingReport', {
    extend: 'EA.portlets.CustomReport',
    config: {
        name: 'Application Components Rating Statistics',
        id: 'applicationArtifactRatingReport',
        artifactType: 'applicationComponentArtifact'
    },
    bodyStyle: 'padding:0 8px;',
    initComponent: function () {
        this.callParent(arguments);
        this.update('<div id="' + this.id + '-table"></div>');
        var self = this;

        $.ajax({
            dataType: 'text',
            url: SERVER_URI + '/../../../remote/execute/scripts/RatingData.js',
            data: {
                artifactType: self.config.artifactType
            },
            success: function (response) {
                // At this time, there is an enter character in responded data
                // so the JSON parse will throw exception
                // temporary fix: use eval to convert data to JSON object
                // but this not a best practice, consider refactor later
                response = eval('(' + response + ')');
                self.buildDataListingTable({
                    data: response.data,
                    name: self.config.name,
                    columns: [{
                        dataIndex: 'rating',
                        header: 'Rating',
                        type: 'int',
                        flex: 1,
                        minWidth: 200,
                        renderer: function (value) {
                            var stars = '',
                                star = '<div class="ui-stars-star ui-stars-star-on"><a title="" style="background-color:transparent">1</a></div>';
                            for (var i = 0; i < value; i++) {
                                stars += star;
                            }
                            return value <= 0 ? 'Not rated' : stars;
                        }
                    }, {
                        dataIndex: 'count',
                        header: 'Number of Rated Artifacts',
                        flex: 1,
                        type: 'int'
                    }, {
                        dataIndex: 'shared',
                        header: 'Share',
                        flex: 1,
                        type: 'string'
                    }, {
                        dataIndex: 'voters',
                        header: 'Number of Votes',
                        flex: 1,
                        type: 'int'
                    }],
                    description: '<br/>' +
                        'Rating: Rating level (0-5 stars)<br/>' +
                        'Number of Rated Artifacts: Number of artifacts with specified average rating<br/>' +
                        'Share: (Number of artifacts with rating)/(Total number of artifacts)*100<br/>' +
                        'Number of Votes: Number of users who gave the rating',
                    renderTo: self.id + '-table'
                });
            }
        });
    }
})