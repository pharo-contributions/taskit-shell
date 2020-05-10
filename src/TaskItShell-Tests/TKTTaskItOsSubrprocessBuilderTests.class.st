Class {
	#name : #TKTTaskItOsSubrprocessBuilderTests,
	#superclass : #TKTTestCase,
	#category : #'TaskItShell-Tests'
}

{ #category : #'as yet unclassified' }
TKTTaskItOsSubrprocessBuilderTests >> testTaskBlockShouldReturnACommandDeclarationOrFail [
	" command: aSymbol options: anArrayOfOptions arguments: anArrayArguments"

	| future worker |
	worker := TKTWorker new.
	worker exceptionHandler: TKTTestExceptionHandler new.
	worker start.
	self
		should: [ future := [ :spec | self ] asOSTask future: worker ]
		raise: Error
]

{ #category : #'as yet unclassified' }
TKTTaskItOsSubrprocessBuilderTests >> testTaskExecutionReturnsStdOutputAsResult [
	" command: aSymbol options: anArrayOfOptions arguments: anArrayArguments"

	| future value expected  |
	future := (OSPlatform current name = #Win32
		ifTrue: [ 
			expected := #Users.
			#dir command
			   option: '/b';
				argument: 'C:\';
				yourself 
		] ifFalse: [ 
			expected := #home.
			#ls command
				argument: '/';
				yourself ])
		redirectStdoutAsResult;
		future.
	
	value := (future synchronizeTimeout: 1 second) lines.
	self
		assert: value size > 1
		description: ' expected at least one line as result of LS '.
	self
		assert: (value includes: expected)
		description: ' ls in / in unix based system should include home '
]
