
----------------------------------------------------------------
-- 
-- Created by the Synopsys Library Compiler Y-2006.06-SP2
-- FILENAME     :    /home/jddjig01/v/make_syn_lib/Synopsys_Libraries/vtvt_tsmc250_Vcomponents.vhd
-- FILE CONTENTS:    VITAL Component Package
-- DATE CREATED :    Mon Dec 11 12:55:01 2006
-- 
-- LIBRARY      :    vtvt_tsmc250
-- REVISION     :    Not Specified
-- TECHNOLOGY   :    cmos
-- TIME SCALE   :    1 ps
-- LOGIC SYSTEM :    IEEE-1164
-- NOTES        :    
-- HISTORY      :
-- 
----------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all;
-- synopsys translate_off

library IEEE;
use IEEE.VITAL_Timing.all;
-- synopsys translate_on

package COMPONENTS is

constant DefaultTimingChecksOn : Boolean := True;
constant DefaultXon : Boolean := False;
constant DefaultMsgOn : Boolean := True;

----- Component ABnorC -----
component ABnorC
-- synopsys translate_off
   generic(
      TimingChecksOn: Boolean := DefaultTimingChecksOn;
      InstancePath: STRING := "*";
      Xon: Boolean := DefaultXon;
      MsgOn: Boolean := DefaultMsgOn;
      tpd_ip1_op                     :	VitalDelayType01 := (88.408 ps, 82.112 ps);
      tpd_ip2_op                     :	VitalDelayType01 := (102.620 ps, 82.112 ps);
      tpd_ip3_op                     :	VitalDelayType01 := (85.904 ps, 30.788 ps);
      tipd_ip1                       :	VitalDelayType01 := (0.000 ps, 0.000 ps);
      tipd_ip2                       :	VitalDelayType01 := (0.000 ps, 0.000 ps);
      tipd_ip3                       :	VitalDelayType01 := (0.000 ps, 0.000 ps));

-- synopsys translate_on
   port(
      ip1                            :	in    STD_ULOGIC;
      ip2                            :	in    STD_ULOGIC;
      ip3                            :	in    STD_ULOGIC;
      op                             :	out   STD_ULOGIC);
end component;


----- Component ABorC -----
component ABorC
-- synopsys translate_off
   generic(
      TimingChecksOn: Boolean := DefaultTimingChecksOn;
      InstancePath: STRING := "*";
      Xon: Boolean := DefaultXon;
      MsgOn: Boolean := DefaultMsgOn;
      tpd_ip1_op                     :	VitalDelayType01 := (187.320 ps, 168.260 ps);
      tpd_ip2_op                     :	VitalDelayType01 := (187.320 ps, 166.300 ps);
      tpd_ip3_op                     :	VitalDelayType01 := (110.440 ps, 184.160 ps);
      tipd_ip1                       :	VitalDelayType01 := (0.000 ps, 0.000 ps);
      tipd_ip2                       :	VitalDelayType01 := (0.000 ps, 0.000 ps);
      tipd_ip3                       :	VitalDelayType01 := (0.000 ps, 0.000 ps));

-- synopsys translate_on
   port(
      ip1                            :	in    STD_ULOGIC;
      ip2                            :	in    STD_ULOGIC;
      ip3                            :	in    STD_ULOGIC;
      op                             :	out   STD_ULOGIC);
end component;


----- Component ab_or_c_or_d -----
component ab_or_c_or_d
-- synopsys translate_off
   generic(
      TimingChecksOn: Boolean := DefaultTimingChecksOn;
      InstancePath: STRING := "*";
      Xon: Boolean := DefaultXon;
      MsgOn: Boolean := DefaultMsgOn;
      tpd_ip1_op                     :	VitalDelayType01 := (157.580 ps, 188.990 ps);
      tpd_ip2_op                     :	VitalDelayType01 := (149.890 ps, 188.990 ps);
      tpd_ip3_op                     :	VitalDelayType01 := (93.827 ps, 188.990 ps);
      tpd_ip4_op                     :	VitalDelayType01 := (78.710 ps, 188.990 ps);
      tipd_ip1                       :	VitalDelayType01 := (0.000 ps, 0.000 ps);
      tipd_ip2                       :	VitalDelayType01 := (0.000 ps, 0.000 ps);
      tipd_ip3                       :	VitalDelayType01 := (0.000 ps, 0.000 ps);
      tipd_ip4                       :	VitalDelayType01 := (0.000 ps, 0.000 ps));

-- synopsys translate_on
   port(
      ip1                            :	in    STD_ULOGIC;
      ip2                            :	in    STD_ULOGIC;
      ip3                            :	in    STD_ULOGIC;
      ip4                            :	in    STD_ULOGIC;
      op                             :	out   STD_ULOGIC);
end component;


----- Component and2_1 -----
component and2_1
-- synopsys translate_off
   generic(
      TimingChecksOn: Boolean := DefaultTimingChecksOn;
      InstancePath: STRING := "*";
      Xon: Boolean := DefaultXon;
      MsgOn: Boolean := DefaultMsgOn;
      tpd_ip1_op                     :	VitalDelayType01 := (116.070 ps, 103.200 ps);
      tpd_ip2_op                     :	VitalDelayType01 := (116.070 ps, 113.380 ps);
      tipd_ip1                       :	VitalDelayType01 := (0.000 ps, 0.000 ps);
      tipd_ip2                       :	VitalDelayType01 := (0.000 ps, 0.000 ps));

-- synopsys translate_on
   port(
      ip1                            :	in    STD_ULOGIC;
      ip2                            :	in    STD_ULOGIC;
      op                             :	out   STD_ULOGIC);
end component;


----- Component and2_2 -----
component and2_2
-- synopsys translate_off
   generic(
      TimingChecksOn: Boolean := DefaultTimingChecksOn;
      InstancePath: STRING := "*";
      Xon: Boolean := DefaultXon;
      MsgOn: Boolean := DefaultMsgOn;
      tpd_ip1_op                     :	VitalDelayType01 := (102.430 ps, 90.721 ps);
      tpd_ip2_op                     :	VitalDelayType01 := (102.430 ps, 99.406 ps);
      tipd_ip1                       :	VitalDelayType01 := (0.000 ps, 0.000 ps);
      tipd_ip2                       :	VitalDelayType01 := (0.000 ps, 0.000 ps));

-- synopsys translate_on
   port(
      ip1                            :	in    STD_ULOGIC;
      ip2                            :	in    STD_ULOGIC;
      op                             :	out   STD_ULOGIC);
end component;


----- Component and2_4 -----
component and2_4
-- synopsys translate_off
   generic(
      TimingChecksOn: Boolean := DefaultTimingChecksOn;
      InstancePath: STRING := "*";
      Xon: Boolean := DefaultXon;
      MsgOn: Boolean := DefaultMsgOn;
      tpd_ip1_op                     :	VitalDelayType01 := (118.220 ps, 105.900 ps);
      tpd_ip2_op                     :	VitalDelayType01 := (118.220 ps, 114.300 ps);
      tipd_ip1                       :	VitalDelayType01 := (0.000 ps, 0.000 ps);
      tipd_ip2                       :	VitalDelayType01 := (0.000 ps, 0.000 ps));

-- synopsys translate_on
   port(
      ip1                            :	in    STD_ULOGIC;
      ip2                            :	in    STD_ULOGIC;
      op                             :	out   STD_ULOGIC);
end component;


----- Component and3_1 -----
component and3_1
-- synopsys translate_off
   generic(
      TimingChecksOn: Boolean := DefaultTimingChecksOn;
      InstancePath: STRING := "*";
      Xon: Boolean := DefaultXon;
      MsgOn: Boolean := DefaultMsgOn;
      tpd_ip1_op                     :	VitalDelayType01 := (188.200 ps, 153.370 ps);
      tpd_ip2_op                     :	VitalDelayType01 := (188.200 ps, 168.880 ps);
      tpd_ip3_op                     :	VitalDelayType01 := (188.200 ps, 171.920 ps);
      tipd_ip1                       :	VitalDelayType01 := (0.000 ps, 0.000 ps);
      tipd_ip2                       :	VitalDelayType01 := (0.000 ps, 0.000 ps);
      tipd_ip3                       :	VitalDelayType01 := (0.000 ps, 0.000 ps));

-- synopsys translate_on
   port(
      ip1                            :	in    STD_ULOGIC;
      ip2                            :	in    STD_ULOGIC;
      ip3                            :	in    STD_ULOGIC;
      op                             :	out   STD_ULOGIC);
end component;


----- Component and3_2 -----
component and3_2
-- synopsys translate_off
   generic(
      TimingChecksOn: Boolean := DefaultTimingChecksOn;
      InstancePath: STRING := "*";
      Xon: Boolean := DefaultXon;
      MsgOn: Boolean := DefaultMsgOn;
      tpd_ip1_op                     :	VitalDelayType01 := (166.520 ps, 135.070 ps);
      tpd_ip2_op                     :	VitalDelayType01 := (166.520 ps, 148.540 ps);
      tpd_ip3_op                     :	VitalDelayType01 := (166.520 ps, 156.510 ps);
      tipd_ip1                       :	VitalDelayType01 := (0.000 ps, 0.000 ps);
      tipd_ip2                       :	VitalDelayType01 := (0.000 ps, 0.000 ps);
      tipd_ip3                       :	VitalDelayType01 := (0.000 ps, 0.000 ps));

-- synopsys translate_on
   port(
      ip1                            :	in    STD_ULOGIC;
      ip2                            :	in    STD_ULOGIC;
      ip3                            :	in    STD_ULOGIC;
      op                             :	out   STD_ULOGIC);
end component;


----- Component and3_4 -----
component and3_4
-- synopsys translate_off
   generic(
      TimingChecksOn: Boolean := DefaultTimingChecksOn;
      InstancePath: STRING := "*";
      Xon: Boolean := DefaultXon;
      MsgOn: Boolean := DefaultMsgOn;
      tpd_ip1_op                     :	VitalDelayType01 := (195.550 ps, 160.980 ps);
      tpd_ip2_op                     :	VitalDelayType01 := (195.550 ps, 171.460 ps);
      tpd_ip3_op                     :	VitalDelayType01 := (195.550 ps, 176.830 ps);
      tipd_ip1                       :	VitalDelayType01 := (0.000 ps, 0.000 ps);
      tipd_ip2                       :	VitalDelayType01 := (0.000 ps, 0.000 ps);
      tipd_ip3                       :	VitalDelayType01 := (0.000 ps, 0.000 ps));

-- synopsys translate_on
   port(
      ip1                            :	in    STD_ULOGIC;
      ip2                            :	in    STD_ULOGIC;
      ip3                            :	in    STD_ULOGIC;
      op                             :	out   STD_ULOGIC);
end component;


----- Component and4_1 -----
component and4_1
-- synopsys translate_off
   generic(
      TimingChecksOn: Boolean := DefaultTimingChecksOn;
      InstancePath: STRING := "*";
      Xon: Boolean := DefaultXon;
      MsgOn: Boolean := DefaultMsgOn;
      tpd_ip1_op                     :	VitalDelayType01 := (244.970 ps, 185.870 ps);
      tpd_ip2_op                     :	VitalDelayType01 := (244.970 ps, 202.780 ps);
      tpd_ip3_op                     :	VitalDelayType01 := (244.970 ps, 214.840 ps);
      tpd_ip4_op                     :	VitalDelayType01 := (244.970 ps, 220.000 ps);
      tipd_ip1                       :	VitalDelayType01 := (0.000 ps, 0.000 ps);
      tipd_ip2                       :	VitalDelayType01 := (0.000 ps, 0.000 ps);
      tipd_ip3                       :	VitalDelayType01 := (0.000 ps, 0.000 ps);
      tipd_ip4                       :	VitalDelayType01 := (0.000 ps, 0.000 ps));

-- synopsys translate_on
   port(
      ip1                            :	in    STD_ULOGIC;
      ip2                            :	in    STD_ULOGIC;
      ip3                            :	in    STD_ULOGIC;
      ip4                            :	in    STD_ULOGIC;
      op                             :	out   STD_ULOGIC);
end component;


----- Component and4_2 -----
component and4_2
-- synopsys translate_off
   generic(
      TimingChecksOn: Boolean := DefaultTimingChecksOn;
      InstancePath: STRING := "*";
      Xon: Boolean := DefaultXon;
      MsgOn: Boolean := DefaultMsgOn;
      tpd_ip1_op                     :	VitalDelayType01 := (214.090 ps, 160.200 ps);
      tpd_ip2_op                     :	VitalDelayType01 := (214.090 ps, 176.760 ps);
      tpd_ip3_op                     :	VitalDelayType01 := (214.090 ps, 188.170 ps);
      tpd_ip4_op                     :	VitalDelayType01 := (214.090 ps, 193.070 ps);
      tipd_ip1                       :	VitalDelayType01 := (0.000 ps, 0.000 ps);
      tipd_ip2                       :	VitalDelayType01 := (0.000 ps, 0.000 ps);
      tipd_ip3                       :	VitalDelayType01 := (0.000 ps, 0.000 ps);
      tipd_ip4                       :	VitalDelayType01 := (0.000 ps, 0.000 ps));

-- synopsys translate_on
   port(
      ip1                            :	in    STD_ULOGIC;
      ip2                            :	in    STD_ULOGIC;
      ip3                            :	in    STD_ULOGIC;
      ip4                            :	in    STD_ULOGIC;
      op                             :	out   STD_ULOGIC);
end component;


----- Component and4_4 -----
component and4_4
-- synopsys translate_off
   generic(
      TimingChecksOn: Boolean := DefaultTimingChecksOn;
      InstancePath: STRING := "*";
      Xon: Boolean := DefaultXon;
      MsgOn: Boolean := DefaultMsgOn;
      tpd_ip1_op                     :	VitalDelayType01 := (253.610 ps, 193.160 ps);
      tpd_ip2_op                     :	VitalDelayType01 := (253.610 ps, 209.720 ps);
      tpd_ip3_op                     :	VitalDelayType01 := (253.610 ps, 221.120 ps);
      tpd_ip4_op                     :	VitalDelayType01 := (253.610 ps, 226.110 ps);
      tipd_ip1                       :	VitalDelayType01 := (0.000 ps, 0.000 ps);
      tipd_ip2                       :	VitalDelayType01 := (0.000 ps, 0.000 ps);
      tipd_ip3                       :	VitalDelayType01 := (0.000 ps, 0.000 ps);
      tipd_ip4                       :	VitalDelayType01 := (0.000 ps, 0.000 ps));

-- synopsys translate_on
   port(
      ip1                            :	in    STD_ULOGIC;
      ip2                            :	in    STD_ULOGIC;
      ip3                            :	in    STD_ULOGIC;
      ip4                            :	in    STD_ULOGIC;
      op                             :	out   STD_ULOGIC);
end component;


----- Component bufzp_2 -----
component bufzp_2
-- synopsys translate_off
   generic(
      TimingChecksOn: Boolean := DefaultTimingChecksOn;
      InstancePath: STRING := "*";
      Xon: Boolean := DefaultXon;
      MsgOn: Boolean := DefaultMsgOn;
      tpd_c_op                       :	VitalDelayType01z := 
               (146.650 ps, 151.120 ps, 146.650 ps, 146.650 ps, 151.120 ps, 151.120 ps);
      tpd_ip_op                      :	VitalDelayType01 := (154.830 ps, 154.990 ps);
      tipd_c                         :	VitalDelayType01 := (0.000 ps, 0.000 ps);
      tipd_ip                        :	VitalDelayType01 := (0.000 ps, 0.000 ps));

-- synopsys translate_on
   port(
      c                              :	in    STD_ULOGIC;
      ip                             :	in    STD_ULOGIC;
      op                             :	out   STD_ULOGIC);
end component;


----- Component buf_1 -----
component buf_1
-- synopsys translate_off
   generic(
      TimingChecksOn: Boolean := DefaultTimingChecksOn;
      InstancePath: STRING := "*";
      Xon: Boolean := DefaultXon;
      MsgOn: Boolean := DefaultMsgOn;
      tpd_ip_op                      :	VitalDelayType01 := (79.087 ps, 82.212 ps);
      tipd_ip                        :	VitalDelayType01 := (0.000 ps, 0.000 ps));

-- synopsys translate_on
   port(
      ip                             :	in    STD_ULOGIC;
      op                             :	out   STD_ULOGIC);
end component;


----- Component buf_2 -----
component buf_2
-- synopsys translate_off
   generic(
      TimingChecksOn: Boolean := DefaultTimingChecksOn;
      InstancePath: STRING := "*";
      Xon: Boolean := DefaultXon;
      MsgOn: Boolean := DefaultMsgOn;
      tpd_ip_op                      :	VitalDelayType01 := (64.644 ps, 68.004 ps);
      tipd_ip                        :	VitalDelayType01 := (0.000 ps, 0.000 ps));

-- synopsys translate_on
   port(
      ip                             :	in    STD_ULOGIC;
      op                             :	out   STD_ULOGIC);
end component;


----- Component buf_4 -----
component buf_4
-- synopsys translate_off
   generic(
      TimingChecksOn: Boolean := DefaultTimingChecksOn;
      InstancePath: STRING := "*";
      Xon: Boolean := DefaultXon;
      MsgOn: Boolean := DefaultMsgOn;
      tpd_ip_op                      :	VitalDelayType01 := (49.662 ps, 52.426 ps);
      tipd_ip                        :	VitalDelayType01 := (0.000 ps, 0.000 ps));

-- synopsys translate_on
   port(
      ip                             :	in    STD_ULOGIC;
      op                             :	out   STD_ULOGIC);
end component;


----- Component cd_8 -----
component cd_8
-- synopsys translate_off
   generic(
      TimingChecksOn: Boolean := DefaultTimingChecksOn;
      InstancePath: STRING := "*";
      Xon: Boolean := DefaultXon;
      MsgOn: Boolean := DefaultMsgOn;
      tpd_ip_op                      :	VitalDelayType01 := (127.410 ps, 130.580 ps);
      tipd_ip                        :	VitalDelayType01 := (0.000 ps, 0.000 ps));

-- synopsys translate_on
   port(
      ip                             :	in    STD_ULOGIC;
      op                             :	out   STD_ULOGIC);
end component;


----- Component cd_12 -----
component cd_12
-- synopsys translate_off
   generic(
      TimingChecksOn: Boolean := DefaultTimingChecksOn;
      InstancePath: STRING := "*";
      Xon: Boolean := DefaultXon;
      MsgOn: Boolean := DefaultMsgOn;
      tpd_ip_op                      :	VitalDelayType01 := (203.990 ps, 207.190 ps);
      tipd_ip                        :	VitalDelayType01 := (0.000 ps, 0.000 ps));

-- synopsys translate_on
   port(
      ip                             :	in    STD_ULOGIC;
      op                             :	out   STD_ULOGIC);
end component;


----- Component cd_16 -----
component cd_16
-- synopsys translate_off
   generic(
      TimingChecksOn: Boolean := DefaultTimingChecksOn;
      InstancePath: STRING := "*";
      Xon: Boolean := DefaultXon;
      MsgOn: Boolean := DefaultMsgOn;
      tpd_ip_op                      :	VitalDelayType01 := (284.870 ps, 287.890 ps);
      tipd_ip                        :	VitalDelayType01 := (0.000 ps, 0.000 ps));

-- synopsys translate_on
   port(
      ip                             :	in    STD_ULOGIC;
      op                             :	out   STD_ULOGIC);
end component;


----- Component dksp_1 -----
component dksp_1
-- synopsys translate_off
   generic(
      TimingChecksOn: Boolean := DefaultTimingChecksOn;
      InstancePath: STRING := "*";
      Xon: Boolean := DefaultXon;
      MsgOn: Boolean := DefaultMsgOn;
      tpd_ck_q                       :	VitalDelayType01 := (427.610 ps, 416.610 ps);
      tpd_ck_qb                      :	VitalDelayType01 := (320.450 ps, 318.050 ps);
      tsetup_ip_ck                   :	VitalDelayType := 214.840 ps;
      tsetup_sb_ck                   :	VitalDelayType := 136.720 ps;
      thold_sb_ck                    :	VitalDelayType := 0.000 ps;
      thold_ip_ck                    :	VitalDelayType := 0.000 ps;
      tpw_ck_posedge                 :	VitalDelayType := 750.000 ps;
      tpw_ck_negedge                 :	VitalDelayType := 750.000 ps;
      ticd_ck                        :	VitalDelayType := 0.000 ps;
      tisd_sb_ck                     :	VitalDelayType := 0.000 ps;
      tisd_ip_ck                     :	VitalDelayType := 0.000 ps;
      tipd_ck                        :	VitalDelayType01 := (0.000 ps, 0.000 ps);
      tipd_ip                        :	VitalDelayType01 := (0.000 ps, 0.000 ps);
      tipd_sb                        :	VitalDelayType01 := (0.000 ps, 0.000 ps));

-- synopsys translate_on
   port(
      ck                             :	in    STD_ULOGIC;
      ip                             :	in    STD_ULOGIC;
      sb                             :	in    STD_ULOGIC;
      q                              :	out   STD_ULOGIC;
      qb                             :	out   STD_ULOGIC);
end component;


----- Component dp_1 -----
component dp_1
-- synopsys translate_off
   generic(
      TimingChecksOn: Boolean := DefaultTimingChecksOn;
      InstancePath: STRING := "*";
      Xon: Boolean := DefaultXon;
      MsgOn: Boolean := DefaultMsgOn;
      tpd_ck_q                       :	VitalDelayType01 := (142.660 ps, 268.490 ps);
      thold_ip_ck                    :	VitalDelayType := 0.000 ps;
      tsetup_ip_ck                   :	VitalDelayType := 214.840 ps;
      tpw_ck_posedge                 :	VitalDelayType := 750.000 ps;
      tpw_ck_negedge                 :	VitalDelayType := 750.000 ps;
      tisd_ip_ck                     :	VitalDelayType := 0.000 ps;
      ticd_ck                        :	VitalDelayType := 0.000 ps;
      tipd_ck                        :	VitalDelayType01 := (0.000 ps, 0.000 ps);
      tipd_ip                        :	VitalDelayType01 := (0.000 ps, 0.000 ps));

-- synopsys translate_on
   port(
      ck                             :	in    STD_ULOGIC;
      ip                             :	in    STD_ULOGIC;
      q                              :	out   STD_ULOGIC);
end component;


----- Component dp_2 -----
component dp_2
-- synopsys translate_off
   generic(
      TimingChecksOn: Boolean := DefaultTimingChecksOn;
      InstancePath: STRING := "*";
      Xon: Boolean := DefaultXon;
      MsgOn: Boolean := DefaultMsgOn;
      tpd_ck_q                       :	VitalDelayType01 := (148.870 ps, 281.580 ps);
      thold_ip_ck                    :	VitalDelayType := 0.000 ps;
      tsetup_ip_ck                   :	VitalDelayType := 214.840 ps;
      tpw_ck_posedge                 :	VitalDelayType := 750.000 ps;
      tpw_ck_negedge                 :	VitalDelayType := 750.000 ps;
      tisd_ip_ck                     :	VitalDelayType := 0.000 ps;
      ticd_ck                        :	VitalDelayType := 0.000 ps;
      tipd_ck                        :	VitalDelayType01 := (0.000 ps, 0.000 ps);
      tipd_ip                        :	VitalDelayType01 := (0.000 ps, 0.000 ps));

-- synopsys translate_on
   port(
      ck                             :	in    STD_ULOGIC;
      ip                             :	in    STD_ULOGIC;
      q                              :	out   STD_ULOGIC);
end component;


----- Component dp_4 -----
component dp_4
-- synopsys translate_off
   generic(
      TimingChecksOn: Boolean := DefaultTimingChecksOn;
      InstancePath: STRING := "*";
      Xon: Boolean := DefaultXon;
      MsgOn: Boolean := DefaultMsgOn;
      tpd_ck_q                       :	VitalDelayType01 := (181.580 ps, 326.090 ps);
      thold_ip_ck                    :	VitalDelayType := 0.000 ps;
      tsetup_ip_ck                   :	VitalDelayType := 214.840 ps;
      tpw_ck_posedge                 :	VitalDelayType := 750.000 ps;
      tpw_ck_negedge                 :	VitalDelayType := 750.000 ps;
      tisd_ip_ck                     :	VitalDelayType := 0.000 ps;
      ticd_ck                        :	VitalDelayType := 0.000 ps;
      tipd_ck                        :	VitalDelayType01 := (0.000 ps, 0.000 ps);
      tipd_ip                        :	VitalDelayType01 := (0.000 ps, 0.000 ps));

-- synopsys translate_on
   port(
      ck                             :	in    STD_ULOGIC;
      ip                             :	in    STD_ULOGIC;
      q                              :	out   STD_ULOGIC);
end component;


----- Component drp_1 -----
component drp_1
-- synopsys translate_off
   generic(
      TimingChecksOn: Boolean := DefaultTimingChecksOn;
      InstancePath: STRING := "*";
      Xon: Boolean := DefaultXon;
      MsgOn: Boolean := DefaultMsgOn;
      tpd_rb_q                       :	VitalDelayType01 := (142.400 ps, 476.020 ps);
      tpd_ck_q                       :	VitalDelayType01 := (142.400 ps, 264.340 ps);
      thold_ip_ck                    :	VitalDelayType := 0.000 ps;
      tsetup_ip_ck                   :	VitalDelayType := 253.910 ps;
      trecovery_rb_ck                :	VitalDelayType := 253.910 ps;
      thold_rb_ck                    :	VitalDelayType := 0.000 ps;
      tpw_ck_posedge                 :	VitalDelayType := 750.000 ps;
      tpw_ck_negedge                 :	VitalDelayType := 750.000 ps;
      tisd_ip_ck                     :	VitalDelayType := 0.000 ps;
      ticd_ck                        :	VitalDelayType := 0.000 ps;
      tisd_rb_ck                     :	VitalDelayType := 0.000 ps;
      tipd_ck                        :	VitalDelayType01 := (0.000 ps, 0.000 ps);
      tipd_ip                        :	VitalDelayType01 := (0.000 ps, 0.000 ps);
      tipd_rb                        :	VitalDelayType01 := (0.000 ps, 0.000 ps));

-- synopsys translate_on
   port(
      ck                             :	in    STD_ULOGIC;
      ip                             :	in    STD_ULOGIC;
      rb                             :	in    STD_ULOGIC;
      q                              :	out   STD_ULOGIC);
end component;


----- Component drp_2 -----
component drp_2
-- synopsys translate_off
   generic(
      TimingChecksOn: Boolean := DefaultTimingChecksOn;
      InstancePath: STRING := "*";
      Xon: Boolean := DefaultXon;
      MsgOn: Boolean := DefaultMsgOn;
      tpd_rb_q                       :	VitalDelayType01 := (160.010 ps, 506.390 ps);
      tpd_ck_q                       :	VitalDelayType01 := (160.010 ps, 294.370 ps);
      thold_ip_ck                    :	VitalDelayType := 0.000 ps;
      tsetup_ip_ck                   :	VitalDelayType := 253.910 ps;
      trecovery_rb_ck                :	VitalDelayType := 253.910 ps;
      thold_rb_ck                    :	VitalDelayType := 0.000 ps;
      tpw_ck_posedge                 :	VitalDelayType := 750.000 ps;
      tpw_ck_negedge                 :	VitalDelayType := 750.000 ps;
      tisd_ip_ck                     :	VitalDelayType := 0.000 ps;
      ticd_ck                        :	VitalDelayType := 0.000 ps;
      tisd_rb_ck                     :	VitalDelayType := 0.000 ps;
      tipd_ck                        :	VitalDelayType01 := (0.000 ps, 0.000 ps);
      tipd_ip                        :	VitalDelayType01 := (0.000 ps, 0.000 ps);
      tipd_rb                        :	VitalDelayType01 := (0.000 ps, 0.000 ps));

-- synopsys translate_on
   port(
      ck                             :	in    STD_ULOGIC;
      ip                             :	in    STD_ULOGIC;
      rb                             :	in    STD_ULOGIC;
      q                              :	out   STD_ULOGIC);
end component;


----- Component drp_4 -----
component drp_4
-- synopsys translate_off
   generic(
      TimingChecksOn: Boolean := DefaultTimingChecksOn;
      InstancePath: STRING := "*";
      Xon: Boolean := DefaultXon;
      MsgOn: Boolean := DefaultMsgOn;
      tpd_rb_q                       :	VitalDelayType01 := (188.200 ps, 549.430 ps);
      tpd_ck_q                       :	VitalDelayType01 := (188.200 ps, 334.830 ps);
      thold_ip_ck                    :	VitalDelayType := 0.000 ps;
      tsetup_ip_ck                   :	VitalDelayType := 253.910 ps;
      trecovery_rb_ck                :	VitalDelayType := 253.910 ps;
      thold_rb_ck                    :	VitalDelayType := 0.000 ps;
      tpw_ck_posedge                 :	VitalDelayType := 750.000 ps;
      tpw_ck_negedge                 :	VitalDelayType := 750.000 ps;
      tisd_ip_ck                     :	VitalDelayType := 0.000 ps;
      ticd_ck                        :	VitalDelayType := 0.000 ps;
      tisd_rb_ck                     :	VitalDelayType := 0.000 ps;
      tipd_ck                        :	VitalDelayType01 := (0.000 ps, 0.000 ps);
      tipd_ip                        :	VitalDelayType01 := (0.000 ps, 0.000 ps);
      tipd_rb                        :	VitalDelayType01 := (0.000 ps, 0.000 ps));

-- synopsys translate_on
   port(
      ck                             :	in    STD_ULOGIC;
      ip                             :	in    STD_ULOGIC;
      rb                             :	in    STD_ULOGIC;
      q                              :	out   STD_ULOGIC);
end component;


----- Component drsp_1 -----
component drsp_1
-- synopsys translate_off
   generic(
      TimingChecksOn: Boolean := DefaultTimingChecksOn;
      InstancePath: STRING := "*";
      Xon: Boolean := DefaultXon;
      MsgOn: Boolean := DefaultMsgOn;
      tpd_rb_q                       :	VitalDelayType01 := (473.120 ps, 500.060 ps);
      tpd_s_q                        :	VitalDelayType01 := (473.120 ps, 500.060 ps);
      tpd_ck_q                       :	VitalDelayType01 := (141.660 ps, 269.630 ps);
      thold_ip_ck                    :	VitalDelayType := 0.000 ps;
      tsetup_ip_ck                   :	VitalDelayType := 410.160 ps;
      trecovery_rb_ck                :	VitalDelayType := 253.910 ps;
      trecovery_s_ck                 :	VitalDelayType := 410.160 ps;
      thold_s_ck                     :	VitalDelayType := 0.000 ps;
      thold_rb_ck                    :	VitalDelayType := 0.000 ps;
      tpw_ck_posedge                 :	VitalDelayType := 750.000 ps;
      tpw_ck_negedge                 :	VitalDelayType := 750.000 ps;
      tisd_ip_ck                     :	VitalDelayType := 0.000 ps;
      ticd_ck                        :	VitalDelayType := 0.000 ps;
      tisd_s_ck                      :	VitalDelayType := 0.000 ps;
      tisd_rb_ck                     :	VitalDelayType := 0.000 ps;
      tipd_ck                        :	VitalDelayType01 := (0.000 ps, 0.000 ps);
      tipd_ip                        :	VitalDelayType01 := (0.000 ps, 0.000 ps);
      tipd_rb                        :	VitalDelayType01 := (0.000 ps, 0.000 ps);
      tipd_s                         :	VitalDelayType01 := (0.000 ps, 0.000 ps));

-- synopsys translate_on
   port(
      ck                             :	in    STD_ULOGIC;
      ip                             :	in    STD_ULOGIC;
      rb                             :	in    STD_ULOGIC;
      s                              :	in    STD_ULOGIC;
      q                              :	out   STD_ULOGIC);
end component;


----- Component drsp_2 -----
component drsp_2
-- synopsys translate_off
   generic(
      TimingChecksOn: Boolean := DefaultTimingChecksOn;
      InstancePath: STRING := "*";
      Xon: Boolean := DefaultXon;
      MsgOn: Boolean := DefaultMsgOn;
      tpd_rb_q                       :	VitalDelayType01 := (494.140 ps, 528.510 ps);
      tpd_s_q                        :	VitalDelayType01 := (494.140 ps, 528.510 ps);
      tpd_ck_q                       :	VitalDelayType01 := (161.510 ps, 297.680 ps);
      thold_ip_ck                    :	VitalDelayType := 0.000 ps;
      tsetup_ip_ck                   :	VitalDelayType := 410.160 ps;
      trecovery_rb_ck                :	VitalDelayType := 292.970 ps;
      trecovery_s_ck                 :	VitalDelayType := 410.160 ps;
      thold_s_ck                     :	VitalDelayType := 0.000 ps;
      thold_rb_ck                    :	VitalDelayType := 0.000 ps;
      tpw_ck_posedge                 :	VitalDelayType := 750.000 ps;
      tpw_ck_negedge                 :	VitalDelayType := 750.000 ps;
      tisd_ip_ck                     :	VitalDelayType := 0.000 ps;
      ticd_ck                        :	VitalDelayType := 0.000 ps;
      tisd_s_ck                      :	VitalDelayType := 0.000 ps;
      tisd_rb_ck                     :	VitalDelayType := 0.000 ps;
      tipd_ck                        :	VitalDelayType01 := (0.000 ps, 0.000 ps);
      tipd_ip                        :	VitalDelayType01 := (0.000 ps, 0.000 ps);
      tipd_rb                        :	VitalDelayType01 := (0.000 ps, 0.000 ps);
      tipd_s                         :	VitalDelayType01 := (0.000 ps, 0.000 ps));

-- synopsys translate_on
   port(
      ck                             :	in    STD_ULOGIC;
      ip                             :	in    STD_ULOGIC;
      rb                             :	in    STD_ULOGIC;
      s                              :	in    STD_ULOGIC;
      q                              :	out   STD_ULOGIC);
end component;


----- Component drsp_4 -----
component drsp_4
-- synopsys translate_off
   generic(
      TimingChecksOn: Boolean := DefaultTimingChecksOn;
      InstancePath: STRING := "*";
      Xon: Boolean := DefaultXon;
      MsgOn: Boolean := DefaultMsgOn;
      tpd_rb_q                       :	VitalDelayType01 := (522.920 ps, 571.100 ps);
      tpd_s_q                        :	VitalDelayType01 := (522.920 ps, 571.100 ps);
      tpd_ck_q                       :	VitalDelayType01 := (189.530 ps, 338.430 ps);
      thold_ip_ck                    :	VitalDelayType := 0.000 ps;
      tsetup_ip_ck                   :	VitalDelayType := 410.160 ps;
      trecovery_rb_ck                :	VitalDelayType := 292.970 ps;
      trecovery_s_ck                 :	VitalDelayType := 410.160 ps;
      thold_s_ck                     :	VitalDelayType := 0.000 ps;
      thold_rb_ck                    :	VitalDelayType := 0.000 ps;
      tpw_ck_posedge                 :	VitalDelayType := 750.000 ps;
      tpw_ck_negedge                 :	VitalDelayType := 750.000 ps;
      tisd_ip_ck                     :	VitalDelayType := 0.000 ps;
      ticd_ck                        :	VitalDelayType := 0.000 ps;
      tisd_s_ck                      :	VitalDelayType := 0.000 ps;
      tisd_rb_ck                     :	VitalDelayType := 0.000 ps;
      tipd_ck                        :	VitalDelayType01 := (0.000 ps, 0.000 ps);
      tipd_ip                        :	VitalDelayType01 := (0.000 ps, 0.000 ps);
      tipd_rb                        :	VitalDelayType01 := (0.000 ps, 0.000 ps);
      tipd_s                         :	VitalDelayType01 := (0.000 ps, 0.000 ps));

-- synopsys translate_on
   port(
      ck                             :	in    STD_ULOGIC;
      ip                             :	in    STD_ULOGIC;
      rb                             :	in    STD_ULOGIC;
      s                              :	in    STD_ULOGIC;
      q                              :	out   STD_ULOGIC);
end component;


----- Component dtrsp_2 -----
component dtrsp_2
-- synopsys translate_off
   generic(
      TimingChecksOn: Boolean := DefaultTimingChecksOn;
      InstancePath: STRING := "*";
      Xon: Boolean := DefaultXon;
      MsgOn: Boolean := DefaultMsgOn;
      tpd_rb_q                       :	VitalDelayType01 := (530.020 ps, 578.110 ps);
      tpd_s_q                        :	VitalDelayType01 := (530.020 ps, 578.110 ps);
      tpd_ck_q                       :	VitalDelayType01 := (187.440 ps, 321.350 ps);
      thold_ip_ck                    :	VitalDelayType := 0.000 ps;
      tsetup_ip_ck                   :	VitalDelayType := 644.530 ps;
      trecovery_rb_ck                :	VitalDelayType := 292.970 ps;
      trecovery_s_ck                 :	VitalDelayType := 449.220 ps;
      thold_sip_ck                   :	VitalDelayType := 0.000 ps;
      tsetup_sip_ck                  :	VitalDelayType := 644.530 ps;
      thold_sm_ck                    :	VitalDelayType := 0.000 ps;
      tsetup_sm_ck                   :	VitalDelayType := 1386.700 ps;
      thold_s_ck                     :	VitalDelayType := 0.000 ps;
      thold_rb_ck                    :	VitalDelayType := 0.000 ps;
      tpw_ck_posedge                 :	VitalDelayType := 750.000 ps;
      tpw_ck_negedge                 :	VitalDelayType := 750.000 ps;
      tisd_ip_ck                     :	VitalDelayType := 0.000 ps;
      ticd_ck                        :	VitalDelayType := 0.000 ps;
      tisd_sip_ck                    :	VitalDelayType := 0.000 ps;
      tisd_sm_ck                     :	VitalDelayType := 0.000 ps;
      tisd_s_ck                      :	VitalDelayType := 0.000 ps;
      tisd_rb_ck                     :	VitalDelayType := 0.000 ps;
      tipd_ck                        :	VitalDelayType01 := (0.000 ps, 0.000 ps);
      tipd_ip                        :	VitalDelayType01 := (0.000 ps, 0.000 ps);
      tipd_rb                        :	VitalDelayType01 := (0.000 ps, 0.000 ps);
      tipd_s                         :	VitalDelayType01 := (0.000 ps, 0.000 ps);
      tipd_sip                       :	VitalDelayType01 := (0.000 ps, 0.000 ps);
      tipd_sm                        :	VitalDelayType01 := (0.000 ps, 0.000 ps));

-- synopsys translate_on
   port(
      ck                             :	in    STD_ULOGIC;
      ip                             :	in    STD_ULOGIC;
      rb                             :	in    STD_ULOGIC;
      s                              :	in    STD_ULOGIC;
      sip                            :	in    STD_ULOGIC;
      sm                             :	in    STD_ULOGIC;
      q                              :	out   STD_ULOGIC);
end component;


----- Component fulladder -----
component fulladder
-- synopsys translate_off
   generic(
      TimingChecksOn: Boolean := DefaultTimingChecksOn;
      InstancePath: STRING := "*";
      Xon: Boolean := DefaultXon;
      MsgOn: Boolean := DefaultMsgOn;
      tpd_a_s                        :	VitalDelayType01 := (479.190 ps, 367.150 ps);
      tpd_b_s                        :	VitalDelayType01 := (479.190 ps, 367.150 ps);
      tpd_ci_s                       :	VitalDelayType01 := (479.190 ps, 367.150 ps);
      tpd_a_co                       :	VitalDelayType01 := (240.520 ps, 316.030 ps);
      tpd_b_co                       :	VitalDelayType01 := (240.520 ps, 316.030 ps);
      tpd_ci_co                      :	VitalDelayType01 := (240.520 ps, 316.030 ps);
      tipd_a                         :	VitalDelayType01 := (0.000 ps, 0.000 ps);
      tipd_b                         :	VitalDelayType01 := (0.000 ps, 0.000 ps);
      tipd_ci                        :	VitalDelayType01 := (0.000 ps, 0.000 ps));

-- synopsys translate_on
   port(
      a                              :	in    STD_ULOGIC;
      b                              :	in    STD_ULOGIC;
      ci                             :	in    STD_ULOGIC;
      s                              :	out   STD_ULOGIC;
      co                             :	out   STD_ULOGIC);
end component;


----- Component invzp_1 -----
component invzp_1
-- synopsys translate_off
   generic(
      TimingChecksOn: Boolean := DefaultTimingChecksOn;
      InstancePath: STRING := "*";
      Xon: Boolean := DefaultXon;
      MsgOn: Boolean := DefaultMsgOn;
      tpd_c_op                       :	VitalDelayType01z := 
               (98.205 ps, 106.050 ps, 98.205 ps, 98.205 ps, 106.050 ps, 106.050 ps);
      tpd_ip_op                      :	VitalDelayType01 := (98.205 ps, 106.050 ps);
      tipd_c                         :	VitalDelayType01 := (0.000 ps, 0.000 ps);
      tipd_ip                        :	VitalDelayType01 := (0.000 ps, 0.000 ps));

-- synopsys translate_on
   port(
      c                              :	in    STD_ULOGIC;
      ip                             :	in    STD_ULOGIC;
      op                             :	out   STD_ULOGIC);
end component;


----- Component invzp_2 -----
component invzp_2
-- synopsys translate_off
   generic(
      TimingChecksOn: Boolean := DefaultTimingChecksOn;
      InstancePath: STRING := "*";
      Xon: Boolean := DefaultXon;
      MsgOn: Boolean := DefaultMsgOn;
      tpd_c_op                       :	VitalDelayType01z := 
               (91.558 ps, 97.887 ps, 91.558 ps, 91.558 ps, 97.887 ps, 97.887 ps);
      tpd_ip_op                      :	VitalDelayType01 := (91.558 ps, 97.887 ps);
      tipd_c                         :	VitalDelayType01 := (0.000 ps, 0.000 ps);
      tipd_ip                        :	VitalDelayType01 := (0.000 ps, 0.000 ps));

-- synopsys translate_on
   port(
      c                              :	in    STD_ULOGIC;
      ip                             :	in    STD_ULOGIC;
      op                             :	out   STD_ULOGIC);
end component;


----- Component invzp_4 -----
component invzp_4
-- synopsys translate_off
   generic(
      TimingChecksOn: Boolean := DefaultTimingChecksOn;
      InstancePath: STRING := "*";
      Xon: Boolean := DefaultXon;
      MsgOn: Boolean := DefaultMsgOn;
      tpd_c_op                       :	VitalDelayType01z := 
               (80.532 ps, 98.090 ps, 80.532 ps, 80.532 ps, 98.090 ps, 98.090 ps);
      tpd_ip_op                      :	VitalDelayType01 := (80.532 ps, 98.090 ps);
      tipd_c                         :	VitalDelayType01 := (0.000 ps, 0.000 ps);
      tipd_ip                        :	VitalDelayType01 := (0.000 ps, 0.000 ps));

-- synopsys translate_on
   port(
      c                              :	in    STD_ULOGIC;
      ip                             :	in    STD_ULOGIC;
      op                             :	out   STD_ULOGIC);
end component;


----- Component inv_1 -----
component inv_1
-- synopsys translate_off
   generic(
      TimingChecksOn: Boolean := DefaultTimingChecksOn;
      InstancePath: STRING := "*";
      Xon: Boolean := DefaultXon;
      MsgOn: Boolean := DefaultMsgOn;
      tpd_ip_op                      :	VitalDelayType01 := (23.626 ps, 22.185 ps);
      tipd_ip                        :	VitalDelayType01 := (0.000 ps, 0.000 ps));

-- synopsys translate_on
   port(
      ip                             :	in    STD_ULOGIC;
      op                             :	out   STD_ULOGIC);
end component;


----- Component inv_2 -----
component inv_2
-- synopsys translate_off
   generic(
      TimingChecksOn: Boolean := DefaultTimingChecksOn;
      InstancePath: STRING := "*";
      Xon: Boolean := DefaultXon;
      MsgOn: Boolean := DefaultMsgOn;
      tpd_ip_op                      :	VitalDelayType01 := (21.393 ps, 20.090 ps);
      tipd_ip                        :	VitalDelayType01 := (0.000 ps, 0.000 ps));

-- synopsys translate_on
   port(
      ip                             :	in    STD_ULOGIC;
      op                             :	out   STD_ULOGIC);
end component;


----- Component inv_4 -----
component inv_4
-- synopsys translate_off
   generic(
      TimingChecksOn: Boolean := DefaultTimingChecksOn;
      InstancePath: STRING := "*";
      Xon: Boolean := DefaultXon;
      MsgOn: Boolean := DefaultMsgOn;
      tpd_ip_op                      :	VitalDelayType01 := (16.043 ps, 15.506 ps);
      tipd_ip                        :	VitalDelayType01 := (0.000 ps, 0.000 ps));

-- synopsys translate_on
   port(
      ip                             :	in    STD_ULOGIC;
      op                             :	out   STD_ULOGIC);
end component;


----- Component jkrp_2 -----
component jkrp_2
-- synopsys translate_off
   generic(
      TimingChecksOn: Boolean := DefaultTimingChecksOn;
      InstancePath: STRING := "*";
      Xon: Boolean := DefaultXon;
      MsgOn: Boolean := DefaultMsgOn;
      tpd_rb_q                       :	VitalDelayType01 := (629.140 ps, 149.610 ps);
      tpd_ck_q                       :	VitalDelayType01 := (629.140 ps, 540.220 ps);
      tpd_rb_qb                      :	VitalDelayType01 := (396.090 ps, 418.370 ps);
      tpd_ck_qb                      :	VitalDelayType01 := (400.780 ps, 418.370 ps);
      tsetup_j_ck                    :	VitalDelayType := 371.090 ps;
      thold_j_ck                     :	VitalDelayType := 0.000 ps;
      tsetup_k_ck                    :	VitalDelayType := 371.090 ps;
      thold_k_ck                     :	VitalDelayType := 0.000 ps;
      trecovery_rb_ck                :	VitalDelayType := 371.090 ps;
      thold_rb_ck                    :	VitalDelayType := 0.000 ps;
      tpw_ck_posedge                 :	VitalDelayType := 750.000 ps;
      tpw_ck_negedge                 :	VitalDelayType := 750.000 ps;
      ticd_ck                        :	VitalDelayType := 0.000 ps;
      tisd_j_ck                      :	VitalDelayType := 0.000 ps;
      tisd_k_ck                      :	VitalDelayType := 0.000 ps;
      tisd_rb_ck                     :	VitalDelayType := 0.000 ps;
      tipd_ck                        :	VitalDelayType01 := (0.000 ps, 0.000 ps);
      tipd_j                         :	VitalDelayType01 := (0.000 ps, 0.000 ps);
      tipd_k                         :	VitalDelayType01 := (0.000 ps, 0.000 ps);
      tipd_rb                        :	VitalDelayType01 := (0.000 ps, 0.000 ps));

-- synopsys translate_on
   port(
      ck                             :	in    STD_ULOGIC;
      j                              :	in    STD_ULOGIC;
      k                              :	in    STD_ULOGIC;
      rb                             :	in    STD_ULOGIC;
      q                              :	out   STD_ULOGIC;
      qb                             :	out   STD_ULOGIC);
end component;


----- Component lp_1 -----
component lp_1
-- synopsys translate_off
   generic(
      TimingChecksOn: Boolean := DefaultTimingChecksOn;
      InstancePath: STRING := "*";
      Xon: Boolean := DefaultXon;
      MsgOn: Boolean := DefaultMsgOn;
      tpd_ck_q                       :	VitalDelayType01 := (158.590 ps, 247.390 ps);
      tpd_ip_q                       :	VitalDelayType01 := (172.470 ps, 247.390 ps);
      thold_ip_ck                    :	VitalDelayType := 253.910 ps;
      tsetup_ip_ck                   :	VitalDelayType := 214.840 ps;
      tpw_ck_posedge                 :	VitalDelayType := 750.000 ps;
      tpw_ck_negedge                 :	VitalDelayType := 750.000 ps;
      tisd_ip_ck                     :	VitalDelayType := 0.000 ps;
      ticd_ck                        :	VitalDelayType := 0.000 ps;
      tipd_ck                        :	VitalDelayType01 := (0.000 ps, 0.000 ps);
      tipd_ip                        :	VitalDelayType01 := (0.000 ps, 0.000 ps));

-- synopsys translate_on
   port(
      ck                             :	in    STD_ULOGIC;
      ip                             :	in    STD_ULOGIC;
      q                              :	out   STD_ULOGIC);
end component;


----- Component lp_2 -----
component lp_2
-- synopsys translate_off
   generic(
      TimingChecksOn: Boolean := DefaultTimingChecksOn;
      InstancePath: STRING := "*";
      Xon: Boolean := DefaultXon;
      MsgOn: Boolean := DefaultMsgOn;
      tpd_ck_q                       :	VitalDelayType01 := (138.830 ps, 217.530 ps);
      tpd_ip_q                       :	VitalDelayType01 := (151.420 ps, 217.530 ps);
      thold_ip_ck                    :	VitalDelayType := 214.840 ps;
      tsetup_ip_ck                   :	VitalDelayType := 175.780 ps;
      tpw_ck_posedge                 :	VitalDelayType := 750.000 ps;
      tpw_ck_negedge                 :	VitalDelayType := 750.000 ps;
      tisd_ip_ck                     :	VitalDelayType := 0.000 ps;
      ticd_ck                        :	VitalDelayType := 0.000 ps;
      tipd_ck                        :	VitalDelayType01 := (0.000 ps, 0.000 ps);
      tipd_ip                        :	VitalDelayType01 := (0.000 ps, 0.000 ps));

-- synopsys translate_on
   port(
      ck                             :	in    STD_ULOGIC;
      ip                             :	in    STD_ULOGIC;
      q                              :	out   STD_ULOGIC);
end component;


----- Component lrp_1 -----
component lrp_1
-- synopsys translate_off
   generic(
      TimingChecksOn: Boolean := DefaultTimingChecksOn;
      InstancePath: STRING := "*";
      Xon: Boolean := DefaultXon;
      MsgOn: Boolean := DefaultMsgOn;
      tpd_ck_q                       :	VitalDelayType01 := (240.430 ps, 270.010 ps);
      tpd_ip_q                       :	VitalDelayType01 := (252.740 ps, 248.460 ps);
      tpd_rb_q                       :	VitalDelayType01 := (250.190 ps, 239.420 ps);
      thold_ip_ck                    :	VitalDelayType := 449.220 ps;
      tsetup_ip_ck                   :	VitalDelayType := 292.970 ps;
      trecovery_rb_ck                :	VitalDelayType := 292.970 ps;
      thold_rb_ck                    :	VitalDelayType := 0.000 ps;
      tpw_ck_posedge                 :	VitalDelayType := 750.000 ps;
      tpw_ck_negedge                 :	VitalDelayType := 750.000 ps;
      tisd_ip_ck                     :	VitalDelayType := 0.000 ps;
      ticd_ck                        :	VitalDelayType := 0.000 ps;
      tisd_rb_ck                     :	VitalDelayType := 0.000 ps;
      tipd_ck                        :	VitalDelayType01 := (0.000 ps, 0.000 ps);
      tipd_ip                        :	VitalDelayType01 := (0.000 ps, 0.000 ps);
      tipd_rb                        :	VitalDelayType01 := (0.000 ps, 0.000 ps));

-- synopsys translate_on
   port(
      ck                             :	in    STD_ULOGIC;
      ip                             :	in    STD_ULOGIC;
      rb                             :	in    STD_ULOGIC;
      q                              :	out   STD_ULOGIC);
end component;


----- Component lrp_2 -----
component lrp_2
-- synopsys translate_off
   generic(
      TimingChecksOn: Boolean := DefaultTimingChecksOn;
      InstancePath: STRING := "*";
      Xon: Boolean := DefaultXon;
      MsgOn: Boolean := DefaultMsgOn;
      tpd_ck_q                       :	VitalDelayType01 := (250.450 ps, 276.060 ps);
      tpd_ip_q                       :	VitalDelayType01 := (259.790 ps, 255.870 ps);
      tpd_rb_q                       :	VitalDelayType01 := (257.990 ps, 248.060 ps);
      thold_ip_ck                    :	VitalDelayType := 371.090 ps;
      tsetup_ip_ck                   :	VitalDelayType := 292.970 ps;
      trecovery_rb_ck                :	VitalDelayType := 292.970 ps;
      thold_rb_ck                    :	VitalDelayType := 0.000 ps;
      tpw_ck_posedge                 :	VitalDelayType := 750.000 ps;
      tpw_ck_negedge                 :	VitalDelayType := 750.000 ps;
      tisd_ip_ck                     :	VitalDelayType := 0.000 ps;
      ticd_ck                        :	VitalDelayType := 0.000 ps;
      tisd_rb_ck                     :	VitalDelayType := 0.000 ps;
      tipd_ck                        :	VitalDelayType01 := (0.000 ps, 0.000 ps);
      tipd_ip                        :	VitalDelayType01 := (0.000 ps, 0.000 ps);
      tipd_rb                        :	VitalDelayType01 := (0.000 ps, 0.000 ps));

-- synopsys translate_on
   port(
      ck                             :	in    STD_ULOGIC;
      ip                             :	in    STD_ULOGIC;
      rb                             :	in    STD_ULOGIC;
      q                              :	out   STD_ULOGIC);
end component;


----- Component lrp_4 -----
component lrp_4
-- synopsys translate_off
   generic(
      TimingChecksOn: Boolean := DefaultTimingChecksOn;
      InstancePath: STRING := "*";
      Xon: Boolean := DefaultXon;
      MsgOn: Boolean := DefaultMsgOn;
      tpd_ck_q                       :	VitalDelayType01 := (262.010 ps, 283.140 ps);
      tpd_ip_q                       :	VitalDelayType01 := (270.350 ps, 267.690 ps);
      tpd_rb_q                       :	VitalDelayType01 := (267.890 ps, 258.840 ps);
      thold_ip_ck                    :	VitalDelayType := 332.030 ps;
      tsetup_ip_ck                   :	VitalDelayType := 292.970 ps;
      trecovery_rb_ck                :	VitalDelayType := 253.910 ps;
      thold_rb_ck                    :	VitalDelayType := 0.000 ps;
      tpw_ck_posedge                 :	VitalDelayType := 750.000 ps;
      tpw_ck_negedge                 :	VitalDelayType := 750.000 ps;
      tisd_ip_ck                     :	VitalDelayType := 0.000 ps;
      ticd_ck                        :	VitalDelayType := 0.000 ps;
      tisd_rb_ck                     :	VitalDelayType := 0.000 ps;
      tipd_ck                        :	VitalDelayType01 := (0.000 ps, 0.000 ps);
      tipd_ip                        :	VitalDelayType01 := (0.000 ps, 0.000 ps);
      tipd_rb                        :	VitalDelayType01 := (0.000 ps, 0.000 ps));

-- synopsys translate_on
   port(
      ck                             :	in    STD_ULOGIC;
      ip                             :	in    STD_ULOGIC;
      rb                             :	in    STD_ULOGIC;
      q                              :	out   STD_ULOGIC);
end component;


----- Component lrsp_1 -----
component lrsp_1
-- synopsys translate_off
   generic(
      TimingChecksOn: Boolean := DefaultTimingChecksOn;
      InstancePath: STRING := "*";
      Xon: Boolean := DefaultXon;
      MsgOn: Boolean := DefaultMsgOn;
      tpd_ck_q                       :	VitalDelayType01 := (209.820 ps, 339.810 ps);
      tpd_ip_q                       :	VitalDelayType01 := (266.900 ps, 367.250 ps);
      tpd_rb_q                       :	VitalDelayType01 := (257.730 ps, 244.580 ps);
      tpd_s_q                        :	VitalDelayType01 := (254.080 ps, 361.440 ps);
      thold_ip_ck                    :	VitalDelayType := 488.280 ps;
      tsetup_ip_ck                   :	VitalDelayType := 410.160 ps;
      trecovery_rb_ck                :	VitalDelayType := 292.970 ps;
      trecovery_s_ck                 :	VitalDelayType := 410.160 ps;
      thold_s_ck                     :	VitalDelayType := 0.000 ps;
      thold_rb_ck                    :	VitalDelayType := 0.000 ps;
      tpw_ck_posedge                 :	VitalDelayType := 750.000 ps;
      tpw_ck_negedge                 :	VitalDelayType := 750.000 ps;
      tisd_ip_ck                     :	VitalDelayType := 0.000 ps;
      ticd_ck                        :	VitalDelayType := 0.000 ps;
      tisd_s_ck                      :	VitalDelayType := 0.000 ps;
      tisd_rb_ck                     :	VitalDelayType := 0.000 ps;
      tipd_ck                        :	VitalDelayType01 := (0.000 ps, 0.000 ps);
      tipd_ip                        :	VitalDelayType01 := (0.000 ps, 0.000 ps);
      tipd_rb                        :	VitalDelayType01 := (0.000 ps, 0.000 ps);
      tipd_s                         :	VitalDelayType01 := (0.000 ps, 0.000 ps));

-- synopsys translate_on
   port(
      ck                             :	in    STD_ULOGIC;
      ip                             :	in    STD_ULOGIC;
      rb                             :	in    STD_ULOGIC;
      s                              :	in    STD_ULOGIC;
      q                              :	out   STD_ULOGIC);
end component;


----- Component lrsp_2 -----
component lrsp_2
-- synopsys translate_off
   generic(
      TimingChecksOn: Boolean := DefaultTimingChecksOn;
      InstancePath: STRING := "*";
      Xon: Boolean := DefaultXon;
      MsgOn: Boolean := DefaultMsgOn;
      tpd_ck_q                       :	VitalDelayType01 := (225.650 ps, 366.540 ps);
      tpd_ip_q                       :	VitalDelayType01 := (284.080 ps, 397.110 ps);
      tpd_rb_q                       :	VitalDelayType01 := (274.260 ps, 255.940 ps);
      tpd_s_q                        :	VitalDelayType01 := (270.740 ps, 391.290 ps);
      thold_ip_ck                    :	VitalDelayType := 410.160 ps;
      tsetup_ip_ck                   :	VitalDelayType := 410.160 ps;
      trecovery_rb_ck                :	VitalDelayType := 292.970 ps;
      trecovery_s_ck                 :	VitalDelayType := 410.160 ps;
      thold_s_ck                     :	VitalDelayType := 0.000 ps;
      thold_rb_ck                    :	VitalDelayType := 0.000 ps;
      tpw_ck_posedge                 :	VitalDelayType := 750.000 ps;
      tpw_ck_negedge                 :	VitalDelayType := 750.000 ps;
      tisd_ip_ck                     :	VitalDelayType := 0.000 ps;
      ticd_ck                        :	VitalDelayType := 0.000 ps;
      tisd_s_ck                      :	VitalDelayType := 0.000 ps;
      tisd_rb_ck                     :	VitalDelayType := 0.000 ps;
      tipd_ck                        :	VitalDelayType01 := (0.000 ps, 0.000 ps);
      tipd_ip                        :	VitalDelayType01 := (0.000 ps, 0.000 ps);
      tipd_rb                        :	VitalDelayType01 := (0.000 ps, 0.000 ps);
      tipd_s                         :	VitalDelayType01 := (0.000 ps, 0.000 ps));

-- synopsys translate_on
   port(
      ck                             :	in    STD_ULOGIC;
      ip                             :	in    STD_ULOGIC;
      rb                             :	in    STD_ULOGIC;
      s                              :	in    STD_ULOGIC;
      q                              :	out   STD_ULOGIC);
end component;


----- Component lrsp_4 -----
component lrsp_4
-- synopsys translate_off
   generic(
      TimingChecksOn: Boolean := DefaultTimingChecksOn;
      InstancePath: STRING := "*";
      Xon: Boolean := DefaultXon;
      MsgOn: Boolean := DefaultMsgOn;
      tpd_ck_q                       :	VitalDelayType01 := (236.470 ps, 383.350 ps);
      tpd_ip_q                       :	VitalDelayType01 := (295.510 ps, 417.980 ps);
      tpd_rb_q                       :	VitalDelayType01 := (286.050 ps, 268.250 ps);
      tpd_s_q                        :	VitalDelayType01 := (281.340 ps, 411.470 ps);
      thold_ip_ck                    :	VitalDelayType := 371.090 ps;
      tsetup_ip_ck                   :	VitalDelayType := 410.160 ps;
      trecovery_rb_ck                :	VitalDelayType := 292.970 ps;
      trecovery_s_ck                 :	VitalDelayType := 410.160 ps;
      thold_s_ck                     :	VitalDelayType := 0.000 ps;
      thold_rb_ck                    :	VitalDelayType := 0.000 ps;
      tpw_ck_posedge                 :	VitalDelayType := 750.000 ps;
      tpw_ck_negedge                 :	VitalDelayType := 750.000 ps;
      tisd_ip_ck                     :	VitalDelayType := 0.000 ps;
      ticd_ck                        :	VitalDelayType := 0.000 ps;
      tisd_s_ck                      :	VitalDelayType := 0.000 ps;
      tisd_rb_ck                     :	VitalDelayType := 0.000 ps;
      tipd_ck                        :	VitalDelayType01 := (0.000 ps, 0.000 ps);
      tipd_ip                        :	VitalDelayType01 := (0.000 ps, 0.000 ps);
      tipd_rb                        :	VitalDelayType01 := (0.000 ps, 0.000 ps);
      tipd_s                         :	VitalDelayType01 := (0.000 ps, 0.000 ps));

-- synopsys translate_on
   port(
      ck                             :	in    STD_ULOGIC;
      ip                             :	in    STD_ULOGIC;
      rb                             :	in    STD_ULOGIC;
      s                              :	in    STD_ULOGIC;
      q                              :	out   STD_ULOGIC);
end component;


----- Component mux2_1 -----
component mux2_1
-- synopsys translate_off
   generic(
      TimingChecksOn: Boolean := DefaultTimingChecksOn;
      InstancePath: STRING := "*";
      Xon: Boolean := DefaultXon;
      MsgOn: Boolean := DefaultMsgOn;
      tpd_ip1_op                     :	VitalDelayType01 := (127.480 ps, 166.900 ps);
      tpd_ip2_op                     :	VitalDelayType01 := (136.820 ps, 150.070 ps);
      tpd_s_op                       :	VitalDelayType01 := (195.670 ps, 217.590 ps);
      tipd_ip1                       :	VitalDelayType01 := (0.000 ps, 0.000 ps);
      tipd_ip2                       :	VitalDelayType01 := (0.000 ps, 0.000 ps);
      tipd_s                         :	VitalDelayType01 := (0.000 ps, 0.000 ps));

-- synopsys translate_on
   port(
      ip1                            :	in    STD_ULOGIC;
      ip2                            :	in    STD_ULOGIC;
      s                              :	in    STD_ULOGIC;
      op                             :	out   STD_ULOGIC);
end component;


----- Component mux2_2 -----
component mux2_2
-- synopsys translate_off
   generic(
      TimingChecksOn: Boolean := DefaultTimingChecksOn;
      InstancePath: STRING := "*";
      Xon: Boolean := DefaultXon;
      MsgOn: Boolean := DefaultMsgOn;
      tpd_ip1_op                     :	VitalDelayType01 := (141.550 ps, 188.490 ps);
      tpd_ip2_op                     :	VitalDelayType01 := (151.340 ps, 171.260 ps);
      tpd_s_op                       :	VitalDelayType01 := (211.740 ps, 240.120 ps);
      tipd_ip1                       :	VitalDelayType01 := (0.000 ps, 0.000 ps);
      tipd_ip2                       :	VitalDelayType01 := (0.000 ps, 0.000 ps);
      tipd_s                         :	VitalDelayType01 := (0.000 ps, 0.000 ps));

-- synopsys translate_on
   port(
      ip1                            :	in    STD_ULOGIC;
      ip2                            :	in    STD_ULOGIC;
      s                              :	in    STD_ULOGIC;
      op                             :	out   STD_ULOGIC);
end component;


----- Component mux2_4 -----
component mux2_4
-- synopsys translate_off
   generic(
      TimingChecksOn: Boolean := DefaultTimingChecksOn;
      InstancePath: STRING := "*";
      Xon: Boolean := DefaultXon;
      MsgOn: Boolean := DefaultMsgOn;
      tpd_ip1_op                     :	VitalDelayType01 := (176.020 ps, 246.440 ps);
      tpd_ip2_op                     :	VitalDelayType01 := (185.760 ps, 228.080 ps);
      tpd_s_op                       :	VitalDelayType01 := (245.670 ps, 294.780 ps);
      tipd_ip1                       :	VitalDelayType01 := (0.000 ps, 0.000 ps);
      tipd_ip2                       :	VitalDelayType01 := (0.000 ps, 0.000 ps);
      tipd_s                         :	VitalDelayType01 := (0.000 ps, 0.000 ps));

-- synopsys translate_on
   port(
      ip1                            :	in    STD_ULOGIC;
      ip2                            :	in    STD_ULOGIC;
      s                              :	in    STD_ULOGIC;
      op                             :	out   STD_ULOGIC);
end component;


----- Component mux3_2 -----
component mux3_2
-- synopsys translate_off
   generic(
      TimingChecksOn: Boolean := DefaultTimingChecksOn;
      InstancePath: STRING := "*";
      Xon: Boolean := DefaultXon;
      MsgOn: Boolean := DefaultMsgOn;
      tpd_ip1_op                     :	VitalDelayType01 := (206.950 ps, 206.140 ps);
      tpd_ip2_op                     :	VitalDelayType01 := (201.530 ps, 206.140 ps);
      tpd_ip3_op                     :	VitalDelayType01 := (119.010 ps, 206.140 ps);
      tpd_s0_op                      :	VitalDelayType01 := (178.530 ps, 206.140 ps);
      tpd_s1_op                      :	VitalDelayType01 := (119.010 ps, 206.140 ps);
      tipd_ip1                       :	VitalDelayType01 := (0.000 ps, 0.000 ps);
      tipd_ip2                       :	VitalDelayType01 := (0.000 ps, 0.000 ps);
      tipd_ip3                       :	VitalDelayType01 := (0.000 ps, 0.000 ps);
      tipd_s0                        :	VitalDelayType01 := (0.000 ps, 0.000 ps);
      tipd_s1                        :	VitalDelayType01 := (0.000 ps, 0.000 ps));

-- synopsys translate_on
   port(
      ip1                            :	in    STD_ULOGIC;
      ip2                            :	in    STD_ULOGIC;
      ip3                            :	in    STD_ULOGIC;
      s0                             :	in    STD_ULOGIC;
      s1                             :	in    STD_ULOGIC;
      op                             :	out   STD_ULOGIC);
end component;


----- Component mux4_2 -----
component mux4_2
-- synopsys translate_off
   generic(
      TimingChecksOn: Boolean := DefaultTimingChecksOn;
      InstancePath: STRING := "*";
      Xon: Boolean := DefaultXon;
      MsgOn: Boolean := DefaultMsgOn;
      tpd_ip1_op                     :	VitalDelayType01 := (215.560 ps, 215.640 ps);
      tpd_ip2_op                     :	VitalDelayType01 := (209.870 ps, 215.640 ps);
      tpd_ip3_op                     :	VitalDelayType01 := (209.960 ps, 215.640 ps);
      tpd_ip4_op                     :	VitalDelayType01 := (209.810 ps, 215.640 ps);
      tpd_s0_op                      :	VitalDelayType01 := (208.050 ps, 215.640 ps);
      tpd_s1_op                      :	VitalDelayType01 := (208.050 ps, 215.640 ps);
      tipd_ip1                       :	VitalDelayType01 := (0.000 ps, 0.000 ps);
      tipd_ip2                       :	VitalDelayType01 := (0.000 ps, 0.000 ps);
      tipd_ip3                       :	VitalDelayType01 := (0.000 ps, 0.000 ps);
      tipd_ip4                       :	VitalDelayType01 := (0.000 ps, 0.000 ps);
      tipd_s0                        :	VitalDelayType01 := (0.000 ps, 0.000 ps);
      tipd_s1                        :	VitalDelayType01 := (0.000 ps, 0.000 ps));

-- synopsys translate_on
   port(
      ip1                            :	in    STD_ULOGIC;
      ip2                            :	in    STD_ULOGIC;
      ip3                            :	in    STD_ULOGIC;
      ip4                            :	in    STD_ULOGIC;
      s0                             :	in    STD_ULOGIC;
      s1                             :	in    STD_ULOGIC;
      op                             :	out   STD_ULOGIC);
end component;


----- Component nand2_1 -----
component nand2_1
-- synopsys translate_off
   generic(
      TimingChecksOn: Boolean := DefaultTimingChecksOn;
      InstancePath: STRING := "*";
      Xon: Boolean := DefaultXon;
      MsgOn: Boolean := DefaultMsgOn;
      tpd_ip1_op                     :	VitalDelayType01 := (35.510 ps, 47.270 ps);
      tpd_ip2_op                     :	VitalDelayType01 := (28.448 ps, 47.270 ps);
      tipd_ip1                       :	VitalDelayType01 := (0.000 ps, 0.000 ps);
      tipd_ip2                       :	VitalDelayType01 := (0.000 ps, 0.000 ps));

-- synopsys translate_on
   port(
      ip1                            :	in    STD_ULOGIC;
      ip2                            :	in    STD_ULOGIC;
      op                             :	out   STD_ULOGIC);
end component;


----- Component nand2_2 -----
component nand2_2
-- synopsys translate_off
   generic(
      TimingChecksOn: Boolean := DefaultTimingChecksOn;
      InstancePath: STRING := "*";
      Xon: Boolean := DefaultXon;
      MsgOn: Boolean := DefaultMsgOn;
      tpd_ip1_op                     :	VitalDelayType01 := (32.582 ps, 42.740 ps);
      tpd_ip2_op                     :	VitalDelayType01 := (25.471 ps, 42.740 ps);
      tipd_ip1                       :	VitalDelayType01 := (0.000 ps, 0.000 ps);
      tipd_ip2                       :	VitalDelayType01 := (0.000 ps, 0.000 ps));

-- synopsys translate_on
   port(
      ip1                            :	in    STD_ULOGIC;
      ip2                            :	in    STD_ULOGIC;
      op                             :	out   STD_ULOGIC);
end component;


----- Component nand2_4 -----
component nand2_4
-- synopsys translate_off
   generic(
      TimingChecksOn: Boolean := DefaultTimingChecksOn;
      InstancePath: STRING := "*";
      Xon: Boolean := DefaultXon;
      MsgOn: Boolean := DefaultMsgOn;
      tpd_ip1_op                     :	VitalDelayType01 := (30.445 ps, 40.291 ps);
      tpd_ip2_op                     :	VitalDelayType01 := (23.223 ps, 40.291 ps);
      tipd_ip1                       :	VitalDelayType01 := (0.000 ps, 0.000 ps);
      tipd_ip2                       :	VitalDelayType01 := (0.000 ps, 0.000 ps));

-- synopsys translate_on
   port(
      ip1                            :	in    STD_ULOGIC;
      ip2                            :	in    STD_ULOGIC;
      op                             :	out   STD_ULOGIC);
end component;


----- Component nand3_1 -----
component nand3_1
-- synopsys translate_off
   generic(
      TimingChecksOn: Boolean := DefaultTimingChecksOn;
      InstancePath: STRING := "*";
      Xon: Boolean := DefaultXon;
      MsgOn: Boolean := DefaultMsgOn;
      tpd_ip1_op                     :	VitalDelayType01 := (51.422 ps, 98.857 ps);
      tpd_ip2_op                     :	VitalDelayType01 := (46.712 ps, 98.857 ps);
      tpd_ip3_op                     :	VitalDelayType01 := (40.547 ps, 98.857 ps);
      tipd_ip1                       :	VitalDelayType01 := (0.000 ps, 0.000 ps);
      tipd_ip2                       :	VitalDelayType01 := (0.000 ps, 0.000 ps);
      tipd_ip3                       :	VitalDelayType01 := (0.000 ps, 0.000 ps));

-- synopsys translate_on
   port(
      ip1                            :	in    STD_ULOGIC;
      ip2                            :	in    STD_ULOGIC;
      ip3                            :	in    STD_ULOGIC;
      op                             :	out   STD_ULOGIC);
end component;


----- Component nand3_2 -----
component nand3_2
-- synopsys translate_off
   generic(
      TimingChecksOn: Boolean := DefaultTimingChecksOn;
      InstancePath: STRING := "*";
      Xon: Boolean := DefaultXon;
      MsgOn: Boolean := DefaultMsgOn;
      tpd_ip1_op                     :	VitalDelayType01 := (46.799 ps, 86.681 ps);
      tpd_ip2_op                     :	VitalDelayType01 := (42.122 ps, 86.681 ps);
      tpd_ip3_op                     :	VitalDelayType01 := (34.221 ps, 86.681 ps);
      tipd_ip1                       :	VitalDelayType01 := (0.000 ps, 0.000 ps);
      tipd_ip2                       :	VitalDelayType01 := (0.000 ps, 0.000 ps);
      tipd_ip3                       :	VitalDelayType01 := (0.000 ps, 0.000 ps));

-- synopsys translate_on
   port(
      ip1                            :	in    STD_ULOGIC;
      ip2                            :	in    STD_ULOGIC;
      ip3                            :	in    STD_ULOGIC;
      op                             :	out   STD_ULOGIC);
end component;


----- Component nand3_4 -----
component nand3_4
-- synopsys translate_off
   generic(
      TimingChecksOn: Boolean := DefaultTimingChecksOn;
      InstancePath: STRING := "*";
      Xon: Boolean := DefaultXon;
      MsgOn: Boolean := DefaultMsgOn;
      tpd_ip1_op                     :	VitalDelayType01 := (68.652 ps, 68.652 ps);
      tpd_ip2_op                     :	VitalDelayType01 := (56.717 ps, 56.717 ps);
      tpd_ip3_op                     :	VitalDelayType01 := (38.677 ps, 52.175 ps);
      tipd_ip1                       :	VitalDelayType01 := (0.000 ps, 0.000 ps);
      tipd_ip2                       :	VitalDelayType01 := (0.000 ps, 0.000 ps);
      tipd_ip3                       :	VitalDelayType01 := (0.000 ps, 0.000 ps));

-- synopsys translate_on
   port(
      ip1                            :	in    STD_ULOGIC;
      ip2                            :	in    STD_ULOGIC;
      ip3                            :	in    STD_ULOGIC;
      op                             :	out   STD_ULOGIC);
end component;


----- Component nand4_1 -----
component nand4_1
-- synopsys translate_off
   generic(
      TimingChecksOn: Boolean := DefaultTimingChecksOn;
      InstancePath: STRING := "*";
      Xon: Boolean := DefaultXon;
      MsgOn: Boolean := DefaultMsgOn;
      tpd_ip1_op                     :	VitalDelayType01 := (59.914 ps, 144.700 ps);
      tpd_ip2_op                     :	VitalDelayType01 := (57.516 ps, 144.700 ps);
      tpd_ip3_op                     :	VitalDelayType01 := (53.043 ps, 144.700 ps);
      tpd_ip4_op                     :	VitalDelayType01 := (44.397 ps, 144.700 ps);
      tipd_ip1                       :	VitalDelayType01 := (0.000 ps, 0.000 ps);
      tipd_ip2                       :	VitalDelayType01 := (0.000 ps, 0.000 ps);
      tipd_ip3                       :	VitalDelayType01 := (0.000 ps, 0.000 ps);
      tipd_ip4                       :	VitalDelayType01 := (0.000 ps, 0.000 ps));

-- synopsys translate_on
   port(
      ip1                            :	in    STD_ULOGIC;
      ip2                            :	in    STD_ULOGIC;
      ip3                            :	in    STD_ULOGIC;
      ip4                            :	in    STD_ULOGIC;
      op                             :	out   STD_ULOGIC);
end component;


----- Component nand4_2 -----
component nand4_2
-- synopsys translate_off
   generic(
      TimingChecksOn: Boolean := DefaultTimingChecksOn;
      InstancePath: STRING := "*";
      Xon: Boolean := DefaultXon;
      MsgOn: Boolean := DefaultMsgOn;
      tpd_ip1_op                     :	VitalDelayType01 := (53.955 ps, 126.840 ps);
      tpd_ip2_op                     :	VitalDelayType01 := (51.648 ps, 126.840 ps);
      tpd_ip3_op                     :	VitalDelayType01 := (46.458 ps, 126.840 ps);
      tpd_ip4_op                     :	VitalDelayType01 := (38.191 ps, 126.840 ps);
      tipd_ip1                       :	VitalDelayType01 := (0.000 ps, 0.000 ps);
      tipd_ip2                       :	VitalDelayType01 := (0.000 ps, 0.000 ps);
      tipd_ip3                       :	VitalDelayType01 := (0.000 ps, 0.000 ps);
      tipd_ip4                       :	VitalDelayType01 := (0.000 ps, 0.000 ps));

-- synopsys translate_on
   port(
      ip1                            :	in    STD_ULOGIC;
      ip2                            :	in    STD_ULOGIC;
      ip3                            :	in    STD_ULOGIC;
      ip4                            :	in    STD_ULOGIC;
      op                             :	out   STD_ULOGIC);
end component;


----- Component nand4_4 -----
component nand4_4
-- synopsys translate_off
   generic(
      TimingChecksOn: Boolean := DefaultTimingChecksOn;
      InstancePath: STRING := "*";
      Xon: Boolean := DefaultXon;
      MsgOn: Boolean := DefaultMsgOn;
      tpd_ip1_op                     :	VitalDelayType01 := (152.360 ps, 301.100 ps);
      tpd_ip2_op                     :	VitalDelayType01 := (161.540 ps, 301.100 ps);
      tpd_ip3_op                     :	VitalDelayType01 := (170.540 ps, 301.100 ps);
      tpd_ip4_op                     :	VitalDelayType01 := (175.240 ps, 301.100 ps);
      tipd_ip1                       :	VitalDelayType01 := (0.000 ps, 0.000 ps);
      tipd_ip2                       :	VitalDelayType01 := (0.000 ps, 0.000 ps);
      tipd_ip3                       :	VitalDelayType01 := (0.000 ps, 0.000 ps);
      tipd_ip4                       :	VitalDelayType01 := (0.000 ps, 0.000 ps));

-- synopsys translate_on
   port(
      ip1                            :	in    STD_ULOGIC;
      ip2                            :	in    STD_ULOGIC;
      ip3                            :	in    STD_ULOGIC;
      ip4                            :	in    STD_ULOGIC;
      op                             :	out   STD_ULOGIC);
end component;


----- Component nor2_1 -----
component nor2_1
-- synopsys translate_off
   generic(
      TimingChecksOn: Boolean := DefaultTimingChecksOn;
      InstancePath: STRING := "*";
      Xon: Boolean := DefaultXon;
      MsgOn: Boolean := DefaultMsgOn;
      tpd_ip1_op                     :	VitalDelayType01 := (72.903 ps, 72.448 ps);
      tpd_ip2_op                     :	VitalDelayType01 := (72.903 ps, 60.423 ps);
      tipd_ip1                       :	VitalDelayType01 := (0.000 ps, 0.000 ps);
      tipd_ip2                       :	VitalDelayType01 := (0.000 ps, 0.000 ps));

-- synopsys translate_on
   port(
      ip1                            :	in    STD_ULOGIC;
      ip2                            :	in    STD_ULOGIC;
      op                             :	out   STD_ULOGIC);
end component;


----- Component nor2_2 -----
component nor2_2
-- synopsys translate_off
   generic(
      TimingChecksOn: Boolean := DefaultTimingChecksOn;
      InstancePath: STRING := "*";
      Xon: Boolean := DefaultXon;
      MsgOn: Boolean := DefaultMsgOn;
      tpd_ip1_op                     :	VitalDelayType01 := (61.327 ps, 61.327 ps);
      tpd_ip2_op                     :	VitalDelayType01 := (60.427 ps, 49.345 ps);
      tipd_ip1                       :	VitalDelayType01 := (0.000 ps, 0.000 ps);
      tipd_ip2                       :	VitalDelayType01 := (0.000 ps, 0.000 ps));

-- synopsys translate_on
   port(
      ip1                            :	in    STD_ULOGIC;
      ip2                            :	in    STD_ULOGIC;
      op                             :	out   STD_ULOGIC);
end component;


----- Component nor2_4 -----
component nor2_4
-- synopsys translate_off
   generic(
      TimingChecksOn: Boolean := DefaultTimingChecksOn;
      InstancePath: STRING := "*";
      Xon: Boolean := DefaultXon;
      MsgOn: Boolean := DefaultMsgOn;
      tpd_ip1_op                     :	VitalDelayType01 := (56.891 ps, 56.891 ps);
      tpd_ip2_op                     :	VitalDelayType01 := (54.992 ps, 44.361 ps);
      tipd_ip1                       :	VitalDelayType01 := (0.000 ps, 0.000 ps);
      tipd_ip2                       :	VitalDelayType01 := (0.000 ps, 0.000 ps));

-- synopsys translate_on
   port(
      ip1                            :	in    STD_ULOGIC;
      ip2                            :	in    STD_ULOGIC;
      op                             :	out   STD_ULOGIC);
end component;


----- Component nor3_1 -----
component nor3_1
-- synopsys translate_off
   generic(
      TimingChecksOn: Boolean := DefaultTimingChecksOn;
      InstancePath: STRING := "*";
      Xon: Boolean := DefaultXon;
      MsgOn: Boolean := DefaultMsgOn;
      tpd_ip1_op                     :	VitalDelayType01 := (133.800 ps, 130.780 ps);
      tpd_ip2_op                     :	VitalDelayType01 := (133.800 ps, 126.850 ps);
      tpd_ip3_op                     :	VitalDelayType01 := (133.800 ps, 95.624 ps);
      tipd_ip1                       :	VitalDelayType01 := (0.000 ps, 0.000 ps);
      tipd_ip2                       :	VitalDelayType01 := (0.000 ps, 0.000 ps);
      tipd_ip3                       :	VitalDelayType01 := (0.000 ps, 0.000 ps));

-- synopsys translate_on
   port(
      ip1                            :	in    STD_ULOGIC;
      ip2                            :	in    STD_ULOGIC;
      ip3                            :	in    STD_ULOGIC;
      op                             :	out   STD_ULOGIC);
end component;


----- Component nor3_2 -----
component nor3_2
-- synopsys translate_off
   generic(
      TimingChecksOn: Boolean := DefaultTimingChecksOn;
      InstancePath: STRING := "*";
      Xon: Boolean := DefaultXon;
      MsgOn: Boolean := DefaultMsgOn;
      tpd_ip1_op                     :	VitalDelayType01 := (113.610 ps, 113.610 ps);
      tpd_ip2_op                     :	VitalDelayType01 := (111.220 ps, 106.220 ps);
      tpd_ip3_op                     :	VitalDelayType01 := (111.220 ps, 74.820 ps);
      tipd_ip1                       :	VitalDelayType01 := (0.000 ps, 0.000 ps);
      tipd_ip2                       :	VitalDelayType01 := (0.000 ps, 0.000 ps);
      tipd_ip3                       :	VitalDelayType01 := (0.000 ps, 0.000 ps));

-- synopsys translate_on
   port(
      ip1                            :	in    STD_ULOGIC;
      ip2                            :	in    STD_ULOGIC;
      ip3                            :	in    STD_ULOGIC;
      op                             :	out   STD_ULOGIC);
end component;


----- Component nor3_4 -----
component nor3_4
-- synopsys translate_off
   generic(
      TimingChecksOn: Boolean := DefaultTimingChecksOn;
      InstancePath: STRING := "*";
      Xon: Boolean := DefaultXon;
      MsgOn: Boolean := DefaultMsgOn;
      tpd_ip1_op                     :	VitalDelayType01 := (100.680 ps, 100.680 ps);
      tpd_ip2_op                     :	VitalDelayType01 := (93.073 ps, 90.799 ps);
      tpd_ip3_op                     :	VitalDelayType01 := (93.073 ps, 59.474 ps);
      tipd_ip1                       :	VitalDelayType01 := (0.000 ps, 0.000 ps);
      tipd_ip2                       :	VitalDelayType01 := (0.000 ps, 0.000 ps);
      tipd_ip3                       :	VitalDelayType01 := (0.000 ps, 0.000 ps));

-- synopsys translate_on
   port(
      ip1                            :	in    STD_ULOGIC;
      ip2                            :	in    STD_ULOGIC;
      ip3                            :	in    STD_ULOGIC;
      op                             :	out   STD_ULOGIC);
end component;


----- Component nor4_1 -----
component nor4_1
-- synopsys translate_off
   generic(
      TimingChecksOn: Boolean := DefaultTimingChecksOn;
      InstancePath: STRING := "*";
      Xon: Boolean := DefaultXon;
      MsgOn: Boolean := DefaultMsgOn;
      tpd_ip1_op                     :	VitalDelayType01 := (203.330 ps, 203.330 ps);
      tpd_ip2_op                     :	VitalDelayType01 := (198.070 ps, 194.550 ps);
      tpd_ip3_op                     :	VitalDelayType01 := (198.070 ps, 170.600 ps);
      tpd_ip4_op                     :	VitalDelayType01 := (198.070 ps, 120.410 ps);
      tipd_ip1                       :	VitalDelayType01 := (0.000 ps, 0.000 ps);
      tipd_ip2                       :	VitalDelayType01 := (0.000 ps, 0.000 ps);
      tipd_ip3                       :	VitalDelayType01 := (0.000 ps, 0.000 ps);
      tipd_ip4                       :	VitalDelayType01 := (0.000 ps, 0.000 ps));

-- synopsys translate_on
   port(
      ip1                            :	in    STD_ULOGIC;
      ip2                            :	in    STD_ULOGIC;
      ip3                            :	in    STD_ULOGIC;
      ip4                            :	in    STD_ULOGIC;
      op                             :	out   STD_ULOGIC);
end component;


----- Component nor4_2 -----
component nor4_2
-- synopsys translate_off
   generic(
      TimingChecksOn: Boolean := DefaultTimingChecksOn;
      InstancePath: STRING := "*";
      Xon: Boolean := DefaultXon;
      MsgOn: Boolean := DefaultMsgOn;
      tpd_ip1_op                     :	VitalDelayType01 := (179.380 ps, 179.380 ps);
      tpd_ip2_op                     :	VitalDelayType01 := (169.800 ps, 169.800 ps);
      tpd_ip3_op                     :	VitalDelayType01 := (168.910 ps, 142.330 ps);
      tpd_ip4_op                     :	VitalDelayType01 := (168.910 ps, 91.037 ps);
      tipd_ip1                       :	VitalDelayType01 := (0.000 ps, 0.000 ps);
      tipd_ip2                       :	VitalDelayType01 := (0.000 ps, 0.000 ps);
      tipd_ip3                       :	VitalDelayType01 := (0.000 ps, 0.000 ps);
      tipd_ip4                       :	VitalDelayType01 := (0.000 ps, 0.000 ps));

-- synopsys translate_on
   port(
      ip1                            :	in    STD_ULOGIC;
      ip2                            :	in    STD_ULOGIC;
      ip3                            :	in    STD_ULOGIC;
      ip4                            :	in    STD_ULOGIC;
      op                             :	out   STD_ULOGIC);
end component;


----- Component nor4_4 -----
component nor4_4
-- synopsys translate_off
   generic(
      TimingChecksOn: Boolean := DefaultTimingChecksOn;
      InstancePath: STRING := "*";
      Xon: Boolean := DefaultXon;
      MsgOn: Boolean := DefaultMsgOn;
      tpd_ip1_op                     :	VitalDelayType01 := (369.210 ps, 364.750 ps);
      tpd_ip2_op                     :	VitalDelayType01 := (369.210 ps, 357.010 ps);
      tpd_ip3_op                     :	VitalDelayType01 := (369.210 ps, 328.350 ps);
      tpd_ip4_op                     :	VitalDelayType01 := (369.210 ps, 277.390 ps);
      tipd_ip1                       :	VitalDelayType01 := (0.000 ps, 0.000 ps);
      tipd_ip2                       :	VitalDelayType01 := (0.000 ps, 0.000 ps);
      tipd_ip3                       :	VitalDelayType01 := (0.000 ps, 0.000 ps);
      tipd_ip4                       :	VitalDelayType01 := (0.000 ps, 0.000 ps));

-- synopsys translate_on
   port(
      ip1                            :	in    STD_ULOGIC;
      ip2                            :	in    STD_ULOGIC;
      ip3                            :	in    STD_ULOGIC;
      ip4                            :	in    STD_ULOGIC;
      op                             :	out   STD_ULOGIC);
end component;


----- Component not_ab_or_c_or_d -----
component not_ab_or_c_or_d
-- synopsys translate_off
   generic(
      TimingChecksOn: Boolean := DefaultTimingChecksOn;
      InstancePath: STRING := "*";
      Xon: Boolean := DefaultXon;
      MsgOn: Boolean := DefaultMsgOn;
      tpd_ip1_op                     :	VitalDelayType01 := (177.050 ps, 177.050 ps);
      tpd_ip2_op                     :	VitalDelayType01 := (148.630 ps, 148.630 ps);
      tpd_ip3_op                     :	VitalDelayType01 := (106.590 ps, 99.802 ps);
      tpd_ip4_op                     :	VitalDelayType01 := (106.590 ps, 69.955 ps);
      tipd_ip1                       :	VitalDelayType01 := (0.000 ps, 0.000 ps);
      tipd_ip2                       :	VitalDelayType01 := (0.000 ps, 0.000 ps);
      tipd_ip3                       :	VitalDelayType01 := (0.000 ps, 0.000 ps);
      tipd_ip4                       :	VitalDelayType01 := (0.000 ps, 0.000 ps));

-- synopsys translate_on
   port(
      ip1                            :	in    STD_ULOGIC;
      ip2                            :	in    STD_ULOGIC;
      ip3                            :	in    STD_ULOGIC;
      ip4                            :	in    STD_ULOGIC;
      op                             :	out   STD_ULOGIC);
end component;


----- Component or2_1 -----
component or2_1
-- synopsys translate_off
   generic(
      TimingChecksOn: Boolean := DefaultTimingChecksOn;
      InstancePath: STRING := "*";
      Xon: Boolean := DefaultXon;
      MsgOn: Boolean := DefaultMsgOn;
      tpd_ip1_op                     :	VitalDelayType01 := (77.135 ps, 144.360 ps);
      tpd_ip2_op                     :	VitalDelayType01 := (86.841 ps, 144.360 ps);
      tipd_ip1                       :	VitalDelayType01 := (0.000 ps, 0.000 ps);
      tipd_ip2                       :	VitalDelayType01 := (0.000 ps, 0.000 ps));

-- synopsys translate_on
   port(
      ip1                            :	in    STD_ULOGIC;
      ip2                            :	in    STD_ULOGIC;
      op                             :	out   STD_ULOGIC);
end component;


----- Component or2_2 -----
component or2_2
-- synopsys translate_off
   generic(
      TimingChecksOn: Boolean := DefaultTimingChecksOn;
      InstancePath: STRING := "*";
      Xon: Boolean := DefaultXon;
      MsgOn: Boolean := DefaultMsgOn;
      tpd_ip1_op                     :	VitalDelayType01 := (68.456 ps, 126.640 ps);
      tpd_ip2_op                     :	VitalDelayType01 := (79.258 ps, 126.640 ps);
      tipd_ip1                       :	VitalDelayType01 := (0.000 ps, 0.000 ps);
      tipd_ip2                       :	VitalDelayType01 := (0.000 ps, 0.000 ps));

-- synopsys translate_on
   port(
      ip1                            :	in    STD_ULOGIC;
      ip2                            :	in    STD_ULOGIC;
      op                             :	out   STD_ULOGIC);
end component;


----- Component or2_4 -----
component or2_4
-- synopsys translate_off
   generic(
      TimingChecksOn: Boolean := DefaultTimingChecksOn;
      InstancePath: STRING := "*";
      Xon: Boolean := DefaultXon;
      MsgOn: Boolean := DefaultMsgOn;
      tpd_ip1_op                     :	VitalDelayType01 := (78.956 ps, 155.500 ps);
      tpd_ip2_op                     :	VitalDelayType01 := (90.931 ps, 155.500 ps);
      tipd_ip1                       :	VitalDelayType01 := (0.000 ps, 0.000 ps);
      tipd_ip2                       :	VitalDelayType01 := (0.000 ps, 0.000 ps));

-- synopsys translate_on
   port(
      ip1                            :	in    STD_ULOGIC;
      ip2                            :	in    STD_ULOGIC;
      op                             :	out   STD_ULOGIC);
end component;


----- Component or3_1 -----
component or3_1
-- synopsys translate_off
   generic(
      TimingChecksOn: Boolean := DefaultTimingChecksOn;
      InstancePath: STRING := "*";
      Xon: Boolean := DefaultXon;
      MsgOn: Boolean := DefaultMsgOn;
      tpd_ip1_op                     :	VitalDelayType01 := (91.922 ps, 252.200 ps);
      tpd_ip2_op                     :	VitalDelayType01 := (107.540 ps, 252.200 ps);
      tpd_ip3_op                     :	VitalDelayType01 := (110.130 ps, 252.200 ps);
      tipd_ip1                       :	VitalDelayType01 := (0.000 ps, 0.000 ps);
      tipd_ip2                       :	VitalDelayType01 := (0.000 ps, 0.000 ps);
      tipd_ip3                       :	VitalDelayType01 := (0.000 ps, 0.000 ps));

-- synopsys translate_on
   port(
      ip1                            :	in    STD_ULOGIC;
      ip2                            :	in    STD_ULOGIC;
      ip3                            :	in    STD_ULOGIC;
      op                             :	out   STD_ULOGIC);
end component;


----- Component or3_2 -----
component or3_2
-- synopsys translate_off
   generic(
      TimingChecksOn: Boolean := DefaultTimingChecksOn;
      InstancePath: STRING := "*";
      Xon: Boolean := DefaultXon;
      MsgOn: Boolean := DefaultMsgOn;
      tpd_ip1_op                     :	VitalDelayType01 := (74.922 ps, 210.870 ps);
      tpd_ip2_op                     :	VitalDelayType01 := (87.708 ps, 210.870 ps);
      tpd_ip3_op                     :	VitalDelayType01 := (91.642 ps, 210.870 ps);
      tipd_ip1                       :	VitalDelayType01 := (0.000 ps, 0.000 ps);
      tipd_ip2                       :	VitalDelayType01 := (0.000 ps, 0.000 ps);
      tipd_ip3                       :	VitalDelayType01 := (0.000 ps, 0.000 ps));

-- synopsys translate_on
   port(
      ip1                            :	in    STD_ULOGIC;
      ip2                            :	in    STD_ULOGIC;
      ip3                            :	in    STD_ULOGIC;
      op                             :	out   STD_ULOGIC);
end component;


----- Component or3_4 -----
component or3_4
-- synopsys translate_off
   generic(
      TimingChecksOn: Boolean := DefaultTimingChecksOn;
      InstancePath: STRING := "*";
      Xon: Boolean := DefaultXon;
      MsgOn: Boolean := DefaultMsgOn;
      tpd_ip1_op                     :	VitalDelayType01 := (82.705 ps, 251.000 ps);
      tpd_ip2_op                     :	VitalDelayType01 := (95.906 ps, 251.000 ps);
      tpd_ip3_op                     :	VitalDelayType01 := (101.060 ps, 251.000 ps);
      tipd_ip1                       :	VitalDelayType01 := (0.000 ps, 0.000 ps);
      tipd_ip2                       :	VitalDelayType01 := (0.000 ps, 0.000 ps);
      tipd_ip3                       :	VitalDelayType01 := (0.000 ps, 0.000 ps));

-- synopsys translate_on
   port(
      ip1                            :	in    STD_ULOGIC;
      ip2                            :	in    STD_ULOGIC;
      ip3                            :	in    STD_ULOGIC;
      op                             :	out   STD_ULOGIC);
end component;


----- Component or4_1 -----
component or4_1
-- synopsys translate_off
   generic(
      TimingChecksOn: Boolean := DefaultTimingChecksOn;
      InstancePath: STRING := "*";
      Xon: Boolean := DefaultXon;
      MsgOn: Boolean := DefaultMsgOn;
      tpd_ip1_op                     :	VitalDelayType01 := (97.130 ps, 356.780 ps);
      tpd_ip2_op                     :	VitalDelayType01 := (113.550 ps, 356.780 ps);
      tpd_ip3_op                     :	VitalDelayType01 := (119.940 ps, 356.780 ps);
      tpd_ip4_op                     :	VitalDelayType01 := (118.500 ps, 356.780 ps);
      tipd_ip1                       :	VitalDelayType01 := (0.000 ps, 0.000 ps);
      tipd_ip2                       :	VitalDelayType01 := (0.000 ps, 0.000 ps);
      tipd_ip3                       :	VitalDelayType01 := (0.000 ps, 0.000 ps);
      tipd_ip4                       :	VitalDelayType01 := (0.000 ps, 0.000 ps));

-- synopsys translate_on
   port(
      ip1                            :	in    STD_ULOGIC;
      ip2                            :	in    STD_ULOGIC;
      ip3                            :	in    STD_ULOGIC;
      ip4                            :	in    STD_ULOGIC;
      op                             :	out   STD_ULOGIC);
end component;


----- Component or4_2 -----
component or4_2
-- synopsys translate_off
   generic(
      TimingChecksOn: Boolean := DefaultTimingChecksOn;
      InstancePath: STRING := "*";
      Xon: Boolean := DefaultXon;
      MsgOn: Boolean := DefaultMsgOn;
      tpd_ip1_op                     :	VitalDelayType01 := (79.122 ps, 295.860 ps);
      tpd_ip2_op                     :	VitalDelayType01 := (91.191 ps, 295.860 ps);
      tpd_ip3_op                     :	VitalDelayType01 := (96.757 ps, 295.860 ps);
      tpd_ip4_op                     :	VitalDelayType01 := (96.270 ps, 295.860 ps);
      tipd_ip1                       :	VitalDelayType01 := (0.000 ps, 0.000 ps);
      tipd_ip2                       :	VitalDelayType01 := (0.000 ps, 0.000 ps);
      tipd_ip3                       :	VitalDelayType01 := (0.000 ps, 0.000 ps);
      tipd_ip4                       :	VitalDelayType01 := (0.000 ps, 0.000 ps));

-- synopsys translate_on
   port(
      ip1                            :	in    STD_ULOGIC;
      ip2                            :	in    STD_ULOGIC;
      ip3                            :	in    STD_ULOGIC;
      ip4                            :	in    STD_ULOGIC;
      op                             :	out   STD_ULOGIC);
end component;


----- Component or4_4 -----
component or4_4
-- synopsys translate_off
   generic(
      TimingChecksOn: Boolean := DefaultTimingChecksOn;
      InstancePath: STRING := "*";
      Xon: Boolean := DefaultXon;
      MsgOn: Boolean := DefaultMsgOn;
      tpd_ip1_op                     :	VitalDelayType01 := (86.001 ps, 356.410 ps);
      tpd_ip2_op                     :	VitalDelayType01 := (98.435 ps, 356.410 ps);
      tpd_ip3_op                     :	VitalDelayType01 := (105.190 ps, 356.410 ps);
      tpd_ip4_op                     :	VitalDelayType01 := (105.900 ps, 356.410 ps);
      tipd_ip1                       :	VitalDelayType01 := (0.000 ps, 0.000 ps);
      tipd_ip2                       :	VitalDelayType01 := (0.000 ps, 0.000 ps);
      tipd_ip3                       :	VitalDelayType01 := (0.000 ps, 0.000 ps);
      tipd_ip4                       :	VitalDelayType01 := (0.000 ps, 0.000 ps));

-- synopsys translate_on
   port(
      ip1                            :	in    STD_ULOGIC;
      ip2                            :	in    STD_ULOGIC;
      ip3                            :	in    STD_ULOGIC;
      ip4                            :	in    STD_ULOGIC;
      op                             :	out   STD_ULOGIC);
end component;


----- Component xnor2_1 -----
component xnor2_1
-- synopsys translate_off
   generic(
      TimingChecksOn: Boolean := DefaultTimingChecksOn;
      InstancePath: STRING := "*";
      Xon: Boolean := DefaultXon;
      MsgOn: Boolean := DefaultMsgOn;
      tpd_ip1_op                     :	VitalDelayType01 := (198.540 ps, 198.540 ps);
      tpd_ip2_op                     :	VitalDelayType01 := (194.200 ps, 194.200 ps);
      tipd_ip1                       :	VitalDelayType01 := (0.000 ps, 0.000 ps);
      tipd_ip2                       :	VitalDelayType01 := (0.000 ps, 0.000 ps));

-- synopsys translate_on
   port(
      ip1                            :	in    STD_ULOGIC;
      ip2                            :	in    STD_ULOGIC;
      op                             :	out   STD_ULOGIC);
end component;


----- Component xnor2_2 -----
component xnor2_2
-- synopsys translate_off
   generic(
      TimingChecksOn: Boolean := DefaultTimingChecksOn;
      InstancePath: STRING := "*";
      Xon: Boolean := DefaultXon;
      MsgOn: Boolean := DefaultMsgOn;
      tpd_ip1_op                     :	VitalDelayType01 := (213.340 ps, 213.340 ps);
      tpd_ip2_op                     :	VitalDelayType01 := (208.810 ps, 208.810 ps);
      tipd_ip1                       :	VitalDelayType01 := (0.000 ps, 0.000 ps);
      tipd_ip2                       :	VitalDelayType01 := (0.000 ps, 0.000 ps));

-- synopsys translate_on
   port(
      ip1                            :	in    STD_ULOGIC;
      ip2                            :	in    STD_ULOGIC;
      op                             :	out   STD_ULOGIC);
end component;


----- Component xor2_1 -----
component xor2_1
-- synopsys translate_off
   generic(
      TimingChecksOn: Boolean := DefaultTimingChecksOn;
      InstancePath: STRING := "*";
      Xon: Boolean := DefaultXon;
      MsgOn: Boolean := DefaultMsgOn;
      tpd_ip1_op                     :	VitalDelayType01 := (135.110 ps, 135.110 ps);
      tpd_ip2_op                     :	VitalDelayType01 := (129.730 ps, 129.730 ps);
      tipd_ip1                       :	VitalDelayType01 := (0.000 ps, 0.000 ps);
      tipd_ip2                       :	VitalDelayType01 := (0.000 ps, 0.000 ps));

-- synopsys translate_on
   port(
      ip1                            :	in    STD_ULOGIC;
      ip2                            :	in    STD_ULOGIC;
      op                             :	out   STD_ULOGIC);
end component;


----- Component xor2_2 -----
component xor2_2
-- synopsys translate_off
   generic(
      TimingChecksOn: Boolean := DefaultTimingChecksOn;
      InstancePath: STRING := "*";
      Xon: Boolean := DefaultXon;
      MsgOn: Boolean := DefaultMsgOn;
      tpd_ip1_op                     :	VitalDelayType01 := (117.310 ps, 117.310 ps);
      tpd_ip2_op                     :	VitalDelayType01 := (105.790 ps, 105.790 ps);
      tipd_ip1                       :	VitalDelayType01 := (0.000 ps, 0.000 ps);
      tipd_ip2                       :	VitalDelayType01 := (0.000 ps, 0.000 ps));

-- synopsys translate_on
   port(
      ip1                            :	in    STD_ULOGIC;
      ip2                            :	in    STD_ULOGIC;
      op                             :	out   STD_ULOGIC);
end component;


end COMPONENTS;

---- end of VITAL components library ----
