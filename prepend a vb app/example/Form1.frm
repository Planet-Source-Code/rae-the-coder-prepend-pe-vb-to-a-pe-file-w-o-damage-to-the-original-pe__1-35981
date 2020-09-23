VERSION 5.00
Begin VB.Form Form1 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "example.exe"
   ClientHeight    =   4110
   ClientLeft      =   45
   ClientTop       =   435
   ClientWidth     =   5880
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   4110
   ScaleWidth      =   5880
   ShowInTaskbar   =   0   'False
   StartUpPosition =   3  'Windows Default
   Begin VB.OptionButton Option1 
      Caption         =   "blah"
      Height          =   375
      Left            =   120
      TabIndex        =   5
      Top             =   1920
      Width           =   1575
   End
   Begin VB.CommandButton Command1 
      Caption         =   "you get the point"
      Height          =   495
      Left            =   4200
      TabIndex        =   4
      Top             =   1800
      Width           =   1455
   End
   Begin VB.ComboBox Combo1 
      Height          =   315
      ItemData        =   "Form1.frx":0000
      Left            =   600
      List            =   "Form1.frx":0079
      TabIndex        =   3
      Text            =   "random data here"
      Top             =   3240
      Width           =   2175
   End
   Begin VB.ListBox List1 
      Height          =   1425
      ItemData        =   "Form1.frx":033B
      Left            =   1920
      List            =   "Form1.frx":0393
      TabIndex        =   2
      Top             =   1800
      Width           =   2175
   End
   Begin VB.TextBox Text1 
      Height          =   285
      Left            =   240
      TabIndex        =   0
      Text            =   "Everything is prefectly intact"
      Top             =   240
      Width           =   3135
   End
   Begin VB.Label Label1 
      Caption         =   "this exe should be working fine, no errors.."
      Height          =   375
      Left            =   1320
      TabIndex        =   1
      Top             =   1200
      Width           =   3615
   End
   Begin VB.Image Image1 
      Height          =   4500
      Left            =   0
      Picture         =   "Form1.frx":0580
      Top             =   0
      Width           =   6000
   End
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub Form_Load()
MsgBox "My shell command was: " & Command
Me.Caption = Command
End Sub

