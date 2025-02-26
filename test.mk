@cd $(PROJECT_PATH);
	python3 -m venv $(VENV_NAME);
	source $(VENV_NAME)/bin/activate;
	echo ">> Info: Activated virtual environment: $$VIRTUAL_ENV";
	PIP_LOC_CHECK=$$(which pip);
	if [ $$PIP_LOC_CHECK != "$(PROJECT_PATH)/$(VENV_NAME)/bin/pip" ]; then \
		echo ">> Error: Virtual environment activation failed."; \
		exit 1; \
	fi;

	PYTHON_LOC_CHECK=$$(which python);
	if [ $$PYTHON_LOC_CHECK != "$(PROJECT_PATH)/$(VENV_NAME)/bin/python" ]; then \
		echo ">> Error: Virtual environment activation failed."; \
		exit 1; \
	fi;

	echo ">> Info: pip path: $$(which pip)";
	echo ">> Info: python path: $$(which python)";
	echo ">> pip list:";
	pip list;

	echo ">> Info: Upgrading pip...";
	echo "pip install --upgrade pip";
	pip install --upgrade pip;

	echo ">> Info: Installing build requirements...";
	$(PYCOMMAND_INST_BUILD_REQS);
	echo "=============================================================";
	echo ">> pip list:";
	pip list;

@cd $(PROJECT_PATH);

$(MAKE) venv-help
