module Document = {
  type nonrec t;

  [@send] [@return nullable]
  external getElementById: (t, string) => option(Dom.element) =
    "getElementById";
};

module AnimationFrame = {
  type nonrec requestId;
  type nonrec domHighResTimeStamp;
  type nonrec requestCallback = domHighResTimeStamp => unit;
};

module Fetch = {
  type nonrec method = [
    | `GET
    | `HEAD
    | `POST
    | `PUT
    | `DELETE
    | `CONNECT
    | `OPTIONS
    | `TRACE
    | `PATCH
  ];

  type nonrec mode = [ 
    | `cors 
    | `no_cors
    | `same_origin
  ];

  type nonrec credentials = [ | `omit | `same_origin | `include_];

  type nonrec cache = [
    | `default
    | `no_store
    | `reload
    | `no_cache
    | `force_cache
    | `only_if_cached
  ];

  type nonrec redirect = [ | `follow | `error | `manual];

  type nonrec referrerPolicy = [
    | `no_referrer
    | `no_referrer_when_downgrade
    | `same_origin
    | `origin
    | `strict_origin
    | `origin_when_cross_origin
    | `strict_origin_when_cross_origin
    | `unsafe_url
  ];

  module Request = {
    type nonrec t;

    [@deriving abstract]
    type nonrec headers = {
      [@as "Content-Type"]
      contentType: string,
      [@as "Authorization"]
      authorization: string,
    };

    [@deriving abstract]
    type nonrec init = {
      method,
      [@optional]
      headers,
      [@optional]
      body: string,
      [@optional]
      credentials,
      [@optional]
      cache,
      [@optional]
      redirect,
      [@optional]
      referrer: string,
      [@optional]
      referrerPolicy,
      /*    @optional integrity:*/
    };

    [@new] external make: (string, init) => t = "Request";
    /* TODO: Handle `TypeError` exception*/
  };

  module Response = {
    type nonrec t;
    /*TODO: @new make*/

    type nonrec statusCode = [ | `200 | `401 | `404];

    [@send] external json: t => Promise.t('a) = "json";
    [@send] external text: t => Promise.t(string) = "json";

    [@get] external ok: t => bool = "ok";
    [@get] external status: t => statusCode = "status";
    [@get] external redirected: t => bool = "redirected";
  };

  [@val] external fetch: Request.t => Promise.t(Response.t) = "fetch";
};

module Window = {
  type nonrec t;

  [@send]
  external requestAnimationFrame:
    (t, AnimationFrame.requestCallback) => AnimationFrame.requestId =
    "requestAnimationFrame";

  [@send]
  external cancelAnimationFrame: (t, AnimationFrame.requestId) => unit =
    "cancelAnimationFrame";
};

[@val] external document: Document.t = "document";
[@val] external window: Window.t = "window";

