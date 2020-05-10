Class {
	#name : #BaselineOfTaskItShell,
	#superclass : #BaselineOf,
	#category : #BaselineOfTaskItShell
}

{ #category : #'as yet unclassified' }
BaselineOfTaskItShell >> baseline: spec [
	<baseline>
	OSPlatform current name = #Win32
		ifTrue: [ self baselineWin32: spec ]
		ifFalse: [ self commonBaseline: spec ]
]

{ #category : #'as yet unclassified' }
BaselineOfTaskItShell >> baselineWin32: spec [
	spec
		for: #common
		do: [ spec
				baseline: #TaskIt
					with: [ spec repository: 'github://pharo-contributions/taskit' ];
				package: #TaskItShell with: [ spec requires: #('TaskIt') ];
				package: #'TaskItShell-Tests'
					with: [ spec requires: #('TaskItShell') ].
			spec group: 'minimal' with: #(#TaskItShell) ]
]

{ #category : #'as yet unclassified' }
BaselineOfTaskItShell >> commonBaseline: spec [
	spec
		for: #common
		do: [ spec
				baseline: #TaskIt
					with: [ spec repository: 'github://pharo-contributions/taskit' ];
				baseline: #OSSubprocess
					with: [ spec
						repository: 'github://pharo-contributions/OSSubprocess:master/repository' ];
				package: #TaskItShell
					with: [ spec requires: #('TaskIt' 'OSSubprocess') ];
				package: #'TaskItShell-Tests'
					with: [ spec requires: #('TaskItShell') ].
			spec group: 'minimal' with: #(#TaskItShell) ]
]
