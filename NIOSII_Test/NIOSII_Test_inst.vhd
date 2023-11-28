	component NIOSII_Test is
		port (
			clk_clk                 : in  std_logic                    := 'X'; -- clk
			reset_reset_n           : in  std_logic                    := 'X'; -- reset_n
			audio_interface_ADCDAT  : in  std_logic                    := 'X'; -- ADCDAT
			audio_interface_ADCLRCK : in  std_logic                    := 'X'; -- ADCLRCK
			audio_interface_BCLK    : in  std_logic                    := 'X'; -- BCLK
			video_interface_CLK     : out std_logic;                           -- CLK
			video_interface_HS      : out std_logic;                           -- HS
			video_interface_VS      : out std_logic;                           -- VS
			video_interface_BLANK   : out std_logic;                           -- BLANK
			video_interface_SYNC    : out std_logic;                           -- SYNC
			video_interface_R       : out std_logic_vector(7 downto 0);        -- R
			video_interface_G       : out std_logic_vector(7 downto 0);        -- G
			video_interface_B       : out std_logic_vector(7 downto 0)         -- B
		);
	end component NIOSII_Test;

	u0 : component NIOSII_Test
		port map (
			clk_clk                 => CONNECTED_TO_clk_clk,                 --             clk.clk
			reset_reset_n           => CONNECTED_TO_reset_reset_n,           --           reset.reset_n
			audio_interface_ADCDAT  => CONNECTED_TO_audio_interface_ADCDAT,  -- audio_interface.ADCDAT
			audio_interface_ADCLRCK => CONNECTED_TO_audio_interface_ADCLRCK, --                .ADCLRCK
			audio_interface_BCLK    => CONNECTED_TO_audio_interface_BCLK,    --                .BCLK
			video_interface_CLK     => CONNECTED_TO_video_interface_CLK,     -- video_interface.CLK
			video_interface_HS      => CONNECTED_TO_video_interface_HS,      --                .HS
			video_interface_VS      => CONNECTED_TO_video_interface_VS,      --                .VS
			video_interface_BLANK   => CONNECTED_TO_video_interface_BLANK,   --                .BLANK
			video_interface_SYNC    => CONNECTED_TO_video_interface_SYNC,    --                .SYNC
			video_interface_R       => CONNECTED_TO_video_interface_R,       --                .R
			video_interface_G       => CONNECTED_TO_video_interface_G,       --                .G
			video_interface_B       => CONNECTED_TO_video_interface_B        --                .B
		);

