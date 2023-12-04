{ ... }:

{
  imports = [ ../../accounts/email-test-accounts.nix ];

  accounts.email.accounts = {
    "hm@example.com" = {
      mu.enable = true;
      aliases = [ "foo@example.com" ];
    };
  };

  programs.mu.enable = true;

  test.stubs.mu = { };

  nmt.script = ''
    assertFileContains activate \
      'if [[ ! -d "/home/hm-user/.cache/mu" ]]; then'

    assertFileContains activate \
      '$DRY_RUN_CMD mu init --maildir=/home/hm-user/Mail --my-address=hm@example.com --my-address=foo@example.com $VERBOSE_ARG;'
  '';
}
