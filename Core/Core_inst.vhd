	component Core is
		port (
			clk_clk                                   : in  std_logic                     := 'X';             -- clk
			vga_external_interface_CLK                : out std_logic;                                        -- CLK
			vga_external_interface_HS                 : out std_logic;                                        -- HS
			vga_external_interface_VS                 : out std_logic;                                        -- VS
			vga_external_interface_BLANK              : out std_logic;                                        -- BLANK
			vga_external_interface_SYNC               : out std_logic;                                        -- SYNC
			vga_external_interface_R                  : out std_logic_vector(7 downto 0);                     -- R
			vga_external_interface_G                  : out std_logic_vector(7 downto 0);                     -- G
			vga_external_interface_B                  : out std_logic_vector(7 downto 0);                     -- B
			reset_reset_n                             : in  std_logic                     := 'X';             -- reset_n
			audio_0_external_interface_ADCDAT         : in  std_logic                     := 'X';             -- ADCDAT
			audio_0_external_interface_ADCLRCK        : in  std_logic                     := 'X';             -- ADCLRCK
			audio_0_external_interface_BCLK           : in  std_logic                     := 'X';             -- BCLK
			audio_0_external_interface_DACDAT         : out std_logic;                                        -- DACDAT
			audio_0_external_interface_DACLRCK        : in  std_logic                     := 'X';             -- DACLRCK
			alt_vip_cti_0_clocked_video_vid_clk       : in  std_logic                     := 'X';             -- vid_clk
			alt_vip_cti_0_clocked_video_vid_data      : in  std_logic_vector(29 downto 0) := (others => 'X'); -- vid_data
			alt_vip_cti_0_clocked_video_overflow      : out std_logic;                                        -- overflow
			alt_vip_cti_0_clocked_video_vid_datavalid : in  std_logic                     := 'X';             -- vid_datavalid
			alt_vip_cti_0_clocked_video_vid_locked    : in  std_logic                     := 'X';             -- vid_locked
			alt_vip_cti_0_clocked_video_vid_v_sync    : in  std_logic                     := 'X';             -- vid_v_sync
			alt_vip_cti_0_clocked_video_vid_h_sync    : in  std_logic                     := 'X';             -- vid_h_sync
			alt_vip_cti_0_clocked_video_vid_f         : in  std_logic                     := 'X'              -- vid_f
		);
	end component Core;

	u0 : component Core
		port map (
			clk_clk                                   => CONNECTED_TO_clk_clk,                                   --                         clk.clk
			vga_external_interface_CLK                => CONNECTED_TO_vga_external_interface_CLK,                --      vga_external_interface.CLK
			vga_external_interface_HS                 => CONNECTED_TO_vga_external_interface_HS,                 --                            .HS
			vga_external_interface_VS                 => CONNECTED_TO_vga_external_interface_VS,                 --                            .VS
			vga_external_interface_BLANK              => CONNECTED_TO_vga_external_interface_BLANK,              --                            .BLANK
			vga_external_interface_SYNC               => CONNECTED_TO_vga_external_interface_SYNC,               --                            .SYNC
			vga_external_interface_R                  => CONNECTED_TO_vga_external_interface_R,                  --                            .R
			vga_external_interface_G                  => CONNECTED_TO_vga_external_interface_G,                  --                            .G
			vga_external_interface_B                  => CONNECTED_TO_vga_external_interface_B,                  --                            .B
			reset_reset_n                             => CONNECTED_TO_reset_reset_n,                             --                       reset.reset_n
			audio_0_external_interface_ADCDAT         => CONNECTED_TO_audio_0_external_interface_ADCDAT,         --  audio_0_external_interface.ADCDAT
			audio_0_external_interface_ADCLRCK        => CONNECTED_TO_audio_0_external_interface_ADCLRCK,        --                            .ADCLRCK
			audio_0_external_interface_BCLK           => CONNECTED_TO_audio_0_external_interface_BCLK,           --                            .BCLK
			audio_0_external_interface_DACDAT         => CONNECTED_TO_audio_0_external_interface_DACDAT,         --                            .DACDAT
			audio_0_external_interface_DACLRCK        => CONNECTED_TO_audio_0_external_interface_DACLRCK,        --                            .DACLRCK
			alt_vip_cti_0_clocked_video_vid_clk       => CONNECTED_TO_alt_vip_cti_0_clocked_video_vid_clk,       -- alt_vip_cti_0_clocked_video.vid_clk
			alt_vip_cti_0_clocked_video_vid_data      => CONNECTED_TO_alt_vip_cti_0_clocked_video_vid_data,      --                            .vid_data
			alt_vip_cti_0_clocked_video_overflow      => CONNECTED_TO_alt_vip_cti_0_clocked_video_overflow,      --                            .overflow
			alt_vip_cti_0_clocked_video_vid_datavalid => CONNECTED_TO_alt_vip_cti_0_clocked_video_vid_datavalid, --                            .vid_datavalid
			alt_vip_cti_0_clocked_video_vid_locked    => CONNECTED_TO_alt_vip_cti_0_clocked_video_vid_locked,    --                            .vid_locked
			alt_vip_cti_0_clocked_video_vid_v_sync    => CONNECTED_TO_alt_vip_cti_0_clocked_video_vid_v_sync,    --                            .vid_v_sync
			alt_vip_cti_0_clocked_video_vid_h_sync    => CONNECTED_TO_alt_vip_cti_0_clocked_video_vid_h_sync,    --                            .vid_h_sync
			alt_vip_cti_0_clocked_video_vid_f         => CONNECTED_TO_alt_vip_cti_0_clocked_video_vid_f          --                            .vid_f
		);

