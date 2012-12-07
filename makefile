FLEX_HOME	:= $(shell echo $$FLEX_HOME)
SRC			:= $(shell find src -type f -name \*.as -o -type f -name \*.mxml)
CONFIG		=bin/DescribeTyper-app.xml
SWF			=bin/DescribeTyper.swf

.PHONY:		all
all			: $(SWF) $(CONFIG)

$(CONFIG)	: makefile
$(CONFIG) 	: src/DescribeTyper-app.xml
	mkdir -p bin
	sed -e 's|<content>.*</content>|<content>DescribeTyper.swf</content>|g' $< > tempfile && mv tempfile $@;

$(SWF) 		: makefile
$(SWF) 		: $(SRC)
	mkdir -p bin
	mxmlc +configname=air -sp src -debug=true -o $@ -library-path+=libs -- src/DescribeTyper.mxml

.PHONY:		run
run			: all
	cp $(FLEX_HOME)/frameworks/libs/player/11.5/playerglobal.swc bin/global.zip
	cd bin && unzip global.zip
	adl bin/DescribeTyper-app.xml

clean		: 
	rm bin/*

