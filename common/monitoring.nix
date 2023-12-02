{ config, pkgs, ... }:

{
  environment.systemPackages = (with config.boot.kernelPackages; [
    bpftrace
    cpupower
    # perf
  ]) ++ (with pkgs; [
    bottom
    btop
    dig
    duf
    libva-utils
    lshw
    lsof
    nettools
    nmap
    pciutils
    smartmontools
    sysstat
    tcpdump
    usbutils
    whois
  ]);

  programs = {
    atop = {
      enable = false;
      setuidWrapper.enable = true;
    };

    bcc.enable = true;

    htop = {
      enable = true;
      settings = {
        account_guest_in_cpu_meters = false;
        color_scheme = 0;
        cpu_count_from_one = false;
        delay = 15;
        detailed_cpu_time = false;
        enable_mouse = true;
        fields = [ 0 48 17 18 38 39 40 2 46 47 49 1 ];
        find_comm_in_cmdline = true;
        header_margin = true;
        hide_function_bar = false;
        hide_kernel_threads = false;
        hide_userland_threads = false;
        highlight_base_name = true;
        highlight_changes = false;
        highlight_changes_delay_Secs = 5;
        highlight_megabytes = true;
        highlight_threads = true;
        shadow_other_users = false;
        show_cpu_frequency = true;
        show_cpu_usage = true;
        show_merged_command = false;
        show_program_path = true;
        show_thread_names = false;
        sort_key = 46;
        sort_direction = 0;
        strip_exe_from_cmdline = true;
        tree_sort_key = 0;
        tree_sort_direction = 1;
        tree_view = false;
        tree_view_always_by_pid = false;
        update_process_names = false;
        vim_mode = true;
        left_meters = [ "LeftCPUs" "CPU" "Memory" "Swap" "Zram" "DiskIO" "NetworkIO" ];
        left_meter_modes = [ 1 2 1 1 2 2 2 ];
        right_meters = [ "RightCPUs" "Tasks" "LoadAverage" "Uptime" "Battery" "SELinux" "Systemd" ];
        right_meter_modes = [ 1 2 2 2 2 2 2 ];
      };
    };

    mtr.enable = true;
    # sysdig.enable = true;
    traceroute.enable = true;
    trippy.enable = true;
    wireshark.enable = true;
    zmap.enable = true;
  };
}
