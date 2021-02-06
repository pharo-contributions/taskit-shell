"
This specific kind of task, relies on the task for knwoing what to execute, it executes depending on the installed library for communicating to the OS (osprocess, ossubprocess), and deploying the result on a future as value or error 
"
Class {
	#name : #TKTShellCommandTask,
	#superclass : #TKTTask,
	#instVars : [
		'command'
	],
	#category : #TaskItShell
}

{ #category : #executing }
TKTShellCommandTask >> command [
	^ command ifNil: [ self error: 'Not command setted! ' ]
]

{ #category : #executing }
TKTShellCommandTask >> command: aCommand [ 
	^ command := aCommand
]

{ #category : #private }
TKTShellCommandTask >> evaluateOn: aTaskExecution [
	^ self command evaluateOn: self with: aTaskExecution
]
