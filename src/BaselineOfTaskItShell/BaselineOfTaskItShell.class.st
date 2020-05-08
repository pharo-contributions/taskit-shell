Class {
	#name : #BaselineOfTaskItShell,
	#superclass : #BaselineOf,
	#category : #BaselineOfTaskItShell
}

{ #category : #'as yet unclassified' }
BaselineOfTaskItShell >> baseline: spec [
	<baseline>
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
