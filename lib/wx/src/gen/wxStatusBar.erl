%%
%% %CopyrightBegin%
%%
%% Copyright Ericsson AB 2008-2020. All Rights Reserved.
%%
%% Licensed under the Apache License, Version 2.0 (the "License");
%% you may not use this file except in compliance with the License.
%% You may obtain a copy of the License at
%%
%%     http://www.apache.org/licenses/LICENSE-2.0
%%
%% Unless required by applicable law or agreed to in writing, software
%% distributed under the License is distributed on an "AS IS" BASIS,
%% WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
%% See the License for the specific language governing permissions and
%% limitations under the License.
%%
%% %CopyrightEnd%
%% This file is generated DO NOT EDIT

-module(wxStatusBar).
-moduledoc """
Functions for wxStatusBar class

A status bar is a narrow window that can be placed along the bottom of a frame
to give small amounts of status information. It can contain one or more fields,
one or more of which can be variable length according to the size of the window.

`m:wxStatusBar` also maintains an independent stack of status texts for each
field (see `pushStatusText/3` and `popStatusText/2`).

Note that in `m:wxStatusBar` context, the terms `pane` and `field` are synonyms.

Styles

This class supports the following styles:

Remark: It is possible to create controls and other windows on the status bar.
Position these windows from an OnSize() event handler.

Remark: Notice that only the first 127 characters of a string will be shown in
status bar fields under Windows if a proper manifest indicating that the program
uses version 6 of common controls library is not used. This is a limitation of
the native control on these platforms.

See: `wxStatusBarPane` (not implemented in wx), `m:wxFrame`,
[Examples](https://docs.wxwidgets.org/3.1/page_samples.html#page_samples_statbar)

This class is derived (and can use functions) from: `m:wxWindow`
`m:wxEvtHandler`

wxWidgets docs:
[wxStatusBar](https://docs.wxwidgets.org/3.1/classwx_status_bar.html)
""".
-include("wxe.hrl").
-export([create/2,create/3,destroy/1,getFieldRect/2,getFieldsCount/1,getStatusText/1,
  getStatusText/2,new/0,new/1,new/2,popStatusText/1,popStatusText/2,pushStatusText/2,
  pushStatusText/3,setFieldsCount/2,setFieldsCount/3,setMinHeight/2,
  setStatusStyles/2,setStatusText/2,setStatusText/3,setStatusWidths/2]).

%% inherited exports
-export([cacheBestSize/2,canSetTransparent/1,captureMouse/1,center/1,center/2,
  centerOnParent/1,centerOnParent/2,centre/1,centre/2,centreOnParent/1,
  centreOnParent/2,clearBackground/1,clientToScreen/2,clientToScreen/3,
  close/1,close/2,connect/2,connect/3,convertDialogToPixels/2,convertPixelsToDialog/2,
  destroyChildren/1,disable/1,disconnect/1,disconnect/2,disconnect/3,
  dragAcceptFiles/2,enable/1,enable/2,findWindow/2,fit/1,fitInside/1,
  freeze/1,getAcceleratorTable/1,getBackgroundColour/1,getBackgroundStyle/1,
  getBestSize/1,getCaret/1,getCharHeight/1,getCharWidth/1,getChildren/1,
  getClientSize/1,getContainingSizer/1,getContentScaleFactor/1,getCursor/1,
  getDPI/1,getDPIScaleFactor/1,getDropTarget/1,getExtraStyle/1,getFont/1,
  getForegroundColour/1,getGrandParent/1,getHandle/1,getHelpText/1,
  getId/1,getLabel/1,getMaxSize/1,getMinSize/1,getName/1,getParent/1,
  getPosition/1,getRect/1,getScreenPosition/1,getScreenRect/1,getScrollPos/2,
  getScrollRange/2,getScrollThumb/2,getSize/1,getSizer/1,getTextExtent/2,
  getTextExtent/3,getThemeEnabled/1,getToolTip/1,getUpdateRegion/1,
  getVirtualSize/1,getWindowStyleFlag/1,getWindowVariant/1,hasCapture/1,
  hasScrollbar/2,hasTransparentBackground/1,hide/1,inheritAttributes/1,
  initDialog/1,invalidateBestSize/1,isDoubleBuffered/1,isEnabled/1,
  isExposed/2,isExposed/3,isExposed/5,isFrozen/1,isRetained/1,isShown/1,
  isShownOnScreen/1,isTopLevel/1,layout/1,lineDown/1,lineUp/1,lower/1,
  move/2,move/3,move/4,moveAfterInTabOrder/2,moveBeforeInTabOrder/2,
  navigate/1,navigate/2,pageDown/1,pageUp/1,parent_class/1,popupMenu/2,
  popupMenu/3,popupMenu/4,raise/1,refresh/1,refresh/2,refreshRect/2,refreshRect/3,
  releaseMouse/1,removeChild/2,reparent/2,screenToClient/1,screenToClient/2,
  scrollLines/2,scrollPages/2,scrollWindow/3,scrollWindow/4,setAcceleratorTable/2,
  setAutoLayout/2,setBackgroundColour/2,setBackgroundStyle/2,setCaret/2,
  setClientSize/2,setClientSize/3,setContainingSizer/2,setCursor/2,
  setDoubleBuffered/2,setDropTarget/2,setExtraStyle/2,setFocus/1,setFocusFromKbd/1,
  setFont/2,setForegroundColour/2,setHelpText/2,setId/2,setLabel/2,setMaxSize/2,
  setMinSize/2,setName/2,setOwnBackgroundColour/2,setOwnFont/2,setOwnForegroundColour/2,
  setPalette/2,setScrollPos/3,setScrollPos/4,setScrollbar/5,setScrollbar/6,
  setSize/2,setSize/3,setSize/5,setSize/6,setSizeHints/2,setSizeHints/3,
  setSizeHints/4,setSizer/2,setSizer/3,setSizerAndFit/2,setSizerAndFit/3,
  setThemeEnabled/2,setToolTip/2,setTransparent/2,setVirtualSize/2,
  setVirtualSize/3,setWindowStyle/2,setWindowStyleFlag/2,setWindowVariant/2,
  shouldInheritColours/1,show/1,show/2,thaw/1,transferDataFromWindow/1,
  transferDataToWindow/1,update/1,updateWindowUI/1,updateWindowUI/2,
  validate/1,warpPointer/3]).

-type wxStatusBar() :: wx:wx_object().
-export_type([wxStatusBar/0]).
%% @hidden
-doc false.
parent_class(wxWindow) -> true;
parent_class(wxEvtHandler) -> true;
parent_class(_Class) -> erlang:error({badtype, ?MODULE}).

%% @doc See <a href="http://www.wxwidgets.org/manuals/2.8.12/wx_wxstatusbar.html#wxstatusbarwxstatusbar">external documentation</a>.
-doc "Default ctor.".
-spec new() -> wxStatusBar().
new() ->
  wxe_util:queue_cmd(?get_env(), ?wxStatusBar_new_0),
  wxe_util:rec(?wxStatusBar_new_0).

%% @equiv new(Parent, [])
-spec new(Parent) -> wxStatusBar() when
	Parent::wxWindow:wxWindow().

new(Parent)
 when is_record(Parent, wx_ref) ->
  new(Parent, []).

%% @doc See <a href="http://www.wxwidgets.org/manuals/2.8.12/wx_wxstatusbar.html#wxstatusbarwxstatusbar">external documentation</a>.
-doc """
Constructor, creating the window.

See: `create/3`
""".
-spec new(Parent, [Option]) -> wxStatusBar() when
	Parent::wxWindow:wxWindow(),
	Option :: {'winid', integer()}
		 | {'style', integer()}.
new(#wx_ref{type=ParentT}=Parent, Options)
 when is_list(Options) ->
  ?CLASS(ParentT,wxWindow),
  MOpts = fun({winid, _winid} = Arg) -> Arg;
          ({style, _style} = Arg) -> Arg;
          (BadOpt) -> erlang:error({badoption, BadOpt}) end,
  Opts = lists:map(MOpts, Options),
  wxe_util:queue_cmd(Parent, Opts,?get_env(),?wxStatusBar_new_2),
  wxe_util:rec(?wxStatusBar_new_2).

%% @equiv create(This,Parent, [])
-spec create(This, Parent) -> boolean() when
	This::wxStatusBar(), Parent::wxWindow:wxWindow().

create(This,Parent)
 when is_record(This, wx_ref),is_record(Parent, wx_ref) ->
  create(This,Parent, []).

%% @doc See <a href="http://www.wxwidgets.org/manuals/2.8.12/wx_wxstatusbar.html#wxstatusbarcreate">external documentation</a>.
-doc """
Creates the window, for two-step construction.

See `new/2` for details.
""".
-spec create(This, Parent, [Option]) -> boolean() when
	This::wxStatusBar(), Parent::wxWindow:wxWindow(),
	Option :: {'winid', integer()}
		 | {'style', integer()}.
create(#wx_ref{type=ThisT}=This,#wx_ref{type=ParentT}=Parent, Options)
 when is_list(Options) ->
  ?CLASS(ThisT,wxStatusBar),
  ?CLASS(ParentT,wxWindow),
  MOpts = fun({winid, _winid} = Arg) -> Arg;
          ({style, _style} = Arg) -> Arg;
          (BadOpt) -> erlang:error({badoption, BadOpt}) end,
  Opts = lists:map(MOpts, Options),
  wxe_util:queue_cmd(This,Parent, Opts,?get_env(),?wxStatusBar_Create),
  wxe_util:rec(?wxStatusBar_Create).

%% @doc See <a href="http://www.wxwidgets.org/manuals/2.8.12/wx_wxstatusbar.html#wxstatusbargetfieldrect">external documentation</a>.
-doc """
Returns the size and position of a field's internal bounding rectangle.

Return: true if the field index is valid, false otherwise.

See: \{X,Y,W,H\}
""".
-spec getFieldRect(This, I) -> Result when
	Result ::{Res ::boolean(), Rect::{X::integer(), Y::integer(), W::integer(), H::integer()}},
	This::wxStatusBar(), I::integer().
getFieldRect(#wx_ref{type=ThisT}=This,I)
 when is_integer(I) ->
  ?CLASS(ThisT,wxStatusBar),
  wxe_util:queue_cmd(This,I,?get_env(),?wxStatusBar_GetFieldRect),
  wxe_util:rec(?wxStatusBar_GetFieldRect).

%% @doc See <a href="http://www.wxwidgets.org/manuals/2.8.12/wx_wxstatusbar.html#wxstatusbargetfieldscount">external documentation</a>.
-doc "Returns the number of fields in the status bar.".
-spec getFieldsCount(This) -> integer() when
	This::wxStatusBar().
getFieldsCount(#wx_ref{type=ThisT}=This) ->
  ?CLASS(ThisT,wxStatusBar),
  wxe_util:queue_cmd(This,?get_env(),?wxStatusBar_GetFieldsCount),
  wxe_util:rec(?wxStatusBar_GetFieldsCount).

%% @equiv getStatusText(This, [])
-spec getStatusText(This) -> unicode:charlist() when
	This::wxStatusBar().

getStatusText(This)
 when is_record(This, wx_ref) ->
  getStatusText(This, []).

%% @doc See <a href="http://www.wxwidgets.org/manuals/2.8.12/wx_wxstatusbar.html#wxstatusbargetstatustext">external documentation</a>.
-doc """
Returns the string associated with a status bar field.

Return: The status field string if the field is valid, otherwise the empty
string.

See: `setStatusText/3`
""".
-spec getStatusText(This, [Option]) -> unicode:charlist() when
	This::wxStatusBar(),
	Option :: {'number', integer()}.
getStatusText(#wx_ref{type=ThisT}=This, Options)
 when is_list(Options) ->
  ?CLASS(ThisT,wxStatusBar),
  MOpts = fun({number, _number} = Arg) -> Arg;
          (BadOpt) -> erlang:error({badoption, BadOpt}) end,
  Opts = lists:map(MOpts, Options),
  wxe_util:queue_cmd(This, Opts,?get_env(),?wxStatusBar_GetStatusText),
  wxe_util:rec(?wxStatusBar_GetStatusText).

%% @equiv popStatusText(This, [])
-spec popStatusText(This) -> 'ok' when
	This::wxStatusBar().

popStatusText(This)
 when is_record(This, wx_ref) ->
  popStatusText(This, []).

%% @doc See <a href="http://www.wxwidgets.org/manuals/2.8.12/wx_wxstatusbar.html#wxstatusbarpopstatustext">external documentation</a>.
-doc """
Restores the text to the value it had before the last call to
`pushStatusText/3`.

Notice that if `setStatusText/3` had been called in the meanwhile,
`popStatusText/2` will not change the text, i.e. it does not override explicit
changes to status text but only restores the saved text if it hadn't been
changed since.

See: `pushStatusText/3`
""".
-spec popStatusText(This, [Option]) -> 'ok' when
	This::wxStatusBar(),
	Option :: {'number', integer()}.
popStatusText(#wx_ref{type=ThisT}=This, Options)
 when is_list(Options) ->
  ?CLASS(ThisT,wxStatusBar),
  MOpts = fun({number, _number} = Arg) -> Arg;
          (BadOpt) -> erlang:error({badoption, BadOpt}) end,
  Opts = lists:map(MOpts, Options),
  wxe_util:queue_cmd(This, Opts,?get_env(),?wxStatusBar_PopStatusText).

%% @equiv pushStatusText(This,String, [])
-spec pushStatusText(This, String) -> 'ok' when
	This::wxStatusBar(), String::unicode:chardata().

pushStatusText(This,String)
 when is_record(This, wx_ref),?is_chardata(String) ->
  pushStatusText(This,String, []).

%% @doc See <a href="http://www.wxwidgets.org/manuals/2.8.12/wx_wxstatusbar.html#wxstatusbarpushstatustext">external documentation</a>.
-doc """
Saves the current field text in a per-field stack, and sets the field text to
the string passed as argument.

See: `popStatusText/2`
""".
-spec pushStatusText(This, String, [Option]) -> 'ok' when
	This::wxStatusBar(), String::unicode:chardata(),
	Option :: {'number', integer()}.
pushStatusText(#wx_ref{type=ThisT}=This,String, Options)
 when ?is_chardata(String),is_list(Options) ->
  ?CLASS(ThisT,wxStatusBar),
  String_UC = unicode:characters_to_binary(String),
  MOpts = fun({number, _number} = Arg) -> Arg;
          (BadOpt) -> erlang:error({badoption, BadOpt}) end,
  Opts = lists:map(MOpts, Options),
  wxe_util:queue_cmd(This,String_UC, Opts,?get_env(),?wxStatusBar_PushStatusText).

%% @equiv setFieldsCount(This,Number, [])
-spec setFieldsCount(This, Number) -> 'ok' when
	This::wxStatusBar(), Number::integer().

setFieldsCount(This,Number)
 when is_record(This, wx_ref),is_integer(Number) ->
  setFieldsCount(This,Number, []).

%% @doc See <a href="http://www.wxwidgets.org/manuals/2.8.12/wx_wxstatusbar.html#wxstatusbarsetfieldscount">external documentation</a>.
-doc "Sets the number of fields, and optionally the field widths.".
-spec setFieldsCount(This, Number, [Option]) -> 'ok' when
	This::wxStatusBar(), Number::integer(),
	Option :: {'widths', [integer()]}.
setFieldsCount(#wx_ref{type=ThisT}=This,Number, Options)
 when is_integer(Number),is_list(Options) ->
  ?CLASS(ThisT,wxStatusBar),
  MOpts = fun({widths, _widths} = Arg) -> Arg;
          (BadOpt) -> erlang:error({badoption, BadOpt}) end,
  Opts = lists:map(MOpts, Options),
  wxe_util:queue_cmd(This,Number, Opts,?get_env(),?wxStatusBar_SetFieldsCount).

%% @doc See <a href="http://www.wxwidgets.org/manuals/2.8.12/wx_wxstatusbar.html#wxstatusbarsetminheight">external documentation</a>.
-doc """
Sets the minimal possible height for the status bar.

The real height may be bigger than the height specified here depending on the
size of the font used by the status bar.
""".
-spec setMinHeight(This, Height) -> 'ok' when
	This::wxStatusBar(), Height::integer().
setMinHeight(#wx_ref{type=ThisT}=This,Height)
 when is_integer(Height) ->
  ?CLASS(ThisT,wxStatusBar),
  wxe_util:queue_cmd(This,Height,?get_env(),?wxStatusBar_SetMinHeight).

%% @equiv setStatusText(This,Text, [])
-spec setStatusText(This, Text) -> 'ok' when
	This::wxStatusBar(), Text::unicode:chardata().

setStatusText(This,Text)
 when is_record(This, wx_ref),?is_chardata(Text) ->
  setStatusText(This,Text, []).

%% @doc See <a href="http://www.wxwidgets.org/manuals/2.8.12/wx_wxstatusbar.html#wxstatusbarsetstatustext">external documentation</a>.
-doc """
Sets the status text for the `i-th` field.

The given text will replace the current text. The display of the status bar is
updated immediately, so there is no need to call `wxWindow:update/1` after
calling this function.

Note that if `pushStatusText/3` had been called before the new text will also
replace the last saved value to make sure that the next call to
`popStatusText/2` doesn't restore the old value, which was overwritten by the
call to this function.

See: `getStatusText/2`, `wxFrame:setStatusText/3`
""".
-spec setStatusText(This, Text, [Option]) -> 'ok' when
	This::wxStatusBar(), Text::unicode:chardata(),
	Option :: {'number', integer()}.
setStatusText(#wx_ref{type=ThisT}=This,Text, Options)
 when ?is_chardata(Text),is_list(Options) ->
  ?CLASS(ThisT,wxStatusBar),
  Text_UC = unicode:characters_to_binary(Text),
  MOpts = fun({number, _number} = Arg) -> Arg;
          (BadOpt) -> erlang:error({badoption, BadOpt}) end,
  Opts = lists:map(MOpts, Options),
  wxe_util:queue_cmd(This,Text_UC, Opts,?get_env(),?wxStatusBar_SetStatusText).

%% @doc See <a href="http://www.wxwidgets.org/manuals/2.8.12/wx_wxstatusbar.html#wxstatusbarsetstatuswidths">external documentation</a>.
-doc """
Sets the widths of the fields in the status line.

There are two types of fields: `fixed` widths and `variable` width fields. For
the fixed width fields you should specify their (constant) width in pixels. For
the variable width fields, specify a negative number which indicates how the
field should expand: the space left for all variable width fields is divided
between them according to the absolute value of this number. A variable width
field with width of -2 gets twice as much of it as a field with width -1 and so
on.

For example, to create one fixed width field of width 100 in the right part of
the status bar and two more fields which get 66% and 33% of the remaining space
correspondingly, you should use an array containing -2, -1 and 100.

Remark: The widths of the variable fields are calculated from the total width of
all fields, minus the sum of widths of the non-variable fields, divided by the
number of variable fields.

See: `setFieldsCount/3`, `wxFrame:setStatusWidths/2`
""".
-spec setStatusWidths(This, Widths_field) -> 'ok' when
	This::wxStatusBar(), Widths_field::[integer()].
setStatusWidths(#wx_ref{type=ThisT}=This,Widths_field)
 when is_list(Widths_field) ->
  ?CLASS(ThisT,wxStatusBar),
  wxe_util:queue_cmd(This,Widths_field,?get_env(),?wxStatusBar_SetStatusWidths).

%% @doc See <a href="http://www.wxwidgets.org/manuals/2.8.12/wx_wxstatusbar.html#wxstatusbarsetstatusstyles">external documentation</a>.
-doc """
Sets the styles of the fields in the status line which can make fields appear
flat or raised instead of the standard sunken 3D border.
""".
-spec setStatusStyles(This, Styles) -> 'ok' when
	This::wxStatusBar(), Styles::[integer()].
setStatusStyles(#wx_ref{type=ThisT}=This,Styles)
 when is_list(Styles) ->
  ?CLASS(ThisT,wxStatusBar),
  wxe_util:queue_cmd(This,Styles,?get_env(),?wxStatusBar_SetStatusStyles).

%% @doc Destroys this object, do not use object again
-doc "Destructor.".
-spec destroy(This::wxStatusBar()) -> 'ok'.
destroy(Obj=#wx_ref{type=Type}) ->
  ?CLASS(Type,wxStatusBar),
  wxe_util:queue_cmd(Obj, ?get_env(), ?DESTROY_OBJECT),
  ok.
 %% From wxWindow
%% @hidden
-doc false.
getDPI(This) -> wxWindow:getDPI(This).
%% @hidden
-doc false.
getContentScaleFactor(This) -> wxWindow:getContentScaleFactor(This).
%% @hidden
-doc false.
setDoubleBuffered(This,On) -> wxWindow:setDoubleBuffered(This,On).
%% @hidden
-doc false.
isDoubleBuffered(This) -> wxWindow:isDoubleBuffered(This).
%% @hidden
-doc false.
canSetTransparent(This) -> wxWindow:canSetTransparent(This).
%% @hidden
-doc false.
setTransparent(This,Alpha) -> wxWindow:setTransparent(This,Alpha).
%% @hidden
-doc false.
warpPointer(This,X,Y) -> wxWindow:warpPointer(This,X,Y).
%% @hidden
-doc false.
validate(This) -> wxWindow:validate(This).
%% @hidden
-doc false.
updateWindowUI(This, Options) -> wxWindow:updateWindowUI(This, Options).
%% @hidden
-doc false.
updateWindowUI(This) -> wxWindow:updateWindowUI(This).
%% @hidden
-doc false.
update(This) -> wxWindow:update(This).
%% @hidden
-doc false.
transferDataToWindow(This) -> wxWindow:transferDataToWindow(This).
%% @hidden
-doc false.
transferDataFromWindow(This) -> wxWindow:transferDataFromWindow(This).
%% @hidden
-doc false.
thaw(This) -> wxWindow:thaw(This).
%% @hidden
-doc false.
show(This, Options) -> wxWindow:show(This, Options).
%% @hidden
-doc false.
show(This) -> wxWindow:show(This).
%% @hidden
-doc false.
shouldInheritColours(This) -> wxWindow:shouldInheritColours(This).
%% @hidden
-doc false.
setWindowVariant(This,Variant) -> wxWindow:setWindowVariant(This,Variant).
%% @hidden
-doc false.
setWindowStyleFlag(This,Style) -> wxWindow:setWindowStyleFlag(This,Style).
%% @hidden
-doc false.
setWindowStyle(This,Style) -> wxWindow:setWindowStyle(This,Style).
%% @hidden
-doc false.
setVirtualSize(This,Width,Height) -> wxWindow:setVirtualSize(This,Width,Height).
%% @hidden
-doc false.
setVirtualSize(This,Size) -> wxWindow:setVirtualSize(This,Size).
%% @hidden
-doc false.
setToolTip(This,TipString) -> wxWindow:setToolTip(This,TipString).
%% @hidden
-doc false.
setThemeEnabled(This,Enable) -> wxWindow:setThemeEnabled(This,Enable).
%% @hidden
-doc false.
setSizerAndFit(This,Sizer, Options) -> wxWindow:setSizerAndFit(This,Sizer, Options).
%% @hidden
-doc false.
setSizerAndFit(This,Sizer) -> wxWindow:setSizerAndFit(This,Sizer).
%% @hidden
-doc false.
setSizer(This,Sizer, Options) -> wxWindow:setSizer(This,Sizer, Options).
%% @hidden
-doc false.
setSizer(This,Sizer) -> wxWindow:setSizer(This,Sizer).
%% @hidden
-doc false.
setSizeHints(This,MinW,MinH, Options) -> wxWindow:setSizeHints(This,MinW,MinH, Options).
%% @hidden
-doc false.
setSizeHints(This,MinW,MinH) -> wxWindow:setSizeHints(This,MinW,MinH).
%% @hidden
-doc false.
setSizeHints(This,MinSize) -> wxWindow:setSizeHints(This,MinSize).
%% @hidden
-doc false.
setSize(This,X,Y,Width,Height, Options) -> wxWindow:setSize(This,X,Y,Width,Height, Options).
%% @hidden
-doc false.
setSize(This,X,Y,Width,Height) -> wxWindow:setSize(This,X,Y,Width,Height).
%% @hidden
-doc false.
setSize(This,Width,Height) -> wxWindow:setSize(This,Width,Height).
%% @hidden
-doc false.
setSize(This,Rect) -> wxWindow:setSize(This,Rect).
%% @hidden
-doc false.
setScrollPos(This,Orientation,Pos, Options) -> wxWindow:setScrollPos(This,Orientation,Pos, Options).
%% @hidden
-doc false.
setScrollPos(This,Orientation,Pos) -> wxWindow:setScrollPos(This,Orientation,Pos).
%% @hidden
-doc false.
setScrollbar(This,Orientation,Position,ThumbSize,Range, Options) -> wxWindow:setScrollbar(This,Orientation,Position,ThumbSize,Range, Options).
%% @hidden
-doc false.
setScrollbar(This,Orientation,Position,ThumbSize,Range) -> wxWindow:setScrollbar(This,Orientation,Position,ThumbSize,Range).
%% @hidden
-doc false.
setPalette(This,Pal) -> wxWindow:setPalette(This,Pal).
%% @hidden
-doc false.
setName(This,Name) -> wxWindow:setName(This,Name).
%% @hidden
-doc false.
setLabel(This,Label) -> wxWindow:setLabel(This,Label).
%% @hidden
-doc false.
setId(This,Winid) -> wxWindow:setId(This,Winid).
%% @hidden
-doc false.
setHelpText(This,HelpText) -> wxWindow:setHelpText(This,HelpText).
%% @hidden
-doc false.
setForegroundColour(This,Colour) -> wxWindow:setForegroundColour(This,Colour).
%% @hidden
-doc false.
setFont(This,Font) -> wxWindow:setFont(This,Font).
%% @hidden
-doc false.
setFocusFromKbd(This) -> wxWindow:setFocusFromKbd(This).
%% @hidden
-doc false.
setFocus(This) -> wxWindow:setFocus(This).
%% @hidden
-doc false.
setExtraStyle(This,ExStyle) -> wxWindow:setExtraStyle(This,ExStyle).
%% @hidden
-doc false.
setDropTarget(This,Target) -> wxWindow:setDropTarget(This,Target).
%% @hidden
-doc false.
setOwnForegroundColour(This,Colour) -> wxWindow:setOwnForegroundColour(This,Colour).
%% @hidden
-doc false.
setOwnFont(This,Font) -> wxWindow:setOwnFont(This,Font).
%% @hidden
-doc false.
setOwnBackgroundColour(This,Colour) -> wxWindow:setOwnBackgroundColour(This,Colour).
%% @hidden
-doc false.
setMinSize(This,Size) -> wxWindow:setMinSize(This,Size).
%% @hidden
-doc false.
setMaxSize(This,Size) -> wxWindow:setMaxSize(This,Size).
%% @hidden
-doc false.
setCursor(This,Cursor) -> wxWindow:setCursor(This,Cursor).
%% @hidden
-doc false.
setContainingSizer(This,Sizer) -> wxWindow:setContainingSizer(This,Sizer).
%% @hidden
-doc false.
setClientSize(This,Width,Height) -> wxWindow:setClientSize(This,Width,Height).
%% @hidden
-doc false.
setClientSize(This,Size) -> wxWindow:setClientSize(This,Size).
%% @hidden
-doc false.
setCaret(This,Caret) -> wxWindow:setCaret(This,Caret).
%% @hidden
-doc false.
setBackgroundStyle(This,Style) -> wxWindow:setBackgroundStyle(This,Style).
%% @hidden
-doc false.
setBackgroundColour(This,Colour) -> wxWindow:setBackgroundColour(This,Colour).
%% @hidden
-doc false.
setAutoLayout(This,AutoLayout) -> wxWindow:setAutoLayout(This,AutoLayout).
%% @hidden
-doc false.
setAcceleratorTable(This,Accel) -> wxWindow:setAcceleratorTable(This,Accel).
%% @hidden
-doc false.
scrollWindow(This,Dx,Dy, Options) -> wxWindow:scrollWindow(This,Dx,Dy, Options).
%% @hidden
-doc false.
scrollWindow(This,Dx,Dy) -> wxWindow:scrollWindow(This,Dx,Dy).
%% @hidden
-doc false.
scrollPages(This,Pages) -> wxWindow:scrollPages(This,Pages).
%% @hidden
-doc false.
scrollLines(This,Lines) -> wxWindow:scrollLines(This,Lines).
%% @hidden
-doc false.
screenToClient(This,Pt) -> wxWindow:screenToClient(This,Pt).
%% @hidden
-doc false.
screenToClient(This) -> wxWindow:screenToClient(This).
%% @hidden
-doc false.
reparent(This,NewParent) -> wxWindow:reparent(This,NewParent).
%% @hidden
-doc false.
removeChild(This,Child) -> wxWindow:removeChild(This,Child).
%% @hidden
-doc false.
releaseMouse(This) -> wxWindow:releaseMouse(This).
%% @hidden
-doc false.
refreshRect(This,Rect, Options) -> wxWindow:refreshRect(This,Rect, Options).
%% @hidden
-doc false.
refreshRect(This,Rect) -> wxWindow:refreshRect(This,Rect).
%% @hidden
-doc false.
refresh(This, Options) -> wxWindow:refresh(This, Options).
%% @hidden
-doc false.
refresh(This) -> wxWindow:refresh(This).
%% @hidden
-doc false.
raise(This) -> wxWindow:raise(This).
%% @hidden
-doc false.
popupMenu(This,Menu,X,Y) -> wxWindow:popupMenu(This,Menu,X,Y).
%% @hidden
-doc false.
popupMenu(This,Menu, Options) -> wxWindow:popupMenu(This,Menu, Options).
%% @hidden
-doc false.
popupMenu(This,Menu) -> wxWindow:popupMenu(This,Menu).
%% @hidden
-doc false.
pageUp(This) -> wxWindow:pageUp(This).
%% @hidden
-doc false.
pageDown(This) -> wxWindow:pageDown(This).
%% @hidden
-doc false.
navigate(This, Options) -> wxWindow:navigate(This, Options).
%% @hidden
-doc false.
navigate(This) -> wxWindow:navigate(This).
%% @hidden
-doc false.
moveBeforeInTabOrder(This,Win) -> wxWindow:moveBeforeInTabOrder(This,Win).
%% @hidden
-doc false.
moveAfterInTabOrder(This,Win) -> wxWindow:moveAfterInTabOrder(This,Win).
%% @hidden
-doc false.
move(This,X,Y, Options) -> wxWindow:move(This,X,Y, Options).
%% @hidden
-doc false.
move(This,X,Y) -> wxWindow:move(This,X,Y).
%% @hidden
-doc false.
move(This,Pt) -> wxWindow:move(This,Pt).
%% @hidden
-doc false.
lower(This) -> wxWindow:lower(This).
%% @hidden
-doc false.
lineUp(This) -> wxWindow:lineUp(This).
%% @hidden
-doc false.
lineDown(This) -> wxWindow:lineDown(This).
%% @hidden
-doc false.
layout(This) -> wxWindow:layout(This).
%% @hidden
-doc false.
isShownOnScreen(This) -> wxWindow:isShownOnScreen(This).
%% @hidden
-doc false.
isTopLevel(This) -> wxWindow:isTopLevel(This).
%% @hidden
-doc false.
isShown(This) -> wxWindow:isShown(This).
%% @hidden
-doc false.
isRetained(This) -> wxWindow:isRetained(This).
%% @hidden
-doc false.
isExposed(This,X,Y,W,H) -> wxWindow:isExposed(This,X,Y,W,H).
%% @hidden
-doc false.
isExposed(This,X,Y) -> wxWindow:isExposed(This,X,Y).
%% @hidden
-doc false.
isExposed(This,Pt) -> wxWindow:isExposed(This,Pt).
%% @hidden
-doc false.
isEnabled(This) -> wxWindow:isEnabled(This).
%% @hidden
-doc false.
isFrozen(This) -> wxWindow:isFrozen(This).
%% @hidden
-doc false.
invalidateBestSize(This) -> wxWindow:invalidateBestSize(This).
%% @hidden
-doc false.
initDialog(This) -> wxWindow:initDialog(This).
%% @hidden
-doc false.
inheritAttributes(This) -> wxWindow:inheritAttributes(This).
%% @hidden
-doc false.
hide(This) -> wxWindow:hide(This).
%% @hidden
-doc false.
hasTransparentBackground(This) -> wxWindow:hasTransparentBackground(This).
%% @hidden
-doc false.
hasScrollbar(This,Orient) -> wxWindow:hasScrollbar(This,Orient).
%% @hidden
-doc false.
hasCapture(This) -> wxWindow:hasCapture(This).
%% @hidden
-doc false.
getWindowVariant(This) -> wxWindow:getWindowVariant(This).
%% @hidden
-doc false.
getWindowStyleFlag(This) -> wxWindow:getWindowStyleFlag(This).
%% @hidden
-doc false.
getVirtualSize(This) -> wxWindow:getVirtualSize(This).
%% @hidden
-doc false.
getUpdateRegion(This) -> wxWindow:getUpdateRegion(This).
%% @hidden
-doc false.
getToolTip(This) -> wxWindow:getToolTip(This).
%% @hidden
-doc false.
getThemeEnabled(This) -> wxWindow:getThemeEnabled(This).
%% @hidden
-doc false.
getTextExtent(This,String, Options) -> wxWindow:getTextExtent(This,String, Options).
%% @hidden
-doc false.
getTextExtent(This,String) -> wxWindow:getTextExtent(This,String).
%% @hidden
-doc false.
getSizer(This) -> wxWindow:getSizer(This).
%% @hidden
-doc false.
getSize(This) -> wxWindow:getSize(This).
%% @hidden
-doc false.
getScrollThumb(This,Orientation) -> wxWindow:getScrollThumb(This,Orientation).
%% @hidden
-doc false.
getScrollRange(This,Orientation) -> wxWindow:getScrollRange(This,Orientation).
%% @hidden
-doc false.
getScrollPos(This,Orientation) -> wxWindow:getScrollPos(This,Orientation).
%% @hidden
-doc false.
getScreenRect(This) -> wxWindow:getScreenRect(This).
%% @hidden
-doc false.
getScreenPosition(This) -> wxWindow:getScreenPosition(This).
%% @hidden
-doc false.
getRect(This) -> wxWindow:getRect(This).
%% @hidden
-doc false.
getPosition(This) -> wxWindow:getPosition(This).
%% @hidden
-doc false.
getParent(This) -> wxWindow:getParent(This).
%% @hidden
-doc false.
getName(This) -> wxWindow:getName(This).
%% @hidden
-doc false.
getMinSize(This) -> wxWindow:getMinSize(This).
%% @hidden
-doc false.
getMaxSize(This) -> wxWindow:getMaxSize(This).
%% @hidden
-doc false.
getLabel(This) -> wxWindow:getLabel(This).
%% @hidden
-doc false.
getId(This) -> wxWindow:getId(This).
%% @hidden
-doc false.
getHelpText(This) -> wxWindow:getHelpText(This).
%% @hidden
-doc false.
getHandle(This) -> wxWindow:getHandle(This).
%% @hidden
-doc false.
getGrandParent(This) -> wxWindow:getGrandParent(This).
%% @hidden
-doc false.
getForegroundColour(This) -> wxWindow:getForegroundColour(This).
%% @hidden
-doc false.
getFont(This) -> wxWindow:getFont(This).
%% @hidden
-doc false.
getExtraStyle(This) -> wxWindow:getExtraStyle(This).
%% @hidden
-doc false.
getDPIScaleFactor(This) -> wxWindow:getDPIScaleFactor(This).
%% @hidden
-doc false.
getDropTarget(This) -> wxWindow:getDropTarget(This).
%% @hidden
-doc false.
getCursor(This) -> wxWindow:getCursor(This).
%% @hidden
-doc false.
getContainingSizer(This) -> wxWindow:getContainingSizer(This).
%% @hidden
-doc false.
getClientSize(This) -> wxWindow:getClientSize(This).
%% @hidden
-doc false.
getChildren(This) -> wxWindow:getChildren(This).
%% @hidden
-doc false.
getCharWidth(This) -> wxWindow:getCharWidth(This).
%% @hidden
-doc false.
getCharHeight(This) -> wxWindow:getCharHeight(This).
%% @hidden
-doc false.
getCaret(This) -> wxWindow:getCaret(This).
%% @hidden
-doc false.
getBestSize(This) -> wxWindow:getBestSize(This).
%% @hidden
-doc false.
getBackgroundStyle(This) -> wxWindow:getBackgroundStyle(This).
%% @hidden
-doc false.
getBackgroundColour(This) -> wxWindow:getBackgroundColour(This).
%% @hidden
-doc false.
getAcceleratorTable(This) -> wxWindow:getAcceleratorTable(This).
%% @hidden
-doc false.
freeze(This) -> wxWindow:freeze(This).
%% @hidden
-doc false.
fitInside(This) -> wxWindow:fitInside(This).
%% @hidden
-doc false.
fit(This) -> wxWindow:fit(This).
%% @hidden
-doc false.
findWindow(This,Id) -> wxWindow:findWindow(This,Id).
%% @hidden
-doc false.
enable(This, Options) -> wxWindow:enable(This, Options).
%% @hidden
-doc false.
enable(This) -> wxWindow:enable(This).
%% @hidden
-doc false.
dragAcceptFiles(This,Accept) -> wxWindow:dragAcceptFiles(This,Accept).
%% @hidden
-doc false.
disable(This) -> wxWindow:disable(This).
%% @hidden
-doc false.
destroyChildren(This) -> wxWindow:destroyChildren(This).
%% @hidden
-doc false.
convertPixelsToDialog(This,Sz) -> wxWindow:convertPixelsToDialog(This,Sz).
%% @hidden
-doc false.
convertDialogToPixels(This,Sz) -> wxWindow:convertDialogToPixels(This,Sz).
%% @hidden
-doc false.
close(This, Options) -> wxWindow:close(This, Options).
%% @hidden
-doc false.
close(This) -> wxWindow:close(This).
%% @hidden
-doc false.
clientToScreen(This,X,Y) -> wxWindow:clientToScreen(This,X,Y).
%% @hidden
-doc false.
clientToScreen(This,Pt) -> wxWindow:clientToScreen(This,Pt).
%% @hidden
-doc false.
clearBackground(This) -> wxWindow:clearBackground(This).
%% @hidden
-doc false.
centreOnParent(This, Options) -> wxWindow:centreOnParent(This, Options).
%% @hidden
-doc false.
centerOnParent(This, Options) -> wxWindow:centerOnParent(This, Options).
%% @hidden
-doc false.
centreOnParent(This) -> wxWindow:centreOnParent(This).
%% @hidden
-doc false.
centerOnParent(This) -> wxWindow:centerOnParent(This).
%% @hidden
-doc false.
centre(This, Options) -> wxWindow:centre(This, Options).
%% @hidden
-doc false.
center(This, Options) -> wxWindow:center(This, Options).
%% @hidden
-doc false.
centre(This) -> wxWindow:centre(This).
%% @hidden
-doc false.
center(This) -> wxWindow:center(This).
%% @hidden
-doc false.
captureMouse(This) -> wxWindow:captureMouse(This).
%% @hidden
-doc false.
cacheBestSize(This,Size) -> wxWindow:cacheBestSize(This,Size).
 %% From wxEvtHandler
%% @hidden
-doc false.
disconnect(This,EventType, Options) -> wxEvtHandler:disconnect(This,EventType, Options).
%% @hidden
-doc false.
disconnect(This,EventType) -> wxEvtHandler:disconnect(This,EventType).
%% @hidden
-doc false.
disconnect(This) -> wxEvtHandler:disconnect(This).
%% @hidden
-doc false.
connect(This,EventType, Options) -> wxEvtHandler:connect(This,EventType, Options).
%% @hidden
-doc false.
connect(This,EventType) -> wxEvtHandler:connect(This,EventType).
