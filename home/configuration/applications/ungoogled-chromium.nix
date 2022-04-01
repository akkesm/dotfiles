{ pkgs, ... }:

{
  programs.chromium = {
    enable = true;
    package = pkgs.ungoogled-chromium;

    extensions = [
      { id = "cjpalhdlnbpafiamejdnhcphjbkeiagm"; } # uBlock Origin
      { id = "dncldolpngigodjmkklknhahjafjoofn"; } # CiscoWebex helper
      { id = "lckanjgmijmafbedllaakclkaicjfmnk"; } # ClearURLs
      { id = "ldpochfccmkkmhdbclfhpagapcfdljkj"; } # Decentraleyes
    ];
  };
}
