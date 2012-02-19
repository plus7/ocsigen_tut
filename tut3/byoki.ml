open Lwt
open Eliom_pervasives
open HTML5.M
open Eliom_services
open Eliom_parameters
open Eliom_output.Html5

let main_service =
  register_service ~path:["index"] ~get_params:unit
    (fun () () ->
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
      let message = name ^ "さんのコメント: " ^ comment
      in
      Lwt.return
        (html (head (title (pcdata "")) [])
              (body [p [pcdata message]])))

let comment_form = 
  register_service ~path:["form"] ~get_params:unit
  (fun () () ->
       let f =
       (Eliom_output.Html5.post_form comment_service
				     (fun (name, (comment, submit)) ->
					  [p [pcdata "name: ";
					  string_input ~input_type:`Text ~name:name ();
					  pcdata "comment: ";
					  string_input ~input_type:`Text ~name:comment ();
					  string_input ~input_type:`Submit ~name:submit ~value:"Post" ()]]) ()) in
     Lwt.return
       (html
         (head (title (pcdata "")) [])
         (body [f])))