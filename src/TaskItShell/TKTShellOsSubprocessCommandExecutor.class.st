Class {
	#name : #TKTShellOsSubprocessCommandExecutor,
	#superclass : #TKTShellCommandExecutor,
	#category : #TaskItShell
}

{ #category : #'as yet unclassified' }
TKTShellOsSubprocessCommandExecutor >> createOSSubprocess: aDeclaration [
	^ (self class environment at: #OSSUnixSubprocess) new
		workingDirectory: aDeclaration workingDirectory;
		command: aDeclaration commandPath;
		arguments: (aDeclaration options , aDeclaration arguments) asArray;
		yourself
]

{ #category : #'as yet unclassified' }
TKTShellOsSubprocessCommandExecutor >> evaluateWithStdoutAsResultOn: aCommandTask with: aTaskExecution with: aDeclaration [
	^ (self createOSSubprocess: aDeclaration)
		redirectStdout;
		redirectStderr;
		runAndWaitOnExitDo: [ :process :outString :errString | 
			process isSuccess
				ifTrue: [ ^ outString ]
				ifFalse: [ Error signal: errString ] ]
]

{ #category : #'as yet unclassified' }
TKTShellOsSubprocessCommandExecutor >> evaluateWithStdoutOnConsoleOn: aCommandTask with: aTaskExecution with: aDeclaration [
	^ (self createOSSubprocess: aDeclaration)
		runAndWaitOnExitDo: [ :process :outString :errString | 
			process isSuccess
				ifTrue: [ ^ outString ]
				ifFalse: [ Error signal: errString ] ]
]
