DB=enceladus
SCRIPTS=${CURDIR}/scripts
CSV='${CURDIR}/data/master_plan.csv'
BUILD=$(SCRIPTS)/build.sql
MASTER=$(SCRIPTS)/import.sql
NORMALISE=$(SCRIPTS)/normalise.sql

all: normalise
	psql $(DB) -f $(BUILD)

master:
	@cat $(MASTER) >> $(BUILD)

import: master
	@echo "COPY import.master_plan FROM $(CSV) WITH DELIMITER ',' HEADER CSV;" >> $(BUILD)

normalise: import
	@cat $(NORMALISE) >> $(BUILD)

clean:
	@rm -rf $(BUILD)
