all:
	ocamlfind ocamlc -thread -package eliom.server -c byoki.ml

server:
	ocsigenserver -c kowai.conf
