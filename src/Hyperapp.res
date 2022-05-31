type action
type effect
type subscription
type dispatch = (. action) => unit

module Action = {
  module NoPayload = {
    external toState: ('s => 's) => action = "%identity"
    external toStateWithEffect: ('s => ('s, effect)) => action = "%identity"
    external toStateWithEffects2: ('s => ('s, effect, effect)) => action = "%identity"
    external toStateWithEffects3: ('s => ('s, effect, effect, effect)) => action = "%identity"
    external toAction: ('s => action) => action = "%identity"
  }

  module WithDomEvent = {
    external toState: (('s, 'ev) => 's) => action = "%identity"
    external toStateWithEffect: (('s, 'ev) => ('s, effect)) => action = "%identity"
    external toStateWithEffects2: (('s, 'ev) => ('s, effect, effect)) => action = "%identity"
    external toStateWithEffects3: (('s, 'ev) => ('s, effect, effect, effect)) => action =
      "%identity"
    external toAction: (('s, 'ev) => action) => action = "%identity"
  }

  module WithPayload = {
    external toState: ((('s, 'p) => 's, 'p)) => action = "%identity"
    external toStateWithEffect: ((('s, 'p) => ('s, effect), 'p)) => action = "%identity"
    external toStateWithEffects2: ((('s, 'p) => ('s, effect, effect), 'p)) => action = "%identity"
    external toStateWithEffects3: ((('s, 'p) => ('s, effect, effect, effect), 'p)) => action =
      "%identity"
    external toAction: ((('s, 'p) => action, 'p)) => action = "%identity"
  }
}

module Effect = {
  external noPayload: (dispatch => unit) => effect = "%identity"
  external withPayload: (((dispatch, 'p) => unit, 'p)) => effect = "%identity"

  let emptyEffectFn = _ => ()
  let makeEmptyEffect = () => noPayload(emptyEffectFn)
}

module Subscription = {
  type cleanupFn = (. unit) => unit
  external noPayload: (dispatch => cleanupFn) => subscription = "%identity"
  external withPayload: (((dispatch, 'p) => cleanupFn, 'p)) => subscription = "%identity"
}

type vnode

// TODO: Test that the activation/deactivation of subscriptions works correctly with option<subscription> style
type appArgs<'s> = {
  init: action,
  view: 's => vnode,
  node: Dom.element,
  subscriptions: option<'s => array<option<subscription>>>,
  dispatch: option<dispatch => dispatch>,
}
@module("hyperapp") @val external app: appArgs<'s> => dispatch = "app"

module H = {
  type props
  @obj external props: (~onchange: action=?, unit) => props = ""
  @module("hyperapp") @val external t: (string, props, array<vnode>) => vnode = "h"
}

module Text = {
  @module("@hyperapp/html") @val external t: string => vnode = "text"
}

module Empty = {
  // h("", {}, []) does not work.
  // It evaluates to document.createElement("", ...),
  // which fails with `String contains an invalid character` due to the empty tag string.
  let t = (. ()) => Text.t("")
}

// @module("@hyperapp/html") @val external a: (props, array<vnode>) => vnode = "a"
// @module("@hyperapp/html") @val external b: (props, array<vnode>) => vnode = "b"
// @module("@hyperapp/html") @val external i: (props, array<vnode>) => vnode = "i"

module P = {
  type props
  @obj external p: unit => props = ""
  @module("@hyperapp/html") @val external t: (props, array<vnode>) => vnode = "p"
}

// @module("@hyperapp/html") @val external q: (props, array<vnode>) => vnode = "q"
// @module("@hyperapp/html") @val external s: (props, array<vnode>) => vnode = "s"
// @module("@hyperapp/html") @val external br: (props, array<vnode>) => vnode = "br"
// @module("@hyperapp/html") @val external dd: (props, array<vnode>) => vnode = "dd"
// @module("@hyperapp/html") @val external dl: (props, array<vnode>) => vnode = "dl"
// @module("@hyperapp/html") @val external dt: (props, array<vnode>) => vnode = "dt"
// @module("@hyperapp/html") @val external em: (props, array<vnode>) => vnode = "em"
// @module("@hyperapp/html") @val external h1: (props, array<vnode>) => vnode = "h1"
// @module("@hyperapp/html") @val external h2: (props, array<vnode>) => vnode = "h2"
// @module("@hyperapp/html") @val external h3: (props, array<vnode>) => vnode = "h3"
// @module("@hyperapp/html") @val external h4: (props, array<vnode>) => vnode = "h4"
// @module("@hyperapp/html") @val external h5: (props, array<vnode>) => vnode = "h5"
// @module("@hyperapp/html") @val external h6: (props, array<vnode>) => vnode = "h6"
// @module("@hyperapp/html") @val external hr: (props, array<vnode>) => vnode = "hr"
// @module("@hyperapp/html") @val external li: (props, array<vnode>) => vnode = "li"
// @module("@hyperapp/html") @val external ol: (props, array<vnode>) => vnode = "ol"
// @module("@hyperapp/html") @val external rp: (props, array<vnode>) => vnode = "rp"
// @module("@hyperapp/html") @val external rt: (props, array<vnode>) => vnode = "rt"
// @module("@hyperapp/html") @val external td: (props, array<vnode>) => vnode = "td"
// @module("@hyperapp/html") @val external th: (props, array<vnode>) => vnode = "th"
// @module("@hyperapp/html") @val external tr: (props, array<vnode>) => vnode = "tr"
// @module("@hyperapp/html") @val external ul: (props, array<vnode>) => vnode = "ul"
// @module("@hyperapp/html") @val external bdi: (props, array<vnode>) => vnode = "bdi"
// @module("@hyperapp/html") @val external bdo: (props, array<vnode>) => vnode = "bdo"
// @module("@hyperapp/html") @val external col: (props, array<vnode>) => vnode = "col"
// @module("@hyperapp/html") @val external del: (props, array<vnode>) => vnode = "del"
// @module("@hyperapp/html") @val external dfn: (props, array<vnode>) => vnode = "dfn"

module Div = {
  type props
  @obj external p: (~id: string=?, ~class: string=?, unit) => props = ""
  @module("@hyperapp/html") @val external t: (props, array<vnode>) => vnode = "div"
}

module Img = {
  type props
  @obj external p: (~src: string, ~alt: string, ~class: string=?, unit) => props = ""
  @module("@hyperapp/html") @val external t: props => vnode = "img"
}

// @module("@hyperapp/html") @val external ins: (props, array<vnode>) => vnode = "ins"
// @module("@hyperapp/html") @val external kbd: (props, array<vnode>) => vnode = "kbd"
// @module("@hyperapp/html") @val external map: (props, array<vnode>) => vnode = "map"
// @module("@hyperapp/html") @val external nav: (props, array<vnode>) => vnode = "nav"
// @module("@hyperapp/html") @val external pre: (props, array<vnode>) => vnode = "pre"
// @module("@hyperapp/html") @val external rtc: (props, array<vnode>) => vnode = "rtc"
// @module("@hyperapp/html") @val external sub: (props, array<vnode>) => vnode = "sub"
// @module("@hyperapp/html") @val external sup: (props, array<vnode>) => vnode = "sup"
// @module("@hyperapp/html") @val external wbr: (props, array<vnode>) => vnode = "wbr"
// @module("@hyperapp/html") @val external abbr: (props, array<vnode>) => vnode = "abbr"
// @module("@hyperapp/html") @val external area: (props, array<vnode>) => vnode = "area"
// @module("@hyperapp/html") @val external cite: (props, array<vnode>) => vnode = "cite"
// @module("@hyperapp/html") @val external code: (props, array<vnode>) => vnode = "code"
// @module("@hyperapp/html") @val external data: (props, array<vnode>) => vnode = "data"
// @module("@hyperapp/html") @val external form: (props, array<vnode>) => vnode = "form"

module Main = {
  type props
  @obj external p: unit => props = ""
  @module("@hyperapp/html") @val external t: (props, array<vnode>) => vnode = "main"
}

// @module("@hyperapp/html") @val external mark: (props, array<vnode>) => vnode = "mark"
// @module("@hyperapp/html") @val external ruby: (props, array<vnode>) => vnode = "ruby"
// @module("@hyperapp/html") @val external samp: (props, array<vnode>) => vnode = "samp"

module Span = {
  type props
  @obj external p: unit => props = ""
  @module("@hyperapp/html") @val external t: (props, array<vnode>) => vnode = "span"
}

// @module("@hyperapp/html") @val external time: (props, array<vnode>) => vnode = "time"
// @module("@hyperapp/html") @val external aside: (props, array<vnode>) => vnode = "aside"
// @module("@hyperapp/html") @val external audio: (props, array<vnode>) => vnode = "audio"

module Input = {
  type type_ = [
    | #text
    | #radio
    | #checkbox
  ]

  @deriving(abstract)
  type p = {
    @as("type") type_: type_,
    @optional id: string,
    @optional value: string,
    @optional defaultValue: string,
    @optional checked: bool,
    @optional onchange: action,
  }

  @module("@hyperapp/html") @val external t: p => vnode = "input"
}

module Label = {
  type props
  @obj external p: unit => props = ""
  @module("@hyperapp/html") @val external t: (props, array<vnode>) => vnode = "label"
}

// @module("@hyperapp/html") @val external meter: (props, array<vnode>) => vnode = "meter"
// @module("@hyperapp/html") @val external param: (props, array<vnode>) => vnode = "param"
// @module("@hyperapp/html") @val external small: (props, array<vnode>) => vnode = "small"
// @module("@hyperapp/html") @val external table: (props, array<vnode>) => vnode = "table"
// @module("@hyperapp/html") @val external tbody: (props, array<vnode>) => vnode = "tbody"
// @module("@hyperapp/html") @val external tfoot: (props, array<vnode>) => vnode = "tfoot"
// @module("@hyperapp/html") @val external thead: (props, array<vnode>) => vnode = "thead"
// @module("@hyperapp/html") @val external track: (props, array<vnode>) => vnode = "track"
// @module("@hyperapp/html") @val external video: (props, array<vnode>) => vnode = "video"
module Button = {
  type type_ = [
    | #button
    | #submit
    | #reset
  ]

  @deriving(abstract)
  type p = {
    @as("type") type_: type_,
    @optional onclick: action,
  }

  @module("@hyperapp/html") @val external t: (p, array<vnode>) => vnode = "button"
}

// @module("@hyperapp/html") @val external canvas: (props, array<vnode>) => vnode = "canvas"
// @module("@hyperapp/html") @val external dialog: (props, array<vnode>) => vnode = "dialog"
// @module("@hyperapp/html") @val external figure: (props, array<vnode>) => vnode = "figure"
// @module("@hyperapp/html") @val external footer: (props, array<vnode>) => vnode = "footer"
// @module("@hyperapp/html") @val external header: (props, array<vnode>) => vnode = "header"
// @module("@hyperapp/html") @val external iframe: (props, array<vnode>) => vnode = "iframe"
// @module("@hyperapp/html") @val external object: (props, array<vnode>) => vnode = "object"
// @module("@hyperapp/html") @val external option: (props, array<vnode>) => vnode = "option"
// @module("@hyperapp/html") @val external output: (props, array<vnode>) => vnode = "output"
// @module("@hyperapp/html") @val external select: (props, array<vnode>) => vnode = "select"
// @module("@hyperapp/html") @val external source: (props, array<vnode>) => vnode = "source"
// @module("@hyperapp/html") @val external strong: (props, array<vnode>) => vnode = "strong"
// @module("@hyperapp/html") @val external address: (props, array<vnode>) => vnode = "address"
// @module("@hyperapp/html") @val external article: (props, array<vnode>) => vnode = "article"
// @module("@hyperapp/html") @val external caption: (props, array<vnode>) => vnode = "caption"
// @module("@hyperapp/html") @val external details: (props, array<vnode>) => vnode = "details"
// @module("@hyperapp/html") @val external section: (props, array<vnode>) => vnode = "section"
// @module("@hyperapp/html") @val external summary: (props, array<vnode>) => vnode = "summary"
// @module("@hyperapp/html") @val external picture: (props, array<vnode>) => vnode = "picture"
// @module("@hyperapp/html") @val external colgroup: (props, array<vnode>) => vnode = "colgroup"
// @module("@hyperapp/html") @val external datalist: (props, array<vnode>) => vnode = "datalist"

module Fieldset = {
  type props

  @obj external p: unit => props = ""

  @module("@hyperapp/html") @val
  external t: (props, array<vnode>) => vnode = "fieldset"
}

module Legend = {
  type props

  @obj external p: unit => props = ""

  @module("@hyperapp/html") @val
  external t: (props, array<vnode>) => vnode = "legend"
}

// @module("@hyperapp/html") @val external menuitem: (props, array<vnode>) => vnode = "menuitem"
// @module("@hyperapp/html") @val external optgroup: (props, array<vnode>) => vnode = "optgroup"
// @module("@hyperapp/html") @val external progress: (props, array<vnode>) => vnode = "progress"
// @module("@hyperapp/html") @val external textarea: (props, array<vnode>) => vnode = "textarea"
// @module("@hyperapp/html") @val external blockquote: (props, array<vnode>) => vnode = "blockquote"
// @module("@hyperapp/html") @val external figcaption: (props, array<vnode>) => vnode = "figcaption"