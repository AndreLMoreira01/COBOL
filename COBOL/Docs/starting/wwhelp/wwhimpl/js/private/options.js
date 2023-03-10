// Copyright (c) 2000-2001 Quadralay Corporation.  All rights reserved.
//

function  WWHJavaScriptSettings_Object()
{
  this.mHoverText = new WWHJavaScriptSettings_HoverText_Object();

  this.mTabs   = new WWHJavaScriptSettings_Tabs_Object();
  this.mTOC    = new WWHJavaScriptSettings_TOC_Object();
  this.mIndex  = new WWHJavaScriptSettings_Index_Object();
  this.mSearch = new WWHJavaScriptSettings_Search_Object();
}

function  WWHJavaScriptSettings_HoverText_Object()
{
  this.mbEnabled = true;

  this.mFontStyle = "font-family: Verdana, Arial, Helvetica, sans-serif ; font-size: 10pt";

  this.mWidth = 150;

  this.mForegroundColor = "#000000";
  this.mBackgroundColor = "#FFFFCC";
  this.mBorderColor     = "#999999";
}

function  WWHJavaScriptSettings_Tabs_Object()
{
  this.mFontStyle = "font-family: Verdana, Arial, Helvetica, sans-serif ; font-size: 10pt";

  this.mSelectedTabColor       = "#FFFFFF";
  this.mSelectedTabBorderColor = "#FF0000";
  this.mSelectedTabTextColor   = "#000000";

  this.mDefaultTabColor       = "#CCCCCC";
  this.mDefaultTabBorderColor = "#666666";
  this.mDefaultTabTextColor   = "#000000";
}

function  WWHJavaScriptSettings_TOC_Object()
{
  this.mbShow = true;

  this.mFontStyle = "font-family: Verdana, Arial, Helvetica, sans-serif ; font-size: 10pt";

  this.mEnabledColor  = "#FF0000";
  this.mDisabledColor = "black";

  this.mIndent = 17;
}

function  WWHJavaScriptSettings_Index_Object()
{
  this.mbShow = true;

  this.mFontStyle = "font-family: Verdana, Arial, Helvetica, sans-serif ; font-size: 10pt";

  this.mEnabledColor  = "#FF0000";
  this.mDisabledColor = "black";

  this.mIndent = 17;

  this.mNavigationFontStyle     = "font-family: Verdana, Arial, Helvetica, sans-serif ; font-size: 7pt ; font-weight: bold";
  this.mNavigationCurrentColor  = "black";
  this.mNavigationEnabledColor  = "#FF0000";
  this.mNavigationDisabledColor = "#999999";
}

function  WWHJavaScriptSettings_Index_DisplayOptions(ParamIndexOptions)
{
  ParamIndexOptions.fSetThreshold(50);

  ParamIndexOptions.fSetSeperator(" - ");

  ParamIndexOptions.fGroup("Numerics", false, true, "1234567890");
  ParamIndexOptions.fGroup("", true, true, "ABCDEFGHIJKLMNOPQRSTUVWXYZ");
  ParamIndexOptions.fGroup("Symbols", false, true, "!@#$%^&*(){}[]<>\"|\\.,;-?+");
}

function  WWHJavaScriptSettings_Search_Object()
{
  this.mbShow = true;

  this.mFontStyle = "font-family: Verdana, Arial, Helvetica, sans-serif ; font-size: 10pt";

  this.mEnabledColor  = "#FF0000";
  this.mDisabledColor = "black";

  this.mIndent = 17;

  this.mbShowBook = true;
  this.mbShowRank = true;
}
