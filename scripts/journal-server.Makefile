# SPDX-License-Identifier: copyleft-next-0.3.1

ifeq (y,$(CONFIG_DEVCONFIG_ENABLE_SYSTEMD_JOURNAL_REMOTE))

JOURNAL_REMOTE:=$(subst ",,$(CONFIG_DEVCONFIG_SYSTEMD_JOURNAL_REMOTE_URL))
ANSIBLE_EXTRA_ARGS += devconfig_systemd_journal_remote_url=$(JOURNAL_REMOTE)
ANSIBLE_EXTRA_ARGS += devconfig_enable_systemd_journal_remote='True'

ifeq (y,$(CONFIG_DEVCONFIG_SYSTEMD_JOURNAL_USE_HTTP))
ANSIBLE_EXTRA_ARGS += devconfig_systemd_journal_use_http='True'
endif

journal-client:
	$(Q)ansible-playbook $(ANSIBLE_VERBOSE) -l baseline,dev \
		-f 30 -i hosts  \
		--extra-vars '{ kdevops_cli_install: True }' \
		--tags vars_simple,journal \
		$(KDEVOPS_PLAYBOOKS_DIR)/devconfig.yml

journal-server:
	$(Q)ansible-playbook $(ANSIBLE_VERBOSE) --connection=local \
		--inventory localhost, \
		$(KDEVOPS_PLAYBOOKS_DIR)/install_systemd_journal_remote.yml

journal-restart:
	$(Q)ansible-playbook $(ANSIBLE_VERBOSE) -l baseline,dev \
		-f 30 -i hosts  \
		--tags vars_extra,journal-upload-restart \
		$(KDEVOPS_PLAYBOOKS_DIR)/devconfig.yml

journal-status:
	$(Q)ansible-playbook $(ANSIBLE_VERBOSE) -l baseline,dev \
		-f 30 -i hosts  \
		--tags vars_extra,journal-status \
		$(KDEVOPS_PLAYBOOKS_DIR)/devconfig.yml

journal-ls:
	$(Q)./workflows/kdevops/scripts/jounal-ls.sh /var/log/journal/remote/

journal-dump:
	$(Q)./workflows/kdevops/scripts/jounal-dump.sh /var/log/journal/remote/


journal-ln:
	$(Q)ansible-playbook $(ANSIBLE_VERBOSE) -l baseline,dev \
		-f 30 -i hosts  \
		--tags vars_extra,journal_ln \
		$(KDEVOPS_PLAYBOOKS_DIR)/devconfig.yml

LOCALHOST_SETUP_WORK += journal-server
KDEVOPS_BRING_UP_DEPS_EARLY += journal-client
KDEVOPS_BRING_UP_LATE_DEPS += journal-ln

journal-help:
	@echo "journal-server	   - Setup systemd-journal-remote on localhost"
	@echo "journal-client	   - Setup systemd-journal-upload on clients"
	@echo "journal-restart	   - Restart client upload service"
	@echo "journal-status	   - Ensure systemd-journal-remote works"
	@echo "journal-ls          - List journals available and sizes"
	@echo "journal-ln          - Add symlinks with hostnames"
	@echo "journal-dump        - Dump journal to local journal/ directory"

HELP_TARGETS += journal-help

else
journal-dump:
	@echo Journal disabled consider enabling CONFIG_DEVCONFIG_ENABLE_SYSTEMD_JOURNAL_REMOTE
endif
