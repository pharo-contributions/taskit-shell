Class {
	#name : #TKTShellLibCCommandExecutor,
	#superclass : #TKTShellCommandExecutor,
	#category : #TaskItShell
}

{ #category : #'as yet unclassified' }
TKTShellLibCCommandExecutor >> evaluateWithStdoutAsResultOn: aCommandTask with: aTaskExecution with: aDeclaration [
	| command tempResult tempError extraError errors results rslt |
	tempResult := (aDeclaration hash asString , '.rslt') asFileReference.
	tempError := (aDeclaration hash asString , '.err') asFileReference.
	command := 'cd {1} & {2} {3} {4} 1> "{5}" 2> "{6}"'
		format:
			{aDeclaration workingDirectory fullName.
			aDeclaration command.
			(' ' join: (aDeclaration options ifEmpty: [ {''} ])).
			(' ' join: (aDeclaration arguments ifEmpty: [ {''} ])).
			tempResult fullName.
			tempError fullName}.
	[ rslt := LibC runCommand: command ]
		on: Error
		do: [ :err | extraError := err ].
	results := tempResult readStream upToEnd.
	tempResult ensureDelete.
	errors := tempError readStream upToEnd.
	tempError ensureDelete.
	(rslt == 0 and: [ extraError isNil ])
		ifTrue: [ ^ results ].
	errors := errors , extraError
		ifNil: [ '' ]
		ifNotNil: [ extraError messageText ].
	^ self error: errors
]

{ #category : #'as yet unclassified' }
TKTShellLibCCommandExecutor >> evaluateWithStdoutOnConsoleOn: aCommandTask with: aTaskExecution with: aDeclaration [
	| command rslt |
	command := 'cd {1} & {2} {3} {4} '
		format:
			{aDeclaration workingDirectory fullName.
			aDeclaration command} , (aDeclaration options ifEmpty: [ {''} ])
				, (aDeclaration arguments ifEmpty: [ {''} ]).
	rslt := LibC runCommand: command.
	^ rslt == 0
		ifTrue: [ command ]
		ifFalse: [ self
				error: 'Error executing ' , aDeclaration command , ' Error: ' , rslt asString ]
]
