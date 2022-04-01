{ libKernel }:

with libKernel;
{
  disable32bit = {
    x86_16BIT = no;
  };

  amdRenoir = {
    X86_AMD_PLATFORM_DEVICE = yes;

    MK8 = yes;

    GART_IOMMU = yes;

    MAX_SMP = yes;
    NR_CPUS = freeform 16;
    SCHED_MC_PRIO = no;

    x86_MCE_INTEL = no;

    PROCESSOR_SELECT = yes;
    CPU_SUP_INTEL = no;
    CPU_SUP_AMD = yes;
    CPU_SUP_HYGON = no;
    CPU_SUP_CENTAUR = no;
    CPU_SUP_ZHAOXIN = no;
    PERF_EVENTS_AMD_POWER = module;
    MICOROCODE_INTEL = no;

    AMD_MEM_ENCRYPT = yes;
    AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT = yes;

    AMD_NUMA = no; # old, X86_64_ACPI_NUMA takes precedence anyway
    X86_SMAP = no;

    X86_INTEL_LPSS = no;
    X86_INTEL_PSTATE = no;

    X86_POWERNOW_K8 = no; # old, new is acpi_cpufreq

    CRYPTO_DEV_CCP = yes;

    VMD = no;

    INTEL_MEI_ME = no;
    INTEL_MEI = no;

    AMD_PMC = module;
    X86_PLATFORM_DRIVERS_INTEL = no;
    INTEL_IPS = no;
    INTEL_SCU_PLATFORM = no;
    INTEL_SCU_IPC_UTIL = no;
  };

  compatibilityBreakers = {
    USELIB = no;

    X86_MPPARSE = no;

    I8K = no;

    X86_SPEEDSTEP_CENTRINO = no;
    X86_P4_CLOCKMOD = no;

    NVME_RDMA = no;
    NVME_FC = no;
    NVME_TCP = no;
    NVME_TARGET_RDMA = no;
    NVME_TARGET_FC = no;
    NVME_TARGET_TCP = no;

    BLK_SED_OPAL = no;

    DEFAULT_MMAP_MIN_ADDR = freeform 65536;

    PCI_MESON = no;

    NTB_SWITCHTEC = no;
    PCI_SW_SWITCHTEC = no;

    YENTA = no;
    PD6729 = no;
    I82092 = no;

    RAPIDIO = no;

    CONFIG_LEDS_LP55XX_COMMON = no;
    X86_PLATFORM_DRIVERS_DELL = no;
    FW_LOADER_USER_HELPER = no;

    USB4 = no;
    APPLE_PROPERTIES = no;

    GNSS = no;

    MTD = no;

    PARPORT = no;

    BLK_DEV_FD = no;
    BLK_DEV_PCIESSD_MTIP32XX = no;

    INFINIBAND = no;

    BLK_DEV_LOOP_MIN_COUNT = freeform 0;
    BLK_DEV_CRYPTOLOOP = no; # deprecated, use dm
    BLK_DEV_DRBD = no;
    BLK_DEV_SX8 = no;
    ATA_OVER_ETH = no;
    BLK_DEV_RBD = no;
    BLK_DEV_RSXX = no;

    AD525X_DPOT = no;
    DUMMY_IRQ = no;
    IBM_ASM = no;
    PHANTOM = no;
    ICS932S401 = no;
    ENCLOSURE_SERVICES = no;
    HP_ILO = no;
    APDS9802ALS = no;
    ISL29003 = no;
    ISL29020 = no;
    SENSORS_TSL2550 = no;
    SENSORS_BH1770 = no;
    SENSORS_APDS990X = no;
    HMC6352 = no;
    DS1682 = no;
    LATTICE_ECP3_CONFIG = no;
    DW_XDATA_PCIE = no;
    XILINX_SDFEC = no;
    C2PORT = no;

    MMC_TIFM_SD = no;
    MMC_SDHCI_F_SDH30 = no;
    MMC_WBSD = no;
    MMC_SPI = no;
    MMC_SDRICOH_CS = no;
    MMC_CB710 = no;
    MMC_VIA_SDMMC = no;
    MMC_VUB300 = no;
    MMC_USHC = no;
    MMC_USDHI6ROL0 = no;
    MMC_TOSHIBA_PCI = no;
    MMC_MTK = no;
    MMC_SDHCI_XENON = no;
    MEMSTICK = no;
    TIFM_CORE = no;

    CB710_CORE = no;

    CHR_DEV_ST = no;
    CHR_DEV_SCH = no;

    SCSI_LOWLEVEL = no;

    SATA_INIC162X = no;
    SATA_ACARD_AHCI = no;
    SATA_SIL24 = no;
    ATA_SFF = no;

    FIREWIRE = no;
    FIREWIRE_NOSY = no;

    MACINTOSH_DRIVERS = no;

    ARCNET = no;
    ATM_DRIVERS = no;

    B53 = no;
    B53_SPI_DRIVER = no;
    B53_MDIO_DRIVER = no;
    B53_MMAP_DRIVER = no;
    B53_SRAB_DRIVER = no;
    B53_SERDES = no;
    NET_DSA_BCM_SF2 = no;
    NET_DSA_LOOP = no;
    NET_DSA_HIRSCHMANN_HELLCREEK = no;
    NET_DSA_LANTIQ_GSWIP = no;
    NET_DSA_MT7530 = no;
    NET_DSA_MV88E6060 = no;
    NET_DSA_MICROCHIP_KSZ_COMMON = no;
    NET_DSA_MICROCHIP_KSZ9477 = no;
    NET_DSA_MICROCHIP_KSZ9477_I2C = no;
    NET_DSA_MICROCHIP_KSZ9477_SPI = no;
    NET_DSA_MICROCHIP_KSZ8795 = no;
    NET_DSA_MICROCHIP_KSZ8795_SPI = no;
    NET_DSA_MICROCHIP_KSZ8863_SMI = no;
    NET_DSA_MV88E6XXX = no;
    NET_DSA_MSCC_SEVILLE = no;
    NET_DSA_AR9331 = no;
    NET_DSA_SJA1105 = no;
    NET_DSA_XRS700X = no;
    NET_DSA_XRS700X_I2C = no;
    NET_DSA_XRS700X_MDIO = no;
    NET_DSA_QCA8K = no;
    NET_DSA_REALTEK_SMI = no;
    NET_DSA_SMSC_LAN9303 = no;
    NET_DSA_SMSC_LAN9303_I2C = no;
    NET_DSA_SMSC_LAN9303_MDIO = no;
    NET_DSA_VITESSE_VSC73XX = no;
    NET_DSA_VITESSE_VSC73XX_SPI = no;
    NET_DSA_VITESSE_VSC73XX_PLATFORM = no;

    MDIO = no;
    NET_VENDOR_3COM = no;
    PCMCIA_3C574 = no;
    PCMCIA_3C589 = no;
    VORTEX = no;
    TYPHOON = no;
    NET_VENDOR_ADAPTEC = no;
    ADAPTEC_STARFIRE = no;
    NET_VENDOR_AGERE = no;
    ET131X = no;
    NET_VENDOR_ALACRITECH = no;
    SLICOSS = no;
    NET_VENDOR_ALTEON = no;
    ACENIC = no;
    ALTERA_TSE = no;
    NET_VENDOR_AMAZON = no;
    ENA_ETHERNET = no;
    NET_VENDOR_AMD = no;
    AMD8111_ETH = no;
    PCNET32 = no;
    PCMCIA_NMCLAN = no;
    AMD_XGBE = no;
    AMD_XGBE_HAVE_ECC = no;
    NET_VENDOR_AQUANTIA = no;
    AQTION = no;
    NET_VENDOR_ARC = no;
    NET_VENDOR_ATHEROS = no;
    ATL2 = no;
    ATL1 = no;
    ATL1E = no;
    ATL1C = no;
    ALX = no;
    NET_VENDOR_BROADCOM = no;
    B44 = no;
    B44_PCI_AUTOSELECT = no;
    B44_PCICORE_AUTOSELECT = no;
    B44_PCI = no;
    BCMGENET = no;
    BNX2 = no;
    CNIC = no;
    TIGON3 = no;
    TIGON3_HWMON = no;
    BNX2X = no;
    BNX2X_SRIOV = no;
    SYSTEMPORT = no;
    BNXT = no;
    BNXT_SRIOV = no;
    BNXT_FLOWER_OFFLOAD = no;
    BNXT_HWMON = no;
    NET_VENDOR_BROCADE = no;
    BNA = no;
    NET_VENDOR_CADENCE = no;
    MACB = no;
    MACB_USE_HWSTAMP = no;
    MACB_PCI = no;
    NET_VENDOR_CAVIUM = no;
    THUNDER_NIC_PF = no;
    THUNDER_NIC_VF = no;
    THUNDER_NIC_BGX = no;
    THUNDER_NIC_RGX = no;
    CAVIUM_PTP = no;
    LIQUIDIO = no;
    LIQUIDIO_VF = no;
    NET_VENDOR_CHELSIO = no;
    CHELSIO_T1 = no;
    CHELSIO_T3 = no;
    CHELSIO_T4 = no;
    CHELSIO_T4VF = no;
    CHELSIO_LIB = no;
    CHELSIO_INLINE_CRYPTO = no;
    CHELSIO_IPSEC_INLINE = no;
    CHELSIO_TLS_DEVICE = no;
    NET_VENDOR_CISCO = no;
    ENIC = no;
    NET_VENDOR_CORTINA = no;
    CX_ECAT = no;
    DNET = no;
    NET_VENDOR_DEC = no;
    NET_TULIP = no;
    DE2104X = no;
    DE2104X_DSL = freeform 0;
    TULIP = no;
    DE4X5 = no;
    WINBOND_840 = no;
    DM9102 = no;
    ULI526X = no;
    PCMCIA_XIRCOM = no;
    NET_VENDOR_DLINK = no;
    DL2K = no;
    SUNDANCE = no;
    NET_VENDOR_EMULEX = no;
    BE2NET = no;
    BE2NET_HWMON = no;
    BE2NET_BE2 = no;
    BE2NET_BE3 = no;
    BE2NET_LANCER = no;
    BE2NET_SKYHAWK = no;
    NET_VENDOR_EZCHIP = no;
    NET_VENDOR_FUJITSU = no;
    PCMCIA_FMVJ18X = no;
    NET_VENDOR_GOOGLE = no;
    GVE = no;
    NET_VENDOR_HUAWEI = no;
    HINIC = no;
    NET_VENDOR_I825XX = no;
    NET_VENDOR_INTEL = no;
    E100 = no;
    E1000 = no;
    E1000E = no;
    E1000E_HWTS = no;
    IGB = no;
    IGB_HWMON = no;
    IGB_DCA = no;
    IGBVF = no;
    IXGB = no;
    IXGBE = no;
    IXGBE_HWMON = no;
    IXGBE_DCA = no;
    IXGBE_IPSEC = no;
    IXGBEVF = no;
    IXGBEVF_IPSEC = no;
    I40E = no;
    IAVF = no;
    I40EVF = no;
    ICE = no;
    FM10K = no;
    IGC = no;
    NET_VENDOR_MICROSOFT = no;
    MICROSOFT_MANA = no;
    JME = no;
    NET_VENDOR_LITEX = no;
    NET_VENDOR_MARVELL = no;
    MVMDIO = no;
    SKGE = no;
    SKY2 = no;
    PRESTERA = no;
    PRESTERA_PCI = no;
    NET_VENDOR_MELLANOX = no;
    MLX4_EN = no;
    MLX4_CORE = no;
    MLX4_DEBUG = no;
    MLX4_CORE_GEN2 = no;
    MLX5_CORE = no;
    MLX5_CORE_EN = no;
    MLX5_EN_ARFS = no;
    MLX5_EN_RXNFC = no;
    MLX5_MPFS = no;
    MLX5_ESWITCH = no;
    MLX5_BRIDGE = no;
    MLX5_CLS_ACT = no;
    MLX5_TC_SAMPLE = no;
    MLX5_SW_STEERING = no;
    MLXSW_CORE = no;
    MLXSW_CORE_HWMON = no;
    MLXSW_CORE_THERMAL = no;
    MLXSW_PCI = no;
    MLXSW_I2C = no;
    MLXSW_SPECTRUM = no;
    MLXSW_MINIMAL = no;
    MLXFW = no;
    NET_VENDOR_MICREL = no;
    KS8842 = no;
    KS8851 = no;
    KS8851_MLL = no;
    KSZ884X_PCI = no;
    NET_VENDOR_MICROCHIP = no;
    ENC28J60 = no;
    ENCX24J600 = no;
    LAN743X = no;
    NET_VENDOR_MICROSEMI = no;
    MSCC_OCELOT_SWITCH_LIB = no;
    NET_VENDOR_MYRI = no;
    MYRI10GE = no;
    MYRI10GE_DCA = no;
    FEALNX = no;
    NET_VENDOR_NATSEMI = no;
    NATSEMI = no;
    NS83820 = no;
    NET_VENDOR_NETERION = no;
    S2IO = no;
    VXGE = no;
    NET_VENDOR_NETRONOME = no;
    NFP = no;
    NFP_APP_FLOWER = no;
    NFP_APP_ABM_NIC = no;
    NET_VENDOR_NI = no;
    NI_XGE_MANAGEMENT_ENET = no;
    NET_VENDOR_8390 = no;
    PCMCIA_AXNET = no;
    NE2K_PCI = no;
    PCMCIA_PCNET = no;
    NET_VENDOR_NVIDIA = no;
    FORCEDETH = no;
    NET_VENDOR_OKI = no;
    ETHOC = no;
    NET_VENDOR_PACKET_ENGINES = no;
    HAMACHI = no;
    YELLOWFIN = no;
    NET_VENDOR_PENSANDO = no;
    IONIC = no;
    NET_VENDOR_QLOGIC = no;
    QLA3XXX = no;
    QLCNIC = no;
    QLCNIC_SRIOV = no;
    QLCNIC_HWMON = no;
    NETXEN_NIC = no;
    QED = no;
    QED_LL2 = no;
    QED_SRIOV = no;
    QEDE = no;
    QED_RDMA = no;
    QED_ISCSI = no;
    QED_FCOE = no;
    QED_OOO = no;
    NET_VENDOR_QUALCOMM = no;
    QCOM_EMAC = no;
    RMNET = no;
    NET_VENDOR_RDC = no;
    R6040 = no;
    NET_VENDOR_REALTEK = no;
    ATP = no;
    "8139CP" = no;
    "8139TOO" = no;
    "8139TOO_8129" = no;
    R8169 = no;
    NET_VENDOR_RENESAS = no;
    NET_VENDOR_ROCKER = no;
    ROCKER = no;
    NET_VENDOR_SAMSUNG = no;
    SXGBE_ETH = no;
    NET_VENDOR_SEEQ = no;
    NET_VENDOR_SOLARFLARE = no;
    SFC = no;
    SFC_MTD = no;
    SFC_MCDI_MON = no;
    SFC_SRIOV = no;
    SFC_MCDI_LOGGING = no;
    SFC_FALCON = no;
    SFC_FALCON_MTD = no;
    NET_VENDOR_SILAN = no;
    SC92031 = no;
    NET_VENDOR_SIS = no;
    SIS900 = no;
    SIS190 = no;
    NET_VENDOR_SMSC = no;
    PCMCIA_SMC91C92 = no;
    EPIC100 = no;
    SMSC911X = no;
    SMSC9420 = no;
    NET_VENDOR_SOCIONEXT = no;
    NET_VENDOR_STMICRO = no;
    STMMAC_ETH = no;
    STMMAC_PLATFORM = no;
    DWMAC_GENERIC = no;
    DWMAC_INTEL = no;
    DWMAC_LOONGSON = no;
    STMMAC_PCI = no;
    NET_VENDOR_SUN = no;
    HAPPYMEAL = no;
    SUNGEM = no;
    CASSINI = no;
    NIU = no;
    NET_VENDOR_SYNOPSYS = no;
    DWC_XLGMAC = no;
    DWC_XLGMAC_PCI = no;
    NET_VENDOR_TEHUTI = no;
    TEHUTI = no;
    NET_VENDOR_TI = no;
    TLAN = no;
    NET_VENDOR_VIA = no;
    VIA_RHINE = no;
    VIA_VELOCITY = no;
    NET_VENDOR_WIZNET = no;
    WIZNET_W5100 = no;
    WIZNET_W5300 = no;
    WIZNET_BUS_ANY = no;
    WIZNET_W5100_SPI = no;
    NET_VENDOR_XILINX = no;
    XILINX_EMACLITE = no;
    XILINX_AXI_EMAC = no;
    XILINX_LL_TEMAC = no;
    NET_VENDOR_XIRCOM = no;
    PCMCIA_XIRC2PS = no;
    FDDI = no;
    DEFXX = no;
    SKFP = no;
    HIPPI = no;
    ROADRUNNER = no;
    NET_SB1000 = no;
    PHYLINK = no;
    PHYLIB = no;
    SWPHY = no;
    FIXED_PHY = no;
    SFP = no;

    AMD_PHY = no;
    ADIN_PHY = no;
    AQUANTIA_PHY = no;
    BROADCOM_PHY = no;
    BCM54140_PHY = no;
    BCM7XXX_PHY = no;
    BCM84881_PHY = no;
    BCM87XX_PHY = no;
    BCM_NET_PHYLIB = no;
    CICADA_PHY = no;
    CORTINA_PHY = no;
    DAVICOM_PHY = no;
    ICPLUS_PHY = no;
    LXT_PHY = no;
    INTEL_XWAY_PHY = no;
    LSI_ET1011C_PHY = no;
    MARVELL_PHY = no;
    MARVELL_10G_PHY = no;
    MARVELL_88X2222_PHY = no;
    MAXLINEAR_GPHY = no;
    MEDIATEK_GE_PHY = no;
    MICREL_PHY = no;
    MICROCHIP_T1_PHY = no;
    MICROSEMI_PHY = no;
    MOTORCOMM_PHY = no;
    NATIONAL_PHY = no;
    NXP_C45_TJA11XX_PHY = no;
    NXP_TJA11XX_PHY = no;
    AT803X_PHY = no;
    QSEMI_PHY = no;
    RENESAS_PHY = no;
    ROCKCHIP_PHY = no;
    STE10XP = no;
    TERANETICS_PHY = no;
    DP83822_PHY = no;
    DP83TC811_PHY = no;
    DP83848_PHY = no;
    DP83867_PHY = no;
    DP83869_PHY = no;
    VITESSE_PHY = no;
    XILINX_GMII2RGMII = no;


    MICREL_KS8995MA = no;

    MDIO_GPIO = no;
    MDIO_MVUSB = no;
    MDIO_MSCC_MIIM = no;
    MDIO_THUNDER = no;

    SLIP = no;

    WLAN_VENDOR_ADMTEK = no;
    WLAN_VENDOR_ATH = no;
    WLAN_VENDOR_ATMEL = no;
    WLAN_VENDOR_BROADCOM = no;
    WLAN_VENDOR_CISCO = no;
    WLAN_VENDOR_INTEL = no;
    IPW2100 = no;
    IPW2200 = no;
    IWL4965 = no;
    IWL3945 = no;
    WLAN_VENDOR_INTERSIL = no;
    WLAN_VENDOR_MARVELL = no;
    WLAN_VENDOR_MEDIATEK = no;
    WLAN_VENDOR_MICROCHIP = no;
    WLAN_VENDOR_RALINK = no;
    WLAN_VENDOR_REALTEK = no;
    WLAN_VENDOR_RSI = no;
    WLAN_VENDOR_ST = no;
    WLAN_VENDOR_TI = no;
    WLAN_VENDOR_ZYDAS = no;
    WLAN_VENDOR_QUANTENNA = no;
    PCMCIA_RAYCS = no;
    PCMCIA_WL3501 = no;
    USB_NET_RNDIS_WLAN = no;
    VIRT_WIFI = no;

    WAN = no;
    IEEE802154_DRIVERS = no;
    WWAN = no;

    KEYBOARD_ADC = no;
    KEYBOARD_ADP5588 = no;
    KEYBOARD_ADP5589 = no;
    KEYBOARD_APPLESPI = no;
    KEYBOARD_ATKBD = no;
    KEYBOARD_QT1050 = no;
    KEYBOARD_QT1070 = no;
    KEYBOARD_QT2160 = no;
    KEYBOARD_DLINK_DIR685 = no;
    KEYBOARD_LKKBD = no;
    KEYBOARD_GPIO = no;
    KEYBOARD_GPIO_POLLED = no;
    KEYBOARD_TCA6416 = no;
    KEYBOARD_TCA8418 = no;
    KEYBOARD_MATRIX = no;
    KEYBOARD_LM8323 = no;
    KEYBOARD_LM8333 = no;
    KEYBOARD_MAX7359 = no;
    KEYBOARD_MCS = no;
    KEYBOARD_MPR121 = no;
    KEYBOARD_NEWTON = no;
    KEYBOARD_OPENCORES = no;
    KEYBOARD_SAMSUNG = no;
    KEYBOARD_STOWAWAY = no;
    KEYBOARD_SUNKBD = no;
    KEYBOARD_IQS62X = no;
    KEYBOARD_TM2_TOUCHKEY = no;
    KEYBOARD_XTKBD = no;
    KEYBOARD_CROS_EC = no;
    KEYBOARD_MTK_PMIC = no;
    INPUT_MOUSE = no;
    MOUSE_PS2 = no;
    MOUSE_PS2_ALPS = no;
    MOUSE_PS2_BYD = no;
    MOUSE_PS2_LOGIPS2PP = no;
    MOUSE_PS2_SYNAPTICS = no;
    MOUSE_PS2_SYNAPTICS_SMBUS = no;
    MOUSE_PS2_CYPRESS = no;
    MOUSE_PS2_LIFEBOOK = no;
    MOUSE_PS2_TRACKPOINT = no;
    MOUSE_PS2_ELANTECH = no;
    MOUSE_PS2_ELANTECH_SMBUS = no;
    MOUSE_PS2_FOCALTECH = no;
    MOUSE_PS2_VMMOUSE = no;
    MOUSE_PS2_SMBUS = no;
    MOUSE_SERIAL = no;
    MOUSE_APPLETOUCH = no;
    MOUSE_BCM5974 = no;
    MOUSE_CYAPA = no;
    MOUSE_ELAN_I2C = no;
    MOUSE_ELAN_I2C_I2C = no;
    MOUSE_ELAN_I2C_SMBUS = no;
    MOUSE_VSXXXAA = no;
    MOUSE_GPIO = no;
    MOUSE_SYNAPTICS_I2C = no;
    MOUSE_SYNAPTICS_USB = no;
    INPUT_JOYSTICK = no;
    JOYSTICK_ANALOG = no;
    JOYSTICK_A3D = no;
    JOYSTICK_ADC = no;
    JOYSTICK_ADI = no;
    JOYSTICK_COBRA = no;
    JOYSTICK_GF2K = no;
    JOYSTICK_GRIP = no;
    JOYSTICK_GRIP_MP = no;
    JOYSTICK_GUILLEMOT = no;
    JOYSTICK_INTERACT = no;
    JOYSTICK_SIDEWINDER = no;
    JOYSTICK_TMDC = no;
    JOYSTICK_IFORCE = no;
    JOYSTICK_IFORCE_USB = no;
    JOYSTICK_IFORCE_232 = no;
    JOYSTICK_WARRIOR = no;
    JOYSTICK_MAGELLAN = no;
    JOYSTICK_SPACEORB = no;
    JOYSTICK_SPACEBALL = no;
    JOYSTICK_STINGER = no;
    JOYSTICK_TWIDJOY = no;
    JOYSTICK_ZHENHUA = no;
    JOYSTICK_DB9 = no;
    JOYSTICK_GAMECON = no;
    JOYSTICK_TURBOGRAFX = no;
    JOYSTICK_AS5011 = no;
    JOYSTICK_JOYDUMP = no;
    JOYSTICK_XPAD = no;
    JOYSTICK_XPAD_FF = no;
    JOYSTICK_XPAD_LEDS = no;
    JOYSTICK_WALKERA0701 = no;
    JOYSTICK_PSXPAD_SPI = no;
    JOYSTICK_PXRC = no;
    JOYSTICK_QWIIC = no;
    JOYSTICK_FSIA6B = no;
    INPUT_TABLET = no;
    TABLET_USB_ACECAD = no;
    TABLET_USB_AIPTEK = no;
    TABLET_USB_HANWANG = no;
    TABLET_USB_KBTAB = no;
    TABLET_USB_PEGASUS = no;
    TABLET_SERIAL_WACOM4 = no;
    INPUT_TOUCHSCREEN = no;
    TOUCHSCREEN_ADS7846 = no;
    TOUCHSCREEN_AD7877 = no;
    TOUCHSCREEN_AD7879 = no;
    TOUCHSCREEN_AD7879_I2C = no;
    TOUCHSCREEN_AD7879_SPI = no;
    TOUCHSCREEN_ADC = no;
    TOUCHSCREEN_ATMEL_MXT = no;
    TOUCHSCREEN_AUO_PIXCIR = no;
    TOUCHSCREEN_BU21013 = no;
    TOUCHSCREEN_BU21029 = no;
    TOUCHSCREEN_CHIPONE_ICN8505 = no;
    TOUCHSCREEN_CY8CTMA140 = no;
    TOUCHSCREEN_CY8CTMG110 = no;
    TOUCHSCREEN_CYTTSP_CORE = no;
    TOUCHSCREEN_CYTTSP_I2C = no;
    TOUCHSCREEN_CYTTSP_SPI = no;
    TOUCHSCREEN_CYTTSP4_CORE = no;
    TOUCHSCREEN_CYTTSP4_I2C = no;
    TOUCHSCREEN_CYTTSP4_SPI = no;
    TOUCHSCREEN_DYNAPRO = no;
    TOUCHSCREEN_HAMPSHIRE = no;
    TOUCHSCREEN_EETI = no;
    TOUCHSCREEN_EGALAX_SERIAL = no;
    TOUCHSCREEN_EXC3000 = no;
    TOUCHSCREEN_FUJITSU = no;
    TOUCHSCREEN_GOODIX = no;
    TOUCHSCREEN_HIDEEP = no;
    TOUCHSCREEN_HYCON_HY46XX = no;
    TOUCHSCREEN_ILI210X = no;
    TOUCHSCREEN_ILITEK = no;
    TOUCHSCREEN_S6SY761 = no;
    TOUCHSCREEN_GUNZE = no;
    TOUCHSCREEN_EKTF2127 = no;
    TOUCHSCREEN_ELAN = no;
    TOUCHSCREEN_ELO = no;
    TOUCHSCREEN_WACOM_W8001 = no;
    TOUCHSCREEN_WACOM_I2C = no;
    TOUCHSCREEN_MAX11801 = no;
    TOUCHSCREEN_MCS5000 = no;
    TOUCHSCREEN_MMS114 = no;
    TOUCHSCREEN_MELFAS_MIP4 = no;
    TOUCHSCREEN_MSG2638 = no;
    TOUCHSCREEN_MTOUCH = no;
    TOUCHSCREEN_INEXIO = no;
    TOUCHSCREEN_MK712 = no;
    TOUCHSCREEN_PENMOUNT = no;
    TOUCHSCREEN_EDT_FT5X06 = no;
    TOUCHSCREEN_TOUCHRIGHT = no;
    TOUCHSCREEN_TOUCHWIN = no;
    TOUCHSCREEN_TI_AM335X_TSC = no;
    TOUCHSCREEN_UCB1400 = no;
    TOUCHSCREEN_PIXCIR = no;
    TOUCHSCREEN_WDT87XX_I2C = no;
    TOUCHSCREEN_WM97XX = no;
    TOUCHSCREEN_WM9705 = no;
    TOUCHSCREEN_WM9712 = no;
    TOUCHSCREEN_WM9713 = no;
    TOUCHSCREEN_USB_COMPOSITE = no;
    TOUCHSCREEN_MC13783 = no;
    TOUCHSCREEN_USB_EGALAX = no;
    TOUCHSCREEN_USB_PANJIT = no;
    TOUCHSCREEN_USB_3M = no;
    TOUCHSCREEN_USB_ITM = no;
    TOUCHSCREEN_USB_ETURBO = no;
    TOUCHSCREEN_USB_GUNZE = no;
    TOUCHSCREEN_USB_DMC_TSC10 = no;
    TOUCHSCREEN_USB_IRTOUCH = no;
    TOUCHSCREEN_USB_IDEALTEK = no;
    TOUCHSCREEN_USB_GENERAL_TOUCH = no;
    TOUCHSCREEN_USB_GOTOP = no;
    TOUCHSCREEN_USB_JASTEC = no;
    TOUCHSCREEN_USB_ELO = no;
    TOUCHSCREEN_USB_E2I = no;
    TOUCHSCREEN_USB_ZYTRONIC = no;
    TOUCHSCREEN_USB_ETT_TC45USB = no;
    TOUCHSCREEN_USB_NEXIO = no;
    TOUCHSCREEN_USB_EASYTOUCH = no;
    TOUCHSCREEN_TOUCHIT213 = no;
    TOUCHSCREEN_TSC_SERIO = no;
    TOUCHSCREEN_TSC200X_CORE = no;
    TOUCHSCREEN_TSC2004 = no;
    TOUCHSCREEN_TSC2005 = no;
    TOUCHSCREEN_TSC2007 = no;
    TOUCHSCREEN_RM_TS = no;
    TOUCHSCREEN_SILEAD = no;
    TOUCHSCREEN_SIS_I2C = no;
    TOUCHSCREEN_ST1232 = no;
    TOUCHSCREEN_STMFTS = no;
    TOUCHSCREEN_SUR40 = no;
    TOUCHSCREEN_SURFACE3_SPI = no;
    TOUCHSCREEN_SX8654 = no;
    TOUCHSCREEN_TPS6507X = no;
    TOUCHSCREEN_ZET6223 = no;
    TOUCHSCREEN_ZFORCE = no;
    TOUCHSCREEN_ROHM_BU21023 = no;
    TOUCHSCREEN_IQS5XX = no;
    TOUCHSCREEN_ZINITIX = no;
    INPUT_MISC = no;
    INPUT_88PM80X_ONKEY = no;
    INPUT_AD714X = no;
    INPUT_AD714X_I2C = no;
    INPUT_AD714X_SPI = no;
    INPUT_ARIZONA_HAPTICS = no;
    INPUT_ATC260X_ONKEY = no;
    INPUT_BMA150 = no;
    INPUT_E3X0_BUTTON = no;
    INPUT_PCSPKR = no;
    INPUT_MAX77693_HAPTIC = no;
    INPUT_MC13783_PWRBUTTON = no;
    INPUT_MMA8450 = no;
    INPUT_APANEL = no;
    INPUT_GPIO_BEEPER = no;
    INPUT_GPIO_DECODER = no;
    INPUT_GPIO_VIBRA = no;
    INPUT_ATLAS_BTNS = no;
    INPUT_ATI_REMOTE2 = no;
    INPUT_KEYSPAN_REMOTE = no;
    INPUT_KXTJ9 = no;
    INPUT_POWERMATE = no;
    INPUT_YEALINK = no;
    INPUT_CM109 = no;
    INPUT_REGULATOR_HAPTIC = no;
    INPUT_RETU_PWRBUTTON = no;
    INPUT_AXP20X_PEK = no;
    INPUT_UINPUT = no;
    INPUT_PCF50633_PMU = no;
    INPUT_PCF8574 = no;
    INPUT_PWM_BEEPER = no;
    INPUT_PWM_VIBRA = no;
    INPUT_GPIO_ROTARY_ENCODER = no;
    INPUT_DA7280_HAPTICS = no;
    INPUT_DA9063_ONKEY = no;
    INPUT_ADXL34X = no;
    INPUT_ADXL34X_I2C = no;
    INPUT_ADXL34X_SPI = no;
    INPUT_IMS_PCU = no;
    INPUT_IQS269A = no;
    INPUT_IQS626A = no;
    INPUT_CMA3000 = no;
    INPUT_CMA3000_I2C = no;
    INPUT_XEN_KBDDEV_FRONTEND = no;
    INPUT_IDEAPAD_SLIDEBAR = no;
    INPUT_SOC_BUTTON_ARRAY = no;
    INPUT_DRV260X_HAPTICS = no;
    INPUT_DRV2665_HAPTICS = no;
    INPUT_DRV2667_HAPTICS = no;
    INPUT_RAVE_SP_PWRBUTTON = no;
    RMI4_CORE = no;
    RMI4_I2C = no;
    RMI4_SPI = no;
    RMI4_SMB = no;
    RMI4_F03 = no;
    RMI4_F03_SERIO = no;
    RMI4_2D_SENSOR = no;
    RMI4_F11 = no;
    RMI4_F12 = no;
    RMI4_F30 = no;

    HUAWEI_WMI = no;
    PEAQ_WMI = no;
    XIAOMI_WMI = no;
    GIGABYTE_WMI = no;
    ACERHDF = no;
    ACER_WIRELESS = no;
    ACER_WMI = no;
    ADV_SWBUTTON = no;
    APPLE_GMUX = no;
    ASUS_LAPTOP = no;
    ASUS_WIRELESS = no;
    ASUS_WMI = no;
    ASUS_NB_WMI = no;
    MERAKI_MX100 = no;
    EEEPC_LAPTOP = no;
    EEEPC_WMI = no;
    ALIENWARE_WMI = no;
    DCDBAS = no;
    DELL_LAPTOP = no;
    DELL_RBU = no;
    DELL_RBTN = no;
    DELL_SMBIOS = no;
    DELL_SMBIOS_WMI = no;
    DELL_SMBIOS_SMM = no;
    DELL_SMO8800 = no;
    DELL_WMI = no;
    DELL_WMI_AIO = no;
    DELL_WMI_DESCRIPTOR = no;
    DELL_WMI_LED = no;
    DELL_WMI_SYSMAN = no;
    AMILO_RFKILL = no;
    FUJITSU_LAPTOP = no;
    FUJITSU_TABLET = no;
    GPD_POCKET_FAN = no;
    HP_ACCEL = no;
    WIRELESS_HOTKEY = no;
    HP_WMI = no;
    IBM_RTL = no;
    IDEAPAD_LAPTOP = no;
    SENSORS_HDAPS = no;
    THINKPAD_ACPI = no;
    THINKPAD_ACPI_ALSA_SUPPORT = no;
    THINKPAD_ACPI_VIDEO = no;
    THINKPAD_ACPI_HOTKEY_POLL = no;
    THINKPAD_LMI = no;

    ACCESSIBILITY = no;
  };

  bpf = {
    BPF_SYSCALL = yes;
    BPF_JIT = yes;
    BPF_JIT_ALWAYS_ON = no;
    BPF_PRELOAD = yes;
    BPF_PRELOAD_UMD = module;
  };

  processor = {
    x86_CPU_RESCTRL = yes;

    NODES_SHIFT = freeform 1;

    CPU_FREQ_DEFAULT_GOV_PERFORMANCE = no;
    CPU_FREQ_DEFAULT_GOV_POWERSAVE = no;
    CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE = no;
    CPU_FREQ_DEFAULT_GOV_SCHEDUTIL = yes;
  };

  cGroups = {
    CGROUP_MISC = yes;
  };

  config = {
    KERNEL_GZIP = no;
    KERNEL_XZ = no;
    KERNEL_ZSTD = yes;

    IKHEADERS = module;

    BOOT_CONFIG = yes;

    EXPERT = yes;

    X86_EXTENDED_PLATFORM = no;

    EFI_MIXED = no;
    EFI_CAPSULE_LOADER = no;

    MODULE_COMPRESS_XZ = yes;
    MODULE_COMPRESS_ZSTD = no; # check pr 143238
    TRIM_UNUSED_KSYMS = yes;

    FW_LOADER_COMPRESS = yes;
  };

  monitoring = {
    TASKSTATS = no;

    WATCH_QUEUE = yes;
  };

  power = {
    PM_ADVANCED_DEBUG = no;
    WQ_POWER_EFFICIENT_DEFAULT = yes;
    ENERGY_MODEL = yes;
  };

  acpi = {
    ACPI_SPCR_TABLE = no;
    ACPI_REV_OVERRIDE_POSSIBLE = no;
    ACPI_TINY_POWER_BUTTON = no;
    ACPI_DOCK = no;
    ACPI_APEI = yes;
    ACPI_APEI_GHES = yes;
  };

  zram = {
    HIBERNATION = no;
    CLEANCACHE = no;
    FRONTSWAP = no;
    ZRAM = yes;
    ZRAM_DEF_COMP_LZORLE = no;
    ZRAM_DEF_COMP_ZSTD = yes;
    ZRAM_MEMORY_TRACKING = yes;
  };

  hardening = {
    SLAB_FREELIST_RANDOM = yes;
    SLAB_FREELIST_HARDENED = yes;
    SHUFFLE_PAGE_ALLOCATOR = yes;

    KEXEC_SIGN = yes;

    ACPI_CUSTOM_METHOD = no;

    RANDOMIZE_KSTACK_OFFSET_DEFAULT = yes;
    LOCK_EVENT_COUNTS = yes;

    GCC_PLUGIN_RANDSTRUCT = yes;
    GCC_PLUGIN_RANDSTRUCT_PERFORMANCE = yes;
  };

  disableVirtualisationGuest = {
    HYPERVISOR_GUEST = no;
  };

  desktop = {
    IPMI_HANDLER = no;

    CPU_IDLE_GOV_MENU = no;
    CPU_IDLE_GOV_TEO = yes;

    CXL_BUS = no;

    NTB = no;
  };

  laptop = {
    DM_RAID = no;
    BLK_DEV_MD = no;

    ATKBD = module;
  };

  devices = {
    SCSI_SCAN_ASYNC = yes;
  };

  server = {
    PREEMPT_NONE = yes;
    PREEMPT_VOLUNTARY = no;

    HZ_100 = yes;
    HZ_1000 = no;
  };

  wifi = {
    TCP_CONG_VENO = yes;
    DEFAULT_CUBIC = no;
    DEFAULT_VENO = yes;
  };
}

# EXPERT
# AMD
# SUPPORTED_VENDORS
# IPMI_HANDLER
# MEMORY_HOTPLUG
# CRYPTO_DEV_CCP
# USB4
