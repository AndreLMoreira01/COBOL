VERSION 5.00
Begin VB.Form frmThreadedWindow 
   Caption         =   "frmThreadedWindow"
   ClientHeight    =   3195
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   4680
   LinkTopic       =   "Form1"
   ScaleHeight     =   3195
   ScaleWidth      =   4680
   StartUpPosition =   3  'Windows Default
   Begin VB.CommandButton CallCobol 
      Caption         =   "Call Cobol"
      Height          =   615
      Left            =   1200
      TabIndex        =   0
      Top             =   240
      Width           =   2295
   End
   Begin VB.Label Label1 
      Caption         =   " "
      Height          =   255
      Left            =   2280
      TabIndex        =   9
      Top             =   1680
      Width           =   2175
   End
   Begin VB.Label Label2 
      Height          =   255
      Left            =   2280
      TabIndex        =   8
      Top             =   2040
      Width           =   2175
   End
   Begin VB.Label Label3 
      Height          =   255
      Left            =   2280
      TabIndex        =   7
      Top             =   2400
      Width           =   2175
   End
   Begin VB.Label Label4 
      Height          =   255
      Left            =   2280
      TabIndex        =   6
      Top             =   2760
      Width           =   2175
   End
   Begin VB.Label Label8 
      Caption         =   "Float"
      Height          =   255
      Left            =   240
      TabIndex        =   5
      Top             =   2760
      Width           =   1935
   End
   Begin VB.Label Label7 
      Caption         =   "Long Number"
      Height          =   255
      Left            =   240
      TabIndex        =   4
      Top             =   2400
      Width           =   1935
   End
   Begin VB.Label Label6 
      Caption         =   "String"
      Height          =   255
      Left            =   240
      TabIndex        =   3
      Top             =   2040
      Width           =   1935
   End
   Begin VB.Label Label5 
      Caption         =   "Number"
      Height          =   255
      Left            =   240
      TabIndex        =   2
      Top             =   1680
      Width           =   1935
   End
   Begin VB.Label Label9 
      Caption         =   "Before COBOL Call"
      Height          =   255
      Left            =   1560
      TabIndex        =   1
      Top             =   1200
      Width           =   1575
   End
End
Attribute VB_Name = "frmThreadedWindow"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'Code for the form frmThreadedWindow.
Public ThreadedWindow As ThreadedWindow
Public cblApp As Object
' Cobol test variables
Public testNum As Variant
Public testStr As Variant
Public testLongNum As Variant
Public testfloatNum As Variant

Private Sub CallCobol_Click()
' Dim cblApp As Object
' Set cblApp = CreateObject("AcuGT.Application")
cblApp.Initialize "-le ..\sample\autosrv\project2\acuerr.log -c ..\sample\autosrv\project2\acuvb.cfg"
retVal = cblApp.Call("astest.acu", testNum, testStr, _
        testLongNum, testfloatNum)
Label1.Caption = testNum
Label2.Caption = testStr
Label3.Caption = testLongNum
Label4.Caption = testfloatNum
Label9.Caption = "After Cobol Call"
End Sub


Private Sub Form_Initialize()
' Set initial values
testNum = 123
testStr = "qwertyuiopasdfghjklzxcvbnm"
testLongNum = 1234567890
testfloatNum = 23.4
Label1.Caption = testNum
Label2.Caption = testStr
Label3.Caption = testLongNum
Label4.Caption = testfloatNum
Set cblApp = CreateObject("AcuGT.Application")
'Set cblApp = CreateObject("Acugt.Application", "\\remote_server")
'Set cblApp = CreateObject("Acugt.Application", "192.215.xxx.xxx")
End Sub

Private Sub Form_Unload(Cancel As Integer)
    Call ThreadedWindow.Closing
    Set ThreadedWindow = Nothing
End Sub
