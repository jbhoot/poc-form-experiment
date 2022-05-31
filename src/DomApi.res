module Document = {
  type t

  @send @return(nullable)
  external getElementById: (t, string) => option<Dom.element> = "getElementById"
}

module AnimationFrame = {
  type requestId
  type domHighResTimeStamp
  type requestCallback = domHighResTimeStamp => unit
}

module Fetch = {
  type method = [
    | #GET
    | #HEAD
    | #POST
    | #PUT
    | #DELETE
    | #CONNECT
    | #OPTIONS
    | #TRACE
    | #PATCH
  ]

  type mode = [
    | #cors
    | #"no-cors"
    | #"same-origin"
  ]

  type credentials = [
    | #omit
    | #"same-origin"
    | #"include"
  ]

  type cache = [
    | #default
    | #"no-store"
    | #reload
    | #"no-cache"
    | #"force-cache"
    | #"only-if-cached"
  ]

  type redirect = [
    | #follow
    | #error
    | #manual
  ]

  type referrerPolicy = [
    | #"no-referrer"
    | #"no-referrer-when-downgrade"
    | #"same-origin"
    | #origin
    | #"strict-origin"
    | #"origin-when-cross-origin"
    | #"strict-origin-when-cross-origin"
    | #"unsafe-url"
  ]

  module Request = {
    type t

    @deriving(abstract)
    type headers = {
      @as("Content-Type") contentType: string,
      @as("Authorization") authorization: string,
    }

    @deriving(abstract)
    type init = {
      method: method,
      @optional headers: headers,
      @optional body: string,
      @optional credentials: credentials,
      @optional cache: cache,
      @optional redirect: redirect,
      @optional referrer: string,
      @optional referrerPolicy: referrerPolicy,
      //    @optional integrity:
    }

    @new external make: (string, init) => t = "Request"
    // TODO: Handle `TypeError` exception
  }

  module Response = {
    type t
    //TODO: @new make

    type statusCode = [
      | #200
      | #401
      | #404
    ]

    @send external json: t => Promise.t<'a> = "json"
    @send external text: t => Promise.t<string> = "json"

    @get external ok: t => bool = "ok"
    @get external status: t => statusCode = "status"
    @get external redirected: t => bool = "redirected"
  }

  @val external fetch: Request.t => Promise.t<Response.t> = "fetch"
}

module Window = {
  type t

  @send
  external requestAnimationFrame: (t, AnimationFrame.requestCallback) => AnimationFrame.requestId =
    "requestAnimationFrame"

  @send
  external cancelAnimationFrame: (t, AnimationFrame.requestId) => unit = "cancelAnimationFrame"
}

@val external document: Document.t = "document"
@val external window: Window.t = "window"