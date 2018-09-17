DUNE = dune
WAG = wag
WFIND = wfind
WLOCATE = wlocate
BIN_DIR = bin

all:
	$(DUNE) build
	mkdir -p bin
	cp _build/install/default/bin/$(WAG) $(BIN_DIR)/$(WAG)
	cp _build/install/default/bin/$(WFIND) $(BIN_DIR)/$(WFIND)
	cp _build/install/default/bin/$(WLOCATE) $(BIN_DIR)/$(WLOCATE)

test:
	$(DUNE) runtest

clean:
	$(DUNE) clean
	-rm -rf $(BIN_DIR)
