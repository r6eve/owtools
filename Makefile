DUNE = dune
WAG = wag
WFIND = wfind
BIN_DIR = bin

all:
	$(DUNE) build
	mkdir -p bin
	cp _build/install/default/bin/$(WAG) $(BIN_DIR)/$(WAG)
	cp _build/install/default/bin/$(WFIND) $(BIN_DIR)/$(WFIND)

clean:
	$(DUNE) clean
	-rm -rf $(BIN_DIR)
