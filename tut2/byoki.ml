open Lwt
open Eliom_pervasives
open HTML5.M
open Eliom_services
open Eliom_parameters
open Eliom_output.Html5

let main_service =
  register_service ~path:["index"] ~get_params:unit
    (fun () () ->
	 (*lwt cf = comment_box () in *)
	 return (html (head (title (pcdata "")) [])
                               (body [h1 [pcdata "Hello work!"]])))
let comment_service =
  Eliom_services.post_service
    ~fallback:main_service
    ~post_params:(string "name" ** string "comment" ** string "submit")
    ()

let comment_page = Eliom_output.Html5.register
    ~service:comment_service
    (fun () (name, (comment, _)) ->
      let message = name ^ ": " ^ comment
      in
      Lwt.return
        (html (head (title (pcdata "")) [])
              (body [h1 [pcdata message]])));
