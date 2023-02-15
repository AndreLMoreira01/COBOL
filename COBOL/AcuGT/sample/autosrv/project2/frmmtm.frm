VERSION 5.00
Begin VB.Form frmMTMain 
   Caption         =   "frmMTMain"
   ClientHeight    =   3195
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   4680
   LinkTopic       =   "Form1"
   ScaleHeight     =   3195
   ScaleWidth      =   4680
   StartUpPosition =   3  'Windows Default
   Begin VB.CommandButton NewThread 
      Caption         =   "New Thread"
      Height          =   615
      Left            =   600
      TabIndex        =   0
      Top             =   480
      Width           =   2055
   End
End
Attribute VB_Name = "frmMTMain"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
' Code for the form frmMTMain.
Public MainApp As MainApp

Private Sub NewThread_Click()
    Set iapt = CreateObject("Thread.ThreadedWindow")
    Call iapt.Initialize(MainApp)
End Sub


Private Sub Form_Unload(Cancel As Integer)
    Call MainApp.Closing
    Set MainApp = Nothing
End Sub

