all:
	ocamlfind ocamlc -thread -package eliom.server -c byoki.ml

server:
	ocsigenserver -c kowai.conf

clean:
	rm *.cmi *.cmo

env:
	mkdir data
	mkdir db
	mkdir log
