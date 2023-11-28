	component Core is
		port (
			audio_external_interface_ADCDAT     : in  std_logic                     := 'X';             -- ADCDAT
			audio_external_interface_ADCLRCK    : in  std_logic                     := 'X';             -- ADCLRCK
			audio_external_interface_BCLK       : in  std_logic                     := 'X';             -- BCLK
			audio_external_interface_DACDAT     : out std_logic;                                        -- DACDAT
			audio_external_interface_DACLRCK    : in  std_logic                     := 'X';             -- DACLRCK
			clk_clk                             : in  std_logic                     := 'X';             -- clk
			reset_reset_n                       : in  std_logic                     := 'X';             -- reset_n
			vga_external_interface_CLK          : out std_logic;                                        -- CLK
			vga_external_interface_HS           : out std_logic;                                        -- HS
			vga_external_interface_VS           : out std_logic;                                        -- VS
			vga_external_interface_BLANK        : out std_logic;                                        -- BLANK
			vga_external_interface_SYNC         : out std_logic;                                        -- SYNC
			vga_external_interface_R            : out std_logic_vector(7 downto 0);                     -- R
			vga_external_interface_G            : out std_logic_vector(7 downto 0);                     -- G
			vga_external_interface_B            : out std_logic_vector(7 downto 0);                     -- B
			clocked_video_conduit_vid_clk       : in  std_logic                     := 'X';             -- vid_clk
			clocked_video_conduit_vid_data      : in  std_logic_vector(29 downto 0) := (others => 'X'); -- vid_data
			clocked_video_conduit_overflow      : out std_logic;                                        -- overflow
			clocked_video_conduit_vid_datavalid : in  std_logic                     := 'X';             -- vid_datavalid
			clocked_video_conduit_vid_locked    : in  std_logic                     := 'X'              -- vid_locked
		);
	end component Core;

	u0 : component Core
		port map (
			audio_external_interface_ADCDAT     => CONNECTED_TO_audio_external_interface_ADCDAT,     -- audio_external_interface.ADCDAT
			audio_external_interface_ADCLRCK    => CONNECTED_TO_audio_external_interface_ADCLRCK,    --                         .ADCLRCK
			audio_external_interface_BCLK       => CONNECTED_TO_audio_external_interface_BCLK,       --                         .BCLK
			audio_external_interface_DACDAT     => CONNECTED_TO_audio_external_interface_DACDAT,     --                         .DACDAT
			audio_external_interface_DACLRCK    => CONNECTED_TO_audio_external_interface_DACLRCK,    --                         .DACLRCK
			clk_clk                             => CONNECTED_TO_clk_clk,                             --                      clk.clk
			reset_reset_n                       => CONNECTED_TO_reset_reset_n,                       --                    reset.reset_n
			vga_external_interface_CLK          => CONNECTED_TO_vga_external_interface_CLK,          --   vga_external_interface.CLK
			vga_external_interface_HS           => CONNECTED_TO_vga_external_interface_HS,           --                         .HS
			vga_external_interface_VS           => CONNECTED_TO_vga_external_interface_VS,           --                         .VS
			vga_external_interface_BLANK        => CONNECTED_TO_vga_external_interface_BLANK,        --                         .BLANK
			vga_external_interface_SYNC         => CONNECTED_TO_vga_external_interface_SYNC,         --                         .SYNC
			vga_external_interface_R            => CONNECTED_TO_vga_external_interface_R,            --                         .R
			vga_external_interface_G            => CONNECTED_TO_vga_external_interface_G,            --                         .G
			vga_external_interface_B            => CONNECTED_TO_vga_external_interface_B,            --                         .B
			clocked_video_conduit_vid_clk       => CONNECTED_TO_clocked_video_conduit_vid_clk,       --    clocked_video_conduit.vid_clk
			clocked_video_conduit_vid_data      => CONNECTED_TO_clocked_video_conduit_vid_data,      --                         .vid_data
			clocked_video_conduit_overflow      => CONNECTED_TO_clocked_video_conduit_overflow,      --                         .overflow
			clocked_video_conduit_vid_datavalid => CONNECTED_TO_clocked_video_conduit_vid_datavalid, --                         .vid_datavalid
			clocked_video_conduit_vid_locked    => CONNECTED_TO_clocked_video_conduit_vid_locked     --                         .vid_locked
		);

