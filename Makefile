# It technically _is_ a dir, but this works well enough to get its name:
EXTENSION = $(strip $(notdir $(CURDIR)))

SUBEXTENSION = pg_readme_test_extension

DATA = $(wildcard $(EXTENSION)*.sql)

REGRESS = $(EXTENSION)

PG_CONFIG = pg_config
PGXS := $(shell $(PG_CONFIG) --pgxs)
include $(PGXS)

README.md: README.sql install
	psql --quiet postgres < $< > $@

install: install_subextension
install_subextension:
	$(MAKE) -C $(SUBEXTENSION) install
