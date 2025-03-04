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

-module(wxSlider).
-moduledoc """
Functions for wxSlider class

A slider is a control with a handle which can be pulled back and forth to change
the value.

On Windows, the track bar control is used.

On GTK+, tick marks are only available for version 2.16 and later.

Slider generates the same events as `m:wxScrollBar` but in practice the most
convenient way to process `m:wxSlider` updates is by handling the
slider-specific `wxEVT_SLIDER` event which carries `m:wxCommandEvent` containing
just the latest slider position.

Styles

This class supports the following styles:

The difference between EVT_SCROLL_THUMBRELEASE and EVT_SCROLL_CHANGED

The EVT_SCROLL_THUMBRELEASE event is only emitted when actually dragging the
thumb using the mouse and releasing it (This EVT_SCROLL_THUMBRELEASE event is
also followed by an EVT_SCROLL_CHANGED event).

The EVT_SCROLL_CHANGED event also occurs when using the keyboard to change the
thumb position, and when clicking next to the thumb (In all these cases the
EVT_SCROLL_THUMBRELEASE event does not happen). In short, the EVT_SCROLL_CHANGED
event is triggered when scrolling/ moving has finished independently of the way
it had started. Please see the page_samples_widgets ("Slider" page) to see the
difference between EVT_SCROLL_THUMBRELEASE and EVT_SCROLL_CHANGED in action.

See:
[Overview events](https://docs.wxwidgets.org/3.1/overview_events.html#overview_events),
`m:wxScrollBar`

This class is derived (and can use functions) from: `m:wxControl` `m:wxWindow`
`m:wxEvtHandler`

wxWidgets docs: [wxSlider](https://docs.wxwidgets.org/3.1/classwx_slider.html)

## Events

Event types emitted from this class: [`scroll_top`](`m:wxScrollEvent`),
[`scroll_bottom`](`m:wxScrollEvent`), [`scroll_lineup`](`m:wxScrollEvent`),
[`scroll_linedown`](`m:wxScrollEvent`), [`scroll_pageup`](`m:wxScrollEvent`),
[`scroll_pagedown`](`m:wxScrollEvent`),
[`scroll_thumbtrack`](`m:wxScrollEvent`),
[`scroll_thumbrelease`](`m:wxScrollEvent`),
[`scroll_changed`](`m:wxScrollEvent`), [`scroll_top`](`m:wxScrollEvent`),
[`scroll_bottom`](`m:wxScrollEvent`), [`scroll_lineup`](`m:wxScrollEvent`),
[`scroll_linedown`](`m:wxScrollEvent`), [`scroll_pageup`](`m:wxScrollEvent`),
[`scroll_pagedown`](`m:wxScrollEvent`),
[`scroll_thumbtrack`](`m:wxScrollEvent`),
[`scroll_thumbrelease`](`m:wxScrollEvent`),
[`scroll_changed`](`m:wxScrollEvent`),
[`command_slider_updated`](`m:wxCommandEvent`)
""".
-include("wxe.hrl").
-export([create/6,create/7,destroy/1,getLineSize/1,getMax/1,getMin/1,getPageSize/1,
  getThumbLength/1,getValue/1,new/0,new/5,new/6,setLineSize/2,setPageSize/2,
  setRange/3,setThumbLength/2,setValue/2]).

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

-type wxSlider() :: wx:wx_object().
-export_type([wxSlider/0]).
%% @hidden
-doc false.
parent_class(wxControl) -> true;
parent_class(wxWindow) -> true;
parent_class(wxEvtHandler) -> true;
parent_class(_Class) -> erlang:error({badtype, ?MODULE}).

%% @doc See <a href="http://www.wxwidgets.org/manuals/2.8.12/wx_wxslider.html#wxsliderwxslider">external documentation</a>.
-doc "Default constructor.".
-spec new() -> wxSlider().
new() ->
  wxe_util:queue_cmd(?get_env(), ?wxSlider_new_0),
  wxe_util:rec(?wxSlider_new_0).

%% @equiv new(Parent,Id,Value,MinValue,MaxValue, [])
-spec new(Parent, Id, Value, MinValue, MaxValue) -> wxSlider() when
	Parent::wxWindow:wxWindow(), Id::integer(), Value::integer(), MinValue::integer(), MaxValue::integer().

new(Parent,Id,Value,MinValue,MaxValue)
 when is_record(Parent, wx_ref),is_integer(Id),is_integer(Value),is_integer(MinValue),is_integer(MaxValue) ->
  new(Parent,Id,Value,MinValue,MaxValue, []).

%% @doc See <a href="http://www.wxwidgets.org/manuals/2.8.12/wx_wxslider.html#wxsliderwxslider">external documentation</a>.
-doc """
Constructor, creating and showing a slider.

See: `create/7`, `wxValidator` (not implemented in wx)
""".
-spec new(Parent, Id, Value, MinValue, MaxValue, [Option]) -> wxSlider() when
	Parent::wxWindow:wxWindow(), Id::integer(), Value::integer(), MinValue::integer(), MaxValue::integer(),
	Option :: {'pos', {X::integer(), Y::integer()}}
		 | {'size', {W::integer(), H::integer()}}
		 | {'style', integer()}
		 | {'validator', wx:wx_object()}.
new(#wx_ref{type=ParentT}=Parent,Id,Value,MinValue,MaxValue, Options)
 when is_integer(Id),is_integer(Value),is_integer(MinValue),is_integer(MaxValue),is_list(Options) ->
  ?CLASS(ParentT,wxWindow),
  MOpts = fun({pos, {_posX,_posY}} = Arg) -> Arg;
          ({size, {_sizeW,_sizeH}} = Arg) -> Arg;
          ({style, _style} = Arg) -> Arg;
          ({validator, #wx_ref{type=ValidatorT}} = Arg) ->   ?CLASS(ValidatorT,wx),Arg;
          (BadOpt) -> erlang:error({badoption, BadOpt}) end,
  Opts = lists:map(MOpts, Options),
  wxe_util:queue_cmd(Parent,Id,Value,MinValue,MaxValue, Opts,?get_env(),?wxSlider_new_6),
  wxe_util:rec(?wxSlider_new_6).

%% @equiv create(This,Parent,Id,Value,MinValue,MaxValue, [])
-spec create(This, Parent, Id, Value, MinValue, MaxValue) -> boolean() when
	This::wxSlider(), Parent::wxWindow:wxWindow(), Id::integer(), Value::integer(), MinValue::integer(), MaxValue::integer().

create(This,Parent,Id,Value,MinValue,MaxValue)
 when is_record(This, wx_ref),is_record(Parent, wx_ref),is_integer(Id),is_integer(Value),is_integer(MinValue),is_integer(MaxValue) ->
  create(This,Parent,Id,Value,MinValue,MaxValue, []).

%% @doc See <a href="http://www.wxwidgets.org/manuals/2.8.12/wx_wxslider.html#wxslidercreate">external documentation</a>.
-doc """
Used for two-step slider construction.

See `new/6` for further details.
""".
-spec create(This, Parent, Id, Value, MinValue, MaxValue, [Option]) -> boolean() when
	This::wxSlider(), Parent::wxWindow:wxWindow(), Id::integer(), Value::integer(), MinValue::integer(), MaxValue::integer(),
	Option :: {'pos', {X::integer(), Y::integer()}}
		 | {'size', {W::integer(), H::integer()}}
		 | {'style', integer()}
		 | {'validator', wx:wx_object()}.
create(#wx_ref{type=ThisT}=This,#wx_ref{type=ParentT}=Parent,Id,Value,MinValue,MaxValue, Options)
 when is_integer(Id),is_integer(Value),is_integer(MinValue),is_integer(MaxValue),is_list(Options) ->
  ?CLASS(ThisT,wxSlider),
  ?CLASS(ParentT,wxWindow),
  MOpts = fun({pos, {_posX,_posY}} = Arg) -> Arg;
          ({size, {_sizeW,_sizeH}} = Arg) -> Arg;
          ({style, _style} = Arg) -> Arg;
          ({validator, #wx_ref{type=ValidatorT}} = Arg) ->   ?CLASS(ValidatorT,wx),Arg;
          (BadOpt) -> erlang:error({badoption, BadOpt}) end,
  Opts = lists:map(MOpts, Options),
  wxe_util:queue_cmd(This,Parent,Id,Value,MinValue,MaxValue, Opts,?get_env(),?wxSlider_Create),
  wxe_util:rec(?wxSlider_Create).

%% @doc See <a href="http://www.wxwidgets.org/manuals/2.8.12/wx_wxslider.html#wxslidergetlinesize">external documentation</a>.
-doc """
Returns the line size.

See: `setLineSize/2`
""".
-spec getLineSize(This) -> integer() when
	This::wxSlider().
getLineSize(#wx_ref{type=ThisT}=This) ->
  ?CLASS(ThisT,wxSlider),
  wxe_util:queue_cmd(This,?get_env(),?wxSlider_GetLineSize),
  wxe_util:rec(?wxSlider_GetLineSize).

%% @doc See <a href="http://www.wxwidgets.org/manuals/2.8.12/wx_wxslider.html#wxslidergetmax">external documentation</a>.
-doc """
Gets the maximum slider value.

See: `getMin/1`, `setRange/3`
""".
-spec getMax(This) -> integer() when
	This::wxSlider().
getMax(#wx_ref{type=ThisT}=This) ->
  ?CLASS(ThisT,wxSlider),
  wxe_util:queue_cmd(This,?get_env(),?wxSlider_GetMax),
  wxe_util:rec(?wxSlider_GetMax).

%% @doc See <a href="http://www.wxwidgets.org/manuals/2.8.12/wx_wxslider.html#wxslidergetmin">external documentation</a>.
-doc """
Gets the minimum slider value.

See: `getMin/1`, `setRange/3`
""".
-spec getMin(This) -> integer() when
	This::wxSlider().
getMin(#wx_ref{type=ThisT}=This) ->
  ?CLASS(ThisT,wxSlider),
  wxe_util:queue_cmd(This,?get_env(),?wxSlider_GetMin),
  wxe_util:rec(?wxSlider_GetMin).

%% @doc See <a href="http://www.wxwidgets.org/manuals/2.8.12/wx_wxslider.html#wxslidergetpagesize">external documentation</a>.
-doc """
Returns the page size.

See: `setPageSize/2`
""".
-spec getPageSize(This) -> integer() when
	This::wxSlider().
getPageSize(#wx_ref{type=ThisT}=This) ->
  ?CLASS(ThisT,wxSlider),
  wxe_util:queue_cmd(This,?get_env(),?wxSlider_GetPageSize),
  wxe_util:rec(?wxSlider_GetPageSize).

%% @doc See <a href="http://www.wxwidgets.org/manuals/2.8.12/wx_wxslider.html#wxslidergetthumblength">external documentation</a>.
-doc """
Returns the thumb length.

Only for:wxmsw

See: `setThumbLength/2`
""".
-spec getThumbLength(This) -> integer() when
	This::wxSlider().
getThumbLength(#wx_ref{type=ThisT}=This) ->
  ?CLASS(ThisT,wxSlider),
  wxe_util:queue_cmd(This,?get_env(),?wxSlider_GetThumbLength),
  wxe_util:rec(?wxSlider_GetThumbLength).

%% @doc See <a href="http://www.wxwidgets.org/manuals/2.8.12/wx_wxslider.html#wxslidergetvalue">external documentation</a>.
-doc """
Gets the current slider value.

See: `getMin/1`, `getMax/1`, `setValue/2`
""".
-spec getValue(This) -> integer() when
	This::wxSlider().
getValue(#wx_ref{type=ThisT}=This) ->
  ?CLASS(ThisT,wxSlider),
  wxe_util:queue_cmd(This,?get_env(),?wxSlider_GetValue),
  wxe_util:rec(?wxSlider_GetValue).

%% @doc See <a href="http://www.wxwidgets.org/manuals/2.8.12/wx_wxslider.html#wxslidersetlinesize">external documentation</a>.
-doc """
Sets the line size for the slider.

See: `getLineSize/1`
""".
-spec setLineSize(This, LineSize) -> 'ok' when
	This::wxSlider(), LineSize::integer().
setLineSize(#wx_ref{type=ThisT}=This,LineSize)
 when is_integer(LineSize) ->
  ?CLASS(ThisT,wxSlider),
  wxe_util:queue_cmd(This,LineSize,?get_env(),?wxSlider_SetLineSize).

%% @doc See <a href="http://www.wxwidgets.org/manuals/2.8.12/wx_wxslider.html#wxslidersetpagesize">external documentation</a>.
-doc """
Sets the page size for the slider.

See: `getPageSize/1`
""".
-spec setPageSize(This, PageSize) -> 'ok' when
	This::wxSlider(), PageSize::integer().
setPageSize(#wx_ref{type=ThisT}=This,PageSize)
 when is_integer(PageSize) ->
  ?CLASS(ThisT,wxSlider),
  wxe_util:queue_cmd(This,PageSize,?get_env(),?wxSlider_SetPageSize).

%% @doc See <a href="http://www.wxwidgets.org/manuals/2.8.12/wx_wxslider.html#wxslidersetrange">external documentation</a>.
-doc """
Sets the minimum and maximum slider values.

See: `getMin/1`, `getMax/1`
""".
-spec setRange(This, MinValue, MaxValue) -> 'ok' when
	This::wxSlider(), MinValue::integer(), MaxValue::integer().
setRange(#wx_ref{type=ThisT}=This,MinValue,MaxValue)
 when is_integer(MinValue),is_integer(MaxValue) ->
  ?CLASS(ThisT,wxSlider),
  wxe_util:queue_cmd(This,MinValue,MaxValue,?get_env(),?wxSlider_SetRange).

%% @doc See <a href="http://www.wxwidgets.org/manuals/2.8.12/wx_wxslider.html#wxslidersetthumblength">external documentation</a>.
-doc """
Sets the slider thumb length.

Only for:wxmsw

See: `getThumbLength/1`
""".
-spec setThumbLength(This, Len) -> 'ok' when
	This::wxSlider(), Len::integer().
setThumbLength(#wx_ref{type=ThisT}=This,Len)
 when is_integer(Len) ->
  ?CLASS(ThisT,wxSlider),
  wxe_util:queue_cmd(This,Len,?get_env(),?wxSlider_SetThumbLength).

%% @doc See <a href="http://www.wxwidgets.org/manuals/2.8.12/wx_wxslider.html#wxslidersetvalue">external documentation</a>.
-doc "Sets the slider position.".
-spec setValue(This, Value) -> 'ok' when
	This::wxSlider(), Value::integer().
setValue(#wx_ref{type=ThisT}=This,Value)
 when is_integer(Value) ->
  ?CLASS(ThisT,wxSlider),
  wxe_util:queue_cmd(This,Value,?get_env(),?wxSlider_SetValue).

%% @doc Destroys this object, do not use object again
-doc "Destructor, destroying the slider.".
-spec destroy(This::wxSlider()) -> 'ok'.
destroy(Obj=#wx_ref{type=Type}) ->
  ?CLASS(Type,wxSlider),
  wxe_util:queue_cmd(Obj, ?get_env(), ?DESTROY_OBJECT),
  ok.
 %% From wxControl
%% @hidden
-doc false.
setLabel(This,Label) -> wxControl:setLabel(This,Label).
%% @hidden
-doc false.
getLabel(This) -> wxControl:getLabel(This).
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
