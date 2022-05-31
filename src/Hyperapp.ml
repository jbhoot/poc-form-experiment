type nonrec action
type nonrec effect
type nonrec subscription
type nonrec dispatch = ((action -> unit)[@bs ])
module Action =
  struct
    module NoPayload =
      struct
        external toState : ('s -> 's) -> action = "%identity"
        external toStateWithEffect :
          ('s -> ('s * effect)) -> action = "%identity"
        external toStateWithEffects2 :
          ('s -> ('s * effect * effect)) -> action = "%identity"
        external toStateWithEffects3 :
          ('s -> ('s * effect * effect * effect)) -> action = "%identity"
        external toAction : ('s -> action) -> action = "%identity"
      end
    module WithDomEvent =
      struct
        external toState : ('s -> 'ev -> 's) -> action = "%identity"
        external toStateWithEffect :
          ('s -> 'ev -> ('s * effect)) -> action = "%identity"
        external toStateWithEffects2 :
          ('s -> 'ev -> ('s * effect * effect)) -> action = "%identity"
        external toStateWithEffects3 :
          ('s -> 'ev -> ('s * effect * effect * effect)) -> action =
            "%identity"
        external toAction : ('s -> 'ev -> action) -> action = "%identity"
      end
    module WithPayload =
      struct
        external toState : (('s -> 'p -> 's) * 'p) -> action = "%identity"
        external toStateWithEffect :
          (('s -> 'p -> ('s * effect)) * 'p) -> action = "%identity"
        external toStateWithEffects2 :
          (('s -> 'p -> ('s * effect * effect)) * 'p) -> action = "%identity"
        external toStateWithEffects3 :
          (('s -> 'p -> ('s * effect * effect * effect)) * 'p) -> action =
            "%identity"
        external toAction :
          (('s -> 'p -> action) * 'p) -> action = "%identity"
      end
  end
module Effect =
  struct
    external noPayload : (dispatch -> unit) -> effect = "%identity"
    external withPayload :
      ((dispatch -> 'p -> unit) * 'p) -> effect = "%identity"
    let emptyEffectFn _ = ()
    let makeEmptyEffect () = noPayload emptyEffectFn
  end
module Subscription =
  struct
    type nonrec cleanupFn = ((unit -> unit)[@bs ])
    external noPayload :
      (dispatch -> cleanupFn) -> subscription = "%identity"
    external withPayload :
      ((dispatch -> 'p -> cleanupFn) * 'p) -> subscription = "%identity"
  end
type nonrec vnode
type nonrec 's appArgs =
  {
  init: action ;
  view: 's -> vnode ;
  node: Dom.element ;
  subscriptions: ('s -> subscription option array) option ;
  dispatch: (dispatch -> dispatch) option }
external app : 's appArgs -> dispatch = "app"[@@module
                                               (("hyperapp")
                                                 [@reason.raw_literal
                                                   "hyperapp"])][@@val ]
module H =
  struct
    type nonrec props
    external props :
      ?onchange:((action)[@ns.namedArgLoc ]) -> unit -> props = ""[@@obj ]
    external t : string -> props -> vnode array -> vnode = "h"[@@module
                                                                (("hyperapp")
                                                                  [@reason.raw_literal
                                                                    "hyperapp"])]
    [@@val ]
  end
module Text =
  struct
    external t : string -> vnode = "text"[@@module
                                           (("@hyperapp/html")
                                             [@reason.raw_literal
                                               "@hyperapp/html"])][@@val ]
  end
module Empty =
  struct
    let t = ((fun () -> Text.t (("")[@reason.raw_literal ""]))[@bs ])
  end
module P =
  struct
    type nonrec props
    external p : unit -> props = ""[@@obj ]
    external t : props -> vnode array -> vnode = "p"[@@module
                                                      (("@hyperapp/html")
                                                        [@reason.raw_literal
                                                          "@hyperapp/html"])]
    [@@val ]
  end
module Div =
  struct
    type nonrec props
    external p :
      ?id:((string)[@ns.namedArgLoc ]) ->
        ?class_:((string)[@ns.namedArgLoc ]) -> unit -> props = ""[@@obj ]
    external t : props -> vnode array -> vnode = "div"[@@module
                                                        (("@hyperapp/html")
                                                          [@reason.raw_literal
                                                            "@hyperapp/html"])]
    [@@val ]
  end
module Img =
  struct
    type nonrec props
    external p :
      src:((string)[@ns.namedArgLoc ]) ->
        alt:((string)[@ns.namedArgLoc ]) ->
          ?class_:((string)[@ns.namedArgLoc ]) -> unit -> props = ""[@@obj ]
    external t : props -> vnode = "img"[@@module
                                         (("@hyperapp/html")
                                           [@reason.raw_literal
                                             "@hyperapp/html"])][@@val ]
  end
module Main =
  struct
    type nonrec props
    external p : unit -> props = ""[@@obj ]
    external t : props -> vnode array -> vnode = "main"[@@module
                                                         (("@hyperapp/html")
                                                           [@reason.raw_literal
                                                             "@hyperapp/html"])]
    [@@val ]
  end
module Span =
  struct
    type nonrec props
    external p : unit -> props = ""[@@obj ]
    external t : props -> vnode array -> vnode = "span"[@@module
                                                         (("@hyperapp/html")
                                                           [@reason.raw_literal
                                                             "@hyperapp/html"])]
    [@@val ]
  end
module Input =
  struct
    type nonrec type_ = [ `text  | `radio  | `checkbox ]
    type nonrec p =
      {
      type_: type_ [@as (("type")[@reason.raw_literal "type"])];
      id: string [@optional ];
      value: string [@optional ];
      defaultValue: string [@optional ];
      checked: bool [@optional ];
      onchange: action [@optional ]}[@@deriving abstract]
    external t : p -> vnode = "input"[@@module
                                       (("@hyperapp/html")
                                         [@reason.raw_literal
                                           "@hyperapp/html"])][@@val ]
  end
module Label =
  struct
    type nonrec props
    external p : unit -> props = ""[@@obj ]
    external t : props -> vnode array -> vnode = "label"[@@module
                                                          (("@hyperapp/html")
                                                            [@reason.raw_literal
                                                              "@hyperapp/html"])]
    [@@val ]
  end
module Button =
  struct
    type nonrec type_ = [ `button  | `submit  | `reset ]
    type nonrec p =
      {
      type_: type_ [@as (("type")[@reason.raw_literal "type"])];
      onclick: action [@optional ]}[@@deriving abstract]
    external t : p -> vnode array -> vnode = "button"[@@module
                                                       (("@hyperapp/html")
                                                         [@reason.raw_literal
                                                           "@hyperapp/html"])]
    [@@val ]
  end
module Fieldset =
  struct
    type nonrec props
    external p : unit -> props = ""[@@obj ]
    external t : props -> vnode array -> vnode = "fieldset"[@@module
                                                             (("@hyperapp/html")
                                                               [@reason.raw_literal
                                                                 "@hyperapp/html"])]
    [@@val ]
  end
module Legend =
  struct
    type nonrec props
    external p : unit -> props = ""[@@obj ]
    external t : props -> vnode array -> vnode = "legend"[@@module
                                                           (("@hyperapp/html")
                                                             [@reason.raw_literal
                                                               "@hyperapp/html"])]
    [@@val ]
  end