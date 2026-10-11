# shellcheck shell=bash

Describe 'shell portability'
  # Process substitution needs /dev/fd, which is unavailable in some
  # environments such as proot-distro on Termux.
  find_process_substitution() {
    grep -nE '<\(' "$PROJECT_ROOT/bin/gga" "$PROJECT_ROOT"/lib/*.sh \
      "$PROJECT_ROOT/install.sh" "$PROJECT_ROOT/uninstall.sh" \
      | grep -vE '^[^:]+:[0-9]+:[[:space:]]*#'
  }

  It 'does not use process substitution in shipped scripts'
    When call find_process_substitution
    The status should be failure
    The output should be blank
  End
End

