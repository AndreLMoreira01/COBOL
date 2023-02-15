VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "ThreadedWindow"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
'Code for a MultiUse ThreadedWindow class.
Private mMainApp As MainApp
Private mfrm As New frmThreadedWindow
Public Sub Initialize(ByVal ma As MainApp)
   Set mMainApp = ma
   Set mfrm.ThreadedWindow = Me
   mfrm.Caption = mfrm.Caption & " (" & App.ThreadID & ")"
   mfrm.Show
End Sub
Friend Sub Closing()
    Set mfrm = Nothing
End Sub

