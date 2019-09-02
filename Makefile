DUNE = dune
BIN_DIR = bin
TEST_DIR = test

all:
	$(DUNE) build
	-rm -f $(BIN_DIR)
	ln -s _build/install/default/bin $(BIN_DIR)

test:
	$(DUNE) runtest $(TEST_DIR)

clean:
	$(DUNE) clean
	-rm -f $(BIN_DIR)
