{ pkgs, ... }:

{
  programs.chromium = {
    enable = true;
    package = pkgs.ungoogled-chromium;

    # Extensions defines like this do not work in ungoogled-chromium
    # extensions = [
    #   { id = "cjpalhdlnbpafiamejdnhcphjbkeiagm"; } # uBlock Origin
    #   { id = "dncldolpngigodjmkklknhahjafjoofn"; } # CiscoWebex helper
    #   { id = "lckanjgmijmafbedllaakclkaicjfmnk"; } # ClearURLs
    #   { id = "ldpochfccmkkmhdbclfhpagapcfdljkj"; } # Decentraleyes
    # ];
  };
}
