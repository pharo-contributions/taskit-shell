Class {
	#name : #TKTShellCommandExecutor,
	#superclass : #Object,
	#category : #TaskItShell
}

{ #category : #accessing }
TKTShellCommandExecutor class >> default [
	^ TKTShellLibCCommandExecutor new
]

{ #category : #'as yet unclassified' }
TKTShellCommandExecutor >> evaluateOn: aCommandTask with: aTaskExecution with: aDeclaration [
	^ aDeclaration isVerbose
		ifTrue: [ self
				evaluateWithStdoutOnConsoleOn: aCommandTask
				with: aTaskExecution
				with: aDeclaration ]
		ifFalse: [ self
				evaluateWithStdoutAsResultOn: aCommandTask
				with: aTaskExecution
				with: aDeclaration ]
]

{ #category : #'as yet unclassified' }
TKTShellCommandExecutor >> evaluateWithStdoutAsResultOn: aCommandTask with: aTaskExecution with: aDeclaration [
	self subclassResponsibility
]

{ #category : #'as yet unclassified' }
TKTShellCommandExecutor >> evaluateWithStdoutOnConsoleOn: aCommandTask with: aTaskExecution with: aDeclaration [
	self subclassResponsibility 
]
