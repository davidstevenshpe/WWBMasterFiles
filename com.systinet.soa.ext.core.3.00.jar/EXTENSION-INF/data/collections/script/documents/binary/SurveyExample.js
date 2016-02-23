/*
 *********      SURVEY SAMPLE        ************
 **
 ** Survey STRUCTURE:
 **
 **   predefinitions: type, value
 **   processing: mapping properties of scores
 **   steps: each step will have 1-many questions
 **
 **
 ** Question TYPES:
 **
 **   'single-choice' : radio buttons with default values: { 'Yes' : true, 'No' : false, 'Don\'t know': undefined }
 **   'multi-choices': checkboxes
 **   'textarea': textarea for multi-line text input
 **   'text'
 **   'number'
 **   'taxonomy' : combobox, will update the selected value to mapped property of Artifact base on question[@type = 'taxonomy'].mapping
 **
 ** Question MAPPING:
 **   The answer to a question can be mapped to artifact property value
 **
 ** Question DEPENDENCY (Conditional Questions)
 ** A question can be defined as dependent on other questions as below
 **   doNotAnswerWhen: [{questionID:'id1', values:['false']}, {questionID:'id2', values:['yes']}]
 ** Question dependency is applicable to single-choice and taxonomy questions only
 ** 
 ** Default VALUES:
 **
 **   predefinedType: if question has no type, it will use the default
 **   predefinedValues: predefined option values of default type
 **
 ** SCORES:
 **   question[@type='score']: each question which type is score will have 1-many type of scores: technical score, financial score,...
 **   Each type score, 1 of 4 ways calculation can be set: { 'avg' : average score, 'min' : minimum score, 'max': maximum score, 'first': first answer }
 **   avg is default
 **
 ** COLOR PATTERNS:
 **
 **   Theme: blue(default): #5fa2dd, green: #9cc96b, purple: #986291, orange: #ebaa4b, red: #f76c51, jade green: #4ebcda
 **   Icons: cloud, user, info, home, heart, gift, signal, gear, file, trash, clock-o, road, lock, inbox, flag, tags, list
 ** or all the icons which defined in font awesome. See more:  http://fortawesome.github.io/Font-Awesome/icons/
 */
{
	/*
	   You can custom background/buttons by predefined theme values: 'primary', 'success', 'info', 'mint', 'purple', 'pink', 'dark', 'warning', 'danger'
	*/
 	//theme: 'primary'
	icon: 'cloud',
	predefinedType: 'single-choice',
	predefinedValues: [{
		'true': 'Yes'
	},
	{
		'false': 'No'
	},
	{
		'undefined': 'Don\'t know'
	}],
	processing: {
		scores: [{// declare the scores defined by the questionnaire and map them to properties
			name: 'technicalScore',
			property: 'technicalAlignment'
		},
		{
			name: 'businessScore',
			property: 'businessAlignment'
		},
		{
			name: 'financialScore',
			property: 'financialAlignment'
		}]
	},
	steps: [{
		name: 'Question Sample',
		// define one step in the survey
		description: 'The goal of this survey is to provide an overview of the survey framework capabilities',
		icon: 'info',
		background: '#ebaa4b',
		questions: [{
			question: 'Is storage encrypted ?',
			id: 'storageEncryption',
			type: 'single-choice',
			//if not defined, default value is 'single-choice'
			mapping: {
				type: 'score',
				scores: {
					technicalScore: {
						aggregationOperator: 'avg',
						'true': 50,
						'false': -20,
						'undefined': 0
					},
					businessScore: {// avg is the default
						'true': -20,
						'false': 50,
						'undefined': 0
					},
					financialScore: {// avg is the default
						'true': -10,
						'false': 0,
						'undefined': 0
					}
				}
			}
		},
		{
			question: 'Please enter the recommended memory required to run this application',
			type: 'number',
			id: 'memoryRequired',
			mapping: {
				type: 'property',
				property: 'memoryRequired',
				// number type (integer/float property type)
				aggregationOperator: 'max' // support min/max/avg (for numbers only) and first (value of the first answer)
			}
		},
		{
			question: ' Enter the application type',
			type: 'taxonomy',
			id: 'applicationType',
			// value and  label
			values: [{
				'saas': 'SaaS'
			},{
				'custom': 'Custom'
			},{
				'cots': 'COTS (Commercial Off-The-Shelf)'
			},{
				'composite': 'Composite (Integrated systems)'
			}],
			mapping: {
				type: 'property',
				property: 'applicationType'
				// category property - values defined for this question must be possible to map to the property values
			}
		}]
	},
	{
		name: 'Architecture',
		description: '',
		icon: 'sitemap',
		background: '#f76c51',
		questions: [{
			question: 'Would you like to answer few more questions about enterprise architecture?',
			type: 'single-choice',
			id: 'moreQuestions',
			values: [{
				'true': 'Yes'
			},
			{
				'false': 'No',
				showStopper: true
			}]
		},
		{
			question: 'What are the sub-components of this application component',
			type: 'relationship',
			id: 'subComponents',
			mapping: { 
				relationshipName: 'composedOf',
				label: 'Sub-Components',
				artifactTypes: ['applicationComponentArtifact'],
				tableViewOnly: true,
				readOnly: false,
				deleteOnly: false
			}
		},
		{
			question: 'Please specify the Business Owner for this application component',
			type: 'relationship',
			id: 'businessOwner',
			mapping: { 
				relationshipName: 'providedBy',
				label: 'Business Owner',
				artifactTypes: ['personArtifact'],
				useType: 'businessExpert',
				tableViewOnly: false
			}
		},
		{
			question: 'What are the application services realized by this component',
			type: 'shortcut',
			id: 'realizedAppService',
			mapping: { 
				shortcutId: 'appComponentToAppService',
				label: 'Realized Application Services',
				showLabel: false
			}
		}]
	},
	{
		name: 'Internet',
		description: '',
		icon: 'signal',
		background: '#9cc96b',
		questions: [{
			question: 'Does the application use only standard internet protocols such as HTTP, HTTPS, or FTP?',
			id: 'internet_01'
		},
		{
			question: 'Is the level of performance of standard internet connectivity sufficient for this application?',
			id: 'internet_02',
			doNotAnswerWhen: [{questionID:'internet_01', values:['false']}]
		},
		{
			question: 'Is the level of reliability of standard internet connectivity sufficient for this application?',
			id: 'internet_03'
		},
		{
			question: 'Is the level of security of standard internet connectivity sufficient for this application, such as HTTPS?',
			id: 'internet_04',
			type: 'multi-choices',
			values: [{
				'ftp': 'FTP'
			},
			{
				'http': 'HTTP'
			},
			{
				'https': 'HTTPS'
			}]
		}]
	},
	{
		name: 'Security',
		description: '',
		icon: 'lock',
		questions: [{
			question: 'Does the application use encryption for communication?',
			id: 'security_01'
		},
		{
			question: 'Is the application\'s data in storage encrypted?',
			id: 'security_02'
		},
		{
			question: 'Does your organization have any security policies that restrict a 3rd-party cloud provider from having admin access to the server, storage, or network infrastructure?',
			id: 'security_03'
		},
		{
			question: 'Does your existing security model use proprietary authentication and authorization?',
			id: 'security_04'
		}]
	},
	{
		name: 'Regulatory',
		description: '',
		icon: 'file',
		questions: [{
			question: 'Is the application subject to regulatory requirements (FISMA, HIPAA, ISO 27000, PCI-DSS, etc.)?',
			id: 'regulatory_01'	
		},
		{
			question: 'Is the application required to run on a government certified operating system image? ',
			id: 'regulatory_02'	
		},
		{
			question: 'Are there any regulatory requirements requiring the data to be restricted to a specific geographic region?',
			id: 'regulatory_03'
		},
		{
			question: 'Is the application completely vendor supported in a virtualized environment?',
			id: 'regulatory_04'
		},
		{
			question: 'Is the application required to run on a vendor certified operating system image?',
			id: 'regulatory_05'	
		}]
	},
	{
		name: 'Service Availability',
		description: '',
		icon: 'gear',
		questions: [{
			question: 'What availability service level is required?',
			id: 'service_01'
		},
		{
			question: 'In the event of a failure, does your application support restarting without human intervention? ',
			id: 'service_02',
			values: [{
				'99': '<=99.9%'
			},
			{
				'100': '>99.9%'
			}]
		}]
	},
	{
		name: 'Finish',
		description: 'Thank you for participating in this survey',
		icon: 'check',
		background: '#4ebcda'
	}]
}